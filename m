Received: from eggs.gnu.org ([2001:4830:134:3::10]:43738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fleAJ-00007N-DE
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fleAE-0008QL-HE
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:47:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Aug 2018 20:46:49 +0300
Message-Id: <20180803174654.278336-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180803174654.278336-1-vsementsov@virtuozzo.com>
References: <20180803174654.278336-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/6] dirty-bitmap: improve
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
 include/qemu/hbitmap.h       |  7 +++++--
 block/backup.c               |  2 +-
 block/dirty-bitmap.c         |  5 +++--
 nbd/server.c                 |  2 +-
 util/hbitmap.c               | 13 ++++++++++---
 6 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 259bd27c40..5dc146abf3 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -98,7 +98,8 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
-int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start,
+                                    uint64_t bytes);
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index ddca52c48e..259bfc2936 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -295,10 +295,13 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
 /* hbitmap_next_zero:
  * @hb: The HBitmap to operate on
  * @start: The bit to start from.
+ * @bytes: Range length to search in. If @bytes is zero, search up to the bitmap
+ *         end.
  *
- * Find next not dirty bit.
+ * Find next not dirty bit within range [@start, @start + @bytes), or from
+ * @start to the bitmap end if @bytes is zero.
  */
-int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start);
+int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t bytes);
 
 /* hbitmap_create_meta:
  * Create a "meta" hbitmap to track dirtiness of the bits in this HBitmap.
diff --git a/block/backup.c b/block/backup.c
index 8630d32926..3c8b054587 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -458,7 +458,7 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
             break;
         }
 
-        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset);
+        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset, 0);
         if (offset == -1) {
             hbitmap_set(job->copy_bitmap, cluster, end - cluster);
             break;
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index c9b8a6fd52..a9ee814da7 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -785,9 +785,10 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
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
diff --git a/nbd/server.c b/nbd/server.c
index ea5fe0eb33..92a5651ba9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1952,7 +1952,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
     assert(begin < overall_end && nb_extents);
     while (begin < overall_end && i < nb_extents) {
         if (dirty) {
-            end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
+            end = bdrv_dirty_bitmap_next_zero(bitmap, begin, 0);
         } else {
             bdrv_set_dirty_iter(it, begin);
             end = bdrv_dirty_iter_next(it);
diff --git a/util/hbitmap.c b/util/hbitmap.c
index bcd304041a..73137c10a0 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -192,16 +192,23 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
     }
 }
 
-int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start)
+int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t bytes)
 {
     size_t pos = (start >> hb->granularity) >> BITS_PER_LEVEL;
     unsigned long *last_lev = hb->levels[HBITMAP_LEVELS - 1];
-    uint64_t sz = hb->sizes[HBITMAP_LEVELS - 1];
+    uint64_t end_bit =
+            bytes ? ((start + bytes - 1) >> hb->granularity) + 1 : hb->size;
+    uint64_t sz = (end_bit + BITS_PER_LONG - 1) >> BITS_PER_LEVEL;
     unsigned long cur = last_lev[pos];
     unsigned start_bit_offset =
             (start >> hb->granularity) & (BITS_PER_LONG - 1);
     int64_t res;
 
+    assert(!bytes || start + bytes <= (hb->size << hb->granularity));
+
+    /* There may be some zero bits in @cur before @start. We are not interested
+     * in them, let's set them.
+     */
     cur |= (1UL << start_bit_offset) - 1;
     assert((start >> hb->granularity) < hb->size);
 
@@ -218,7 +225,7 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start)
     }
 
     res = (pos << BITS_PER_LEVEL) + ctol(cur);
-    if (res >= hb->size) {
+    if (res >= end_bit) {
         return -1;
     }
 
-- 
2.11.1
