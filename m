Received: from eggs.gnu.org ([2001:4830:134:3::10]:56923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAMM-0003Rn-Gj
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAML-00069l-A0
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:19:06 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Jun 2018 20:18:17 +0200
Message-Id: <20180613181823.13618-9-mreitz@redhat.com>
In-Reply-To: <20180613181823.13618-1-mreitz@redhat.com>
References: <20180613181823.13618-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 08/14] test-hbitmap: Add non-advancing
 iter_next tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

Add a function that wraps hbitmap_iter_next() and always calls it in
non-advancing mode first, and in advancing mode next.  The result should
always be the same.

By using this function everywhere we called hbitmap_iter_next() before,
we should get good test coverage for non-advancing hbitmap_iter_next().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/test-hbitmap.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index f2158f767d..5e67ac1d3a 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -30,6 +30,18 @@ typedef struct TestHBitmapData {
 } TestHBitmapData;
 
 
+static int64_t check_hbitmap_iter_next(HBitmapIter *hbi)
+{
+    int next0, next1;
+
+    next0 = hbitmap_iter_next(hbi, false);
+    next1 = hbitmap_iter_next(hbi, true);
+
+    g_assert_cmpint(next0, ==, next1);
+
+    return next0;
+}
+
 /* Check that the HBitmap and the shadow bitmap contain the same data,
  * ignoring the same "first" bits.
  */
@@ -46,7 +58,7 @@ static void hbitmap_test_check(TestHBitmapData *data,
 
     i = first;
     for (;;) {
-        next = hbitmap_iter_next(&hbi, true);
+        next = check_hbitmap_iter_next(&hbi);
         if (next < 0) {
             next = data->size;
         }
@@ -435,25 +447,25 @@ static void test_hbitmap_iter_granularity(TestHBitmapData *data,
     /* Note that hbitmap_test_check has to be invoked manually in this test.  */
     hbitmap_test_init(data, 131072 << 7, 7);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
+    g_assert_cmpint(check_hbitmap_iter_next(&hbi), <, 0);
 
     hbitmap_test_set(data, ((L2 + L1 + 1) << 7) + 8, 8);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
+    g_assert_cmpint(check_hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
+    g_assert_cmpint(check_hbitmap_iter_next(&hbi), <, 0);
 
     hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
     g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
 
     hbitmap_test_set(data, (131072 << 7) - 8, 8);
     hbitmap_iter_init(&hbi, data->hb, 0);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
+    g_assert_cmpint(check_hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
+    g_assert_cmpint(check_hbitmap_iter_next(&hbi), ==, 131071 << 7);
+    g_assert_cmpint(check_hbitmap_iter_next(&hbi), <, 0);
 
     hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
-    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
+    g_assert_cmpint(check_hbitmap_iter_next(&hbi), ==, 131071 << 7);
+    g_assert_cmpint(check_hbitmap_iter_next(&hbi), <, 0);
 }
 
 static void hbitmap_test_set_boundary_bits(TestHBitmapData *data, ssize_t diff)
@@ -893,7 +905,7 @@ static void test_hbitmap_serialize_zeroes(TestHBitmapData *data,
     for (i = 0; i < num_positions; i++) {
         hbitmap_deserialize_zeroes(data->hb, positions[i], min_l1, true);
         hbitmap_iter_init(&iter, data->hb, 0);
-        next = hbitmap_iter_next(&iter, true);
+        next = check_hbitmap_iter_next(&iter);
         if (i == num_positions - 1) {
             g_assert_cmpint(next, ==, -1);
         } else {
@@ -919,10 +931,10 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
 
     hbitmap_iter_init(&hbi, data->hb, BITS_PER_LONG - 1);
 
-    hbitmap_iter_next(&hbi, true);
+    check_hbitmap_iter_next(&hbi);
 
     hbitmap_reset_all(data->hb);
-    hbitmap_iter_next(&hbi, true);
+    check_hbitmap_iter_next(&hbi);
 }
 
 static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
-- 
2.17.1
