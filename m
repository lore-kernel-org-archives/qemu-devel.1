Received: from eggs.gnu.org ([2001:4830:134:3::10]:46096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApA-0007Eb-Oa
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAp7-0000XN-JQ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAp7-0000XD-9U
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:41 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8q6k054235
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:40 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a37q5hje-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:40 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:12:39 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:12:32 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577835232.10533.7425882944487667514.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 23/36] 9pfs: local: mknod/mkdir/open2:
 don't follow symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This fixes CVE-2016-9602 for the "passthrough" security model.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |  128 ++++++++++++++++++++++++----------------------------
 1 file changed, 59 insertions(+), 69 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index dbc56b16979c..48d46b6abd28 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -77,6 +77,13 @@ char *local_basename(const char *path)
     return result;
 }
 
+static void unlinkat_preserve_errno(int dirfd, const char *path, int flags)
+{
+    int serrno = errno;
+    unlinkat(dirfd, path, flags);
+    errno = serrno;
+}
+
 #define VIRTFS_META_DIR ".virtfs_metadata"
 
 static char *local_mapped_attr_path(FsContext *ctx, const char *path)
@@ -319,31 +326,41 @@ static int local_set_xattr(const char *path, FsCred *credp)
     return 0;
 }
 
-static int local_post_create_passthrough(FsContext *fs_ctx, const char *path,
-                                         FsCred *credp)
+static int local_post_create_passthrough(FsContext *fs_ctx, int dirfd,
+                                         const char *name, FsCred *credp)
 {
-    char *buffer;
+    int fd, err = -1;
 
-    buffer = rpath(fs_ctx, path);
-    if (lchown(buffer, credp->fc_uid, credp->fc_gid) < 0) {
+    if (fchownat(dirfd, name, credp->fc_uid, credp->fc_gid,
+                 AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH) < 0) {
         /*
          * If we fail to change ownership and if we are
          * using security model none. Ignore the error
          */
         if ((fs_ctx->export_flags & V9FS_SEC_MASK) != V9FS_SM_NONE) {
-            goto err;
+            return -1;
         }
     }
 
-    if (chmod(buffer, credp->fc_mode & 07777) < 0) {
-        goto err;
+    if (name[0]) {
+        fd = openat_nofollow(dirfd, name, O_RDONLY, 0);
+        if (fd == -1) {
+            return -1;
+        }
+    } else {
+        fd = dirfd;
     }
 
-    g_free(buffer);
-    return 0;
-err:
-    g_free(buffer);
-    return -1;
+    if (fchmod(fd, credp->fc_mode & 07777) < 0) {
+        goto out;
+    }
+    err = 0;
+
+out:
+    if (name[0]) {
+        close_preserve_errno(fd);
+    }
+    return err;
 }
 
 static int readlink_nofollow(FsContext *fs_ctx, const char *path, char *buf,
@@ -637,34 +654,27 @@ out:
 static int local_mknod_passthrough(FsContext *fs_ctx, V9fsPath *dir_path,
                                    const char *name, FsCred *credp)
 {
-    char *path;
-    int err = -1;
-    int serrno = 0;
-    V9fsString fullname;
-    char *buffer = NULL;
+    int dirfd, err;
 
-    v9fs_string_init(&fullname);
-    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
-    path = fullname.data;
+    dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
+    if (dirfd == -1) {
+        return -1;
+    }
 
-    buffer = rpath(fs_ctx, path);
-    err = mknod(buffer, credp->fc_mode, credp->fc_rdev);
+    err = mknodat(dirfd, name, credp->fc_mode, credp->fc_rdev);
     if (err == -1) {
         goto out;
     }
-    err = local_post_create_passthrough(fs_ctx, path, credp);
+    err = local_post_create_passthrough(fs_ctx, dirfd, name, credp);
     if (err == -1) {
-        serrno = errno;
         goto err_end;
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
 
@@ -755,34 +765,27 @@ out:
 static int local_mkdir_passthrough(FsContext *fs_ctx, V9fsPath *dir_path,
                                    const char *name, FsCred *credp)
 {
-    char *path;
-    int err = -1;
-    int serrno = 0;
-    V9fsString fullname;
-    char *buffer = NULL;
+    int dirfd, err;
 
-    v9fs_string_init(&fullname);
-    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
-    path = fullname.data;
+    dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
+    if (dirfd == -1) {
+        return -1;
+    }
 
-    buffer = rpath(fs_ctx, path);
-    err = mkdir(buffer, credp->fc_mode);
+    err = mkdirat(dirfd, name, credp->fc_mode);
     if (err == -1) {
         goto out;
     }
-    err = local_post_create_passthrough(fs_ctx, path, credp);
+    err = local_post_create_passthrough(fs_ctx, dirfd, name, credp);
     if (err == -1) {
-        serrno = errno;
         goto err_end;
     }
     goto out;
 
 err_end:
-    remove(buffer);
-    errno = serrno;
+    unlinkat_preserve_errno(dirfd, name, AT_REMOVEDIR);
 out:
-    g_free(buffer);
-    v9fs_string_free(&fullname);
+    close_preserve_errno(dirfd);
     return err;
 }
 
@@ -939,44 +942,31 @@ static int local_open2_passthrough(FsContext *fs_ctx, V9fsPath *dir_path,
                                    const char *name, int flags, FsCred *credp,
                                    V9fsFidOpenState *fs)
 {
-    char *path;
-    int fd = -1;
     int err = -1;
-    int serrno = 0;
-    V9fsString fullname;
-    char *buffer = NULL;
+    int dirfd, fd;
 
-    /*
-     * Mark all the open to not follow symlinks
-     */
-    flags |= O_NOFOLLOW;
-
-    v9fs_string_init(&fullname);
-    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
-    path = fullname.data;
+    dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
+    if (dirfd == -1) {
+        return -1;
+    }
 
-    buffer = rpath(fs_ctx, path);
-    fd = open(buffer, flags, credp->fc_mode);
+    fd = openat(dirfd, name, flags | O_NOFOLLOW, credp->fc_mode);
     if (fd == -1) {
-        err = fd;
         goto out;
     }
-    err = local_post_create_passthrough(fs_ctx, path, credp);
+    err = local_post_create_passthrough(fs_ctx, fd, "", credp);
     if (err == -1) {
-        serrno = errno;
         goto err_end;
     }
-    err = fd;
     fs->fd = fd;
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
 
