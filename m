Received: from eggs.gnu.org ([2001:4830:134:3::10]:45432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAmw-0004jJ-LY
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAmt-0008Ve-Gd
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAmt-0008VO-6P
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:23 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8h4n108577
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:22 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a119j7fj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:21 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:10:20 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:10:14 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577821419.10533.9897113488170022796.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 05/36] 9pfs: local: split open2 operation
 per security model
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

Having all security models implemented in one monolithic function is
cumbersome. Especially when the need arises to fix something in the
shared code, as it forces to change all the paths at the same time.

This doesn't fix any bug, it is just preparatory cleanup.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |  167 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 123 insertions(+), 44 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 0d6869123094..4deb19ce8775 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -785,8 +785,9 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
     return err;
 }
 
-static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
-                       int flags, FsCred *credp, V9fsFidOpenState *fs)
+static int local_open2_mapped(FsContext *fs_ctx, V9fsPath *dir_path,
+                              const char *name, int flags, FsCred *credp,
+                              V9fsFidOpenState *fs)
 {
     char *path;
     int fd = -1;
@@ -804,48 +805,65 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
     v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
     path = fullname.data;
 
-    /* Determine the security model */
-    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        fd = open(buffer, flags, SM_LOCAL_MODE_BITS);
-        if (fd == -1) {
-            err = fd;
-            goto out;
-        }
-        credp->fc_mode = credp->fc_mode|S_IFREG;
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
-        }
-        credp->fc_mode = credp->fc_mode|S_IFREG;
-        /* Set client credentials in .virtfs_metadata directory files */
-        err = local_set_mapped_file_attr(fs_ctx, path, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
-    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
-               (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        fd = open(buffer, flags, credp->fc_mode);
-        if (fd == -1) {
-            err = fd;
-            goto out;
-        }
-        err = local_post_create_passthrough(fs_ctx, path, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
+    buffer = rpath(fs_ctx, path);
+    fd = open(buffer, flags, SM_LOCAL_MODE_BITS);
+    if (fd == -1) {
+        err = fd;
+        goto out;
+    }
+    credp->fc_mode = credp->fc_mode | S_IFREG;
+    /* Set cleint credentials in xattr */
+    err = local_set_xattr(buffer, credp);
+    if (err == -1) {
+        serrno = errno;
+        goto err_end;
+    }
+    err = fd;
+    fs->fd = fd;
+    goto out;
+
+err_end:
+    close(fd);
+    remove(buffer);
+    errno = serrno;
+out:
+    g_free(buffer);
+    v9fs_string_free(&fullname);
+    return err;
+}
+
+static int local_open2_mapped_file(FsContext *fs_ctx, V9fsPath *dir_path,
+                                   const char *name, int flags, FsCred *credp,
+                                   V9fsFidOpenState *fs)
+{
+    char *path;
+    int fd = -1;
+    int err = -1;
+    int serrno = 0;
+    V9fsString fullname;
+    char *buffer = NULL;
+
+    /*
+     * Mark all the open to not follow symlinks
+     */
+    flags |= O_NOFOLLOW;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    path = fullname.data;
+
+    buffer = rpath(fs_ctx, path);
+    fd = open(buffer, flags, SM_LOCAL_MODE_BITS);
+    if (fd == -1) {
+        err = fd;
+        goto out;
+    }
+    credp->fc_mode = credp->fc_mode | S_IFREG;
+    /* Set client credentials in .virtfs_metadata directory files */
+    err = local_set_mapped_file_attr(fs_ctx, path, credp);
+    if (err == -1) {
+        serrno = errno;
+        goto err_end;
     }
     err = fd;
     fs->fd = fd;
@@ -861,6 +879,67 @@ out:
     return err;
 }
 
+static int local_open2_passthrough(FsContext *fs_ctx, V9fsPath *dir_path,
+                                   const char *name, int flags, FsCred *credp,
+                                   V9fsFidOpenState *fs)
+{
+    char *path;
+    int fd = -1;
+    int err = -1;
+    int serrno = 0;
+    V9fsString fullname;
+    char *buffer = NULL;
+
+    /*
+     * Mark all the open to not follow symlinks
+     */
+    flags |= O_NOFOLLOW;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    path = fullname.data;
+
+    buffer = rpath(fs_ctx, path);
+    fd = open(buffer, flags, credp->fc_mode);
+    if (fd == -1) {
+        err = fd;
+        goto out;
+    }
+    err = local_post_create_passthrough(fs_ctx, path, credp);
+    if (err == -1) {
+        serrno = errno;
+        goto err_end;
+    }
+    err = fd;
+    fs->fd = fd;
+    goto out;
+
+err_end:
+    close(fd);
+    remove(buffer);
+    errno = serrno;
+out:
+    g_free(buffer);
+    v9fs_string_free(&fullname);
+    return err;
+}
+
+static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
+                       int flags, FsCred *credp, V9fsFidOpenState *fs)
+{
+    /* Determine the security model */
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+        return local_open2_mapped(fs_ctx, dir_path, name, flags, credp, fs);
+    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        return local_open2_mapped_file(fs_ctx, dir_path, name, flags, credp,
+                                       fs);
+    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
+               (fs_ctx->export_flags & V9FS_SM_NONE)) {
+        return local_open2_passthrough(fs_ctx, dir_path, name, flags, credp,
+                                       fs);
+    }
+    g_assert_not_reached();
+}
 
 static int local_symlink(FsContext *fs_ctx, const char *oldpath,
                          V9fsPath *dir_path, const char *name, FsCred *credp)
