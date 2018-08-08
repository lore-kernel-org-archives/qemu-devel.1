Received: from eggs.gnu.org ([2001:4830:134:3::10]:38592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fnNuC-0004fb-IH
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fnNuB-0004IT-0K
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:49:36 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  8 Aug 2018 15:49:25 +0300
Message-Id: <20180808124925.21031-8-vsementsov@virtuozzo.com>
In-Reply-To: <20180808124925.21031-1-vsementsov@virtuozzo.com>
References: <20180808124925.21031-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 7/7] Revert "hbitmap: Add @advance param to
 hbitmap_iter_next()"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

This reverts commit a33fbb4f8b64226becf502a123733776ce319b24.

The functionality is unused.

Note: in addition to automatic revert, drop second parameter in
hbitmap_iter_next() call from hbitmap_next_dirty_area() too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/hbitmap.h |  5 +----
 block/backup.c         |  2 +-
 block/dirty-bitmap.c   |  2 +-
 tests/test-hbitmap.c   | 26 +++++++++++++-------------
 util/hbitmap.c         | 12 ++++--------
 5 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index b1e897af28..958a6ebf03 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -345,14 +345,11 @@ void hbitmap_free_meta(HBitmap *hb);
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
diff --git a/block/backup.c b/block/backup.c
index 3c8b054587..5ee80e58a3 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -421,7 +421,7 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     HBitmapIter hbi;
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((cluster = hbitmap_iter_next(&hbi, true)) != -1) {
+    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
         do {
             if (yield_and_check(job)) {
                 return 0;
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 35987e66a8..c9a7887885 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -525,7 +525,7 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)
 
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 {
-    return hbitmap_iter_next(&iter->hbi, true);
+    return hbitmap_iter_next(&iter->hbi);
 }
 
 /* Called within bdrv_dirty_bitmap_lock..unlock */
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 957caa27ae..44a79d696d 100644
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
index 9de0d7bf2d..5c2c4deef1 100644
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
@@ -256,7 +252,7 @@ bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *offset,
     }
 
     hbitmap_iter_init(&hbi, hb, *offset << hb->granularity);
-    off1 = hbitmap_iter_next(&hbi, true);
+    off1 = hbitmap_iter_next(&hbi);
 
     if (off1 < 0 || off1 >= end) {
         return false;
-- 
2.11.1
