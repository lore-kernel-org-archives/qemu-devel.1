Received: from eggs.gnu.org ([2001:4830:134:3::10]:40307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QU-0001Qo-9v
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QR-0004fd-2p
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QQ-0004ew-Q9
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Xg1128055
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:17 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ambn28yc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:17 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:16 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:34 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-11-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 10/81] 9pfs: local: lremovexattr: don't follow
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
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

The local_lremovexattr() callback is vulnerable to symlink attacks because
it calls lremovexattr() which follows symbolic links in all path elements
but the rightmost one.

This patch introduces a helper to emulate the non-existing fremovexattrat()
function: it is implemented with /proc/self/fd which provides a trusted
path that can be safely passed to lremovexattr().

local_lremovexattr() is converted to use this helper and opendir_nofollow().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 72f0d0bf51362011c4d841a89fb8f5cfb16e0bf3)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-posix-acl.c  | 10 ++--------
 hw/9pfs/9p-xattr-user.c |  8 +-------
 hw/9pfs/9p-xattr.c      | 36 +++++++++++++++++++++++++++++++-----
 hw/9pfs/9p-xattr.h      |  2 ++
 4 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/hw/9pfs/9p-posix-acl.c b/hw/9pfs/9p-posix-acl.c
index 0154e2a..bbf8906 100644
--- a/hw/9pfs/9p-posix-acl.c
+++ b/hw/9pfs/9p-posix-acl.c
@@ -58,10 +58,8 @@ static int mp_pacl_removexattr(FsContext *ctx,
                                const char *path, const char *name)
 {
     int ret;
-    char *buffer;
 
-    buffer = rpath(ctx, path);
-    ret  = lremovexattr(buffer, MAP_ACL_ACCESS);
+    ret = local_removexattr_nofollow(ctx, path, MAP_ACL_ACCESS);
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
+    ret = local_removexattr_nofollow(ctx, path, MAP_ACL_DEFAULT);
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
index 1840a5d..2c90817 100644
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
index a0167dd..eec160b 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -234,17 +234,43 @@ int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
     return local_setxattr_nofollow(ctx, path, name, value, size, flags);
 }
 
-int pt_removexattr(FsContext *ctx, const char *path, const char *name)
+static ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                       const char *name)
 {
-    char *buffer;
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
     int ret;
 
-    buffer = rpath(ctx, path);
-    ret = lremovexattr(path, name);
-    g_free(buffer);
+    ret = lremovexattr(proc_path, name);
+    g_free(proc_path);
     return ret;
 }
 
+ssize_t local_removexattr_nofollow(FsContext *ctx, const char *path,
+                                   const char *name)
+{
+    char *dirpath = g_path_get_dirname(path);
+    char *filename = g_path_get_basename(path);
+    int dirfd;
+    ssize_t ret = -1;
+
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = fremovexattrat_nofollow(dirfd, filename, name);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(filename);
+    return ret;
+}
+
+int pt_removexattr(FsContext *ctx, const char *path, const char *name)
+{
+    return local_removexattr_nofollow(ctx, path, name);
+}
+
 ssize_t notsup_getxattr(FsContext *ctx, const char *path, const char *name,
                         void *value, size_t size)
 {
diff --git a/hw/9pfs/9p-xattr.h b/hw/9pfs/9p-xattr.h
index 7558970..0d83996 100644
--- a/hw/9pfs/9p-xattr.h
+++ b/hw/9pfs/9p-xattr.h
@@ -34,6 +34,8 @@ ssize_t local_getxattr_nofollow(FsContext *ctx, const char *path,
 ssize_t local_setxattr_nofollow(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size,
                                 int flags);
+ssize_t local_removexattr_nofollow(FsContext *ctx, const char *path,
+                                   const char *name);
 
 extern XattrOperations mapped_user_xattr;
 extern XattrOperations passthrough_user_xattr;
-- 
2.7.4
