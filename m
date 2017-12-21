Received: from eggs.gnu.org ([2001:4830:134:3::10]:42184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1kr-0002l8-H8
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1kq-0001qy-L5
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:37 +0100
Message-Id: <20171221142251.18366-6-kwolf@redhat.com>
In-Reply-To: <20171221142251.18366-1-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/19] test-bdrv-drain: Test
 bs->quiesce_counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

This is currently only working correctly for bdrv_drain(), not for
bdrv_drain_all(). Leave a comment for the drain_all case, we'll address
it later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index c05203bba8..2aa2b9aa43 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -178,6 +178,48 @@ static void test_drv_cb_drain(void)
     test_drv_cb_common(BDRV_DRAIN, false);
 }
 
+static void test_quiesce_common(enum drain_type drain_type, bool recursive)
+{
+    BlockBackend *blk;
+    BlockDriverState *bs, *backing;
+
+    blk = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs = bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
+                              &error_abort);
+    blk_insert_bs(blk, bs, &error_abort);
+
+    backing = bdrv_new_open_driver(&bdrv_test, "backing", 0, &error_abort);
+    bdrv_set_backing_hd(bs, backing, &error_abort);
+
+    g_assert_cmpint(bs->quiesce_counter, ==, 0);
+    g_assert_cmpint(backing->quiesce_counter, ==, 0);
+
+    do_drain_begin(drain_type, bs);
+
+    g_assert_cmpint(bs->quiesce_counter, ==, 1);
+    g_assert_cmpint(backing->quiesce_counter, ==, !!recursive);
+
+    do_drain_end(drain_type, bs);
+
+    g_assert_cmpint(bs->quiesce_counter, ==, 0);
+    g_assert_cmpint(backing->quiesce_counter, ==, 0);
+
+    bdrv_unref(backing);
+    bdrv_unref(bs);
+    blk_unref(blk);
+}
+
+static void test_quiesce_drain_all(void)
+{
+    // XXX drain_all doesn't quiesce
+    //test_quiesce_common(BDRV_DRAIN_ALL, true);
+}
+
+static void test_quiesce_drain(void)
+{
+    test_quiesce_common(BDRV_DRAIN, false);
+}
+
 int main(int argc, char **argv)
 {
     bdrv_init();
@@ -188,5 +230,8 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/driver-cb/drain_all", test_drv_cb_drain_all);
     g_test_add_func("/bdrv-drain/driver-cb/drain", test_drv_cb_drain);
 
+    g_test_add_func("/bdrv-drain/quiesce/drain_all", test_quiesce_drain_all);
+    g_test_add_func("/bdrv-drain/quiesce/drain", test_quiesce_drain);
+
     return g_test_run();
 }
-- 
2.13.6
