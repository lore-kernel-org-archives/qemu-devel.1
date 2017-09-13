Received: from eggs.gnu.org ([2001:4830:134:3::10]:37474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCHs-0000eH-IV
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCHr-000627-Ff
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:21:24 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:19:04 +0200
Message-Id: <20170913181910.29688-13-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 12/18] block/dirty-bitmap: Add
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This new function allows to look for a consecutively dirty area in a
dirty bitmap.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/dirty-bitmap.h |  2 ++
 block/dirty-bitmap.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index a79a58d2c3..7654748700 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -90,6 +90,8 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t cur_sector, int64_t nr_sectors);
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
+bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
+                               uint64_t *offset, int *bytes);
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index aee57cf8c8..81b2f78016 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -550,6 +550,58 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
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
+ */
+bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
+                               uint64_t *offset, int *bytes)
+{
+    uint32_t granularity = bdrv_dirty_bitmap_granularity(iter->bitmap);
+    uint64_t gran_max_offset;
+    int sector_gran = granularity >> BDRV_SECTOR_BITS;
+    int64_t ret;
+    int size;
+
+    if (DIV_ROUND_UP(max_offset, BDRV_SECTOR_SIZE) == iter->bitmap->size) {
+        /* If max_offset points to the image end, round it up by the
+         * bitmap granularity */
+        gran_max_offset = ROUND_UP(max_offset, granularity);
+    } else {
+        gran_max_offset = max_offset;
+    }
+
+    ret = hbitmap_iter_next(&iter->hbi, false);
+    if (ret < 0 || (ret << BDRV_SECTOR_BITS) + granularity > gran_max_offset) {
+        return false;
+    }
+
+    *offset = ret << BDRV_SECTOR_BITS;
+    size = 0;
+
+    assert(granularity <= INT_MAX);
+
+    do {
+        /* Advance iterator */
+        ret = hbitmap_iter_next(&iter->hbi, true);
+        size += granularity;
+    } while ((ret << BDRV_SECTOR_BITS) + granularity <= gran_max_offset &&
+             hbitmap_iter_next(&iter->hbi, false) == ret + sector_gran &&
+             size <= INT_MAX - granularity);
+
+    *bytes = MIN(size, max_offset - *offset);
+    return true;
+}
+
 /* Called within bdrv_dirty_bitmap_lock..unlock */
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t cur_sector, int64_t nr_sectors)
-- 
2.13.5
