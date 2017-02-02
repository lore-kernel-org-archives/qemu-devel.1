Received: from eggs.gnu.org ([2001:4830:134:3::10]:46168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZHKk-0002cH-HK
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZHKj-0008Ho-95
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:21:54 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:11035 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZHKi-0008Fx-U4
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:21:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  2 Feb 2017 16:21:25 +0300
Message-Id: <20170202132145.168790-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170202132145.168790-1-vsementsov@virtuozzo.com>
References: <20170202132145.168790-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 04/24] tests: add hbitmap iter test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Test that hbitmap iter is resistant to bitmap resetting.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/test-hbitmap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 23773d2051..1acb353889 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -909,6 +909,22 @@ static void hbitmap_test_add(const char *testpath,
                hbitmap_test_teardown);
 }
 
+static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
+                                        const void *unused)
+{
+    HBitmapIter hbi;
+
+    hbitmap_test_init(data, L1 * 2, 0);
+    hbitmap_set(data->hb, 0, data->size);
+
+    hbitmap_iter_init(&hbi, data->hb, BITS_PER_LONG - 1);
+
+    hbitmap_iter_next(&hbi);
+
+    hbitmap_reset_all(data->hb);
+    hbitmap_iter_next(&hbi);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -966,6 +982,9 @@ int main(int argc, char **argv)
                      test_hbitmap_serialize_part);
     hbitmap_test_add("/hbitmap/serialize/zeroes",
                      test_hbitmap_serialize_zeroes);
+
+    hbitmap_test_add("/hbitmap/iter/iter_and_reset",
+                     test_hbitmap_iter_and_reset);
     g_test_run();
 
     return 0;
-- 
2.11.0
