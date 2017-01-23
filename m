Received: from eggs.gnu.org ([2001:4830:134:3::10]:36274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSR-0002HA-L4
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSN-0005BA-IU
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:47 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:17231 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSN-00057p-4x
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:43 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:18 +0300
Message-Id: <20170123121036.4823-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 06/24] block/dirty-bitmap: add deserialize_ones
 func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Add bdrv_dirty_bitmap_deserialize_ones() function, which is needed for
qcow2 bitmap loading, to handle unallocated bitmap parts, marked as
all-ones.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         |  7 +++++++
 include/block/dirty-bitmap.h |  3 +++
 include/qemu/hbitmap.h       | 15 +++++++++++++++
 util/hbitmap.c               | 17 +++++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 186941cfc3..90af37287f 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -499,6 +499,13 @@ void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
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
index 7cbe623ba7..1e17729ac2 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -70,6 +70,9 @@ void bdrv_dirty_bitmap_deserialize_part(BdrvDirtyBitmap *bitmap,
 void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
                                           uint64_t start, uint64_t count,
                                           bool finish);
+void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
+                                        uint64_t start, uint64_t count,
+                                        bool finish);
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
 #endif
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 2965f01383..063ec0e7ad 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -216,6 +216,21 @@ void hbitmap_deserialize_zeroes(HBitmap *hb, uint64_t start, uint64_t count,
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
index 1dbc8ba8b7..47418a915e 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -535,6 +535,23 @@ void hbitmap_deserialize_zeroes(HBitmap *hb, uint64_t start, uint64_t count,
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
2.11.0
