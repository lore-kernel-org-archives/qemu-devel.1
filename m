Received: from eggs.gnu.org ([2001:4830:134:3::10]:43004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmD-0006Eh-2x
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmB-0000W3-Dw
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:23 +0200
Message-Id: <1499447335-6125-69-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 068/100] block/dirty-bitmap: add
 deserialize_ones func
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add bdrv_dirty_bitmap_deserialize_ones() function, which is needed for
qcow2 bitmap loading, to handle unallocated bitmap parts, marked as
all-ones.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-7-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/dirty-bitmap.c         |  7 +++++++
 include/block/dirty-bitmap.h |  3 +++
 include/qemu/hbitmap.h       | 15 +++++++++++++++
 util/hbitmap.c               | 17 +++++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index df0110c..f502c45 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -586,6 +586,13 @@ void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
     hbitmap_deserialize_zeroes(bitmap->bitmap, start, count, finish);
 }
 
+void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
+                                        uint64_t start, uint64_t count,
+                                        bool finish)
+{
+    hbitmap_deserialize_ones(bitmap->bitmap, start, count, finish);
+}
+
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap)
 {
     hbitmap_deserialize_finish(bitmap->bitmap);
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index ab89f08..05451c7 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -66,6 +66,9 @@ void bdrv_dirty_bitmap_deserialize_part(BdrvDirtyBitmap *bitmap,
 void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
                                           uint64_t start, uint64_t count,
                                           bool finish);
+void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
+                                        uint64_t start, uint64_t count,
+                                        bool finish);
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
 /* Functions that require manual locking.  */
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 6b04391..b52304a 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -229,6 +229,21 @@ void hbitmap_deserialize_zeroes(HBitmap *hb, uint64_t start, uint64_t count,
                                 bool finish);
 
 /**
+ * hbitmap_deserialize_ones
+ * @hb: HBitmap to operate on.
+ * @start: First bit to restore.
+ * @count: Number of bits to restore.
+ * @finish: Whether to call hbitmap_deserialize_finish automatically.
+ *
+ * Fills the bitmap with ones.
+ *
+ * If @finish is false, caller must call hbitmap_serialize_finish before using
+ * the bitmap.
+ */
+void hbitmap_deserialize_ones(HBitmap *hb, uint64_t start, uint64_t count,
+                              bool finish);
+
+/**
  * hbitmap_deserialize_finish
  * @hb: HBitmap to operate on.
  *
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 0b38817..0c1591a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -551,6 +551,23 @@ void hbitmap_deserialize_zeroes(HBitmap *hb, uint64_t start, uint64_t count,
     }
 }
 
+void hbitmap_deserialize_ones(HBitmap *hb, uint64_t start, uint64_t count,
+                              bool finish)
+{
+    uint64_t el_count;
+    unsigned long *first;
+
+    if (!count) {
+        return;
+    }
+    serialization_chunk(hb, start, count, &first, &el_count);
+
+    memset(first, 0xff, el_count * sizeof(unsigned long));
+    if (finish) {
+        hbitmap_deserialize_finish(hb);
+    }
+}
+
 void hbitmap_deserialize_finish(HBitmap *bitmap)
 {
     int64_t i, size, prev_size;
-- 
1.8.3.1
