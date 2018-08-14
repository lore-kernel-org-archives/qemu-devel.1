Received: from eggs.gnu.org ([2001:4830:134:3::10]:37592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYDs-0002eF-V8
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYDn-00052K-RF
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:14:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Aug 2018 15:14:39 +0300
Message-Id: <20180814121443.33114-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180814121443.33114-1-vsementsov@virtuozzo.com>
References: <20180814121443.33114-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 4/8] tests: add tests for
 hbitmap_next_dirty_area
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
 tests/test-hbitmap.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index dddb67c3c5..af5142b481 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -1016,6 +1016,105 @@ static void test_hbitmap_next_zero_4(TestHBitmapData *data, const void *unused)
     test_hbitmap_next_zero_do(data, 4);
 }
 
+static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
+                                               uint64_t offset,
+                                               uint64_t count)
+{
+    uint64_t off1, off2;
+    uint64_t len1 = 0, len2 = 0;
+    bool ret1, ret2;
+    int64_t end;
+
+    off1 = offset;
+    end = count ? offset + count : 0;
+    ret1 = hbitmap_next_dirty_area(data->hb, &off1, end, &len1);
+
+    end = count ? offset + count : data->size;
+
+    for (off2 = offset; off2 < end && !hbitmap_get(data->hb, off2); off2++) {
+        ;
+    }
+
+    for (len2 = 1; off2 + len2 < end && hbitmap_get(data->hb, off2 + len2);
+         len2++)
+    {
+    }
+
+    ret2 = off2 < end;
+    if (!ret2) {
+        /* leave unchanged */
+        off2 = offset;
+        len2 = 0;
+    }
+
+    g_assert_cmpint(ret1, ==, ret2);
+    g_assert_cmpint(off1, ==, off2);
+    g_assert_cmpint(len1, ==, len2);
+}
+
+static void test_hbitmap_next_dirty_area_do(TestHBitmapData *data,
+                                            int granularity)
+{
+    hbitmap_test_init(data, L3, granularity);
+    test_hbitmap_next_dirty_area_check(data, 0, 0);
+    test_hbitmap_next_dirty_area_check(data, 0, 1);
+    test_hbitmap_next_dirty_area_check(data, L3 - 1, 1);
+
+    hbitmap_set(data->hb, L2, 1);
+    test_hbitmap_next_dirty_area_check(data, 0, 1);
+    test_hbitmap_next_dirty_area_check(data, 0, L2);
+    test_hbitmap_next_dirty_area_check(data, 0, 0);
+    test_hbitmap_next_dirty_area_check(data, L2 - 1, 0);
+    test_hbitmap_next_dirty_area_check(data, L2 - 1, 1);
+    test_hbitmap_next_dirty_area_check(data, L2 - 1, 2);
+    test_hbitmap_next_dirty_area_check(data, L2 - 1, 3);
+    test_hbitmap_next_dirty_area_check(data, L2, 0);
+    test_hbitmap_next_dirty_area_check(data, L2, 1);
+    test_hbitmap_next_dirty_area_check(data, L2 + 1, 1);
+
+    hbitmap_set(data->hb, L2 + 5, L1);
+    test_hbitmap_next_dirty_area_check(data, 0, 0);
+    test_hbitmap_next_dirty_area_check(data, L2 - 2, 8);
+    test_hbitmap_next_dirty_area_check(data, L2 + 1, 5);
+    test_hbitmap_next_dirty_area_check(data, L2 + 1, 3);
+    test_hbitmap_next_dirty_area_check(data, L2 + 4, L1);
+    test_hbitmap_next_dirty_area_check(data, L2 + 5, L1);
+    test_hbitmap_next_dirty_area_check(data, L2 + 7, L1);
+    test_hbitmap_next_dirty_area_check(data, L2 + L1, L1);
+    test_hbitmap_next_dirty_area_check(data, L2, 0);
+    test_hbitmap_next_dirty_area_check(data, L2 + 1, 0);
+
+    hbitmap_set(data->hb, L2 * 2, L3 - L2 * 2);
+    test_hbitmap_next_dirty_area_check(data, 0, 0);
+    test_hbitmap_next_dirty_area_check(data, L2, 0);
+    test_hbitmap_next_dirty_area_check(data, L2 + 1, 0);
+    test_hbitmap_next_dirty_area_check(data, L2 + 5 + L1 - 1, 0);
+    test_hbitmap_next_dirty_area_check(data, L2 + 5 + L1, 5);
+    test_hbitmap_next_dirty_area_check(data, L2 * 2 - L1, L1 + 1);
+    test_hbitmap_next_dirty_area_check(data, L2 * 2, L2);
+
+    hbitmap_set(data->hb, 0, L3);
+    test_hbitmap_next_dirty_area_check(data, 0, 0);
+}
+
+static void test_hbitmap_next_dirty_area_0(TestHBitmapData *data,
+                                           const void *unused)
+{
+    test_hbitmap_next_dirty_area_do(data, 0);
+}
+
+static void test_hbitmap_next_dirty_area_1(TestHBitmapData *data,
+                                           const void *unused)
+{
+    test_hbitmap_next_dirty_area_do(data, 1);
+}
+
+static void test_hbitmap_next_dirty_area_4(TestHBitmapData *data,
+                                           const void *unused)
+{
+    test_hbitmap_next_dirty_area_do(data, 4);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -1082,6 +1181,13 @@ int main(int argc, char **argv)
     hbitmap_test_add("/hbitmap/next_zero/next_zero_4",
                      test_hbitmap_next_zero_4);
 
+    hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_0",
+                     test_hbitmap_next_dirty_area_0);
+    hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_1",
+                     test_hbitmap_next_dirty_area_1);
+    hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_4",
+                     test_hbitmap_next_dirty_area_4);
+
     g_test_run();
 
     return 0;
-- 
2.11.1
