Received: from eggs.gnu.org ([2001:4830:134:3::10]:55468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30l-0007PO-KW
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30k-0008VX-7g
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 10:10:46 -0500
Message-Id: <20170703151051.31327-13-eblake@redhat.com>
In-Reply-To: <20170703151051.31327-1-eblake@redhat.com>
References: <20170703151051.31327-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 12/17] dirty-bitmap: Change
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

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

---
v4: only context change, due to rebasing to persistent bitmaps
v3: rebase to addition of _locked interfaces; complex enough that I
dropped R-b
v2: no change
---
 include/block/dirty-bitmap.h |  8 ++++----
 block/dirty-bitmap.c         | 22 ++++++++++++++--------
 block/mirror.c               | 16 ++++++++--------
 migration/block.c            |  7 +++++--
 4 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 1dddcd3..0341a60 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -40,9 +40,9 @@ const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap);
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                           int64_t cur_sector, int64_t nr_sectors);
+                           int64_t offset, int64_t bytes);
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                             int64_t cur_sector, int64_t nr_sectors);
+                             int64_t offset, int64_t bytes);
 BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter);
@@ -75,9 +75,9 @@ void bdrv_dirty_bitmap_unlock(BdrvDirtyBitmap *bitmap);
 bool bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
                            int64_t offset);
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
-                                  int64_t cur_sector, int64_t nr_sectors);
+                                  int64_t offset, int64_t bytes);
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
-                                    int64_t cur_sector, int64_t nr_sectors);
+                                    int64_t offset, int64_t bytes);
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t offset);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 03ed2f6..7c79da4 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -511,35 +511,41 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)

 /* Called within bdrv_dirty_bitmap_lock..unlock */
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
-                                  int64_t cur_sector, int64_t nr_sectors)
+                                  int64_t offset, int64_t bytes)
 {
+    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
+
     assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
-    hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
+    hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
+                end_sector - (offset >> BDRV_SECTOR_BITS));
 }

 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                           int64_t cur_sector, int64_t nr_sectors)
+                           int64_t offset, int64_t bytes)
 {
     bdrv_dirty_bitmap_lock(bitmap);
-    bdrv_set_dirty_bitmap_locked(bitmap, cur_sector, nr_sectors);
+    bdrv_set_dirty_bitmap_locked(bitmap, offset, bytes);
     bdrv_dirty_bitmap_unlock(bitmap);
 }

 /* Called within bdrv_dirty_bitmap_lock..unlock */
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
-                                    int64_t cur_sector, int64_t nr_sectors)
+                                    int64_t offset, int64_t bytes)
 {
+    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
+
     assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
-    hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
+    hbitmap_reset(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
+                  end_sector - (offset >> BDRV_SECTOR_BITS));
 }

 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                             int64_t cur_sector, int64_t nr_sectors)
+                             int64_t offset, int64_t bytes)
 {
     bdrv_dirty_bitmap_lock(bitmap);
-    bdrv_reset_dirty_bitmap_locked(bitmap, cur_sector, nr_sectors);
+    bdrv_reset_dirty_bitmap_locked(bitmap, offset, bytes);
     bdrv_dirty_bitmap_unlock(bitmap);
 }

diff --git a/block/mirror.c b/block/mirror.c
index 19331c0..b74d6e0 100644
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
@@ -383,8 +381,8 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
      * calling bdrv_get_block_status_above could yield - if some blocks are
      * marked dirty in this window, we need to know.
      */
-    bdrv_reset_dirty_bitmap_locked(s->dirty_bitmap, offset >> BDRV_SECTOR_BITS,
-                                   nb_chunks * sectors_per_chunk);
+    bdrv_reset_dirty_bitmap_locked(s->dirty_bitmap, offset,
+                                   nb_chunks * s->granularity);
     bdrv_dirty_bitmap_unlock(s->dirty_bitmap);

     bitmap_set(s->in_flight_bitmap, offset / s->granularity, nb_chunks);
@@ -626,7 +624,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)

     if (base == NULL && !bdrv_has_zero_init(target_bs)) {
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
-            bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, end);
+            bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
             return 0;
         }

@@ -679,7 +677,9 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
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
index d6557a1..2844149 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -326,7 +326,8 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
     blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
                                 0, blk_mig_read_cb, blk);

-    bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector, nr_sectors);
+    bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
+                            nr_sectors * BDRV_SECTOR_SIZE);
     aio_context_release(blk_get_aio_context(bmds->blk));
     qemu_mutex_unlock_iothread();

@@ -534,7 +535,9 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
             } else {
                 nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
             }
-            bdrv_reset_dirty_bitmap_locked(bmds->dirty_bitmap, sector, nr_sectors);
+            bdrv_reset_dirty_bitmap_locked(bmds->dirty_bitmap,
+                                           sector * BDRV_SECTOR_SIZE,
+                                           nr_sectors * BDRV_SECTOR_SIZE);
             bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);

             blk = g_new(BlkMigBlock, 1);
-- 
2.9.4
