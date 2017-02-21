Received: from eggs.gnu.org ([2001:4830:134:3::10]:42523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuI-00083T-HS
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuH-0007kL-2y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:00 +0100
Message-Id: <1487689130-30373-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 04/54] block: Pass BdrvChild to bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                | 3 ++-
 block/blkdebug.c       | 2 +-
 block/block-backend.c  | 2 +-
 block/crypto.c         | 2 +-
 block/parallels.c      | 8 ++++----
 block/qcow.c           | 4 ++--
 block/qcow2-refcount.c | 2 +-
 block/qcow2.c          | 4 ++--
 block/raw-format.c     | 2 +-
 block/vhdx-log.c       | 2 +-
 block/vhdx.c           | 2 +-
 include/block/block.h  | 2 +-
 12 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/block.c b/block.c
index 743c349..d951b5d 100644
--- a/block.c
+++ b/block.c
@@ -2626,8 +2626,9 @@ exit:
 /**
  * Truncate file to 'offset' bytes (needed only for file protocols)
  */
-int bdrv_truncate(BlockDriverState *bs, int64_t offset)
+int bdrv_truncate(BdrvChild *child, int64_t offset)
 {
+    BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
     int ret;
     if (!drv)
diff --git a/block/blkdebug.c b/block/blkdebug.c
index d8eee1b..6117ce5 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -663,7 +663,7 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
 
 static int blkdebug_truncate(BlockDriverState *bs, int64_t offset)
 {
-    return bdrv_truncate(bs->file->bs, offset);
+    return bdrv_truncate(bs->file, offset);
 }
 
 static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
diff --git a/block/block-backend.c b/block/block-backend.c
index 819f272..492e71e 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1605,7 +1605,7 @@ int blk_truncate(BlockBackend *blk, int64_t offset)
         return -ENOMEDIUM;
     }
 
-    return bdrv_truncate(blk_bs(blk), offset);
+    return bdrv_truncate(blk->root, offset);
 }
 
 static void blk_pdiscard_entry(void *opaque)
diff --git a/block/crypto.c b/block/crypto.c
index 7aa7eb5..e05e4dd 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -383,7 +383,7 @@ static int block_crypto_truncate(BlockDriverState *bs, int64_t offset)
 
     offset += payload_offset;
 
-    return bdrv_truncate(bs->file->bs, offset);
+    return bdrv_truncate(bs->file, offset);
 }
 
 static void block_crypto_close(BlockDriverState *bs)
diff --git a/block/parallels.c b/block/parallels.c
index 2ccefa7..ac94dfb 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -215,7 +215,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
                                      s->data_end << BDRV_SECTOR_BITS,
                                      space << BDRV_SECTOR_BITS, 0);
         } else {
-            ret = bdrv_truncate(bs->file->bs,
+            ret = bdrv_truncate(bs->file,
                                 (s->data_end + space) << BDRV_SECTOR_BITS);
         }
         if (ret < 0) {
@@ -449,7 +449,7 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
                 size - res->image_end_offset);
         res->leaks += count;
         if (fix & BDRV_FIX_LEAKS) {
-            ret = bdrv_truncate(bs->file->bs, res->image_end_offset);
+            ret = bdrv_truncate(bs->file, res->image_end_offset);
             if (ret < 0) {
                 res->check_errors++;
                 return ret;
@@ -681,7 +681,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail_options;
     }
     if (!bdrv_has_zero_init(bs->file->bs) ||
-            bdrv_truncate(bs->file->bs, bdrv_getlength(bs->file->bs)) != 0) {
+            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs)) != 0) {
         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
     }
 
@@ -724,7 +724,7 @@ static void parallels_close(BlockDriverState *bs)
     }
 
     if (bs->open_flags & BDRV_O_RDWR) {
-        bdrv_truncate(bs->file->bs, s->data_end << BDRV_SECTOR_BITS);
+        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS);
     }
 
     g_free(s->bat_dirty_bmap);
diff --git a/block/qcow.c b/block/qcow.c
index fb738fc..4534515 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -467,7 +467,7 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
                 /* round to cluster size */
                 cluster_offset = (cluster_offset + s->cluster_size - 1) &
                     ~(s->cluster_size - 1);
-                bdrv_truncate(bs->file->bs, cluster_offset + s->cluster_size);
+                bdrv_truncate(bs->file, cluster_offset + s->cluster_size);
                 /* if encrypted, we must initialize the cluster
                    content which won't be written */
                 if (bs->encrypted &&
@@ -909,7 +909,7 @@ static int qcow_make_empty(BlockDriverState *bs)
     if (bdrv_pwrite_sync(bs->file, s->l1_table_offset, s->l1_table,
             l1_length) < 0)
         return -1;
-    ret = bdrv_truncate(bs->file->bs, s->l1_table_offset + l1_length);
+    ret = bdrv_truncate(bs->file, s->l1_table_offset + l1_length);
     if (ret < 0)
         return ret;
 
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3dbde18..9e96f64 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1734,7 +1734,7 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
                     goto resize_fail;
                 }
 
-                ret = bdrv_truncate(bs->file->bs, offset + s->cluster_size);
+                ret = bdrv_truncate(bs->file, offset + s->cluster_size);
                 if (ret < 0) {
                     goto resize_fail;
                 }
diff --git a/block/qcow2.c b/block/qcow2.c
index 254545a..3e1172b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2570,7 +2570,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         /* align end of file to a sector boundary to ease reading with
            sector based I/Os */
         cluster_offset = bdrv_getlength(bs->file->bs);
-        return bdrv_truncate(bs->file->bs, cluster_offset);
+        return bdrv_truncate(bs->file, cluster_offset);
     }
 
     buf = qemu_blockalign(bs, s->cluster_size);
@@ -2784,7 +2784,7 @@ static int make_completely_empty(BlockDriverState *bs)
         goto fail;
     }
 
-    ret = bdrv_truncate(bs->file->bs, (3 + l1_clusters) * s->cluster_size);
+    ret = bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/raw-format.c b/block/raw-format.c
index 8404a82..0ddffbd 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -341,7 +341,7 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset)
 
     s->size = offset;
     offset += s->offset;
-    return bdrv_truncate(bs->file->bs, offset);
+    return bdrv_truncate(bs->file, offset);
 }
 
 static int raw_media_changed(BlockDriverState *bs)
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 02eb104..67a91c0 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -548,7 +548,7 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
             if (new_file_size % (1024*1024)) {
                 /* round up to nearest 1MB boundary */
                 new_file_size = ((new_file_size >> 20) + 1) << 20;
-                bdrv_truncate(bs->file->bs, new_file_size);
+                bdrv_truncate(bs->file, new_file_size);
             }
         }
         qemu_vfree(desc_entries);
diff --git a/block/vhdx.c b/block/vhdx.c
index 68db9e0..c67772e 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1165,7 +1165,7 @@ static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
     /* per the spec, the address for a block is in units of 1MB */
     *new_offset = ROUND_UP(*new_offset, 1024 * 1024);
 
-    return bdrv_truncate(bs->file->bs, *new_offset + s->block_size);
+    return bdrv_truncate(bs->file, *new_offset + s->block_size);
 }
 
 /*
diff --git a/include/block/block.h b/include/block/block.h
index 4e81f20..a4cd06f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -253,7 +253,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 int bdrv_get_backing_file_depth(BlockDriverState *bs);
 void bdrv_refresh_filename(BlockDriverState *bs);
-int bdrv_truncate(BlockDriverState *bs, int64_t offset);
+int bdrv_truncate(BdrvChild *child, int64_t offset);
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
-- 
1.8.3.1
