Received: from eggs.gnu.org ([209.51.188.92]:57800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaC-0002j1-Br
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZa3-0004Vj-PE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjZa2-0004R2-BV
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:19 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jan 2019 20:01:00 -0500
Message-Id: <20190116010106.27626-3-jsnow@redhat.com>
In-Reply-To: <20190116010106.27626-1-jsnow@redhat.com>
References: <20190116010106.27626-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] tests: add tests for hbitmap_next_zero with
 specified end parameter
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/test-hbitmap.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index b04a45a2de..c0da31a6bd 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -937,31 +937,49 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
     check_hbitmap_iter_next(&hbi);
 }
 
-static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
+static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
+                                               uint64_t start,
+                                               uint64_t count)
 {
-    int64_t ret1 = hbitmap_next_zero(data->hb, start, UINT64_MAX);
+    int64_t ret1 = hbitmap_next_zero(data->hb, start, count);
     int64_t ret2 = start;
-    for ( ; ret2 < data->size && hbitmap_get(data->hb, ret2); ret2++) {
+    int64_t end = start >= data->size || data->size - start < count ?
+                data->size : start + count;
+
+    for ( ; ret2 < end && hbitmap_get(data->hb, ret2); ret2++) {
         ;
     }
-    if (ret2 == data->size) {
+    if (ret2 == end) {
         ret2 = -1;
     }
 
     g_assert_cmpint(ret1, ==, ret2);
 }
 
+static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
+{
+    test_hbitmap_next_zero_check_range(data, start, UINT64_MAX);
+}
+
 static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
 {
     hbitmap_test_init(data, L3, granularity);
     test_hbitmap_next_zero_check(data, 0);
     test_hbitmap_next_zero_check(data, L3 - 1);
+    test_hbitmap_next_zero_check_range(data, 0, 1);
+    test_hbitmap_next_zero_check_range(data, L3 - 1, 1);
 
     hbitmap_set(data->hb, L2, 1);
     test_hbitmap_next_zero_check(data, 0);
     test_hbitmap_next_zero_check(data, L2 - 1);
     test_hbitmap_next_zero_check(data, L2);
     test_hbitmap_next_zero_check(data, L2 + 1);
+    test_hbitmap_next_zero_check_range(data, 0, 1);
+    test_hbitmap_next_zero_check_range(data, 0, L2);
+    test_hbitmap_next_zero_check_range(data, L2 - 1, 1);
+    test_hbitmap_next_zero_check_range(data, L2 - 1, 2);
+    test_hbitmap_next_zero_check_range(data, L2, 1);
+    test_hbitmap_next_zero_check_range(data, L2 + 1, 1);
 
     hbitmap_set(data->hb, L2 + 5, L1);
     test_hbitmap_next_zero_check(data, 0);
@@ -970,6 +988,10 @@ static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
     test_hbitmap_next_zero_check(data, L2 + 5);
     test_hbitmap_next_zero_check(data, L2 + L1 - 1);
     test_hbitmap_next_zero_check(data, L2 + L1);
+    test_hbitmap_next_zero_check_range(data, L2, 6);
+    test_hbitmap_next_zero_check_range(data, L2 + 1, 3);
+    test_hbitmap_next_zero_check_range(data, L2 + 4, L1);
+    test_hbitmap_next_zero_check_range(data, L2 + 5, L1);
 
     hbitmap_set(data->hb, L2 * 2, L3 - L2 * 2);
     test_hbitmap_next_zero_check(data, L2 * 2 - L1);
@@ -977,6 +999,8 @@ static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
     test_hbitmap_next_zero_check(data, L2 * 2 - 1);
     test_hbitmap_next_zero_check(data, L2 * 2);
     test_hbitmap_next_zero_check(data, L3 - 1);
+    test_hbitmap_next_zero_check_range(data, L2 * 2 - L1, L1 + 1);
+    test_hbitmap_next_zero_check_range(data, L2 * 2, L2);
 
     hbitmap_set(data->hb, 0, L3);
     test_hbitmap_next_zero_check(data, 0);
-- 
2.17.2
