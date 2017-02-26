Received: from eggs.gnu.org ([2001:4830:134:3::10]:50985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Yn-0007D7-0h
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Yj-00037a-Qt
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:44:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ci7Yj-00037T-Gz
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:44:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1QMi2fT000947
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:44:52 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u640d91x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:44:52 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sun, 26 Feb 2017 15:44:51 -0700
From: Greg Kurz <groug@kaod.org>
Date: Sun, 26 Feb 2017 23:44:46 +0100
In-Reply-To: <148814889214.28146.16915712763478774662.stgit@bahia>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148814908593.28146.3393343891347627324.stgit@bahia>
Subject: [Qemu-devel] [PATCH v2 24/28] 9pfs: local: symlink: don't follow
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
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

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
v2: - use openat_file()
---
 hw/9pfs/9p-local.c |   81 ++++++++++++++++------------------------------------
 1 file changed, 25 insertions(+), 56 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 0bacf722edfe..b87cb7defca5 100644
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
 
