USE [master]
GO
/****** Object:  Database [HelpDesk]    Script Date: 2015/8/14 9:31:56 ******/
CREATE DATABASE [HelpDesk]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HelpDesk', FILENAME = N'D:\HelpDesk.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'HelpDesk_Log', FILENAME = N'D:\HelpDeskLog.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 1024KB )
GO
ALTER DATABASE [HelpDesk] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HelpDesk].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HelpDesk] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HelpDesk] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HelpDesk] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HelpDesk] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HelpDesk] SET ARITHABORT OFF 
GO
ALTER DATABASE [HelpDesk] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HelpDesk] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [HelpDesk] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HelpDesk] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HelpDesk] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HelpDesk] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HelpDesk] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HelpDesk] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HelpDesk] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HelpDesk] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HelpDesk] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HelpDesk] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HelpDesk] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HelpDesk] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HelpDesk] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HelpDesk] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HelpDesk] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HelpDesk] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HelpDesk] SET RECOVERY FULL 
GO
ALTER DATABASE [HelpDesk] SET  MULTI_USER 
GO
ALTER DATABASE [HelpDesk] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HelpDesk] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HelpDesk] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HelpDesk] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HelpDesk', N'ON'
GO
USE [HelpDesk]
GO
/****** Object:  StoredProcedure [dbo].[PRC_Application_User_Create]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-------------------------------------------------------------------------
Procedure Name	: PRC_Application_User_Create
Description		: Create data
Databases       : HelpDesk
Called From		: 
Returns			: boolean (0 - failed, 1 - successful)
Created By		: Alex
QA'ed By        : 
Create Date		: 2/Aug/2015
---------------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[PRC_Application_User_Create]
@In_User_Name Varchar(50), 
@In_User_Password Varchar(20), 
@In_User_Role Varchar(50), 
@In_User_Address Varchar(50),
@In_User_Mobile int, 
@In_User_Email varchar(30)
AS
BEGIN 
   DECLARE @newId Integer
   Begin Tran
	INSERT INTO Application_User VALUES (@In_User_Name, @In_User_Password, @In_User_Role, @In_User_Address, @In_User_Mobile, @In_User_Email)
	SET @newId = SCOPE_IDENTITY() 
	if (@@error != 0)
	  begin 
		ROLLBACK Tran;
		return 0;
	  end		
	else
	  begin 
		COMMIT Tran;
		return @newId;
	  end
END

GO
/****** Object:  StoredProcedure [dbo].[PRC_Application_User_Update]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-------------------------------------------------------------------------
Procedure Name	: PRC_Application_User_Update
Description		: Update data
Databases       : HelpDesk
Called From		: 
Returns			: boolean (0 - failed, 1 - successful)
Created By		: Alex
QA'ed By        : 
Create Date		: 14/Aug/2015
---------------------------------------------------------------------------*/

Create PROCEDURE [dbo].[PRC_Application_User_Update]
@In_User_Name Varchar(50), 
@In_User_Password Varchar(20), 
@In_User_Role Varchar(50), 
@In_User_Address Varchar(50),
@In_User_Mobile int, 
@In_User_Email varchar(30)
AS
BEGIN 
   DECLARE @newId Integer
   Begin Tran
	Update Application_User 
	set Application_User.User_Password = @In_User_Password,Application_User.User_Address = @In_User_Address,Application_User.User_Mobile = @In_User_Mobile,Application_User.User_Email = @In_User_Email
	where Application_User.User_Name = @In_User_Name
	SET @newId = SCOPE_IDENTITY() 
	if (@@error != 0)
	  begin 
		ROLLBACK Tran;
		return 0;
	  end		
	else
	  begin 
		COMMIT Tran;
		return @newId;
	  end
END

GO
/****** Object:  StoredProcedure [dbo].[PRC_Modification_Create]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-------------------------------------------------------------------------
Procedure Name	: PRC_Modification_Create
Description		: Create data
Databases       : HelpDesk
Called From		: 
Returns			: boolean (0 - failed, 1 - successful)
Created By		: Alex
QA'ed By        : 
Create Date		: 2/Aug/2015
---------------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[PRC_Modification_Create]
@In_Request_SID int,  
@In_Contract_time varchar(50),
@In_Interaction_type varchar(50),
@In_Status varchar(20),
@In_Modification_Date datetime,
@In_Modified_by int
AS
BEGIN 
   DECLARE @newId Integer
   Begin Tran
	INSERT INTO Modification VALUES (@In_Request_SID, @In_Contract_time, @In_Interaction_type, @In_Status,Getdate(), @In_Modified_by)
	SET @newId = SCOPE_IDENTITY() 
	if (@@error != 0)
	  begin 
		ROLLBACK Tran;
		return 0;
	  end		
	else
	  begin 
		COMMIT Tran;
		return @newId;
	  end
END

GO
/****** Object:  StoredProcedure [dbo].[PRC_Request_Create]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-------------------------------------------------------------------------
Procedure Name	: PRC_Request_Create
Description		: Create data
Databases       : HelpDesk
Called From		: 
Returns			: boolean (0 - failed, 1 - successful)
Created By		: Alex
QA'ed By        : 
Create Date		: 2/Aug/2015
---------------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[PRC_Request_Create]
@In_Request_Summary varchar(50),  
@In_Request_detail varchar(2000),
@In_Creation_Date datetime
AS
BEGIN 
   DECLARE @newId Integer
   Begin Tran
	INSERT INTO Request VALUES (@In_Request_Summary, @In_Request_detail,Getdate())
	SET @newId = SCOPE_IDENTITY() 
	if (@@error != 0)
	  begin 
		ROLLBACK Tran;
		return 0;
	  end		
	else
	  begin 
		COMMIT Tran;
		return @newId;
	  end
END

GO
/****** Object:  StoredProcedure [dbo].[PRC_Request_Update]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-------------------------------------------------------------------------
Procedure Name	: PRC_Request_Create
Description		: Update data
Databases       : HelpDesk
Called From		: 
Returns			: boolean (0 - failed, 1 - successful)
Created By		: Alex
QA'ed By        : 
Create Date		: 14/Aug/2015
---------------------------------------------------------------------------*/

