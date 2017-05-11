Received: from eggs.gnu.org ([2001:4830:134:3::10]:42823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIm-0002Bh-Dg
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIi-0004WV-8c
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:48 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 May 2017 16:42:06 +0200
Message-Id: <20170511144208.24075-17-pbonzini@redhat.com>
In-Reply-To: <20170511144208.24075-1-pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 16/18] block: protect modification of dirty
 bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: remove bdrv_get_dirty from API [Stefan]
                convert block migration from bdrv_get_dirty to _locked [Stefan]

 block/dirty-bitmap.c         | 68 ++++++++++++++++++++++++++++++++++++++------
 block/mirror.c               | 11 +++++--
 include/block/block_int.h    |  4 +--
 include/block/dirty-bitmap.h | 25 +++++++++++-----
 migration/block.c            | 10 ++++---
 5 files changed, 94 insertions(+), 24 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index fa78109365..a04c6e4154 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -37,6 +37,7 @@
  *     or enabled. A frozen bitmap can only abdicate() or reclaim().
  */
 struct BdrvDirtyBitmap {
+    QemuMutex *mutex;
     HBitmap *bitmap;            /* Dirty sector bitmap implementation */
     HBitmap *meta;              /* Meta dirty bitmap */
     BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
@@ -62,6 +63,16 @@ static inline void bdrv_dirty_bitmaps_unlock(BlockDriverState *bs)
     qemu_mutex_unlock(&bs->dirty_bitmap_mutex);
 }
 
+void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap)
+{
+    qemu_mutex_lock(bitmap->mutex);
+}
+
+void bdrv_dirty_bitmap_unlock(BdrvDirtyBitmap *bitmap)
+{
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
 /* Called with BQL or dirty_bitmap lock taken.  */
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs, const char *name)
 {
@@ -109,6 +120,7 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
         return NULL;
     }
     bitmap = g_new0(BdrvDirtyBitmap, 1);
+    bitmap->mutex = &bs->dirty_bitmap_mutex;
     bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(sector_granularity));
     bitmap->size = bitmap_size;
     bitmap->name = g_strdup(name);
@@ -134,20 +146,24 @@ void bdrv_create_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                                    int chunk_size)
 {
     assert(!bitmap->meta);
+    qemu_mutex_lock(bitmap->mutex);
     bitmap->meta = hbitmap_create_meta(bitmap->bitmap,
                                        chunk_size * BITS_PER_BYTE);
+    qemu_mutex_unlock(bitmap->mutex);
 }
 
 void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     assert(bitmap->meta);
+    qemu_mutex_lock(bitmap->mutex);
     hbitmap_free_meta(bitmap->bitmap);
     bitmap->meta = NULL;
+    qemu_mutex_unlock(bitmap->mutex);
 }
 
-int bdrv_dirty_bitmap_get_meta(BlockDriverState *bs,
-                               BdrvDirtyBitmap *bitmap, int64_t sector,
-                               int nb_sectors)
+int bdrv_dirty_bitmap_get_meta_locked(BlockDriverState *bs,
+                                      BdrvDirtyBitmap *bitmap, int64_t sector,
+                                      int nb_sectors)
 {
     uint64_t i;
     int sectors_per_bit = 1 << hbitmap_granularity(bitmap->meta);
@@ -162,11 +178,26 @@ int bdrv_dirty_bitmap_get_meta(BlockDriverState *bs,
     return false;
 }
 
+int bdrv_dirty_bitmap_get_meta(BlockDriverState *bs,
+                               BdrvDirtyBitmap *bitmap, int64_t sector,
+                               int nb_sectors)
+{
+    bool dirty;
+
+    qemu_mutex_lock(bitmap->mutex);
+    dirty = bdrv_dirty_bitmap_get_meta_locked(bs, bitmap, sector, nb_sectors);
+    qemu_mutex_unlock(bitmap->mutex);
+
+    return dirty;
+}
+
 void bdrv_dirty_bitmap_reset_meta(BlockDriverState *bs,
                                   BdrvDirtyBitmap *bitmap, int64_t sector,
                                   int nb_sectors)
 {
+    qemu_mutex_lock(bitmap->mutex);
     hbitmap_reset(bitmap->meta, sector, nb_sectors);
+    qemu_mutex_unlock(bitmap->mutex);
 }
 
 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap)
