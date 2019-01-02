Received: from eggs.gnu.org ([208.118.235.92]:56765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gedLO-0005uu-Rz
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gedLN-0007iI-P6
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:01:46 -0500
From: mahaocong <mahaocong_work@163.com>
Date: Wed,  2 Jan 2019 18:01:13 +0800
Message-Id: <20190102100113.24621-1-mahaocong_work@163.com>
Subject: [Qemu-devel] [PATCH v1] add new function to copy dirty-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: fam@euphon.net, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, mahaocong <mahaocong@didichuxing.com>

From: mahaocong <mahaocong@didichuxing.com>

This patch adds new function to copy the hbitmap from an exist dirty-bitmap to
another. The destination bitmap should have the same size and granularity with
the source bitmap, or the copy will fail.

Signed-off-by: mahaocong <mahaocong@didichuxing.com>
---
 block/dirty-bitmap.c         | 14 ++++++++++++++
 include/block/dirty-bitmap.h |  3 +++
 include/qemu/hbitmap.h       |  2 ++
 util/hbitmap.c               | 28 ++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 89fd1d7f8b..4445182e2a 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -348,6 +348,20 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
     return ret;
 }
 
+BdrvDirtyBitmap *bdrv_copy_dirty_bitmap(BdrvDirtyBitmap *src,
+                                        BdrvDirtyBitmap *dest,
+                                        Error **errp)
+{
+    qemu_mutex_lock(src->mutex);
+    if (!hbitmap_copy(dest->bitmap, src->bitmap)) {
+        error_setg(errp, "Error: copy src bitmap failed");
+        return NULL;
+    }
+    qemu_mutex_unlock(src->mutex);
+
+    return dest;
+}
+
 /**
  * Truncates _all_ bitmaps attached to a BDS.
  * Called with BQL taken.
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8f38a3dec1..ae2e82f44b 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -21,6 +21,9 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
                                            BdrvDirtyBitmap *bitmap,
                                            Error **errp);
+BdrvDirtyBitmap *bdrv_copy_dirty_bitmap(BdrvDirtyBitmap *src,
+                                        BdrvDirtyBitmap *dest,
+                                        Error **errp);
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index a7cb780592..6de3b4eb7e 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -91,6 +91,8 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result);
  */
 bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b);
 
+bool hbitmap_copy(HBitmap *dst, const HBitmap *src);
+
 /**
  * hbitmap_empty:
  * @hb: HBitmap to operate on.
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 8d402c59d9..7ae2fc270c 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -765,6 +765,34 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result)
     return true;
 }
 
+/*
+ * Copy HBitmaps form src to dst.
+ *
+ * @return true if the copy was successful,
+ *         false if it was not attempted.
+ */
+bool hbitmap_copy(HBitmap *dst, const HBitmap *src)
+{
+    int i;
+
+    if ((dst->size != src->size) || (dst->granularity != src->granularity)) {
+        return false;
+    }
+
+    if (hbitmap_count(src) == 0) {
+        return true;
+    }
+
+    for (i = HBITMAP_LEVELS - 1; i >= 0; i--) {
+        memcpy(dst->levels[i], src->levels[i],
+               src->sizes[i] * sizeof(unsigned long));
+    }
+
+    dst->count = src->count;
+    return true;
+}
+
+
 HBitmap *hbitmap_create_meta(HBitmap *hb, int chunk_size)
 {
     assert(!(chunk_size & (chunk_size - 1)));
-- 
2.14.1
