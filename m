Received: from eggs.gnu.org ([2001:4830:134:3::10]:37875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsJg-00068U-Fd
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsJe-0001V9-Vi
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:32 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 22:20:53 +0200
Message-Id: <20170613202107.10125-3-mreitz@redhat.com>
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
References: <20170613202107.10125-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 02/16] block: Add PreallocMode to
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

For block drivers that just pass a truncate request to the underlying
protocol, we can now pass the preallocation mode instead of aborting if
it is not PREALLOC_MODE_OFF.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h  |  3 ++-
 block.c                |  5 +++--
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
 12 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index e2c6a0d..06b2f42 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -300,7 +300,8 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
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
index 2fdb8a5..d9f618a 100644
--- a/block.c
+++ b/block.c
@@ -3394,7 +3394,8 @@ exit:
 /**
  * Truncate file to 'offset' bytes (needed only for file protocols)
  */
-int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
+int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
+                  Error **errp)
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
@@ -3417,7 +3418,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
 
     assert(!(bs->open_flags & BDRV_O_INACTIVE));
 
-    ret = drv->bdrv_truncate(bs, offset, PREALLOC_MODE_OFF, errp);
+    ret = drv->bdrv_truncate(bs, offset, prealloc, errp);
     if (ret == 0) {
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
         bdrv_dirty_bitmap_truncate(bs);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 00090aa..3f971a3 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -815,13 +815,7 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
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
index 7d7f369..3c91655 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1778,7 +1778,7 @@ int blk_truncate(BlockBackend *blk, int64_t offset, Error **errp)
         return -ENOMEDIUM;
     }
 
-    return bdrv_truncate(blk->root, offset, errp);
+    return bdrv_truncate(blk->root, offset, PREALLOC_MODE_OFF, errp);
 }
 
 static void blk_pdiscard_entry(void *opaque)
diff --git a/block/crypto.c b/block/crypto.c
index 7047cb2..6370598 100644
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
index 8be46a7..5a38998 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -224,7 +224,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         } else {
             ret = bdrv_truncate(bs->file,
                                 (s->data_end + space) << BDRV_SECTOR_BITS,
-                                NULL);
+                                PREALLOC_MODE_OFF, NULL);
         }
         if (ret < 0) {
             return ret;
@@ -458,7 +458,8 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
         res->leaks += count;
         if (fix & BDRV_FIX_LEAKS) {
             Error *local_err = NULL;
-            ret = bdrv_truncate(bs->file, res->image_end_offset, &local_err);
+            ret = bdrv_truncate(bs->file, res->image_end_offset,
+                                PREALLOC_MODE_OFF, &local_err);
             if (ret < 0) {
                 error_report_err(local_err);
                 res->check_errors++;
@@ -699,7 +700,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
-            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs), NULL) != 0) {
+            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs),
+                          PREALLOC_MODE_OFF, NULL) != 0) {
         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
     }
 
@@ -742,7 +744,8 @@ static void parallels_close(BlockDriverState *bs)
     }
 
     if (bs->open_flags & BDRV_O_RDWR) {
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, NULL);
+        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
+                      PREALLOC_MODE_OFF, NULL);
     }
 
     g_free(s->bat_dirty_bmap);
diff --git a/block/qcow.c b/block/qcow.c
index 7bd94dc..1306065 100644
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
@@ -917,7 +918,8 @@ static int qcow_make_empty(BlockDriverState *bs)
     if (bdrv_pwrite_sync(bs->file, s->l1_table_offset, s->l1_table,
             l1_length) < 0)
         return -1;
-    ret = bdrv_truncate(bs->file, s->l1_table_offset + l1_length, NULL);
+    ret = bdrv_truncate(bs->file, s->l1_table_offset + l1_length,
+                        PREALLOC_MODE_OFF, NULL);
     if (ret < 0)
         return ret;
 
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061..84e0cee 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1730,7 +1730,7 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
                 }
 
                 ret = bdrv_truncate(bs->file, offset + s->cluster_size,
-                                    &local_err);
+                                    PREALLOC_MODE_OFF, &local_err);
                 if (ret < 0) {
                     error_report_err(local_err);
                     goto resize_fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 942befe..685958a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2665,7 +2665,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         /* align end of file to a sector boundary to ease reading with
            sector based I/Os */
         cluster_offset = bdrv_getlength(bs->file->bs);
-        return bdrv_truncate(bs->file, cluster_offset, NULL);
+        return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF, NULL);
     }
 
     buf = qemu_blockalign(bs, s->cluster_size);
@@ -2881,7 +2881,7 @@ static int make_completely_empty(BlockDriverState *bs)
     }
 
     ret = bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size,
-                        &local_err);
+                        PREALLOC_MODE_OFF, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         goto fail;
diff --git a/block/raw-format.c b/block/raw-format.c
index 20134cb..83a0b33 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -357,12 +357,6 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset,
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
@@ -375,7 +369,7 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset,
 
     s->size = offset;
     offset += s->offset;
-    return bdrv_truncate(bs->file, offset, errp);
+    return bdrv_truncate(bs->file, offset, prealloc, errp);
 }
 
 static int raw_media_changed(BlockDriverState *bs)
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 3f4c2aa..01278f3 100644
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
index 8b270b5..85c476a 100644
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
2.9.4
