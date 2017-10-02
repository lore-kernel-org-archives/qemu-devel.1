Received: from eggs.gnu.org ([2001:4830:134:3::10]:52143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sX-0001YG-Hw
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sT-00030e-JN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:29 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:5764 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dz1sT-0002ys-7C
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:25 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  2 Oct 2017 17:39:15 +0300
Message-Id: <20171002143919.207741-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171002143919.207741-1-vsementsov@virtuozzo.com>
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/5] hbitmap: add next_zero function
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
List-ID: <qemu-devel.nongnu.org>

The function searches for next zero bit.
Also add interface for BdrvDirtyBitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h |  1 +
 include/qemu/hbitmap.h       |  8 ++++++++
 block/dirty-bitmap.c         |  5 +++++
 util/hbitmap.c               | 29 +++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 3579a7597c..a591c27213 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -91,5 +91,6 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
 
 #endif
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 81e78043d1..6b6490ecad 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -292,6 +292,14 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first);
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
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index bd04e991b1..7879d13ddb 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -715,3 +715,8 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
 {
     return hbitmap_sha256(bitmap->bitmap, errp);
 }
+
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset)
+{
+    return hbitmap_next_zero(bitmap->bitmap, offset);
+}
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 2f9d0fdbd0..ffcdbc5587 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -188,6 +188,35 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
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
+    int64_t res;
+    cur |= (1UL << start_bit_offset) - 1;
+    assert((start >> hb->granularity) < hb->size);
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
+    res = (pos << BITS_PER_LEVEL) + ctol(cur);
+
+    return res < hb->size ? (res << hb->granularity) : -1;
+}
+
 bool hbitmap_empty(const HBitmap *hb)
 {
     return hb->count == 0;
-- 
2.11.1
