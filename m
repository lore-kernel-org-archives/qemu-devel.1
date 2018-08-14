Received: from eggs.gnu.org ([2001:4830:134:3::10]:37591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYDs-0002eE-Ux
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYDn-00051y-Rf
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:14:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Aug 2018 15:14:36 +0300
Message-Id: <20180814121443.33114-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180814121443.33114-1-vsementsov@virtuozzo.com>
References: <20180814121443.33114-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 1/8] dirty-bitmap: improve
 bdrv_dirty_bitmap_next_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add bytes parameter to the function, to limit searched range.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h |  3 ++-
 include/qemu/hbitmap.h       | 10 ++++++++--
 block/backup.c               |  2 +-
 block/dirty-bitmap.c         |  5 +++--
 nbd/server.c                 |  2 +-
 tests/test-hbitmap.c         |  2 +-
 util/hbitmap.c               | 25 ++++++++++++++++++++-----
 7 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 259bd27c40..27f5299c4e 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -98,7 +98,8 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
-int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start,
+                                    int64_t end);
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index ddca52c48e..fe4dfde27a 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -295,10 +295,16 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
 /* hbitmap_next_zero:
  * @hb: The HBitmap to operate on
  * @start: The bit to start from.
+ * @end: End of range to search in. If @end is -1, search up to the bitmap
+ *       end.
  *
- * Find next not dirty bit.
+ * Find next not dirty bit within range [@start, @end), or from
+ * @start to the bitmap end if @end is -1. If not found, return -1.
+ *
+ * @end may be greater than original bitmap size, in this case, search up to
+ * the bitmap end.
  */
-int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start);
+int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, int64_t end);
 
 /* hbitmap_create_meta:
  * Create a "meta" hbitmap to track dirtiness of the bits in this HBitmap.
diff --git a/block/backup.c b/block/backup.c
index 8630d32926..9bfd3f7189 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -458,7 +458,7 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
             break;
         }
 
-        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset);
+        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset, -1);
         if (offset == -1) {
             hbitmap_set(job->copy_bitmap, cluster, end - cluster);
             break;
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index c9b8a6fd52..037ae62726 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -785,9 +785,10 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
     return hbitmap_sha256(bitmap->bitmap, errp);
 }
 
-int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset)
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
+                                    int64_t end)
 {
-    return hbitmap_next_zero(bitmap->bitmap, offset);
+    return hbitmap_next_zero(bitmap->bitmap, offset, end);
 }
 
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
diff --git a/nbd/server.c b/nbd/server.c
index ea5fe0eb33..07920d123b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1952,7 +1952,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
     assert(begin < overall_end && nb_extents);
     while (begin < overall_end && i < nb_extents) {
         if (dirty) {
-            end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
+            end = bdrv_dirty_bitmap_next_zero(bitmap, begin, -1);
         } else {
             bdrv_set_dirty_iter(it, begin);
             end = bdrv_dirty_iter_next(it);
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 5e67ac1d3a..6b6a40bddd 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -939,7 +939,7 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
 
 static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
 {
-    int64_t ret1 = hbitmap_next_zero(data->hb, start);
+    int64_t ret1 = hbitmap_next_zero(data->hb, start, -1);
     int64_t ret2 = start;
     for ( ; ret2 < data->size && hbitmap_get(data->hb, ret2); ret2++) {
         ;
diff --git a/util/hbitmap.c b/util/hbitmap.c
index bcd304041a..1687372504 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -53,6 +53,9 @@
  */
 
 struct HBitmap {
+    /* Size of the bitmap, as requested in hbitmap_alloc. */
+    uint64_t orig_size;
+
     /* Number of total bits in the bottom level.  */
     uint64_t size;
 
@@ -192,16 +195,26 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
     }
 }
 
-int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start)
+int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, int64_t end)
 {
     size_t pos = (start >> hb->granularity) >> BITS_PER_LEVEL;
     unsigned long *last_lev = hb->levels[HBITMAP_LEVELS - 1];
-    uint64_t sz = hb->sizes[HBITMAP_LEVELS - 1];
     unsigned long cur = last_lev[pos];
-    unsigned start_bit_offset =
-            (start >> hb->granularity) & (BITS_PER_LONG - 1);
+    unsigned start_bit_offset;
+    uint64_t end_bit, sz;
     int64_t res;
 
+    if (start >= hb->orig_size || (end != -1 && end <= start)) {
+        return -1;
+    }
+
+    end_bit = end == -1 ? hb->size : ((end - 1) >> hb->granularity) + 1;
+    sz = (end_bit + BITS_PER_LONG - 1) >> BITS_PER_LEVEL;
+
+    /* There may be some zero bits in @cur before @start. We are not interested
+     * in them, let's set them.
+     */
+    start_bit_offset = (start >> hb->granularity) & (BITS_PER_LONG - 1);
     cur |= (1UL << start_bit_offset) - 1;
     assert((start >> hb->granularity) < hb->size);
 
@@ -218,7 +231,7 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start)
     }
 
     res = (pos << BITS_PER_LEVEL) + ctol(cur);
-    if (res >= hb->size) {
+    if (res >= end_bit) {
         return -1;
     }
 
@@ -652,6 +665,8 @@ HBitmap *hbitmap_alloc(uint64_t size, int granularity)
     HBitmap *hb = g_new0(struct HBitmap, 1);
     unsigned i;
 
+    hb->orig_size = size;
+
     assert(granularity >= 0 && granularity < 64);
     size = (size + (1ULL << granularity) - 1) >> granularity;
     assert(size <= ((uint64_t)1 << HBITMAP_LOG_MAX_SIZE));
-- 
2.11.1
