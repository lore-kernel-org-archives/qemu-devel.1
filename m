Received: from eggs.gnu.org ([2001:4830:134:3::10]:45369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAmn-0004c7-CP
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAmk-0008U0-7a
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAmj-0008Tt-U1
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8g1W034304
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:13 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 289td6waqk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:12 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:10:11 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:10:06 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577820691.10533.11259393061139343996.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 04/36] 9pfs: local: split mkdir operation
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
 hw/9pfs/9p-local.c |  134 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 95 insertions(+), 39 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 7f513c5728f6..0d6869123094 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -626,8 +626,8 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
     g_assert_not_reached();
 }
 
-static int local_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
-                       const char *name, FsCred *credp)
+static int local_mkdir_mapped(FsContext *fs_ctx, V9fsPath *dir_path,
+                              const char *name, FsCred *credp)
 {
     char *path;
     int err = -1;
@@ -639,43 +639,16 @@ static int local_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
     v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
     path = fullname.data;
 
-    /* Determine the security model */
-    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        err = mkdir(buffer, SM_LOCAL_DIR_MODE_BITS);
-        if (err == -1) {
-            goto out;
-        }
-        credp->fc_mode = credp->fc_mode|S_IFDIR;
-        err = local_set_xattr(buffer, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
-    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        buffer = rpath(fs_ctx, path);
-        err = mkdir(buffer, SM_LOCAL_DIR_MODE_BITS);
-        if (err == -1) {
-            goto out;
-        }
-        credp->fc_mode = credp->fc_mode|S_IFDIR;
-        err = local_set_mapped_file_attr(fs_ctx, path, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
-    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
-               (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        err = mkdir(buffer, credp->fc_mode);
-        if (err == -1) {
-            goto out;
-        }
-        err = local_post_create_passthrough(fs_ctx, path, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
+    buffer = rpath(fs_ctx, path);
+    err = mkdir(buffer, SM_LOCAL_DIR_MODE_BITS);
+    if (err == -1) {
+        goto out;
+    }
+    credp->fc_mode = credp->fc_mode | S_IFDIR;
+    err = local_set_xattr(buffer, credp);
+    if (err == -1) {
+        serrno = errno;
+        goto err_end;
     }
     goto out;
 
@@ -688,6 +661,89 @@ out:
     return err;
 }
 
+static int local_mkdir_mapped_file(FsContext *fs_ctx, V9fsPath *dir_path,
+                                   const char *name, FsCred *credp)
+{
+    char *path;
+    int err = -1;
+    int serrno = 0;
+    V9fsString fullname;
+    char *buffer = NULL;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    path = fullname.data;
+
+    buffer = rpath(fs_ctx, path);
+    err = mkdir(buffer, SM_LOCAL_DIR_MODE_BITS);
+    if (err == -1) {
+        goto out;
+    }
+    credp->fc_mode = credp->fc_mode | S_IFDIR;
+    err = local_set_mapped_file_attr(fs_ctx, path, credp);
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
+static int local_mkdir_passthrough(FsContext *fs_ctx, V9fsPath *dir_path,
+                                   const char *name, FsCred *credp)
+{
+    char *path;
+    int err = -1;
+    int serrno = 0;
+    V9fsString fullname;
+    char *buffer = NULL;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
+    path = fullname.data;
+
+    buffer = rpath(fs_ctx, path);
+    err = mkdir(buffer, credp->fc_mode);
+    if (err == -1) {
+        goto out;
+    }
+    err = local_post_create_passthrough(fs_ctx, path, credp);
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
+static int local_mkdir(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
+                       FsCred *credp)
+{
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+        return local_mkdir_mapped(fs_ctx, dir_path, name, credp);
+    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        return local_mkdir_mapped_file(fs_ctx, dir_path, name, credp);
+    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
+               (fs_ctx->export_flags & V9FS_SM_NONE)) {
+        return local_mkdir_passthrough(fs_ctx, dir_path, name, credp);
+    }
+    g_assert_not_reached();
+}
+
 static int local_fstat(FsContext *fs_ctx, int fid_type,
                        V9fsFidOpenState *fs, struct stat *stbuf)
 {
