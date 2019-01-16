Received: from eggs.gnu.org ([209.51.188.92]:57876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaJ-0002nA-2A
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZa8-0004Y5-Hf
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjZa4-0004Ra-42
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:20 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jan 2019 20:01:02 -0500
Message-Id: <20190116010106.27626-5-jsnow@redhat.com>
In-Reply-To: <20190116010106.27626-1-jsnow@redhat.com>
References: <20190116010106.27626-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] tests: add tests for hbitmap_next_dirty_area
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
 tests/test-hbitmap.c | 107 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index c0da31a6bd..4f312e9da3 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -1016,6 +1016,106 @@ static void test_hbitmap_next_zero_4(TestHBitmapData *data, const void *unused)
     test_hbitmap_next_zero_do(data, 4);
 }
 
+static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
+                                               uint64_t offset,
+                                               uint64_t count)
+{
+    uint64_t off1, off2;
+    uint64_t len1 = 0, len2;
+    bool ret1, ret2;
+    int64_t end;
+
+    off1 = offset;
+    len1 = count;
+    ret1 = hbitmap_next_dirty_area(data->hb, &off1, &len1);
+
+    end = offset > data->size || data->size - offset < count ? data->size :
+                                                               offset + count;
+
+    for (off2 = offset; off2 < end && !hbitmap_get(data->hb, off2); off2++) {
+        ;
+    }
+
+    for (len2 = 1; off2 + len2 < end && hbitmap_get(data->hb, off2 + len2);
+         len2++) {
+        ;
+    }
+
+    ret2 = off2 < end;
+    if (!ret2) {
+        /* leave unchanged */
+        off2 = offset;
+        len2 = count;
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
+    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, 0, 1);
+    test_hbitmap_next_dirty_area_check(data, L3 - 1, 1);
+
+    hbitmap_set(data->hb, L2, 1);
+    test_hbitmap_next_dirty_area_check(data, 0, 1);
+    test_hbitmap_next_dirty_area_check(data, 0, L2);
+    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2 - 1, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2 - 1, 1);
+    test_hbitmap_next_dirty_area_check(data, L2 - 1, 2);
+    test_hbitmap_next_dirty_area_check(data, L2 - 1, 3);
+    test_hbitmap_next_dirty_area_check(data, L2, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2, 1);
+    test_hbitmap_next_dirty_area_check(data, L2 + 1, 1);
+
+    hbitmap_set(data->hb, L2 + 5, L1);
+    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
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
+    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2 + 1, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2 + 5 + L1 - 1, UINT64_MAX);
+    test_hbitmap_next_dirty_area_check(data, L2 + 5 + L1, 5);
+    test_hbitmap_next_dirty_area_check(data, L2 * 2 - L1, L1 + 1);
+    test_hbitmap_next_dirty_area_check(data, L2 * 2, L2);
+
+    hbitmap_set(data->hb, 0, L3);
+    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
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
@@ -1082,6 +1182,13 @@ int main(int argc, char **argv)
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
2.17.2
