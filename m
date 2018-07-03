Received: from eggs.gnu.org ([2001:4830:134:3::10]:37831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faPS9-00055w-5y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faPS8-00034L-9z
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:51:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Jul 2018 19:50:49 +0200
Message-Id: <20180703175049.27669-3-kwolf@redhat.com>
In-Reply-To: <20180703175049.27669-1-kwolf@redhat.com>
References: <20180703175049.27669-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] test-bdrv-drain: Test bdrv_append() to
 drained node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 291a050f86..17bb8508ae 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1250,6 +1250,47 @@ static void test_detach_by_driver_cb(void)
     test_detach_indirect(false);
 }
 
+static void test_append_to_drained(void)
+{
+    BlockBackend *blk;
+    BlockDriverState *base, *overlay;
+    BDRVTestState *base_s, *overlay_s;
+
+    blk = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    base = bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_abort);
+    base_s = base->opaque;
+    blk_insert_bs(blk, base, &error_abort);
+
+    overlay = bdrv_new_open_driver(&bdrv_test, "overlay", BDRV_O_RDWR,
+                                   &error_abort);
+    overlay_s = overlay->opaque;
+
+    do_drain_begin(BDRV_DRAIN, base);
+    g_assert_cmpint(base->quiesce_counter, ==, 1);
+    g_assert_cmpint(base_s->drain_count, ==, 1);
+    g_assert_cmpint(base->in_flight, ==, 0);
+
+    /* Takes ownership of overlay, so we don't have to unref it later */
+    bdrv_append(overlay, base, &error_abort);
+    g_assert_cmpint(base->in_flight, ==, 0);
+    g_assert_cmpint(overlay->in_flight, ==, 0);
+
+    g_assert_cmpint(base->quiesce_counter, ==, 1);
+    g_assert_cmpint(base_s->drain_count, ==, 1);
+    g_assert_cmpint(overlay->quiesce_counter, ==, 1);
+    g_assert_cmpint(overlay_s->drain_count, ==, 1);
+
+    do_drain_end(BDRV_DRAIN, base);
+
+    g_assert_cmpint(base->quiesce_counter, ==, 0);
+    g_assert_cmpint(base_s->drain_count, ==, 0);
+    g_assert_cmpint(overlay->quiesce_counter, ==, 0);
+    g_assert_cmpint(overlay_s->drain_count, ==, 0);
+
+    bdrv_unref(base);
+    blk_unref(blk);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -1308,6 +1349,8 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/detach/parent_cb", test_detach_by_parent_cb);
     g_test_add_func("/bdrv-drain/detach/driver_cb", test_detach_by_driver_cb);
 
+    g_test_add_func("/bdrv-drain/attach/drain", test_append_to_drained);
+
     ret = g_test_run();
     qemu_event_destroy(&done_event);
     return ret;
-- 
2.13.6
