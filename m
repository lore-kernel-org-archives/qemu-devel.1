Received: from eggs.gnu.org ([2001:4830:134:3::10]:40246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QT-0001Qh-4x
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QP-0004eY-QL
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QP-0004df-Gr
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:17 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Zuc020723
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:16 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 299yqc6ydr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:15 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:15 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:33 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-10-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 09/81] 9pfs: local: lsetxattr: don't follow
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
(cherry picked from commit 3e36aba757f76673007a80b3cd56a4062c2e3462)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-posix-acl.c  | 18 ++++--------------
 hw/9pfs/9p-util.h       |  2 ++
 hw/9pfs/9p-xattr-user.c |  8 +-------
 hw/9pfs/9p-xattr.c      | 39 +++++++++++++++++++++++++++++++++------
 hw/9pfs/9p-xattr.h      |  3 +++
 5 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/hw/9pfs/9p-posix-acl.c b/hw/9pfs/9p-posix-acl.c
index 9435e27..0154e2a 100644
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
index 676641f..091f3ce 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -48,5 +48,7 @@ int relative_openat_nofollow(int dirfd, const char *path, int flags,
                              mode_t mode);
 ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
                              void *value, size_t size);
+int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
+                         void *value, size_t size, int flags);
 
 #endif
diff --git a/hw/9pfs/9p-xattr-user.c b/hw/9pfs/9p-xattr-user.c
index 4071fbc..1840a5d 100644
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
index 54193c6..a0167dd 100644
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
index 69a8b6b..7558970 100644
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
