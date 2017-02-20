Received: from eggs.gnu.org ([2001:4830:134:3::10]:54868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpBH-0000XG-3i
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:43:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpBD-00049M-TF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:43:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfpBD-000498-J1
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:43:07 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEdAeq048770
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:43:06 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pphvhs3v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:43:06 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:43:05 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:42:58 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760177893.31154.1632894671963250618.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 28/29] 9pfs: local: open2: don't follow symlinks
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
---
 hw/9pfs/9p-local.c |   70 ++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 85c0ea813baf..730cc37b765f 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -525,9 +525,13 @@ static int local_set_cred_passthrough(FsContext *fs_ctx, int dirfd,
         }
     }
 
-    fd = openat_nofollow(dirfd, name, O_RDONLY, 0);
-    if (fd == -1) {
-        return -1;
+    if (name[0]) {
+        fd = openat_nofollow(dirfd, name, O_RDONLY, 0);
+        if (fd == -1) {
+            return -1;
+        }
+    } else {
+        fd = dirfd;
     }
 
     if (fchmod(fd, credp->fc_mode & 07777) < 0) {
@@ -536,7 +540,9 @@ static int local_set_cred_passthrough(FsContext *fs_ctx, int dirfd,
     err = 0;
 
 out:
-    close_preserve_errno(fd);
+    if (name[0]) {
+        close_preserve_errno(fd);
+    }
     return err;
 }
 
@@ -877,62 +883,45 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
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
+        fd = openat(dirfd, name, flags, SM_LOCAL_MODE_BITS);
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
+        fd = openat(dirfd, name, flags, credp->fc_mode);
         if (fd == -1) {
-            err = fd;
             goto out;
         }
-        err = local_post_create_passthrough(fs_ctx, path, credp);
+        err = local_set_cred_passthrough(fs_ctx, fd, "", credp);
         if (err == -1) {
-            serrno = errno;
             goto err_end;
         }
     }
@@ -941,12 +930,11 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
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
 
