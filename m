Received: from eggs.gnu.org ([209.51.188.92]:57946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaS-0002un-33
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaJ-0004cC-2W
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjZa8-0004SR-RL
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:27 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jan 2019 20:01:06 -0500
Message-Id: <20190116010106.27626-9-jsnow@redhat.com>
In-Reply-To: <20190116010106.27626-1-jsnow@redhat.com>
References: <20190116010106.27626-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] Revert "hbitmap: Add @advance param to
 hbitmap_iter_next()"
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

This reverts commit a33fbb4f8b64226becf502a123733776ce319b24.

The functionality is unused.

Note: in addition to automatic revert, drop second parameter in
hbitmap_iter_next() call from hbitmap_next_dirty_area() too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c         |  2 +-
 block/dirty-bitmap.c   |  2 +-
 include/qemu/hbitmap.h |  5 +----
 tests/test-hbitmap.c   | 26 +++++++++++++-------------
 util/hbitmap.c         | 12 ++++--------
 5 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9ffce5c183..435414e964 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -385,7 +385,7 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     HBitmapIter hbi;
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((cluster = hbitmap_iter_next(&hbi, true)) != -1) {
+    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
         do {
             if (yield_and_check(job)) {
                 return 0;
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 4d9a8af17d..00ea36f554 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -515,7 +515,7 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)
 
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 {
-    return hbitmap_iter_next(&iter->hbi, true);
+    return hbitmap_iter_next(&iter->hbi);
 }
 
 /* Called within bdrv_dirty_bitmap_lock..unlock */
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 097dce31ee..4afbe6292e 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -351,14 +351,11 @@ void hbitmap_free_meta(HBitmap *hb);
 /**
  * hbitmap_iter_next:
  * @hbi: HBitmapIter to operate on.
- * @advance: If true, advance the iterator.  Otherwise, the next call
- *           of this function will return the same result (if that
- *           position is still dirty).
  *
  * Return the next bit that is set in @hbi's associated HBitmap,
  * or -1 if all remaining bits are zero.
  */
-int64_t hbitmap_iter_next(HBitmapIter *hbi, bool advance);
+int64_t hbitmap_iter_next(HBitmapIter *hbi);
 
 /**
  * hbitmap_iter_next_word:
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 6358f35359..592d8219db 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -46,7 +46,7 @@ static void hbitmap_test_check(TestHBitmapData *data,
 
     i = first;
     for (;;) {
-        next = hbitmap_iter_next(&hbi, true);
+        next = hbitmap_iter_next(&hbi);
         if (next < 0) {
             next = data->size;
         }
@@ -435,25 +435,25 @@ static void test_hbitmap_iter_granularity(TestHBitmapData *data,
     /* Note that hbitmap_test_check has to be invoked manually in this test.  */
     hbitmap_test_init(data, 131072 << 7, 7);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
 
     hbitmap_test_set(data, ((L2 + L1 + 1) << 7) + 8, 8);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
 
     hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
 
     hbitmap_test_set(data, (131072 << 7) - 8, 8);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, 131071 << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
 
     hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, 131071 << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
 }
 
 static void hbitmap_test_set_boundary_bits(TestHBitmapData *data, ssize_t diff)
@@ -893,7 +893,7 @@ static void test_hbitmap_serialize_zeroes(TestHBitmapData *data,
     for (i = 0; i < num_positions; i++) {
         hbitmap_deserialize_zeroes(data->hb, positions[i], min_l1, true);
         hbitmap_iter_init(&iter, data->hb, 0);
-        next = hbitmap_iter_next(&iter, true);
+        next = hbitmap_iter_next(&iter);
         if (i == num_positions - 1) {
             g_assert_cmpint(next, ==, -1);
         } else {
@@ -919,10 +919,10 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
 
     hbitmap_iter_init(&hbi, data->hb, BITS_PER_LONG - 1);
 
-    hbitmap_iter_next(&hbi, true);
+    hbitmap_iter_next(&hbi);
 
     hbitmap_reset_all(data->hb);
-    hbitmap_iter_next(&hbi, true);
+    hbitmap_iter_next(&hbi);
 }
 
 static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
diff --git a/util/hbitmap.c b/util/hbitmap.c
index fa356522c4..7905212a8b 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -144,7 +144,7 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi)
     return cur;
 }
 
-int64_t hbitmap_iter_next(HBitmapIter *hbi, bool advance)
+int64_t hbitmap_iter_next(HBitmapIter *hbi)
 {
     unsigned long cur = hbi->cur[HBITMAP_LEVELS - 1] &
             hbi->hb->levels[HBITMAP_LEVELS - 1][hbi->pos];
@@ -157,12 +157,8 @@ int64_t hbitmap_iter_next(HBitmapIter *hbi, bool advance)
         }
     }
 
-    if (advance) {
-        /* The next call will resume work from the next bit.  */
-        hbi->cur[HBITMAP_LEVELS - 1] = cur & (cur - 1);
-    } else {
-        hbi->cur[HBITMAP_LEVELS - 1] = cur;
-    }
+    /* The next call will resume work from the next bit.  */
+    hbi->cur[HBITMAP_LEVELS - 1] = cur & (cur - 1);
     item = ((uint64_t)hbi->pos << BITS_PER_LEVEL) + ctzl(cur);
 
     return item << hbi->granularity;
@@ -261,7 +257,7 @@ bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *start,
     end = *count > hb->orig_size - *start ? hb->orig_size : *start + *count;
 
     hbitmap_iter_init(&hbi, hb, *start);
-    firt_dirty_off = hbitmap_iter_next(&hbi, false);
+    firt_dirty_off = hbitmap_iter_next(&hbi);
 
     if (firt_dirty_off < 0 || firt_dirty_off >= end) {
         return false;
-- 
2.17.2
