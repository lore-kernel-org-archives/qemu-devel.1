Received: from eggs.gnu.org ([2001:4830:134:3::10]:45761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnm-0005RG-NH
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnj-0000ES-IO
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53875
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAnj-0000EO-DL
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:15 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC9FaU062080
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:15 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a32f5ybf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:14 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:11:14 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:11:08 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577826836.10533.14554283458241893932.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 12/36] 9pfs: local: pre remove operation
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

The remove operation is really the same for the passthrough and mapped
security models. This patch simply moves the mapped-file bits to a
separate function. This will make future modifications easier.

This doesn't fix any bug, it is just preparatory cleanup.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   74 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 74953e4dbfe0..7506d2155c05 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1303,41 +1303,25 @@ static int local_utimensat(FsContext *s, V9fsPath *fs_path,
     return ret;
 }
 
-static int local_remove(FsContext *ctx, const char *path)
+static int local_pre_remove_mapped_file(FsContext *ctx, const char *path)
 {
     int err;
     struct stat stbuf;
     char *buffer;
 
-    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        buffer = rpath(ctx, path);
-        err =  lstat(buffer, &stbuf);
-        g_free(buffer);
-        if (err) {
-            goto err_out;
-        }
-        /*
-         * If directory remove .virtfs_metadata contained in the
-         * directory
-         */
-        if (S_ISDIR(stbuf.st_mode)) {
-            buffer = g_strdup_printf("%s/%s/%s", ctx->fs_root,
-                                     path, VIRTFS_META_DIR);
-            err = remove(buffer);
-            g_free(buffer);
-            if (err < 0 && errno != ENOENT) {
-                /*
-                 * We didn't had the .virtfs_metadata file. May be file created
-                 * in non-mapped mode ?. Ignore ENOENT.
-                 */
-                goto err_out;
-            }
-        }
-        /*
-         * Now remove the name from parent directory
-         * .virtfs_metadata directory
-         */
-        buffer = local_mapped_attr_path(ctx, path);
+    buffer = rpath(ctx, path);
+    err =  lstat(buffer, &stbuf);
+    g_free(buffer);
+    if (err) {
+        goto err_out;
+    }
+    /*
+     * If directory remove .virtfs_metadata contained in the
+     * directory
+     */
+    if (S_ISDIR(stbuf.st_mode)) {
+        buffer = g_strdup_printf("%s/%s/%s", ctx->fs_root,
+                                 path, VIRTFS_META_DIR);
         err = remove(buffer);
         g_free(buffer);
         if (err < 0 && errno != ENOENT) {
@@ -1348,6 +1332,36 @@ static int local_remove(FsContext *ctx, const char *path)
             goto err_out;
         }
     }
+    /*
+     * Now remove the name from parent directory
+     * .virtfs_metadata directory
+     */
+    buffer = local_mapped_attr_path(ctx, path);
+    err = remove(buffer);
+    g_free(buffer);
+    if (err < 0 && errno == ENOENT) {
+        /*
+         * We didn't had the .virtfs_metadata file. May be file created
+         * in non-mapped mode ?. Ignore ENOENT.
+         */
+        err = 0;
+    }
+
+err_out:
+    return err;
+}
+
+static int local_remove(FsContext *ctx, const char *path)
+{
+    int err;
+    char *buffer;
+
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        err =  local_pre_remove_mapped_file(ctx, path);
+        if (err) {
+            goto err_out;
+        }
+    }
 
     buffer = rpath(ctx, path);
     err = remove(buffer);
