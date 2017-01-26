Received: from eggs.gnu.org ([2001:4830:134:3::10]:56350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWa6u-0001Bp-Pm
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 21:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWa6t-00073Q-SO
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 21:48:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWa6t-00073H-MI
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 21:48:27 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 26 Jan 2017 10:48:15 +0800
Message-Id: <20170126024815.22841-3-famz@redhat.com>
In-Reply-To: <20170126024815.22841-1-famz@redhat.com>
References: <20170126024815.22841-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] test-hbitmap: Add hbitmap_is_serializable()
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Max Reitz <mreitz@redhat.com>

Add calls to hbitmap_is_serializable() (asserting that it returns true)
where necessary (i.e. before every series of (de-)serialization function
invocations).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20161115225746.3590-3-mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/test-hbitmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 9b7495c..23773d2 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -744,6 +744,8 @@ static void test_hbitmap_serialize_granularity(TestHBitmapData *data,
     int r;
 
     hbitmap_test_init(data, L3 * 2, 3);
+    g_assert(hbitmap_is_serializable(data->hb));
+
     r = hbitmap_serialization_granularity(data->hb);
     g_assert_cmpint(r, ==, 64 << 3);
 }
@@ -768,6 +770,8 @@ static void hbitmap_test_serialize_range(TestHBitmapData *data,
     if (count) {
         hbitmap_set(data->hb, pos, count);
     }
+
+    g_assert(hbitmap_is_serializable(data->hb));
     hbitmap_serialize_part(data->hb, buf, 0, data->size);
 
     /* Serialized buffer is inherently LE, convert it back manually to test */
@@ -788,6 +792,8 @@ static void hbitmap_test_serialize_range(TestHBitmapData *data,
     memset(buf, 0, buf_size);
     hbitmap_serialize_part(data->hb, buf, 0, data->size);
     hbitmap_reset_all(data->hb);
+
+    g_assert(hbitmap_is_serializable(data->hb));
     hbitmap_deserialize_part(data->hb, buf, 0, data->size, true);
 
     for (i = 0; i < data->size; i++) {
@@ -810,6 +816,7 @@ static void test_hbitmap_serialize_basic(TestHBitmapData *data,
     int num_positions = sizeof(positions) / sizeof(positions[0]);
 
     hbitmap_test_init(data, L3, 0);
+    g_assert(hbitmap_is_serializable(data->hb));
     buf_size = hbitmap_serialization_size(data->hb, 0, data->size);
     buf = g_malloc0(buf_size);
 
@@ -841,6 +848,8 @@ static void test_hbitmap_serialize_part(TestHBitmapData *data,
         hbitmap_set(data->hb, positions[i], 1);
     }
 
+    g_assert(hbitmap_is_serializable(data->hb));
+
     for (i = 0; i < data->size; i += buf_size) {
         unsigned long *el = (unsigned long *)buf;
         hbitmap_serialize_part(data->hb, buf, i, buf_size);
@@ -879,6 +888,8 @@ static void test_hbitmap_serialize_zeroes(TestHBitmapData *data,
         hbitmap_set(data->hb, positions[i], L1);
     }
 
+    g_assert(hbitmap_is_serializable(data->hb));
+
     for (i = 0; i < num_positions; i++) {
         hbitmap_deserialize_zeroes(data->hb, positions[i], min_l1, true);
         hbitmap_iter_init(&iter, data->hb, 0);
-- 
2.9.3
