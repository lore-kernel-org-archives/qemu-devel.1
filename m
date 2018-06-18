Received: from eggs.gnu.org ([2001:4830:134:3::10]:52355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHi-0005Ga-VI
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHh-0006Vv-Pt
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:59 +0200
Message-Id: <20180618164504.24488-31-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 30/35] block/dirty-bitmap: Add
 bdrv_dirty_iter_next_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

This new function allows to look for a consecutively dirty area in a
dirty bitmap.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20180613181823.13618-10-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/dirty-bitmap.h |  2 ++
 block/dirty-bitmap.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 02e0cbabd2..288dc6adb6 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -82,6 +82,8 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t offset, int64_t bytes);
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
+bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
+                               uint64_t *offset, int *bytes);
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t offset);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index cedb971765..db1782ec1f 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -522,6 +522,61 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
     return hbitmap_iter_next(&iter->hbi, true);
 }
 
+/**
+ * Return the next consecutively dirty area in the dirty bitmap
+ * belonging to the given iterator @iter.
+ *
+ * @max_offset: Maximum value that may be returned for
+ *              *offset + *bytes
+ * @offset:     Will contain the start offset of the next dirty area
+ * @bytes:      Will contain the length of the next dirty area
+ *
+ * Returns: True if a dirty area could be found before max_offset
+ *          (which means that *offset and *bytes then contain valid
+ *          values), false otherwise.
+ *
+ * Note that @iter is never advanced if false is returned.  If an area
+ * is found (which means that true is returned), it will be advanced
+ * past that area.
+ */
+bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
+                               uint64_t *offset, int *bytes)
+{
+    uint32_t granularity = bdrv_dirty_bitmap_granularity(iter->bitmap);
+    uint64_t gran_max_offset;
+    int64_t ret;
+    int size;
+
+    if (max_offset == iter->bitmap->size) {
+        /* If max_offset points to the image end, round it up by the
+         * bitmap granularity */
+        gran_max_offset = ROUND_UP(max_offset, granularity);
+    } else {
+        gran_max_offset = max_offset;
+    }
+
+    ret = hbitmap_iter_next(&iter->hbi, false);
+    if (ret < 0 || ret + granularity > gran_max_offset) {
+        return false;
+    }
+
+    *offset = ret;
+    size = 0;
+
+    assert(granularity <= INT_MAX);
+
+    do {
+        /* Advance iterator */
+        ret = hbitmap_iter_next(&iter->hbi, true);
+        size += granularity;
+    } while (ret + granularity <= gran_max_offset &&
+             hbitmap_iter_next(&iter->hbi, false) == ret + granularity &&
+             size <= INT_MAX - granularity);
+
+    *bytes = MIN(size, max_offset - *offset);
+    return true;
+}
+
 /* Called within bdrv_dirty_bitmap_lock..unlock */
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t offset, int64_t bytes)
-- 
2.13.6
