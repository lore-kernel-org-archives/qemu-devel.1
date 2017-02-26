Received: from eggs.gnu.org ([2001:4830:134:3::10]:50626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7X7-0005W1-Q9
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:43:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7X4-0002ti-NJ
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:43:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ci7X4-0002tT-Dg
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:43:10 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1QMcOWJ023143
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:43:09 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u88qa2wu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:43:08 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sun, 26 Feb 2017 15:43:08 -0700
From: Greg Kurz <groug@kaod.org>
Date: Sun, 26 Feb 2017 23:43:00 +0100
In-Reply-To: <148814889214.28146.16915712763478774662.stgit@bahia>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148814898026.28146.12256183919348399642.stgit@bahia>
Subject: [Qemu-devel] [PATCH v2 11/28] 9pfs: local: unlinkat: don't follow
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

The local_unlinkat() callback is vulnerable to symlink attacks because it
calls remove() which follows symbolic links in all path elements but the
rightmost one.

This patch converts local_unlinkat() to rely on opendir_nofollow() and
unlinkat() instead.

Most of the code is moved to a separate local_unlinkat_common() helper
which will be reused in a subsequent patch to fix the same issue in
local_remove().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2: - use openat_dir()
---
 hw/9pfs/9p-local.c |   99 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 43 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 74b921e65316..69439714cd91 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -969,6 +969,56 @@ static int local_utimensat(FsContext *s, V9fsPath *fs_path,
     return ret;
 }
 
+static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
+                                 int flags)
+{
+    int ret = -1;
+
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        int map_dirfd;
+
+        if (flags == AT_REMOVEDIR) {
+            int fd;
+
+            fd = openat(dirfd, name, O_RDONLY | O_DIRECTORY | O_PATH);
+            if (fd == -1) {
+                goto err_out;
+            }
+            /*
+             * If directory remove .virtfs_metadata contained in the
+             * directory
+             */
+            ret = unlinkat(fd, VIRTFS_META_DIR, AT_REMOVEDIR);
+            close_preserve_errno(fd);
+            if (ret < 0 && errno != ENOENT) {
+                /*
+                 * We didn't had the .virtfs_metadata file. May be file created
+                 * in non-mapped mode ?. Ignore ENOENT.
+                 */
+                goto err_out;
+            }
+        }
+        /*
+         * Now remove the name from parent directory
+         * .virtfs_metadata directory.
+         */
+        map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
+        ret = unlinkat(map_dirfd, name, 0);
+        close_preserve_errno(map_dirfd);
+        if (ret < 0 && errno != ENOENT) {
+            /*
+             * We didn't had the .virtfs_metadata file. May be file created
+             * in non-mapped mode ?. Ignore ENOENT.
+             */
+            goto err_out;
+        }
+    }
+
+    ret = unlinkat(dirfd, name, flags);
+err_out:
+    return ret;
+}
+
 static int local_remove(FsContext *ctx, const char *path)
 {
     int err;
@@ -1118,52 +1168,15 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
                           const char *name, int flags)
 {
     int ret;
-    V9fsString fullname;
-    char *buffer;
-
-    v9fs_string_init(&fullname);
+    int dirfd;
 
-    v9fs_string_sprintf(&fullname, "%s/%s", dir->data, name);
-    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        if (flags == AT_REMOVEDIR) {
-            /*
-             * If directory remove .virtfs_metadata contained in the
-             * directory
-             */
-            buffer = g_strdup_printf("%s/%s/%s", ctx->fs_root,
-                                     fullname.data, VIRTFS_META_DIR);
-            ret = remove(buffer);
-            g_free(buffer);
-            if (ret < 0 && errno != ENOENT) {
-                /*
-                 * We didn't had the .virtfs_metadata file. May be file created
-                 * in non-mapped mode ?. Ignore ENOENT.
-                 */
-                goto err_out;
-            }
-        }
-        /*
-         * Now remove the name from parent directory
-         * .virtfs_metadata directory.
-         */
-        buffer = local_mapped_attr_path(ctx, fullname.data);
-        ret = remove(buffer);
-        g_free(buffer);
-        if (ret < 0 && errno != ENOENT) {
-            /*
-             * We didn't had the .virtfs_metadata file. May be file created
-             * in non-mapped mode ?. Ignore ENOENT.
-             */
-            goto err_out;
-        }
+    dirfd = local_opendir_nofollow(ctx, dir->data);
+    if (dirfd == -1) {
+        return -1;
     }
-    /* Remove the name finally */
-    buffer = rpath(ctx, fullname.data);
-    ret = remove(buffer);
-    g_free(buffer);
 
-err_out:
-    v9fs_string_free(&fullname);
+    ret = local_unlinkat_common(ctx, dirfd, name, flags);
+    close_preserve_errno(dirfd);
     return ret;
 }
 
