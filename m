Received: from eggs.gnu.org ([2001:4830:134:3::10]:43598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXhs-0007Ch-5E
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXhq-0001lD-Nl
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:40:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Mar 2017 22:40:18 +0100
Message-Id: <20170313214032.26672-1-mreitz@redhat.com>
In-Reply-To: <20170313214001.26339-1-mreitz@redhat.com>
References: <20170313214001.26339-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 02/16] block: Add PreallocMode to
 bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

For block drivers that just pass a truncate request to the underlying
protocol, we can now pass the preallocation mode instead of aborting if
it is not PREALLOC_MODE_OFF.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h  |  3 ++-
 block.c                | 12 +++++++++---
 block/blkdebug.c       |  8 +-------
 block/block-backend.c  |  2 +-
 block/crypto.c         |  8 +-------
 block/parallels.c      | 11 +++++++----
 block/qcow.c           |  6 ++++--
 block/qcow2-refcount.c |  2 +-
 block/qcow2.c          |  4 ++--
 block/raw-format.c     |  8 +-------
 block/vhdx-log.c       |  2 +-
 block/vhdx.c           |  3 ++-
 12 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 4c9ed0e43c..5042b79dc9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -294,7 +294,8 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 int bdrv_get_backing_file_depth(BlockDriverState *bs);
 void bdrv_refresh_filename(BlockDriverState *bs);
-int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp);
+int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
+                  Error **errp);
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
diff --git a/block.c b/block.c
index 57ae40a84e..9dc7ad85e2 100644
--- a/block.c
+++ b/block.c
@@ -3216,7 +3216,8 @@ exit:
 /**
  * Truncate file to 'offset' bytes (needed only for file protocols)
  */
-int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
+int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
+                  Error **errp)
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
@@ -3237,14 +3238,19 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
         return -EACCES;
     }
 
-    ret = drv->bdrv_truncate(bs, offset, PREALLOC_MODE_OFF, errp);
+    ret = drv->bdrv_truncate(bs, offset, prealloc, errp);
     if (ret == 0) {
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
         bdrv_dirty_bitmap_truncate(bs);
         bdrv_parent_cb_resize(bs);
         ++bs->write_gen;
     } else if (errp && !*errp) {
-        error_setg_errno(errp, -ret, "Failed to resize image");
+        if (ret == -ENOTSUP) {
+            error_setg(errp, "Resize or preallocation mode not supported for "
+                       "this image");
+        } else {
+            error_setg_errno(errp, -ret, "Failed to resize image");
+        }
     }
     return ret;
 }
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 31a71a34d3..f682cbdbcb 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -664,13 +664,7 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
 static int blkdebug_truncate(BlockDriverState *bs, int64_t offset,
                              PreallocMode prealloc, Error **errp)
 {
-    if (prealloc != PREALLOC_MODE_OFF) {
-        error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
-        return -ENOTSUP;
-    }
-
-    return bdrv_truncate(bs->file, offset, errp);
+    return bdrv_truncate(bs->file, offset, prealloc, errp);
 }
 
 static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
diff --git a/block/block-backend.c b/block/block-backend.c
index 24a16aadca..1bebc7f1ba 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1705,7 +1705,7 @@ int blk_truncate(BlockBackend *blk, int64_t offset, Error **errp)
         return -ENOMEDIUM;
     }
 
-    return bdrv_truncate(blk->root, offset, errp);
+    return bdrv_truncate(blk->root, offset, PREALLOC_MODE_OFF, errp);
 }
 
 static void blk_pdiscard_entry(void *opaque)
diff --git a/block/crypto.c b/block/crypto.c
index fa61aef380..c24102fa7f 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -388,15 +388,9 @@ static int block_crypto_truncate(BlockDriverState *bs, int64_t offset,
     size_t payload_offset =
         qcrypto_block_get_payload_offset(crypto->block);
 
-    if (prealloc != PREALLOC_MODE_OFF) {
-        error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
-        return -ENOTSUP;
-    }
-
     offset += payload_offset;
 
-    return bdrv_truncate(bs->file, offset, errp);
+    return bdrv_truncate(bs->file, offset, prealloc, errp);
 }
 
 static void block_crypto_close(BlockDriverState *bs)
