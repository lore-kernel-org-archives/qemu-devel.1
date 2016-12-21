Received: from eggs.gnu.org ([2001:4830:134:3::10]:58688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJiIU-0003my-Aw
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJiIR-0006iH-5a
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:55:14 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:6067 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cJiIQ-0006YH-J0
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:55:10 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Dec 2016 17:54:42 +0300
Message-Id: <1482332102-131788-5-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482332102-131788-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482332102-131788-1-git-send-email-vsementsov@virtuozzo.com>
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
index 9b7495c..c76d2b5 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -898,6 +898,22 @@ static void hbitmap_test_add(const char *testpath,
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
@@ -955,6 +971,9 @@ int main(int argc, char **argv)
                      test_hbitmap_serialize_part);
     hbitmap_test_add("/hbitmap/serialize/zeroes",
                      test_hbitmap_serialize_zeroes);
+
+    hbitmap_test_add("/hbitmap/iter/iter_and_reset",
+                     test_hbitmap_iter_and_reset);
     g_test_run();
 
     return 0;
-- 
1.8.3.1
