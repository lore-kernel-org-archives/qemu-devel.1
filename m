Received: from eggs.gnu.org ([2001:4830:134:3::10]:33450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKku-000128-U4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkt-0006qq-ML
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:28 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:55 +0100
Message-Id: <20180309161933.8168-19-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 18/56] qcow2: Let qcow2_create() handle protocol
 layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Currently, qcow2_create() only parses the QemuOpts and then calls
qcow2_co_create() for the actual image creation, which includes both the
creation of the actual file on the file system and writing a valid empty
qcow2 image into that file.

The plan is that qcow2_co_create() becomes the function that implements
the functionality for a future 'blockdev-create' QMP command, which only
creates the qcow2 layer on an already opened file node.

This is a first step towards that goal: Let's move out anything that
deals with the protocol layer from qcow2_co_create() into
qcow2_create().  This means that qcow2_co_create() doesn't need a file
name any more.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 64 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b7354a27a1..7a11874d22 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2761,7 +2761,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
 }
 
 static int coroutine_fn
-qcow2_co_create(const char *filename, int64_t total_size,
+qcow2_co_create(BlockDriverState *bs, int64_t total_size,
                 const char *backing_file, const char *backing_format,
                 int flags, size_t cluster_size, PreallocMode prealloc,
                 QemuOpts *opts, int version, int refcount_order,
@@ -2787,28 +2787,11 @@ qcow2_co_create(const char *filename, int64_t total_size,
     Error *local_err = NULL;
     int ret;
 
-    if (prealloc == PREALLOC_MODE_FULL || prealloc == PREALLOC_MODE_FALLOC) {
-        int64_t prealloc_size =
-            qcow2_calc_prealloc_size(total_size, cluster_size, refcount_order);
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &error_abort);
-        qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_str(prealloc),
-                     &error_abort);
-    }
-
-    ret = bdrv_create_file(filename, opts, &local_err);
+    blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
-        return ret;
-    }
-
-    blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                       &local_err);
-    if (blk == NULL) {
-        error_propagate(errp, local_err);
-        return -EIO;
+        goto out;
     }
-
     blk_set_allow_write_beyond_eof(blk, true);
 
     /* Write the header */
@@ -2863,7 +2846,8 @@ qcow2_co_create(const char *filename, int64_t total_size,
      */
     options = qdict_new();
     qdict_put_str(options, "driver", "qcow2");
-    blk = blk_new_open(filename, NULL, options,
+    qdict_put_str(options, "file", bs->node_name);
+    blk = blk_new_open(NULL, NULL, options,
                        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_NO_FLUSH,
                        &local_err);
     if (blk == NULL) {
@@ -2935,7 +2919,8 @@ qcow2_co_create(const char *filename, int64_t total_size,
      */
     options = qdict_new();
     qdict_put_str(options, "driver", "qcow2");
-    blk = blk_new_open(filename, NULL, options,
+    qdict_put_str(options, "file", bs->node_name);
+    blk = blk_new_open(NULL, NULL, options,
                        BDRV_O_RDWR | BDRV_O_NO_BACKING | BDRV_O_NO_IO,
                        &local_err);
     if (blk == NULL) {
@@ -2966,6 +2951,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
     uint64_t refcount_bits;
     int refcount_order;
     char *encryptfmt = NULL;
+    BlockDriverState *bs = NULL;
     Error *local_err = NULL;
     int ret;
 
@@ -3034,12 +3020,38 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
 
     refcount_order = ctz32(refcount_bits);
 
-    ret = qcow2_co_create(filename, size, backing_file, backing_fmt, flags,
+    /* Create and open the file (protocol layer) */
+    if (prealloc == PREALLOC_MODE_FULL || prealloc == PREALLOC_MODE_FALLOC) {
+        int64_t prealloc_size =
+            qcow2_calc_prealloc_size(size, cluster_size, refcount_order);
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &error_abort);
+        qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_str(prealloc),
+                     &error_abort);
+    }
+
+    ret = bdrv_create_file(filename, opts, errp);
+    if (ret < 0) {
+        goto finish;
+    }
+
+    bs = bdrv_open(filename, NULL, NULL,
+                   BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (bs == NULL) {
+        ret = -EIO;
+        goto finish;
+    }
+
+    /* Create the qcow2 image (format layer) */
+    ret = qcow2_co_create(bs, size, backing_file, backing_fmt, flags,
                           cluster_size, prealloc, opts, version, refcount_order,
-                          encryptfmt, &local_err);
-    error_propagate(errp, local_err);
+                          encryptfmt, errp);
+    if (ret < 0) {
+        goto finish;
+    }
 
 finish:
+    bdrv_unref(bs);
+
     g_free(backing_file);
     g_free(backing_fmt);
     g_free(encryptfmt);
-- 
2.13.6
