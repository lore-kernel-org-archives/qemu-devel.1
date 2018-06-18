Received: from eggs.gnu.org ([2001:4830:134:3::10]:52326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHi-0005F2-2E
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHg-0006UF-O0
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:57 +0200
Message-Id: <20180618164504.24488-29-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/35] hbitmap: Add @advance param to
 hbitmap_iter_next()
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

This new parameter allows the caller to just query the next dirty
position without moving the iterator.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20180613181823.13618-8-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/hbitmap.h |  5 ++++-
 block/backup.c         |  2 +-
 block/dirty-bitmap.c   |  2 +-
 tests/test-hbitmap.c   | 26 +++++++++++++-------------
 util/hbitmap.c         | 10 +++++++---
 5 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 6b6490ecad..ddca52c48e 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -324,11 +324,14 @@ void hbitmap_free_meta(HBitmap *hb);
 /**
  * hbitmap_iter_next:
  * @hbi: HBitmapIter to operate on.
+ * @advance: If true, advance the iterator.  Otherwise, the next call
+ *           of this function will return the same result (if that
+ *           position is still dirty).
  *
  * Return the next bit that is set in @hbi's associated HBitmap,
  * or -1 if all remaining bits are zero.
  */
-int64_t hbitmap_iter_next(HBitmapIter *hbi);
+int64_t hbitmap_iter_next(HBitmapIter *hbi, bool advance);
 
 /**
  * hbitmap_iter_next_word:
diff --git a/block/backup.c b/block/backup.c
index 5661435675..d18be40caf 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -354,7 +354,7 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     HBitmapIter hbi;
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
+    while ((cluster = hbitmap_iter_next(&hbi, true)) != -1) {
         do {
             if (yield_and_check(job)) {
                 return 0;
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 383d742cdb..cedb971765 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -519,7 +519,7 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)
 
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 {
-    return hbitmap_iter_next(&iter->hbi);
+    return hbitmap_iter_next(&iter->hbi, true);
 }
 
 /* Called within bdrv_dirty_bitmap_lock..unlock */
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index f29631f939..f2158f767d 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -46,7 +46,7 @@ static void hbitmap_test_check(TestHBitmapData *data,
 
     i = first;
     for (;;) {
-        next = hbitmap_iter_next(&hbi);
+        next = hbitmap_iter_next(&hbi, true);
         if (next < 0) {
             next = data->size;
         }
@@ -435,25 +435,25 @@ static void test_hbitmap_iter_granularity(TestHBitmapData *data,
     /* Note that hbitmap_test_check has to be invoked manually in this test.  */
     hbitmap_test_init(data, 131072 << 7, 7);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 
     hbitmap_test_set(data, ((L2 + L1 + 1) << 7) + 8, 8);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 
     hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 
     hbitmap_test_set(data, (131072 << 7) - 8, 8);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, 131071 << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 
     hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, 131071 << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 }
 
 static void hbitmap_test_set_boundary_bits(TestHBitmapData *data, ssize_t diff)
@@ -893,7 +893,7 @@ static void test_hbitmap_serialize_zeroes(TestHBitmapData *data,
     for (i = 0; i < num_positions; i++) {
         hbitmap_deserialize_zeroes(data->hb, positions[i], min_l1, true);
         hbitmap_iter_init(&iter, data->hb, 0);
-        next = hbitmap_iter_next(&iter);
+        next = hbitmap_iter_next(&iter, true);
         if (i == num_positions - 1) {
             g_assert_cmpint(next, ==, -1);
         } else {
@@ -919,10 +919,10 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
 
     hbitmap_iter_init(&hbi, data->hb, BITS_PER_LONG - 1);
 
-    hbitmap_iter_next(&hbi);
+    hbitmap_iter_next(&hbi, true);
 
     hbitmap_reset_all(data->hb);
-    hbitmap_iter_next(&hbi);
+    hbitmap_iter_next(&hbi, true);
 }
 
 static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 58a2c93842..bcd304041a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -141,7 +141,7 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi)
     return cur;
 }
 
-int64_t hbitmap_iter_next(HBitmapIter *hbi)
+int64_t hbitmap_iter_next(HBitmapIter *hbi, bool advance)
 {
     unsigned long cur = hbi->cur[HBITMAP_LEVELS - 1] &
             hbi->hb->levels[HBITMAP_LEVELS - 1][hbi->pos];
@@ -154,8 +154,12 @@ int64_t hbitmap_iter_next(HBitmapIter *hbi)
         }
     }
 
-    /* The next call will resume work from the next bit.  */
-    hbi->cur[HBITMAP_LEVELS - 1] = cur & (cur - 1);
+    if (advance) {
+        /* The next call will resume work from the next bit.  */
+        hbi->cur[HBITMAP_LEVELS - 1] = cur & (cur - 1);
+    } else {
+        hbi->cur[HBITMAP_LEVELS - 1] = cur;
+    }
     item = ((uint64_t)hbi->pos << BITS_PER_LEVEL) + ctzl(cur);
 
     return item << hbi->granularity;
-- 
2.13.6
