Received: from eggs.gnu.org ([2001:4830:134:3::10]:59681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eH-0001nK-Vl
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eG-0003IC-H2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:33 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 18 Dec 2017 16:08:10 -0500
Message-Id: <20171218210819.31576-2-jcody@redhat.com>
In-Reply-To: <20171218210819.31576-1-jcody@redhat.com>
References: <20171218210819.31576-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] hbitmap: add next_zero function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The function searches for next zero bit.
Also add interface for BdrvDirtyBitmap and unit test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20171012135313.227864-2-vsementsov@virtuozzo.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/dirty-bitmap.c         |  5 ++++
 include/block/dirty-bitmap.h |  1 +
 include/qemu/hbitmap.h       |  8 ++++++
 tests/test-hbitmap.c         | 61 ++++++++++++++++++++++++++++++++++++++++++++
 util/hbitmap.c               | 39 ++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index bd04e99..7879d13 100644
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
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 3579a75..a591c27 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -91,5 +91,6 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
+int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
 
 #endif
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 81e7804..6b6490e 100644
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
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index af41642..9091c63 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -925,6 +925,61 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
     hbitmap_iter_next(&hbi);
 }
 
+static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
+{
+    int64_t ret1 = hbitmap_next_zero(data->hb, start);
+    int64_t ret2 = start;
+    for ( ; ret2 < data->size && hbitmap_get(data->hb, ret2); ret2++) {
+        ;
+    }
+    if (ret2 == data->size) {
+        ret2 = -1;
+    }
+
+    g_assert_cmpint(ret1, ==, ret2);
+}
+
+static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
+{
+    hbitmap_test_init(data, L3, granularity);
+    test_hbitmap_next_zero_check(data, 0);
+    test_hbitmap_next_zero_check(data, L3 - 1);
+
+    hbitmap_set(data->hb, L2, 1);
+    test_hbitmap_next_zero_check(data, 0);
+    test_hbitmap_next_zero_check(data, L2 - 1);
+    test_hbitmap_next_zero_check(data, L2);
+    test_hbitmap_next_zero_check(data, L2 + 1);
+
+    hbitmap_set(data->hb, L2 + 5, L1);
+    test_hbitmap_next_zero_check(data, 0);
+    test_hbitmap_next_zero_check(data, L2 + 1);
+    test_hbitmap_next_zero_check(data, L2 + 2);
+    test_hbitmap_next_zero_check(data, L2 + 5);
+    test_hbitmap_next_zero_check(data, L2 + L1 - 1);
+    test_hbitmap_next_zero_check(data, L2 + L1);
+
+    hbitmap_set(data->hb, L2 * 2, L3 - L2 * 2);
+    test_hbitmap_next_zero_check(data, L2 * 2 - L1);
+    test_hbitmap_next_zero_check(data, L2 * 2 - 2);
+    test_hbitmap_next_zero_check(data, L2 * 2 - 1);
+    test_hbitmap_next_zero_check(data, L2 * 2);
+    test_hbitmap_next_zero_check(data, L3 - 1);
+
+    hbitmap_set(data->hb, 0, L3);
+    test_hbitmap_next_zero_check(data, 0);
+}
+
+static void test_hbitmap_next_zero_0(TestHBitmapData *data, const void *unused)
+{
+    test_hbitmap_next_zero_do(data, 0);
+}
+
+static void test_hbitmap_next_zero_4(TestHBitmapData *data, const void *unused)
+{
+    test_hbitmap_next_zero_do(data, 4);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -985,6 +1040,12 @@ int main(int argc, char **argv)
 
     hbitmap_test_add("/hbitmap/iter/iter_and_reset",
                      test_hbitmap_iter_and_reset);
+
+    hbitmap_test_add("/hbitmap/next_zero/next_zero_0",
+                     test_hbitmap_next_zero_0);
+    hbitmap_test_add("/hbitmap/next_zero/next_zero_4",
+                     test_hbitmap_next_zero_4);
+
     g_test_run();
 
     return 0;
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 2f9d0fd..289778a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -188,6 +188,45 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
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
+
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
+    if (res >= hb->size) {
+        return -1;
+    }
+
+    res = res << hb->granularity;
+    if (res < start) {
+        assert(((start - res) >> hb->granularity) == 0);
+        return start;
+    }
+
+    return res;
+}
+
 bool hbitmap_empty(const HBitmap *hb)
 {
     return hb->count == 0;
-- 
2.9.5
