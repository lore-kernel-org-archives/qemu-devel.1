Received: from eggs.gnu.org ([2001:4830:134:3::10]:59741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdQ-0001g5-76
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdP-0004mO-2q
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:51 +0100
Message-Id: <20180313161803.1814-30-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 29/41] vdi: Move file creation to
 vdi_co_create_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 0c8f8204ce..2a39b0ac98 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -721,9 +721,7 @@ nonallocating_write:
     return ret;
 }
 
-static int coroutine_fn vdi_co_do_create(const char *filename,
-                                         QemuOpts *file_opts,
-                                         BlockdevCreateOptionsVdi *vdi_opts,
+static int coroutine_fn vdi_co_do_create(BlockdevCreateOptionsVdi *vdi_opts,
                                          size_t block_size, Error **errp)
 {
     int ret = 0;
@@ -734,7 +732,7 @@ static int coroutine_fn vdi_co_do_create(const char *filename,
     size_t i;
     size_t bmap_size;
     int64_t offset = 0;
-    Error *local_err = NULL;
+    BlockDriverState *bs_file = NULL;
     BlockBackend *blk = NULL;
     uint32_t *bmap = NULL;
 
@@ -770,18 +768,15 @@ static int coroutine_fn vdi_co_do_create(const char *filename,
         goto exit;
     }
 
-    ret = bdrv_create_file(filename, file_opts, &local_err);
-    if (ret < 0) {
-        error_propagate(errp, local_err);
+    bs_file = bdrv_open_blockdev_ref(vdi_opts->file, errp);
+    if (!bs_file) {
+        ret = -EIO;
         goto exit;
     }
 
-    blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                       &local_err);
-    if (blk == NULL) {
-        error_propagate(errp, local_err);
-        ret = -EIO;
+    blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    ret = blk_insert_bs(blk, bs_file, errp);
+    if (ret < 0) {
         goto exit;
     }
 
@@ -818,7 +813,7 @@ static int coroutine_fn vdi_co_do_create(const char *filename,
     vdi_header_to_le(&header);
     ret = blk_pwrite(blk, offset, &header, sizeof(header), 0);
     if (ret < 0) {
-        error_setg(errp, "Error writing header to %s", filename);
+        error_setg(errp, "Error writing header");
         goto exit;
     }
     offset += sizeof(header);
@@ -839,7 +834,7 @@ static int coroutine_fn vdi_co_do_create(const char *filename,
         }
         ret = blk_pwrite(blk, offset, bmap, bmap_size, 0);
         if (ret < 0) {
-            error_setg(errp, "Error writing bmap to %s", filename);
+            error_setg(errp, "Error writing bmap");
             goto exit;
         }
         offset += bmap_size;
@@ -849,13 +844,14 @@ static int coroutine_fn vdi_co_do_create(const char *filename,
         ret = blk_truncate(blk, offset + blocks * block_size,
                            PREALLOC_MODE_OFF, errp);
         if (ret < 0) {
-            error_prepend(errp, "Failed to statically allocate %s", filename);
+            error_prepend(errp, "Failed to statically allocate file");
             goto exit;
         }
     }
 
 exit:
     blk_unref(blk);
+    bdrv_unref(bs_file);
     g_free(bmap);
     return ret;
 }
@@ -865,6 +861,7 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
 {
     QDict *qdict = NULL;
     BlockdevCreateOptionsVdi *create_options = NULL;
+    BlockDriverState *bs_file = NULL;
     uint64_t block_size = DEFAULT_CLUSTER_SIZE;
     Visitor *v;
     Error *local_err = NULL;
@@ -888,7 +885,19 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
 
     qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vdi_create_opts, true);
 
-    qdict_put_str(qdict, "file", ""); /* FIXME */
+    ret = bdrv_create_file(filename, opts, errp);
+    if (ret < 0) {
+        goto done;
+    }
+
+    bs_file = bdrv_open(filename, NULL, NULL,
+                        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (!bs_file) {
+        ret = -EIO;
+        goto done;
+    }
+
+    qdict_put_str(qdict, "file", bs_file->node_name);
 
     /* Get the QAPI object */
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
@@ -903,10 +912,11 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
 
     create_options->size = ROUND_UP(create_options->size, BDRV_SECTOR_SIZE);
 
-    ret = vdi_co_do_create(filename, opts, create_options, block_size, errp);
+    ret = vdi_co_do_create(create_options, block_size, errp);
 done:
     QDECREF(qdict);
     qapi_free_BlockdevCreateOptionsVdi(create_options);
+    bdrv_unref(bs_file);
     return ret;
 }
 
-- 
2.13.6
