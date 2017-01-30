Received: from eggs.gnu.org ([2001:4830:134:3::10]:46573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAqo-0000GM-Hn
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAql-00014Z-E4
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:14:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38774
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAql-00014T-9N
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:14:23 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UCEDZQ022492
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:14:23 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a3d3d8wp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:14:22 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:14:19 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:14:12 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577845274.10533.5364955445893182409.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 36/36] 9pfs: local: lremovexattr: don't
 follow symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This fixes CVE-2016-9602 for all security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-posix-acl.c  |   14 ++++----------
 hw/9pfs/9p-xattr-user.c |   12 +++---------
 hw/9pfs/9p-xattr.c      |    8 +-------
 3 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/hw/9pfs/9p-posix-acl.c b/hw/9pfs/9p-posix-acl.c
index 0154e2a7605f..73aee0e9d1fa 100644
--- a/hw/9pfs/9p-posix-acl.c
+++ b/hw/9pfs/9p-posix-acl.c
@@ -54,14 +54,12 @@ static int mp_pacl_setxattr(FsContext *ctx, const char *path, const char *name,
                                    flags);
 }
 
-static int mp_pacl_removexattr(FsContext *ctx,
-                               const char *path, const char *name)
+static int mp_pacl_removexattr(FsContext *ctx, const char *path,
+                               const char *name)
 {
     int ret;
-    char *buffer;
 
-    buffer = rpath(ctx, path);
-    ret  = lremovexattr(buffer, MAP_ACL_ACCESS);
+    ret = local_removexattr_nofollow(ctx, MAP_ACL_ACCESS, name);
     if (ret == -1 && errno == ENODATA) {
         /*
          * We don't get ENODATA error when trying to remove a
@@ -71,7 +69,6 @@ static int mp_pacl_removexattr(FsContext *ctx,
         errno = 0;
         ret = 0;
     }
-    g_free(buffer);
     return ret;
 }
 
@@ -111,10 +108,8 @@ static int mp_dacl_removexattr(FsContext *ctx,
                                const char *path, const char *name)
 {
     int ret;
-    char *buffer;
 
-    buffer = rpath(ctx, path);
-    ret  = lremovexattr(buffer, MAP_ACL_DEFAULT);
+    ret = local_removexattr_nofollow(ctx, MAP_ACL_DEFAULT, name);
     if (ret == -1 && errno == ENODATA) {
         /*
          * We don't get ENODATA error when trying to remove a
@@ -124,7 +119,6 @@ static int mp_dacl_removexattr(FsContext *ctx,
         errno = 0;
         ret = 0;
     }
-    g_free(buffer);
     return ret;
 }
 
diff --git a/hw/9pfs/9p-xattr-user.c b/hw/9pfs/9p-xattr-user.c
index 1840a5db66f3..ec606a4146a7 100644
--- a/hw/9pfs/9p-xattr-user.c
+++ b/hw/9pfs/9p-xattr-user.c
@@ -78,12 +78,9 @@ static int mp_user_setxattr(FsContext *ctx, const char *path, const char *name,
     return local_setxattr_nofollow(ctx, path, name, value, size, flags);
 }
 
-static int mp_user_removexattr(FsContext *ctx,
-                               const char *path, const char *name)
+static int mp_user_removexattr(FsContext *ctx, const char *path,
+                               const char *name)
 {
-    char *buffer;
-    int ret;
-
     if (strncmp(name, "user.virtfs.", 12) == 0) {
         /*
          * Don't allow fetch of user.virtfs namesapce
@@ -92,10 +89,7 @@ static int mp_user_removexattr(FsContext *ctx,
         errno = EACCES;
         return -1;
     }
-    buffer = rpath(ctx, path);
-    ret = lremovexattr(buffer, name);
-    g_free(buffer);
-    return ret;
+    return local_removexattr_nofollow(ctx, path, name);
 }
 
 XattrOperations mapped_user_xattr = {
diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 053ab6eff692..bbfef248e767 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -331,13 +331,7 @@ int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
 
 int pt_removexattr(FsContext *ctx, const char *path, const char *name)
 {
-    char *buffer;
-    int ret;
-
-    buffer = rpath(ctx, path);
-    ret = lremovexattr(path, name);
-    g_free(buffer);
-    return ret;
+    return local_removexattr_nofollow(ctx, path, name);
 }
 
 ssize_t notsup_getxattr(FsContext *ctx, const char *path, const char *name,
