Received: from eggs.gnu.org ([2001:4830:134:3::10]:54167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp98-0006hG-LJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp95-0003iN-F6
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35047
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp95-0003i9-8g
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEcqr9039659
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:54 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qv468d2u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:54 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:40:53 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:40:45 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760164565.31154.18106542980362196249.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 11/29] 9pfs: local: lremovexattr: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

The local_lremovexattr() callback is vulnerable to symlink attacks because
it calls lremovexattr() which follows symbolic links in all path elements but
the rightmost one.

This patch converts local_lremovexattr() to rely on opendir_nofollow() and
fremovexattrat_nofollow() instead.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-posix-acl.c  |   10 ++--------
 hw/9pfs/9p-xattr-user.c |    8 +-------
 hw/9pfs/9p-xattr.c      |    8 +-------
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/hw/9pfs/9p-posix-acl.c b/hw/9pfs/9p-posix-acl.c
index 0154e2a7605f..c20409104135 100644
--- a/hw/9pfs/9p-posix-acl.c
+++ b/hw/9pfs/9p-posix-acl.c
@@ -58,10 +58,8 @@ static int mp_pacl_removexattr(FsContext *ctx,
                                const char *path, const char *name)
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
index 1840a5db66f3..2c90817b75a6 100644
--- a/hw/9pfs/9p-xattr-user.c
+++ b/hw/9pfs/9p-xattr-user.c
@@ -81,9 +81,6 @@ static int mp_user_setxattr(FsContext *ctx, const char *path, const char *name,
 static int mp_user_removexattr(FsContext *ctx,
                                const char *path, const char *name)
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
index 72ef820f16d7..6fbfbca7e9a0 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -333,13 +333,7 @@ int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
 
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
