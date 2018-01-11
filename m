Received: from eggs.gnu.org ([2001:4830:134:3::10]:57347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuX-0005Da-QJ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuW-0000JX-Ld
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:18 +0100
Message-Id: <20180111195225.4226-4-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 03/10] qcow2: Let qcow2_create() handle
 protocol layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Currently, qcow2_create() only parses the QemuOpts and then calls
qcow2_create2() for the actual image creation, which includes both the
creation of the actual file on the file system and writing a valid empty
qcow2 image into that file.

The plan is that qcow2_create2() becomes the function that implements
the functionality for a future 'blockdev-create' QMP command, which only
creates the qcow2 layer on an already opened file node.

This is a first step towards that goal: Let's move out anything that
deals with the protocol layer from qcow2_create2() into qcow2_create().
This means that qcow2_create2() doesn't need a file name any more.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 64 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4348b2c0c5..b02bc39a01 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2690,7 +2690,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
     return refcount_bits;
 }
 
-static int qcow2_create2(const char *filename, int64_t total_size,
+static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
                          const char *backing_file, const char *backing_format,
                          int flags, size_t cluster_size, PreallocMode prealloc,
                          QemuOpts *opts, int version, int refcount_order,
@@ -2716,28 +2716,11 @@ static int qcow2_create2(const char *filename, int64_t total_size,
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
@@ -2792,7 +2775,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
      */
     options = qdict_new();
     qdict_put_str(options, "driver", "qcow2");
-    blk = blk_new_open(filename, NULL, options,
+    qdict_put_str(options, "file", bs->node_name);
+    blk = blk_new_open(NULL, NULL, options,
                        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_NO_FLUSH,
                        &local_err);
     if (blk == NULL) {
@@ -2864,7 +2848,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
      */
     options = qdict_new();
     qdict_put_str(options, "driver", "qcow2");
-    blk = blk_new_open(filename, NULL, options,
+    qdict_put_str(options, "file", bs->node_name);
+    blk = blk_new_open(NULL, NULL, options,
                        BDRV_O_RDWR | BDRV_O_NO_BACKING | BDRV_O_NO_IO,
                        &local_err);
     if (blk == NULL) {
@@ -2894,6 +2879,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     uint64_t refcount_bits;
     int refcount_order;
     char *encryptfmt = NULL;
+    BlockDriverState *bs = NULL;
     Error *local_err = NULL;
     int ret;
 
@@ -2962,12 +2948,38 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 
     refcount_order = ctz32(refcount_bits);
 
-    ret = qcow2_create2(filename, size, backing_file, backing_fmt, flags,
+    /* Create and open the file (protocol layer */
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
+    ret = qcow2_create2(bs, size, backing_file, backing_fmt, flags,
                         cluster_size, prealloc, opts, version, refcount_order,
-                        encryptfmt, &local_err);
-    error_propagate(errp, local_err);
+                        encryptfmt, errp);
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
