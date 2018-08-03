Received: from eggs.gnu.org ([2001:4830:134:3::10]:43735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fleAJ-00007J-Cz
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fleAE-0008Pz-GH
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:47:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Aug 2018 20:46:53 +0300
Message-Id: <20180803174654.278336-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180803174654.278336-1-vsementsov@virtuozzo.com>
References: <20180803174654.278336-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/6] Revert "test-hbitmap: Add non-advancing
 iter_next tests"
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

This reverts commit 269576848ec3d57d2d958cf5ac69b08c44adf816.

The functionality is unused. Drop tests.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/test-hbitmap.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 5e67ac1d3a..f2158f767d 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -30,18 +30,6 @@ typedef struct TestHBitmapData {
 } TestHBitmapData;
 
 
-static int64_t check_hbitmap_iter_next(HBitmapIter *hbi)
-{
-    int next0, next1;
-
-    next0 = hbitmap_iter_next(hbi, false);
-    next1 = hbitmap_iter_next(hbi, true);
-
-    g_assert_cmpint(next0, ==, next1);
-
-    return next0;
-}
-
 /* Check that the HBitmap and the shadow bitmap contain the same data,
  * ignoring the same "first" bits.
  */
@@ -58,7 +46,7 @@ static void hbitmap_test_check(TestHBitmapData *data,
 
     i = first;
     for (;;) {
-        next = check_hbitmap_iter_next(&hbi);
+        next = hbitmap_iter_next(&hbi, true);
         if (next < 0) {
             next = data->size;
         }
@@ -447,25 +435,25 @@ static void test_hbitmap_iter_granularity(TestHBitmapData *data,
     /* Note that hbitmap_test_check has to be invoked manually in this test.  */
     hbitmap_test_init(data, 131072 << 7, 7);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(check_hbitmap_iter_next(&hbi), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 
     hbitmap_test_set(data, ((L2 + L1 + 1) << 7) + 8, 8);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(check_hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
-    g_assert_cmpint(check_hbitmap_iter_next(&hbi), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 
     hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
     g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 
     hbitmap_test_set(data, (131072 << 7) - 8, 8);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(check_hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
-    g_assert_cmpint(check_hbitmap_iter_next(&hbi), ==, 131071 << 7);
-    g_assert_cmpint(check_hbitmap_iter_next(&hbi), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 
     hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
-    g_assert_cmpint(check_hbitmap_iter_next(&hbi), ==, 131071 << 7);
-    g_assert_cmpint(check_hbitmap_iter_next(&hbi), <, 0);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
+    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 }
 
 static void hbitmap_test_set_boundary_bits(TestHBitmapData *data, ssize_t diff)
@@ -905,7 +893,7 @@ static void test_hbitmap_serialize_zeroes(TestHBitmapData *data,
     for (i = 0; i < num_positions; i++) {
         hbitmap_deserialize_zeroes(data->hb, positions[i], min_l1, true);
         hbitmap_iter_init(&iter, data->hb, 0);
-        next = check_hbitmap_iter_next(&iter);
+        next = hbitmap_iter_next(&iter, true);
         if (i == num_positions - 1) {
             g_assert_cmpint(next, ==, -1);
         } else {
@@ -931,10 +919,10 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
 
     hbitmap_iter_init(&hbi, data->hb, BITS_PER_LONG - 1);
 
-    check_hbitmap_iter_next(&hbi);
+    hbitmap_iter_next(&hbi, true);
 
     hbitmap_reset_all(data->hb);
-    check_hbitmap_iter_next(&hbi);
+    hbitmap_iter_next(&hbi, true);
 }
 
 static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
-- 
2.11.1
