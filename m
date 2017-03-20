Received: from eggs.gnu.org ([2001:4830:134:3::10]:40744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qe-0001cv-Da
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qa-0004rJ-6g
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QZ-0004qt-RP
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8YuX109702
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:26 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ak40pc06-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:26 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:25 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:51 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-28-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 27/81] 9pfs: local: open2: don't follow symlinks
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

The local_open2() callback is vulnerable to symlink attacks because it
calls:

(1) open() which follows symbolic links for all path elements but the
    rightmost one
(2) local_set_xattr()->setxattr() which follows symbolic links for all
    path elements
(3) local_set_mapped_file_attr() which calls in turn local_fopen() and
    mkdir(), both functions following symbolic links for all path
    elements but the rightmost one
(4) local_post_create_passthrough() which calls in turn lchown() and
    chmod(), both functions also following symbolic links

This patch converts local_open2() to rely on opendir_nofollow() and
mkdirat() to fix (1), as well as local_set_xattrat(),
local_set_mapped_file_attrat() and local_set_cred_passthrough() to
fix (2), (3) and (4) respectively. Since local_open2() already opens
a descriptor to the target file, local_set_cred_passthrough() is
modified to reuse it instead of opening a new one.

The mapped and mapped-file security modes are supposed to be identical,
except for the place where credentials and file modes are stored. While
here, we also make that explicit by sharing the call to openat().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit a565fea56546e254b7610305b07711f0a3bda0c7)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 56 ++++++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 76ac205..ea293e8 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -888,62 +888,45 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
 static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
                        int flags, FsCred *credp, V9fsFidOpenState *fs)
 {
-    char *path;
     int fd = -1;
     int err = -1;
-    int serrno = 0;
-    V9fsString fullname;
-    char *buffer = NULL;
+    int dirfd;
 
     /*
      * Mark all the open to not follow symlinks
      */
     flags |= O_NOFOLLOW;
 
-    v9fs_string_init(&fullname);
-    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
-    path = fullname.data;
+    dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
+    if (dirfd == -1) {
+        return -1;
+    }
 
     /* Determine the security model */
-    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        fd = open(buffer, flags, SM_LOCAL_MODE_BITS);
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
+        fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        fd = openat_file(dirfd, name, flags, SM_LOCAL_MODE_BITS);
         if (fd == -1) {
-            err = fd;
             goto out;
         }
         credp->fc_mode = credp->fc_mode|S_IFREG;
-        /* Set cleint credentials in xattr */
-        err = local_set_xattr(buffer, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
-    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        buffer = rpath(fs_ctx, path);
-        fd = open(buffer, flags, SM_LOCAL_MODE_BITS);
-        if (fd == -1) {
-            err = fd;
-            goto out;
+        if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+            /* Set cleint credentials in xattr */
+            err = local_set_xattrat(dirfd, name, credp);
+        } else {
+            err = local_set_mapped_file_attrat(dirfd, name, credp);
         }
-        credp->fc_mode = credp->fc_mode|S_IFREG;
-        /* Set client credentials in .virtfs_metadata directory files */
-        err = local_set_mapped_file_attr(fs_ctx, path, credp);
         if (err == -1) {
-            serrno = errno;
             goto err_end;
         }
     } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
                (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        fd = open(buffer, flags, credp->fc_mode);
+        fd = openat_file(dirfd, name, flags, credp->fc_mode);
         if (fd == -1) {
-            err = fd;
             goto out;
         }
-        err = local_post_create_passthrough(fs_ctx, path, credp);
+        err = local_set_cred_passthrough(fs_ctx, dirfd, name, credp);
         if (err == -1) {
-            serrno = errno;
             goto err_end;
         }
     }
@@ -952,12 +935,11 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
     goto out;
 
 err_end:
-    close(fd);
-    remove(buffer);
-    errno = serrno;
+    unlinkat_preserve_errno(dirfd, name,
+                            flags & O_DIRECTORY ? AT_REMOVEDIR : 0);
+    close_preserve_errno(fd);
 out:
-    g_free(buffer);
-    v9fs_string_free(&fullname);
+    close_preserve_errno(dirfd);
     return err;
 }
 
-- 
2.7.4
