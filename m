Received: from eggs.gnu.org ([2001:4830:134:3::10]:41392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjO1-0002td-00
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNy-0003fv-86
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:48:05 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 16 May 2017 15:47:21 -0500
Message-Id: <20170516204724.1617-10-eblake@redhat.com>
In-Reply-To: <20170516204724.1617-1-eblake@redhat.com>
References: <20170516204724.1617-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/12] dirty-bitmap: Change
 bdrv_[re]set_dirty_bitmap() to use bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Some of the callers were already scaling bytes to sectors; others
can be easily converted to pass byte offsets, all in our shift
towards a consistent byte interface everywhere.  Making the change
will also make it easier to write the hold-out callers to use byte
rather than sectors for their iterations; it also makes it easier
for a future dirty-bitmap patch to offload scaling over to the
internal hbitmap.  Although all callers happen to pass
sector-aligned values, make the internal scaling robust to any
sub-sector requests.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: no change
---
 include/block/dirty-bitmap.h |  4 ++--
 block/dirty-bitmap.c         | 14 ++++++++++----
 block/mirror.c               | 16 ++++++++--------
 migration/block.c            |  7 +++++--
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index b8434e5..fdff1e2 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -37,9 +37,9 @@ DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
 bool bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
                     int64_t offset);
 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                           int64_t cur_sector, int64_t nr_sectors);
+                           int64_t offset, int64_t bytes);
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                             int64_t cur_sector, int64_t nr_sectors);
+                             int64_t offset, int64_t bytes);
 BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index c8100d2..8e7822c 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -401,17 +401,23 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 }

 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                           int64_t cur_sector, int64_t nr_sectors)
+                           int64_t offset, int64_t bytes)
 {
+    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
+
     assert(bdrv_dirty_bitmap_enabled(bitmap));
-    hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
+    hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
+                end_sector - (offset >> BDRV_SECTOR_BITS));
 }

 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                             int64_t cur_sector, int64_t nr_sectors)
+                             int64_t offset, int64_t bytes)
 {
+    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
+
     assert(bdrv_dirty_bitmap_enabled(bitmap));
-    hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
+    hbitmap_reset(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
+                  end_sector - (offset >> BDRV_SECTOR_BITS));
 }

 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
diff --git a/block/mirror.c b/block/mirror.c
index 8b36ec2..b4fe259 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -141,8 +141,7 @@ static void mirror_write_complete(void *opaque, int ret)
     if (ret < 0) {
         BlockErrorAction action;

-        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset >> BDRV_SECTOR_BITS,
-                              op->bytes >> BDRV_SECTOR_BITS);
+        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset, op->bytes);
         action = mirror_error_action(s, false, -ret);
         if (action == BLOCK_ERROR_ACTION_REPORT && s->ret >= 0) {
             s->ret = ret;
@@ -161,8 +160,7 @@ static void mirror_read_complete(void *opaque, int ret)
     if (ret < 0) {
         BlockErrorAction action;

-        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset >> BDRV_SECTOR_BITS,
-                              op->bytes >> BDRV_SECTOR_BITS);
+        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset, op->bytes);
         action = mirror_error_action(s, true, -ret);
         if (action == BLOCK_ERROR_ACTION_REPORT && s->ret >= 0) {
             s->ret = ret;
@@ -380,8 +378,8 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
      * calling bdrv_get_block_status_above could yield - if some blocks are
      * marked dirty in this window, we need to know.
      */
-    bdrv_reset_dirty_bitmap(s->dirty_bitmap, offset >> BDRV_SECTOR_BITS,
-                            nb_chunks * sectors_per_chunk);
+    bdrv_reset_dirty_bitmap(s->dirty_bitmap, offset,
+                            nb_chunks * s->granularity);
     bitmap_set(s->in_flight_bitmap, offset / s->granularity, nb_chunks);
     while (nb_chunks > 0 && offset < s->bdev_length) {
         int64_t ret;
@@ -614,7 +612,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)

     if (base == NULL && !bdrv_has_zero_init(target_bs)) {
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
-            bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, end);
+            bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
             return 0;
         }

@@ -667,7 +665,9 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
         assert(n > 0);
         if (ret == 1) {
-            bdrv_set_dirty_bitmap(s->dirty_bitmap, sector_num, n);
+            bdrv_set_dirty_bitmap(s->dirty_bitmap,
+                                  sector_num * BDRV_SECTOR_SIZE,
+                                  n * BDRV_SECTOR_SIZE);
         }
         sector_num += n;
     }
diff --git a/migration/block.c b/migration/block.c
index 3e3dec9..5b1b53c 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -331,7 +331,8 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
     blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
                                 0, blk_mig_read_cb, blk);

-    bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector, nr_sectors);
+    bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
+                            nr_sectors * BDRV_SECTOR_SIZE);
     aio_context_release(blk_get_aio_context(bmds->blk));
     qemu_mutex_unlock_iothread();

@@ -575,7 +576,9 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
                 g_free(blk);
             }

-            bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
+            bdrv_reset_dirty_bitmap(bmds->dirty_bitmap,
+                                    sector * BDRV_SECTOR_SIZE,
+                                    nr_sectors * BDRV_SECTOR_SIZE);
             sector += nr_sectors;
             bmds->cur_dirty = sector;

-- 
2.9.4
