Received: from eggs.gnu.org ([2001:4830:134:3::10]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpB1-0000Ks-Bb
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpAy-00045O-5U
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39525
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfpAx-00045J-Ua
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:52 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEdOd3114204
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:51 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28pgs4wbbf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:51 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:42:48 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:42:42 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760176237.31154.7566198284512559524.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 26/29] 9pfs: local: mknod: don't follow symlinks
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

The local_mknod() callback is vulnerable to symlink attacks because it
calls:

(1) mknod() which follows symbolic links for all path elements but the
    rightmost one
(2) local_set_xattr()->setxattr() which follows symbolic links for all
    path elements
(3) local_set_mapped_file_attr() which calls in turn local_fopen() and
    mkdir(), both functions following symbolic links for all path
    elements but the rightmost one
(4) local_post_create_passthrough() which calls in turn lchown() and
    chmod(), both functions also following symbolic links

This patch converts local_mknod() to rely on opendir_nofollow() and
mknodat() to fix (1), as well as local_set_xattrat() and
local_set_mapped_file_attrat() to fix (2) and (3) respectively.

A new local_set_cred_passthrough() helper based on fchownat() and fchmod()
is introduced as a replacement to local_post_create_passthrough() to fix (4).
No effort is made to factor out code because local_post_create_passthrough()
will be dropped when all users have been converted to call the new helper.

The mapped and mapped-file security modes are supposed to be identical,
except for the place where credentials and file modes are stored. While
here, we also make that explicit by sharing the call to mknodat().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   82 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 9c4faae0b3a2..89357b9486e3 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -509,6 +509,37 @@ err:
     return -1;
 }
 
+static int local_set_cred_passthrough(FsContext *fs_ctx, int dirfd,
+                                      const char *name, FsCred *credp)
+{
+    int fd, err = -1;
+
+    if (fchownat(dirfd, name, credp->fc_uid, credp->fc_gid,
+                 AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH) < 0) {
+        /*
+         * If we fail to change ownership and if we are
+         * using security model none. Ignore the error
+         */
+        if ((fs_ctx->export_flags & V9FS_SEC_MASK) != V9FS_SM_NONE) {
+            return -1;
+        }
+    }
+
+    fd = openat_nofollow(dirfd, name, O_RDONLY, 0);
+    if (fd == -1) {
+        return -1;
+    }
+
+    if (fchmod(fd, credp->fc_mode & 07777) < 0) {
+        goto out;
+    }
+    err = 0;
+
+out:
+    close_preserve_errno(fd);
+    return err;
+}
+
 static ssize_t local_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
                               char *buf, size_t bufsz)
 {
@@ -712,61 +743,46 @@ static int local_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
                        const char *name, FsCred *credp)
 {
-    char *path;
     int err = -1;
-    int serrno = 0;
-    V9fsString fullname;
-    char *buffer = NULL;
+    int dirfd;
 
-    v9fs_string_init(&fullname);
-    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
-    path = fullname.data;
+    dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
+    if (dirfd == -1) {
+        return -1;
+    }
 
-    /* Determine the security model */
-    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        err = mknod(buffer, SM_LOCAL_MODE_BITS|S_IFREG, 0);
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
+        fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        err = mknodat(dirfd, name, SM_LOCAL_MODE_BITS | S_IFREG, 0);
         if (err == -1) {
             goto out;
         }
-        err = local_set_xattr(buffer, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
-    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
 
-        buffer = rpath(fs_ctx, path);
-        err = mknod(buffer, SM_LOCAL_MODE_BITS|S_IFREG, 0);
-        if (err == -1) {
-            goto out;
+        if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+            err = local_set_xattrat(dirfd, name, credp);
+        } else {
+            err = local_set_mapped_file_attrat(dirfd, name, credp);
         }
-        err = local_set_mapped_file_attr(fs_ctx, path, credp);
         if (err == -1) {
-            serrno = errno;
             goto err_end;
         }
-    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
-               (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        err = mknod(buffer, credp->fc_mode, credp->fc_rdev);
+    } else if (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH ||
+               fs_ctx->export_flags & V9FS_SM_NONE) {
+        err = mknodat(dirfd, name, credp->fc_mode, credp->fc_rdev);
         if (err == -1) {
             goto out;
         }
-        err = local_post_create_passthrough(fs_ctx, path, credp);
+        err = local_set_cred_passthrough(fs_ctx, dirfd, name, credp);
         if (err == -1) {
-            serrno = errno;
             goto err_end;
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
 
