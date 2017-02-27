Received: from eggs.gnu.org ([2001:4830:134:3::10]:46797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHj-0000Vp-5g
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHh-0003vU-Hn
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49078
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHh-0003uY-Ad
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMrapt122537
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:48 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vrp83aj8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:48 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:46 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 00:00:02 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-13-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 12/31] 9pfs: local: lsetxattr: don't follow
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The local_lsetxattr() callback is vulnerable to symlink attacks because
it calls lsetxattr() which follows symbolic links in all path elements but
the rightmost one.

This patch introduces a helper to emulate the non-existing fsetxattrat()
function: it is implemented with /proc/self/fd which provides a trusted
path that can be safely passed to lsetxattr().

local_lsetxattr() is converted to use this helper and opendir_nofollow().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-posix-acl.c  | 18 ++++--------------
 hw/9pfs/9p-util.h       |  2 ++
 hw/9pfs/9p-xattr-user.c |  8 +-------
 hw/9pfs/9p-xattr.c      | 39 +++++++++++++++++++++++++++++++++------
 hw/9pfs/9p-xattr.h      |  3 +++
 5 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/hw/9pfs/9p-posix-acl.c b/hw/9pfs/9p-posix-acl.c
index 9435e27a368c..0154e2a7605f 100644
--- a/hw/9pfs/9p-posix-acl.c
+++ b/hw/9pfs/9p-posix-acl.c
@@ -50,13 +50,8 @@ static ssize_t mp_pacl_listxattr(FsContext *ctx, const char *path,
 static int mp_pacl_setxattr(FsContext *ctx, const char *path, const char *name,
                             void *value, size_t size, int flags)
 {
-    char *buffer;
-    int ret;
-
-    buffer = rpath(ctx, path);
-    ret = lsetxattr(buffer, MAP_ACL_ACCESS, value, size, flags);
-    g_free(buffer);
-    return ret;
+    return local_setxattr_nofollow(ctx, path, MAP_ACL_ACCESS, value, size,
+                                   flags);
 }
 
 static int mp_pacl_removexattr(FsContext *ctx,
@@ -108,13 +103,8 @@ static ssize_t mp_dacl_listxattr(FsContext *ctx, const char *path,
 static int mp_dacl_setxattr(FsContext *ctx, const char *path, const char *name,
                             void *value, size_t size, int flags)
 {
-    char *buffer;
-    int ret;
-
-    buffer = rpath(ctx, path);
-    ret = lsetxattr(buffer, MAP_ACL_DEFAULT, value, size, flags);
-    g_free(buffer);
-    return ret;
+    return local_setxattr_nofollow(ctx, path, MAP_ACL_DEFAULT, value, size,
+                                   flags);
 }
 
 static int mp_dacl_removexattr(FsContext *ctx,
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 806af82dcdbb..aea07a428958 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -47,5 +47,7 @@ int relative_openat_nofollow(int dirfd, const char *path, int flags,
                              mode_t mode);
 ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
                              void *value, size_t size);
+int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
+                         void *value, size_t size, int flags);
 
 #endif
diff --git a/hw/9pfs/9p-xattr-user.c b/hw/9pfs/9p-xattr-user.c
index 4071fbc4c086..1840a5db66f3 100644
--- a/hw/9pfs/9p-xattr-user.c
+++ b/hw/9pfs/9p-xattr-user.c
@@ -67,9 +67,6 @@ static ssize_t mp_user_listxattr(FsContext *ctx, const char *path,
 static int mp_user_setxattr(FsContext *ctx, const char *path, const char *name,
                             void *value, size_t size, int flags)
 {
-    char *buffer;
-    int ret;
-
     if (strncmp(name, "user.virtfs.", 12) == 0) {
         /*
          * Don't allow fetch of user.virtfs namesapce
@@ -78,10 +75,7 @@ static int mp_user_setxattr(FsContext *ctx, const char *path, const char *name,
         errno = EACCES;
         return -1;
     }
-    buffer = rpath(ctx, path);
-    ret = lsetxattr(buffer, name, value, size, flags);
-    g_free(buffer);
-    return ret;
+    return local_setxattr_nofollow(ctx, path, name, value, size, flags);
 }
 
 static int mp_user_removexattr(FsContext *ctx,
diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 54193c630c9d..a0167dd4d898 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -195,18 +195,45 @@ ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
     return local_getxattr_nofollow(ctx, path, name, value, size);
 }
 
-int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
-                size_t size, int flags)
+int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                         void *value, size_t size, int flags)
 {
-    char *buffer;
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
     int ret;
 
-    buffer = rpath(ctx, path);
-    ret = lsetxattr(buffer, name, value, size, flags);
-    g_free(buffer);
+    ret = lsetxattr(proc_path, name, value, size, flags);
+    g_free(proc_path);
+    return ret;
+}
+
+ssize_t local_setxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size,
+                                int flags)
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
+    ret = fsetxattrat_nofollow(dirfd, filename, name, value, size, flags);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(filename);
     return ret;
 }
 
+int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
+                size_t size, int flags)
+{
+    return local_setxattr_nofollow(ctx, path, name, value, size, flags);
+}
+
 int pt_removexattr(FsContext *ctx, const char *path, const char *name)
 {
     char *buffer;
diff --git a/hw/9pfs/9p-xattr.h b/hw/9pfs/9p-xattr.h
index 69a8b6b62e3c..7558970d8511 100644
--- a/hw/9pfs/9p-xattr.h
+++ b/hw/9pfs/9p-xattr.h
@@ -31,6 +31,9 @@ typedef struct xattr_operations
 
 ssize_t local_getxattr_nofollow(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size);
+ssize_t local_setxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size,
+                                int flags);
 
 extern XattrOperations mapped_user_xattr;
 extern XattrOperations passthrough_user_xattr;
-- 
2.7.4