diff --git a/block/parallels.c b/block/parallels.c
index 618fc860e2..180111f71e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -217,7 +217,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         } else {
             ret = bdrv_truncate(bs->file,
                                 (s->data_end + space) << BDRV_SECTOR_BITS,
-                                NULL);
+                                PREALLOC_MODE_OFF, NULL);
         }
         if (ret < 0) {
             return ret;
@@ -451,7 +451,8 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
         res->leaks += count;
         if (fix & BDRV_FIX_LEAKS) {
             Error *local_err = NULL;
-            ret = bdrv_truncate(bs->file, res->image_end_offset, &local_err);
+            ret = bdrv_truncate(bs->file, res->image_end_offset,
+                                PREALLOC_MODE_OFF, &local_err);
             if (ret < 0) {
                 error_report_err(local_err);
                 res->check_errors++;
@@ -691,7 +692,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail_options;
     }
     if (!bdrv_has_zero_init(bs->file->bs) ||
-            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs), NULL) != 0) {
+            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs),
+                          PREALLOC_MODE_OFF, NULL) != 0) {
         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
     }
 
@@ -734,7 +736,8 @@ static void parallels_close(BlockDriverState *bs)
     }
 
     if (bs->open_flags & BDRV_O_RDWR) {
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, NULL);
+        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
+                      PREALLOC_MODE_OFF, NULL);
     }
 
     g_free(s->bat_dirty_bmap);
diff --git a/block/qcow.c b/block/qcow.c
index 5d147b962e..45e3ff1a89 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -473,7 +473,8 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
                 /* round to cluster size */
                 cluster_offset = (cluster_offset + s->cluster_size - 1) &
                     ~(s->cluster_size - 1);
-                bdrv_truncate(bs->file, cluster_offset + s->cluster_size, NULL);
+                bdrv_truncate(bs->file, cluster_offset + s->cluster_size,
+                              PREALLOC_MODE_OFF, NULL);
                 /* if encrypted, we must initialize the cluster
                    content which won't be written */
                 if (bs->encrypted &&
@@ -916,7 +917,8 @@ static int qcow_make_empty(BlockDriverState *bs)
     if (bdrv_pwrite_sync(bs->file, s->l1_table_offset, s->l1_table,
             l1_length) < 0)
         return -1;
-    ret = bdrv_truncate(bs->file, s->l1_table_offset + l1_length, NULL);
+    ret = bdrv_truncate(bs->file, s->l1_table_offset + l1_length,
+                        PREALLOC_MODE_OFF, NULL);
     if (ret < 0)
         return ret;
 
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 4efca7ebdb..c176ffed14 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1736,7 +1736,7 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
                 }
 
                 ret = bdrv_truncate(bs->file, offset + s->cluster_size,
-                                    &local_err);
+                                    PREALLOC_MODE_OFF, &local_err);
                 if (ret < 0) {
                     error_report_err(local_err);
                     goto resize_fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 8d180bbf9d..52b9ad75fe 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2592,7 +2592,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         /* align end of file to a sector boundary to ease reading with
            sector based I/Os */
         cluster_offset = bdrv_getlength(bs->file->bs);
-        return bdrv_truncate(bs->file, cluster_offset, NULL);
+        return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF, NULL);
     }
 
     buf = qemu_blockalign(bs, s->cluster_size);
@@ -2808,7 +2808,7 @@ static int make_completely_empty(BlockDriverState *bs)
     }
 
     ret = bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size,
-                        &local_err);
+                        PREALLOC_MODE_OFF, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         goto fail;
diff --git a/block/raw-format.c b/block/raw-format.c
index aeaa13e3f5..a7c5a7bce8 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -332,12 +332,6 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset,
 {
     BDRVRawState *s = bs->opaque;
 
-    if (prealloc != PREALLOC_MODE_OFF) {
-        error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
-        return -ENOTSUP;
-    }
-
     if (s->has_size) {
         error_setg(errp, "Cannot resize fixed-size raw disks");
         return -ENOTSUP;
@@ -350,7 +344,7 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset,
 
     s->size = offset;
     offset += s->offset;
-    return bdrv_truncate(bs->file, offset, errp);
+    return bdrv_truncate(bs->file, offset, prealloc, errp);
 }
 
 static int raw_media_changed(BlockDriverState *bs)
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 3f4c2aa095..01278f3fc9 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -548,7 +548,7 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
             if (new_file_size % (1024*1024)) {
                 /* round up to nearest 1MB boundary */
                 new_file_size = ((new_file_size >> 20) + 1) << 20;
-                bdrv_truncate(bs->file, new_file_size, NULL);
+                bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_OFF, NULL);
             }
         }
         qemu_vfree(desc_entries);
diff --git a/block/vhdx.c b/block/vhdx.c
index e8fe3fb5e9..967c93e996 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1171,7 +1171,8 @@ static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
     /* per the spec, the address for a block is in units of 1MB */
     *new_offset = ROUND_UP(*new_offset, 1024 * 1024);
 
-    return bdrv_truncate(bs->file, *new_offset + s->block_size, NULL);
+    return bdrv_truncate(bs->file, *new_offset + s->block_size,
+                         PREALLOC_MODE_OFF, NULL);
 }
 
 /*
-- 
2.12.0
