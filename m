Received: from eggs.gnu.org ([2001:4830:134:3::10]:38501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fnNu9-0004dC-MU
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fnNu6-0004DV-EO
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:49:33 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  8 Aug 2018 15:49:20 +0300
Message-Id: <20180808124925.21031-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180808124925.21031-1-vsementsov@virtuozzo.com>
References: <20180808124925.21031-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/7] tests: add tests for hbitmap_next_zero
 with non-zero count parameter
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/test-hbitmap.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 888515b3bb..c11d160633 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -937,31 +937,48 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
     check_hbitmap_iter_next(&hbi);
 }
 
-static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
+static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
+                                               int64_t start,
+                                               int64_t count)
 {
-    int64_t ret1 = hbitmap_next_zero(data->hb, start, 0);
+    int64_t ret1 = hbitmap_next_zero(data->hb, start, count);
     int64_t ret2 = start;
-    for ( ; ret2 < data->size && hbitmap_get(data->hb, ret2); ret2++) {
+    int64_t end = count ? start + count : data->size;
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
+    test_hbitmap_next_zero_check_range(data, start, 0);
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
@@ -970,6 +987,10 @@ static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
     test_hbitmap_next_zero_check(data, L2 + 5);
     test_hbitmap_next_zero_check(data, L2 + L1 - 1);
     test_hbitmap_next_zero_check(data, L2 + L1);
+    test_hbitmap_next_zero_check_range(data, L2, 6);
+    test_hbitmap_next_zero_check_range(data, L2 + 1, 3);
+    test_hbitmap_next_zero_check_range(data, L2 + 4, L1);
+    test_hbitmap_next_zero_check_range(data, L2 + 5, L1);
 
     hbitmap_set(data->hb, L2 * 2, L3 - L2 * 2);
     test_hbitmap_next_zero_check(data, L2 * 2 - L1);
@@ -977,6 +998,8 @@ static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
     test_hbitmap_next_zero_check(data, L2 * 2 - 1);
     test_hbitmap_next_zero_check(data, L2 * 2);
     test_hbitmap_next_zero_check(data, L3 - 1);
+    test_hbitmap_next_zero_check_range(data, L2 * 2 - L1, L1 + 1);
+    test_hbitmap_next_zero_check_range(data, L2 * 2, L2);
 
     hbitmap_set(data->hb, 0, L3);
     test_hbitmap_next_zero_check(data, 0);
-- 
2.11.1
