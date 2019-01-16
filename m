Received: from eggs.gnu.org ([209.51.188.92]:57795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaC-0002j0-Bj
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZa4-0004X1-PJ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjZa3-0004Qt-88
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:19 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jan 2019 20:00:59 -0500
Message-Id: <20190116010106.27626-2-jsnow@redhat.com>
In-Reply-To: <20190116010106.27626-1-jsnow@redhat.com>
References: <20190116010106.27626-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] dirty-bitmap: improve
 bdrv_dirty_bitmap_next_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add bytes parameter to the function, to limit searched range.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c               |  3 ++-
 block/dirty-bitmap.c         |  5 +++--
 include/block/dirty-bitmap.h |  3 ++-
 include/qemu/hbitmap.h       | 10 +++++++---
 nbd/server.c                 |  2 +-
 tests/test-hbitmap.c         |  2 +-
 util/hbitmap.c               | 27 ++++++++++++++++++++++-----
 7 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index b829b251eb..9ffce5c183 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -422,7 +422,8 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
             break;
         }
 
-        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset);
+        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset,
+                                             UINT64_MAX);
         if (offset == -1) {
             hbitmap_set(job->copy_bitmap, cluster, end - cluster);
             break;
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 6b688394e4..b162f4ac22 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -781,9 +781,10 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
     return hbitmap_sha256(bitmap->bitmap, errp);
 }
 
-int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset)
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
+                                    uint64_t bytes)
 {
-    return hbitmap_next_zero(bitmap->bitmap, offset);
+    return hbitmap_next_zero(bitmap->bitmap, offset, bytes);
 }
 
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8f38a3dec1..102ccdda32 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -99,7 +99,8 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
-int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
+                                    uint64_t bytes);
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index a7cb780592..135975530f 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -300,12 +300,16 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first);
 unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
 
 /* hbitmap_next_zero:
+ *
+ * Find next not dirty bit within selected range. If not found, return -1.
+ *
  * @hb: The HBitmap to operate on
  * @start: The bit to start from.
- *
- * Find next not dirty bit.
+ * @count: Number of bits to proceed. If @start+@count > bitmap size, the whole
+ * bitmap is looked through. You can use UINT64_MAX as @count to search up to
+ * the bitmap end.
  */
-int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start);
+int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count);
 
 /* hbitmap_create_meta:
  * Create a "meta" hbitmap to track dirtiness of the bits in this HBitmap.
diff --git a/nbd/server.c b/nbd/server.c
index e8c56607ef..6b136019f8 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2014,7 +2014,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
         bool next_dirty = !dirty;
 
         if (dirty) {
-            end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
+            end = bdrv_dirty_bitmap_next_zero(bitmap, begin, UINT64_MAX);
         } else {
             bdrv_set_dirty_iter(it, begin);
             end = bdrv_dirty_iter_next(it);
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 5e67ac1d3a..b04a45a2de 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -939,7 +939,7 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
 
 static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
 {
-    int64_t ret1 = hbitmap_next_zero(data->hb, start);
+    int64_t ret1 = hbitmap_next_zero(data->hb, start, UINT64_MAX);
     int64_t ret2 = start;
     for ( ; ret2 < data->size && hbitmap_get(data->hb, ret2); ret2++) {
         ;
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 8d402c59d9..09b3719e44 100644
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
 
@@ -192,16 +195,28 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
     }
 }
 
-int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start)
+int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count)
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
 
+    if (start >= hb->orig_size || count == 0) {
+        return -1;
+    }
+
+    end_bit = count > hb->orig_size - start ?
+                hb->size :
+                ((start + count - 1) >> hb->granularity) + 1;
+    sz = (end_bit + BITS_PER_LONG - 1) >> BITS_PER_LEVEL;
+
+    /* There may be some zero bits in @cur before @start. We are not interested
+     * in them, let's set them.
+     */
+    start_bit_offset = (start >> hb->granularity) & (BITS_PER_LONG - 1);
     cur |= (1UL << start_bit_offset) - 1;
     assert((start >> hb->granularity) < hb->size);
 
@@ -218,7 +233,7 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start)
     }
 
     res = (pos << BITS_PER_LEVEL) + ctol(cur);
-    if (res >= hb->size) {
+    if (res >= end_bit) {
         return -1;
     }
 
@@ -652,6 +667,8 @@ HBitmap *hbitmap_alloc(uint64_t size, int granularity)
     HBitmap *hb = g_new0(struct HBitmap, 1);
     unsigned i;
 
+    hb->orig_size = size;
+
     assert(granularity >= 0 && granularity < 64);
     size = (size + (1ULL << granularity) - 1) >> granularity;
     assert(size <= ((uint64_t)1 << HBITMAP_LOG_MAX_SIZE));
-- 
2.17.2
