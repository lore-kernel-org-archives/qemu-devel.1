Received: from eggs.gnu.org ([2001:4830:134:3::10]:45832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnw-0005Yw-Cc
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnt-0000GT-2w
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33373
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAns-0000GN-TO
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:25 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8eEd008901
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:24 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a3d3d5uc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:24 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:11:23 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:11:16 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577827655.10533.13509941844053957690.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 13/36] 9pfs: local: pre unlikat operation
 for mapped-file security
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

The unlinkat operation is really the same for the passthrough and
mapped security models. This patch simply moves the mapped-file bits
to a separate function. This will make future modifications easier.

This doesn't fix any bug, it is just preparatory cleanup.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   68 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 7506d2155c05..b75ad452decc 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1462,39 +1462,23 @@ static int local_renameat(FsContext *ctx, V9fsPath *olddir,
     return ret;
 }
 
-static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
-                          const char *name, int flags)
+static int local_pre_unlinkat_mapped_file(FsContext *ctx, V9fsPath *dir,
+                                          const char *name, int flags)
 {
     int ret;
     V9fsString fullname;
     char *buffer;
 
     v9fs_string_init(&fullname);
-
     v9fs_string_sprintf(&fullname, "%s/%s", dir->data, name);
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
+
+    if (flags == AT_REMOVEDIR) {
         /*
-         * Now remove the name from parent directory
-         * .virtfs_metadata directory.
+         * If directory remove .virtfs_metadata contained in the
+         * directory
          */
-        buffer = local_mapped_attr_path(ctx, fullname.data);
+        buffer = g_strdup_printf("%s/%s/%s", ctx->fs_root,
+                                 fullname.data, VIRTFS_META_DIR);
         ret = remove(buffer);
         g_free(buffer);
         if (ret < 0 && errno != ENOENT) {
@@ -1505,6 +1489,42 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
             goto err_out;
         }
     }
+    /*
+     * Now remove the name from parent directory
+     * .virtfs_metadata directory.
+     */
+    buffer = local_mapped_attr_path(ctx, fullname.data);
+    ret = remove(buffer);
+    g_free(buffer);
+    if (ret < 0 && errno == ENOENT) {
+        /*
+         * We didn't had the .virtfs_metadata file. May be file created
+         * in non-mapped mode ?. Ignore ENOENT.
+         */
+        ret = 0;
+    }
+
+err_out:
+    v9fs_string_free(&fullname);
+    return ret;
+}
+
+static int local_unlinkat(FsContext *ctx, V9fsPath *dir, const char *name,
+                          int flags)
+{
+    int ret;
+    V9fsString fullname;
+    char *buffer;
+
+    v9fs_string_init(&fullname);
+    v9fs_string_sprintf(&fullname, "%s/%s", dir->data, name);
+
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        ret = local_pre_unlinkat_mapped_file(ctx, dir, name, flags);
+        if (ret < 0) {
+            goto err_out;
+        }
+    }
     /* Remove the name finally */
     buffer = rpath(ctx, fullname.data);
     ret = remove(buffer);