@@ -393,8 +424,9 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
     return list;
 }
 
-int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
-                   int64_t sector)
+/* Called within bdrv_dirty_bitmap_lock..unlock */
+int bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+                          int64_t sector)
 {
     if (bitmap) {
         return hbitmap_get(bitmap->bitmap, sector);
@@ -467,23 +499,42 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
     return hbitmap_iter_next(&iter->hbi);
 }
 
+/* Called within bdrv_dirty_bitmap_lock..unlock */
+void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
+                                  int64_t cur_sector, int64_t nr_sectors)
+{
+    assert(bdrv_dirty_bitmap_enabled(bitmap));
+    hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
+}
+
 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t cur_sector, int64_t nr_sectors)
 {
+    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_set_dirty_bitmap_locked(bitmap, cur_sector, nr_sectors);
+    bdrv_dirty_bitmap_unlock(bitmap);
+}
+
+/* Called within bdrv_dirty_bitmap_lock..unlock */
+void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
+                                    int64_t cur_sector, int64_t nr_sectors)
+{
     assert(bdrv_dirty_bitmap_enabled(bitmap));
-    hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
+    hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
 }
 
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t cur_sector, int64_t nr_sectors)
 {
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
-    hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
+    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_reset_dirty_bitmap_locked(bitmap, cur_sector, nr_sectors);
+    bdrv_dirty_bitmap_unlock(bitmap);
 }
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    bdrv_dirty_bitmap_lock(bitmap);
     if (!out) {
         hbitmap_reset_all(bitmap->bitmap);
     } else {
@@ -492,6 +543,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
                                        hbitmap_granularity(backup));
         *out = backup;
     }
+    bdrv_dirty_bitmap_unlock(bitmap);
 }
 
 void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in)
diff --git a/block/mirror.c b/block/mirror.c
index fc03a6d0a0..e367a33dfb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -342,6 +342,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     int max_io_sectors = MAX((s->buf_size >> BDRV_SECTOR_BITS) / MAX_IN_FLIGHT,
                              MAX_IO_SECTORS);
 
+    bdrv_dirty_bitmap_lock(s->dirty_bitmap);
     sector_num = bdrv_dirty_iter_next(s->dbi);
     if (sector_num < 0) {
         bdrv_set_dirty_iter(s->dbi, 0);
@@ -349,6 +350,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bitmap));
         assert(sector_num >= 0);
     }
