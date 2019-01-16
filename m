Received: from eggs.gnu.org ([209.51.188.92]:57920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaQ-0002t9-4T
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaF-0004al-9l
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjZa4-0004SD-Po
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:24 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jan 2019 20:01:05 -0500
Message-Id: <20190116010106.27626-8-jsnow@redhat.com>
In-Reply-To: <20190116010106.27626-1-jsnow@redhat.com>
References: <20190116010106.27626-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] Revert "test-hbitmap: Add non-advancing
 iter_next tests"
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

This reverts commit 269576848ec3d57d2d958cf5ac69b08c44adf816.

The functionality is unused. Drop tests.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/test-hbitmap.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 4f312e9da3..6358f35359 100644
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
 
 static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
-- 
2.17.2
