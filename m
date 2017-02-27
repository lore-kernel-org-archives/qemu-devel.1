Received: from eggs.gnu.org ([2001:4830:134:3::10]:47086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHt-0000gt-Ff
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHr-000493-Ug
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:01:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33465
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHr-00048L-N8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:59 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMraYP121510
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:59 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vn69xy0v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:58 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:57 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 00:00:17 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-28-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 27/31] 9pfs: local: symlink: don't follow
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

The local_symlink() callback is vulnerable to symlink attacks because it
calls:

(1) symlink() which follows symbolic links for all path elements but the
    rightmost one
(2) open(O_NOFOLLOW) which follows symbolic links for all path elements but
    the rightmost one
(3) local_set_xattr()->setxattr() which follows symbolic links for all
    path elements
(4) local_set_mapped_file_attr() which calls in turn local_fopen() and
    mkdir(), both functions following symbolic links for all path
    elements but the rightmost one

This patch converts local_symlink() to rely on opendir_nofollow() and
symlinkat() to fix (1), openat(O_NOFOLLOW) to fix (2), as well as
local_set_xattrat() and local_set_mapped_file_attrat() to fix (3) and
(4) respectively.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-local.c | 81 +++++++++++++++++-------------------------------------
 1 file changed, 25 insertions(+), 56 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 7c197417ebff..907ecc59d494 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -978,23 +978,22 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
                          V9fsPath *dir_path, const char *name, FsCred *credp)
 {
     int err = -1;
-    int serrno = 0;
-    char *newpath;
-    V9fsString fullname;
-    char *buffer = NULL;
+    int dirfd;
 
-    v9fs_string_init(&fullname);
-    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
-    newpath = fullname.data;
+    dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
+    if (dirfd == -1) {
+        return -1;
+    }
 
     /* Determine the security model */
-    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
+        fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         int fd;
         ssize_t oldpath_size, write_size;
-        buffer = rpath(fs_ctx, newpath);
-        fd = open(buffer, O_CREAT|O_EXCL|O_RDWR|O_NOFOLLOW, SM_LOCAL_MODE_BITS);
+
+        fd = openat_file(dirfd, name, O_CREAT | O_EXCL | O_RDWR,
+                         SM_LOCAL_MODE_BITS);
         if (fd == -1) {
-            err = fd;
             goto out;
         }
         /* Write the oldpath (target) to the file. */
@@ -1002,78 +1001,48 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
         do {
             write_size = write(fd, (void *)oldpath, oldpath_size);
         } while (write_size == -1 && errno == EINTR);
+        close_preserve_errno(fd);
 
         if (write_size != oldpath_size) {
-            serrno = errno;
-            close(fd);
-            err = -1;
             goto err_end;
         }
-        close(fd);
         /* Set cleint credentials in symlink's xattr */
-        credp->fc_mode = credp->fc_mode|S_IFLNK;
-        err = local_set_xattr(buffer, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
-    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        int fd;
-        ssize_t oldpath_size, write_size;
-        buffer = rpath(fs_ctx, newpath);
-        fd = open(buffer, O_CREAT|O_EXCL|O_RDWR|O_NOFOLLOW, SM_LOCAL_MODE_BITS);
-        if (fd == -1) {
-            err = fd;
-            goto out;
-        }
-        /* Write the oldpath (target) to the file. */
-        oldpath_size = strlen(oldpath);
-        do {
-            write_size = write(fd, (void *)oldpath, oldpath_size);
-        } while (write_size == -1 && errno == EINTR);
+        credp->fc_mode = credp->fc_mode | S_IFLNK;
 
-        if (write_size != oldpath_size) {
-            serrno = errno;
-            close(fd);
-            err = -1;
-            goto err_end;
+        if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+            err = local_set_xattrat(dirfd, name, credp);
+        } else {
+            err = local_set_mapped_file_attrat(dirfd, name, credp);
         }
-        close(fd);
-        /* Set cleint credentials in symlink's xattr */
-        credp->fc_mode = credp->fc_mode|S_IFLNK;
-        err = local_set_mapped_file_attr(fs_ctx, newpath, credp);
         if (err == -1) {
-            serrno = errno;
             goto err_end;
         }
-    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
-               (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, newpath);
-        err = symlink(oldpath, buffer);
+    } else if (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH ||
+               fs_ctx->export_flags & V9FS_SM_NONE) {
+        err = symlinkat(oldpath, dirfd, name);
         if (err) {
             goto out;
         }
-        err = lchown(buffer, credp->fc_uid, credp->fc_gid);
+        err = fchownat(dirfd, name, credp->fc_uid, credp->fc_gid,
+                       AT_SYMLINK_NOFOLLOW);
         if (err == -1) {
             /*
              * If we fail to change ownership and if we are
              * using security model none. Ignore the error
              */
             if ((fs_ctx->export_flags & V9FS_SEC_MASK) != V9FS_SM_NONE) {
-                serrno = errno;
                 goto err_end;
-            } else
+            } else {
                 err = 0;
+            }
         }
     }
     goto out;
 
 err_end:
-    remove(buffer);
-    errno = serrno;
+    unlinkat_preserve_errno(dirfd, name, 0);
 out:
-    g_free(buffer);
-    v9fs_string_free(&fullname);
+    close_preserve_errno(dirfd);
     return err;
 }
 
-- 
2.7.4
