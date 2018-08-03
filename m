Received: from eggs.gnu.org ([2001:4830:134:3::10]:43734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fleAJ-00007I-Ca
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fleAE-0008QU-H1
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:47:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Aug 2018 20:46:50 +0300
Message-Id: <20180803174654.278336-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180803174654.278336-1-vsementsov@virtuozzo.com>
References: <20180803174654.278336-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/6] dirty-bitmap: add
 bdrv_dirty_bitmap_next_dirty_area
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

The function alters bdrv_dirty_iter_next_area(), which is wrong and
less efficient (see next commit for description).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h |  3 +++
 include/qemu/hbitmap.h       | 15 +++++++++++++++
 block/dirty-bitmap.c         |  7 +++++++
 util/hbitmap.c               | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 5dc146abf3..c02be67564 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -100,6 +100,9 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start,
                                     uint64_t bytes);
+bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
+                                       uint64_t *offset, uint64_t end,
+                                       uint64_t *length);
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 259bfc2936..347a46ef48 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -303,6 +303,21 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
  */
 int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t bytes);
 
+/* hbitmap_next_dirty_area:
+ * @hb: The HBitmap to operate on
+ * @offset: in-out parameter.
+ *          in: the offset to start from
+ *          out: (if area found) start of found area
+ * @end: end of requested region. (*@offset + *@length) will be <= @end
+ * @length: length of found area
+ *
+ * If dirty area found within [@offset, @end), returns true and sets @offset
+ * and @length appropriately. Otherwise returns true and leaves @offset and
+ * @length unchanged.
+ */
+bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *offset,
+                             uint64_t end, uint64_t *length);
+
 /* hbitmap_create_meta:
  * Create a "meta" hbitmap to track dirtiness of the bits in this HBitmap.
  * The caller owns the created bitmap and must call hbitmap_free_meta(hb) to
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index a9ee814da7..c24aa0e229 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -791,6 +791,13 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
     return hbitmap_next_zero(bitmap->bitmap, offset, bytes);
 }
 
+bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
+                                       uint64_t *offset, uint64_t end,
+                                       uint64_t *length)
+{
+    return hbitmap_next_dirty_area(bitmap->bitmap, offset, end, length);
+}
+
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
                              Error **errp)
 {
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 73137c10a0..7bfcb878c1 100644
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
 
@@ -238,6 +241,40 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t bytes)
     return res;
 }
 
+bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *offset,
+                             uint64_t end, uint64_t *length)
+{
+    HBitmapIter hbi;
+    int64_t off1, off0;
+    uint32_t granularity = 1UL << hb->granularity;
+
+    if (end == 0) {
+        end = hb->orig_size;
+    }
+
+    hbitmap_iter_init(&hbi, hb, *offset << hb->granularity);
+    off1 = hbitmap_iter_next(&hbi, true);
+
+    if (off1 < 0 || off1 >= end) {
+        return false;
+    }
+
+    if (off1 + granularity >= end) {
+        *offset = off1;
+        *length = end - off1;
+        return true;
+    }
+
+    off0 = hbitmap_next_zero(hb, off1 + granularity, end);
+    if (off0 < 0) {
+        off0 = end;
+    }
+
+    *offset = off1;
+    *length = off0 - off1;
+    return true;
+}
+
 bool hbitmap_empty(const HBitmap *hb)
 {
     return hb->count == 0;
@@ -659,6 +696,8 @@ HBitmap *hbitmap_alloc(uint64_t size, int granularity)
     HBitmap *hb = g_new0(struct HBitmap, 1);
     unsigned i;
 
+    hb->orig_size = size;
+
     assert(granularity >= 0 && granularity < 64);
     size = (size + (1ULL << granularity) - 1) >> granularity;
     assert(size <= ((uint64_t)1 << HBITMAP_LOG_MAX_SIZE));
-- 
2.11.1