Create PROCEDURE [dbo].[PRC_Request_Update]
@In_Request_Summary varchar(50),  
@In_Request_detail varchar(2000),
@In_Creation_Date datetime
AS
BEGIN 
   DECLARE @newId Integer
   Begin Tran
	Update Request
	set Request.Request_detail = @In_Request_detail,Request.Creation_Date = GETDATE()
	Where Request.Request_Summary = @In_Request_Summary
	SET @newId = SCOPE_IDENTITY() 
	if (@@error != 0)
	  begin 
		ROLLBACK Tran;
		return 0;
	  end		
	else
	  begin 
		COMMIT Tran;
		return @newId;
	  end
END
GO
/****** Object:  StoredProcedure [dbo].[PRC_UserRequestMapping_Create]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-------------------------------------------------------------------------
Procedure Name	: PRC_UserRequestMapping_Create
Description		: Create data
Databases       : HelpDesk
Called From		: 
Returns			: boolean (0 - failed, 1 - successful)
Created By		: Alex
QA'ed By        : 
Create Date		: 2/Aug/2014
---------------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[PRC_UserRequestMapping_Create]
@In_User_SID int, 
@In_Request_SID int  
AS
BEGIN 
   DECLARE @newId Integer
   Begin Tran
	INSERT INTO UserRequestMapping VALUES (@In_User_SID, @In_Request_SID)
	SET @newId = SCOPE_IDENTITY() 
	if (@@error != 0)
	  begin 
		ROLLBACK Tran;
		return 0;
	  end		
	else
	  begin 
		COMMIT Tran;
		return @newId;
	  end
END

GO
/****** Object:  Table [dbo].[Application_User]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Application_User](
	[User_SID] [int] IDENTITY(1,1) NOT NULL,
	[User_Name] [varchar](50) NOT NULL,
	[User_Password] [varchar](20) NOT NULL,
	[User_Role] [varchar](50) NOT NULL,
	[User_Address] [varchar](50) NOT NULL,
	[User_Mobile] [int] NOT NULL,
	[User_Email] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[User_SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Modification]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Modification](
	[Modification_SID] [int] IDENTITY(1,1) NOT NULL,
	[Request_SID] [int] NOT NULL,
	[Contract_Time] [varchar](50) NOT NULL,
	[Interaction_Type] [varchar](50) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[Modification_Date] [datetime] NOT NULL,
	[Modified_by] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Modification_SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Request]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Request](
	[Request_SID] [int] IDENTITY(1,1) NOT NULL,
	[Request_Summary] [varchar](50) NOT NULL,
	[Request_detail] [varchar](2000) NOT NULL,
	[Creation_Date] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Request_SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRequestMapping]    Script Date: 2015/8/14 9:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRequestMapping](
	[UserRequestMapping_SID] [int] IDENTITY(1,1) NOT NULL,
	[User_SID] [int] NOT NULL,
	[Request_SID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRequestMapping_SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Modification] ADD  DEFAULT (getdate()) FOR [Modification_Date]
GO
ALTER TABLE [dbo].[Request] ADD  DEFAULT (getdate()) FOR [Creation_Date]
GO
ALTER TABLE [dbo].[Modification]  WITH CHECK ADD FOREIGN KEY([Modified_by])
REFERENCES [dbo].[Application_User] ([User_SID])
GO
ALTER TABLE [dbo].[Modification]  WITH CHECK ADD FOREIGN KEY([Request_SID])
REFERENCES [dbo].[Request] ([Request_SID])
GO
ALTER TABLE [dbo].[UserRequestMapping]  WITH CHECK ADD FOREIGN KEY([Request_SID])
REFERENCES [dbo].[Request] ([Request_SID])
GO
ALTER TABLE [dbo].[UserRequestMapping]  WITH CHECK ADD FOREIGN KEY([User_SID])
REFERENCES [dbo].[Application_User] ([User_SID])
GO
USE [master]
GO
ALTER DATABASE [HelpDesk] SET  READ_WRITE 
GO