+    bdrv_dirty_bitmap_unlock(s->dirty_bitmap);
 
     first_chunk = sector_num / sectors_per_chunk;
     while (test_bit(first_chunk, s->in_flight_bitmap)) {
@@ -360,12 +362,13 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 
     /* Find the number of consective dirty chunks following the first dirty
      * one, and wait for in flight requests in them. */
+    bdrv_dirty_bitmap_lock(s->dirty_bitmap);
     while (nb_chunks * sectors_per_chunk < (s->buf_size >> BDRV_SECTOR_BITS)) {
         int64_t next_dirty;
         int64_t next_sector = sector_num + nb_chunks * sectors_per_chunk;
         int64_t next_chunk = next_sector / sectors_per_chunk;
         if (next_sector >= end ||
-            !bdrv_get_dirty(source, s->dirty_bitmap, next_sector)) {
+            !bdrv_get_dirty_locked(source, s->dirty_bitmap, next_sector)) {
             break;
         }
         if (test_bit(next_chunk, s->in_flight_bitmap)) {
@@ -386,8 +389,10 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
      * calling bdrv_get_block_status_above could yield - if some blocks are
      * marked dirty in this window, we need to know.
      */
-    bdrv_reset_dirty_bitmap(s->dirty_bitmap, sector_num,
-                            nb_chunks * sectors_per_chunk);
+    bdrv_reset_dirty_bitmap_locked(s->dirty_bitmap, sector_num,
+                                  nb_chunks * sectors_per_chunk);
+    bdrv_dirty_bitmap_unlock(s->dirty_bitmap);
+
     bitmap_set(s->in_flight_bitmap, sector_num / sectors_per_chunk, nb_chunks);
     while (nb_chunks > 0 && sector_num < end) {
         int64_t ret;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 70ec219abf..33d48054f2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -597,8 +597,8 @@ struct BlockDriverState {
 
     /* Writing to the list requires the BQL _and_ the dirty_bitmap_mutex.
      * Reading from the list can be done with either the BQL or the
-     * dirty_bitmap_mutex.  Modifying a bitmap requires the AioContext
-     * lock.  */
+     * dirty_bitmap_mutex.  Modifying a bitmap only requires
+     * dirty_bitmap_mutex.  */
     QemuMutex dirty_bitmap_mutex;
     QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
 
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 9dea14ba03..ad6558af56 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -36,8 +36,6 @@ bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap);
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
-int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
-                   int64_t sector);
 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t cur_sector, int64_t nr_sectors);
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
@@ -45,6 +43,9 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 int bdrv_dirty_bitmap_get_meta(BlockDriverState *bs,
                                BdrvDirtyBitmap *bitmap, int64_t sector,
                                int nb_sectors);
+int bdrv_dirty_bitmap_get_meta_locked(BlockDriverState *bs,
+                                      BdrvDirtyBitmap *bitmap, int64_t sector,
+                                      int nb_sectors);
 void bdrv_dirty_bitmap_reset_meta(BlockDriverState *bs,
                                   BdrvDirtyBitmap *bitmap, int64_t sector,
                                   int nb_sectors);
@@ -52,11 +53,6 @@ BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap,
                                          uint64_t first_sector);
 void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter);
-int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
-void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
-int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
-int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
-void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
 
 uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bitmap,
                                               uint64_t start, uint64_t count);
@@ -72,4 +68,19 @@ void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
                                           bool finish);
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
+/* Functions that require manual locking.  */
+void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
+void bdrv_dirty_bitmap_unlock(BdrvDirtyBitmap *bitmap);
+int bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+                          int64_t sector);
+void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
+                                  int64_t cur_sector, int64_t nr_sectors);
+void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
+                                    int64_t cur_sector, int64_t nr_sectors);
+int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
+void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
+int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
+int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
+void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
+
 #endif
diff --git a/migration/block.c b/migration/block.c
index 79adab88cf..c1669ba54a 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -530,14 +530,15 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
         } else {
             blk_mig_unlock();
         }
-        if (bdrv_get_dirty(bs, bmds->dirty_bitmap, sector)) {
-
+        bdrv_dirty_bitmap_lock(bmds->dirty_bitmap);
+        if (bdrv_get_dirty_locked(bs, bmds->dirty_bitmap, sector)) {
             if (total_sectors - sector < BDRV_SECTORS_PER_DIRTY_CHUNK) {
                 nr_sectors = total_sectors - sector;
             } else {
                 nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
             }
-            bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
+            bdrv_reset_dirty_bitmap_locked(bmds->dirty_bitmap, sector, nr_sectors);
+            bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);
 
             blk = g_new(BlkMigBlock, 1);
             blk->buf = g_malloc(BLOCK_SIZE);
@@ -573,9 +574,10 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
 
             sector += nr_sectors;
             bmds->cur_dirty = sector;
-
             break;
         }
+
+        bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);
         sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
         bmds->cur_dirty = sector;
     }
-- 
2.12.2
