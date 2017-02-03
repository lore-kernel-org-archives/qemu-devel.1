Received: from eggs.gnu.org ([2001:4830:134:3::10]:36691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007nU-AU
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5i-00080s-I1
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:22171 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5i-0007z5-78
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:47 +0300
Message-Id: <20170203154757.36140-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 08/18] hbitmap: add next_zero function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

The function searches for next zero bit.
Also add interface for BdrvDirtyBitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c         |  5 +++++
 include/block/dirty-bitmap.h |  2 ++
 include/qemu/hbitmap.h       |  8 ++++++++
 util/hbitmap.c               | 26 ++++++++++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 519737c8d3..d2f23a00d9 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -533,3 +533,8 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
 {
     return hbitmap_count(bitmap->meta);
 }
+
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start)
+{
+    return hbitmap_next_zero(bitmap->bitmap, start);
+}
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 9dea14ba03..8826b74b37 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -72,4 +72,6 @@ void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
                                           bool finish);
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
+
 #endif
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index eb464759d5..d6fe553b12 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -257,6 +257,14 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first);
  */
 unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
 
+/* hbitmap_next_zero:
+ * @hb: The HBitmap to operate on
+ * @start: The bit to start from.
+ *
+ * Find next not dirty bit.
+ */
+int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start);
+
 /* hbitmap_create_meta:
  * Create a "meta" hbitmap to track dirtiness of the bits in this HBitmap.
  * The caller owns the created bitmap and must call hbitmap_free_meta(hb) to
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 9f691b76bd..b850c2baf5 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -166,6 +166,32 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
     }
 }
 
+int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start)
+{
+    size_t pos = (start >> hb->granularity) >> BITS_PER_LEVEL;
+    unsigned long *last_lev = hb->levels[HBITMAP_LEVELS - 1];
+    uint64_t sz = hb->sizes[HBITMAP_LEVELS - 1];
+    unsigned long cur = last_lev[pos];
+    unsigned start_bit_offset =
+            (start >> hb->granularity) & (BITS_PER_LONG - 1);
+    cur |= (1UL << start_bit_offset) - 1;
+
+    if (cur == (unsigned long)-1) {
+        do {
+            pos++;
+        } while (pos < sz && last_lev[pos] == (unsigned long)-1);
+
+        if (pos >= sz) {
+            return -1;
+        }
+
+        cur = last_lev[pos];
+    }
+
+    return MIN((pos << BITS_PER_LEVEL) + ctol(cur), hb->size - 1)
+            << hb->granularity;
+}
+
 bool hbitmap_empty(const HBitmap *hb)
 {
     return hb->count == 0;
-- 
2.11.0
