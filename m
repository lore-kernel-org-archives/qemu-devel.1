Received: from eggs.gnu.org ([2001:4830:134:3::10]:45829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnv-0005YM-Lz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAns-0000GJ-FR
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33755
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAns-0000GD-9a
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8ew9014038
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:23 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a1ah1hxt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:23 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:10:27 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:10:21 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577822148.10533.3386447664016520304.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 06/36] 9pfs: local: split symlink operation
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
 hw/9pfs/9p-local.c |  210 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 137 insertions(+), 73 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4deb19ce8775..f9abd4229b17 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -941,96 +941,144 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
     g_assert_not_reached();
 }
 
-static int local_symlink(FsContext *fs_ctx, const char *oldpath,
-                         V9fsPath *dir_path, const char *name, FsCred *credp)
+static int local_symlink_mapped(FsContext *fs_ctx, const char *oldpath,
+                                V9fsPath *dir_path, const char *name,
+                                FsCred *credp)
 {
     int err = -1;
     int serrno = 0;
     char *newpath;
     V9fsString fullname;
     char *buffer = NULL;
+    int fd;
+    ssize_t oldpath_size, write_size;
 
     v9fs_string_init(&fullname);
     v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
     newpath = fullname.data;
 
-    /* Determine the security model */
-    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
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
+    buffer = rpath(fs_ctx, newpath);
+    fd = open(buffer, O_CREAT | O_EXCL | O_RDWR | O_NOFOLLOW,
+              SM_LOCAL_MODE_BITS);
+    if (fd == -1) {
+        err = fd;
+        goto out;
+    }
+    /* Write the oldpath (target) to the file. */
+    oldpath_size = strlen(oldpath);
+    do {
+        write_size = write(fd, (void *)oldpath, oldpath_size);
+    } while (write_size == -1 && errno == EINTR);
 
-        if (write_size != oldpath_size) {
-            serrno = errno;
-            close(fd);
-            err = -1;
-            goto err_end;
-        }
+    if (write_size != oldpath_size) {
+        serrno = errno;
         close(fd);
-        /* Set cleint credentials in symlink's xattr */
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
+        err = -1;
+        goto err_end;
+    }
+    close(fd);
+    /* Set cleint credentials in symlink's xattr */
+    credp->fc_mode = credp->fc_mode | S_IFLNK;
+    err = local_set_xattr(buffer, credp);
+    if (err == -1) {
+        serrno = errno;
+        goto err_end;
+    }
+    goto out;
 
-        if (write_size != oldpath_size) {
-            serrno = errno;
-            close(fd);
-            err = -1;
-            goto err_end;
-        }
+err_end:
+    remove(buffer);
+    errno = serrno;
+out:
+    g_free(buffer);
+    v9fs_string_free(&fullname);
+    return err;
+}
+
+static int local_symlink_mapped_file(FsContext *fs_ctx, const char *oldpath,
+                                     V9fsPath *dir_path, const char *name,
+                                     FsCred *credp)
+{
+    int err = -1;
+    int serrno = 0;
+    char *newpath;
+    V9fsString fullname;
+    char *buffer = NULL;
+    int fd;
+    ssize_t oldpath_size, write_size;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    newpath = fullname.data;
+
+    buffer = rpath(fs_ctx, newpath);
+    fd = open(buffer, O_CREAT | O_EXCL | O_RDWR | O_NOFOLLOW,
+              SM_LOCAL_MODE_BITS);
+    if (fd == -1) {
+        err = fd;
+        goto out;
+    }
+    /* Write the oldpath (target) to the file. */
+    oldpath_size = strlen(oldpath);
+    do {
+        write_size = write(fd, (void *)oldpath, oldpath_size);
+    } while (write_size == -1 && errno == EINTR);
+
+    if (write_size != oldpath_size) {
+        serrno = errno;
         close(fd);
-        /* Set cleint credentials in symlink's xattr */
-        credp->fc_mode = credp->fc_mode|S_IFLNK;
-        err = local_set_mapped_file_attr(fs_ctx, newpath, credp);
-        if (err == -1) {
+        err = -1;
+        goto err_end;
+    }
+    close(fd);
+    /* Set cleint credentials in symlink's xattr */
+    credp->fc_mode = credp->fc_mode | S_IFLNK;
+    err = local_set_mapped_file_attr(fs_ctx, newpath, credp);
+    if (err == -1) {
+        serrno = errno;
+        goto err_end;
+    }
+    goto out;
+
+err_end:
+    remove(buffer);
+    errno = serrno;
+out:
+    g_free(buffer);
+    v9fs_string_free(&fullname);
+    return err;
+}
+
+static int local_symlink_passthrough(FsContext *fs_ctx, const char *oldpath,
+                                     V9fsPath *dir_path, const char *name,
+                                     FsCred *credp)
+{
+    int err = -1;
+    int serrno = 0;
+    char *newpath;
+    V9fsString fullname;
+    char *buffer = NULL;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    newpath = fullname.data;
+
+    buffer = rpath(fs_ctx, newpath);
+    err = symlink(oldpath, buffer);
+    if (err) {
+        goto out;
+    }
+    err = lchown(buffer, credp->fc_uid, credp->fc_gid);
+    if (err == -1) {
+        /*
+         * If we fail to change ownership and if we are
+         * using security model none. Ignore the error
+         */
+        if ((fs_ctx->export_flags & V9FS_SEC_MASK) != V9FS_SM_NONE) {
             serrno = errno;
             goto err_end;
-        }
-    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
-               (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, newpath);
-        err = symlink(oldpath, buffer);
-        if (err) {
-            goto out;
-        }
-        err = lchown(buffer, credp->fc_uid, credp->fc_gid);
-        if (err == -1) {
-            /*
-             * If we fail to change ownership and if we are
-             * using security model none. Ignore the error
-             */
-            if ((fs_ctx->export_flags & V9FS_SEC_MASK) != V9FS_SM_NONE) {
-                serrno = errno;
-                goto err_end;
-            } else
-                err = 0;
+        } else {
+            err = 0;
         }
     }
     goto out;
@@ -1044,6 +1092,22 @@ out:
     return err;
 }
 
+static int local_symlink(FsContext *fs_ctx, const char *oldpath,
+                         V9fsPath *dir_path, const char *name, FsCred *credp)
+{
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+        return local_symlink_mapped(fs_ctx, oldpath, dir_path, name, credp);
+    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        return local_symlink_mapped_file(fs_ctx, oldpath, dir_path, name,
+                                         credp);
+    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
+               (fs_ctx->export_flags & V9FS_SM_NONE)) {
+        return local_symlink_passthrough(fs_ctx, oldpath, dir_path, name,
+                                         credp);
+    }
+    g_assert_not_reached();
+}
+
 static int local_link(FsContext *ctx, V9fsPath *oldpath,
                       V9fsPath *dirpath, const char *name)
 {
