Received: from eggs.gnu.org ([209.51.188.92]:57904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaM-0002qI-Qf
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaF-0004b2-9k
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjZa8-0004RN-RJ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:27 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jan 2019 20:01:01 -0500
Message-Id: <20190116010106.27626-4-jsnow@redhat.com>
In-Reply-To: <20190116010106.27626-1-jsnow@redhat.com>
References: <20190116010106.27626-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] dirty-bitmap: add
 bdrv_dirty_bitmap_next_dirty_area
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

The function alters bdrv_dirty_iter_next_area(), which is wrong and
less efficient (see further commit
"block/mirror: fix and improve do_sync_target_write" for description).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         |  6 ++++++
 include/block/dirty-bitmap.h |  2 ++
 include/qemu/hbitmap.h       | 16 +++++++++++++++
 util/hbitmap.c               | 39 ++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index b162f4ac22..c1518373f9 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -787,6 +787,12 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
     return hbitmap_next_zero(bitmap->bitmap, offset, bytes);
 }
 
+bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
+                                       uint64_t *offset, uint64_t *bytes)
+{
+    return hbitmap_next_dirty_area(bitmap->bitmap, offset, bytes);
+}
+
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
                              HBitmap **backup, Error **errp)
 {
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 102ccdda32..4ef00ca6ba 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -101,6 +101,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
                                     uint64_t bytes);
+bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
+                                       uint64_t *offset, uint64_t *bytes);
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 135975530f..097dce31ee 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -311,6 +311,22 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
  */
 int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count);
 
+/* hbitmap_next_dirty_area:
+ * @hb: The HBitmap to operate on
+ * @start: in-out parameter.
+ *         in: the offset to start from
+ *         out: (if area found) start of found area
+ * @count: in-out parameter.
+ *         in: length of requested region
+ *         out: length of found area
+ *
+ * If dirty area found within [@start, @start + @count), returns true and sets
+ * @offset and @bytes appropriately. Otherwise returns false and leaves @offset
+ * and @bytes unchanged.
+ */
+bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *start,
+                             uint64_t *count);
+
 /* hbitmap_create_meta:
  * Create a "meta" hbitmap to track dirtiness of the bits in this HBitmap.
  * The caller owns the created bitmap and must call hbitmap_free_meta(hb) to
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 09b3719e44..fa356522c4 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -246,6 +246,45 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t count)
     return res;
 }
 
+bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *start,
+                             uint64_t *count)
+{
+    HBitmapIter hbi;
+    int64_t firt_dirty_off, area_end;
+    uint32_t granularity = 1UL << hb->granularity;
+    uint64_t end;
+
+    if (*start >= hb->orig_size || *count == 0) {
+        return false;
+    }
+
+    end = *count > hb->orig_size - *start ? hb->orig_size : *start + *count;
+
+    hbitmap_iter_init(&hbi, hb, *start);
+    firt_dirty_off = hbitmap_iter_next(&hbi, false);
+
+    if (firt_dirty_off < 0 || firt_dirty_off >= end) {
+        return false;
+    }
+
+    if (firt_dirty_off + granularity >= end) {
+        area_end = end;
+    } else {
+        area_end = hbitmap_next_zero(hb, firt_dirty_off + granularity,
+                                     end - firt_dirty_off - granularity);
+        if (area_end < 0) {
+            area_end = end;
+        }
+    }
+
+    if (firt_dirty_off > *start) {
+        *start = firt_dirty_off;
+    }
+    *count = area_end - *start;
+
+    return true;
+}
+
 bool hbitmap_empty(const HBitmap *hb)
 {
     return hb->count == 0;
-- 
2.17.2
