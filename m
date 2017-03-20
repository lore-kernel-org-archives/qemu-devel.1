Received: from eggs.gnu.org ([2001:4830:134:3::10]:42108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6RC-0002E2-Kv
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R0-0005Mg-0H
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40087
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qz-0005Le-Q9
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8aqO119508
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29ajfe8ny9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:53 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:52 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:31 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-8-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 07/81] 9pfs: local: lgetxattr: don't follow
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

The local_lgetxattr() callback is vulnerable to symlink attacks because
it calls lgetxattr() which follows symbolic links in all path elements but
the rightmost one.

This patch introduces a helper to emulate the non-existing fgetxattrat()
function: it is implemented with /proc/self/fd which provides a trusted
path that can be safely passed to lgetxattr().

local_lgetxattr() is converted to use this helper and opendir_nofollow().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 56ad3e54dad6cdcee8668d170df161d89581846f)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-posix-acl.c  | 16 ++--------------
 hw/9pfs/9p-util.c       | 12 ++++++++++++
 hw/9pfs/9p-util.h       |  2 ++
 hw/9pfs/9p-xattr-user.c |  8 +-------
 hw/9pfs/9p-xattr.c      | 31 ++++++++++++++++++++++++-------
 hw/9pfs/9p-xattr.h      |  2 ++
 6 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/hw/9pfs/9p-posix-acl.c b/hw/9pfs/9p-posix-acl.c
index ec00318..9435e27 100644
--- a/hw/9pfs/9p-posix-acl.c
+++ b/hw/9pfs/9p-posix-acl.c
@@ -25,13 +25,7 @@
 static ssize_t mp_pacl_getxattr(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size)
 {
-    char *buffer;
-    ssize_t ret;
-
-    buffer = rpath(ctx, path);
-    ret = lgetxattr(buffer, MAP_ACL_ACCESS, value, size);
-    g_free(buffer);
-    return ret;
+    return local_getxattr_nofollow(ctx, path, MAP_ACL_ACCESS, value, size);
 }
 
 static ssize_t mp_pacl_listxattr(FsContext *ctx, const char *path,
@@ -89,13 +83,7 @@ static int mp_pacl_removexattr(FsContext *ctx,
 static ssize_t mp_dacl_getxattr(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size)
 {
-    char *buffer;
-    ssize_t ret;
-
-    buffer = rpath(ctx, path);
-    ret = lgetxattr(buffer, MAP_ACL_DEFAULT, value, size);
-    g_free(buffer);
-    return ret;
+    return local_getxattr_nofollow(ctx, path, MAP_ACL_DEFAULT, value, size);
 }
 
 static ssize_t mp_dacl_listxattr(FsContext *ctx, const char *path,
diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
index 54134b0..fdb4d57 100644
--- a/hw/9pfs/9p-util.c
+++ b/hw/9pfs/9p-util.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/xattr.h"
 #include "9p-util.h"
 
 int relative_openat_nofollow(int dirfd, const char *path, int flags,
@@ -55,3 +56,14 @@ int relative_openat_nofollow(int dirfd, const char *path, int flags,
 
     return fd;
 }
+
+ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                             void *value, size_t size)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = lgetxattr(proc_path, name, value, size);
+    g_free(proc_path);
+    return ret;
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index e80b5a5..676641f 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -46,5 +46,7 @@ static inline int openat_file(int dirfd, const char *name, int flags,
 
 int relative_openat_nofollow(int dirfd, const char *path, int flags,
                              mode_t mode);
+ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
+                             void *value, size_t size);
 
 #endif
diff --git a/hw/9pfs/9p-xattr-user.c b/hw/9pfs/9p-xattr-user.c
index f87530c..4071fbc 100644
--- a/hw/9pfs/9p-xattr-user.c
+++ b/hw/9pfs/9p-xattr-user.c
@@ -20,9 +20,6 @@
 static ssize_t mp_user_getxattr(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size)
 {
-    char *buffer;
-    ssize_t ret;
-
     if (strncmp(name, "user.virtfs.", 12) == 0) {
         /*
          * Don't allow fetch of user.virtfs namesapce
@@ -31,10 +28,7 @@ static ssize_t mp_user_getxattr(FsContext *ctx, const char *path,
         errno = ENOATTR;
         return -1;
     }
-    buffer = rpath(ctx, path);
-    ret = lgetxattr(buffer, name, value, size);
-    g_free(buffer);
-    return ret;
+    return local_getxattr_nofollow(ctx, path, name, value, size);
 }
 
 static ssize_t mp_user_listxattr(FsContext *ctx, const char *path,
diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 19a2daf..aa4391e 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -15,6 +15,8 @@
 #include "9p.h"
 #include "fsdev/file-op-9p.h"
 #include "9p-xattr.h"
+#include "9p-util.h"
+#include "9p-local.h"
 
 
 static XattrOperations *get_xattr_operations(XattrOperations **h,
@@ -143,18 +145,33 @@ int v9fs_remove_xattr(FsContext *ctx,
 
 }
 
-ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
-                    void *value, size_t size)
+ssize_t local_getxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size)
 {
-    char *buffer;
-    ssize_t ret;
+    char *dirpath = g_path_get_dirname(path);
+    char *filename = g_path_get_basename(path);
+    int dirfd;
+    ssize_t ret = -1;
+
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
 
-    buffer = rpath(ctx, path);
-    ret = lgetxattr(buffer, name, value, size);
-    g_free(buffer);
+    ret = fgetxattrat_nofollow(dirfd, filename, name, value, size);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(filename);
     return ret;
 }
 
+ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
+                    void *value, size_t size)
+{
+    return local_getxattr_nofollow(ctx, path, name, value, size);
+}
+
 int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
                 size_t size, int flags)
 {
diff --git a/hw/9pfs/9p-xattr.h b/hw/9pfs/9p-xattr.h
index 3f43f51..69a8b6b 100644
--- a/hw/9pfs/9p-xattr.h
+++ b/hw/9pfs/9p-xattr.h
@@ -29,6 +29,8 @@ typedef struct xattr_operations
                        const char *path, const char *name);
 } XattrOperations;
 
+ssize_t local_getxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size);
 
 extern XattrOperations mapped_user_xattr;
 extern XattrOperations passthrough_user_xattr;
-- 
2.7.4
