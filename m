Received: from eggs.gnu.org ([2001:4830:134:3::10]:42541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1lA-00033c-AR
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1l9-000259-9y
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:45 +0100
Message-Id: <20171221142251.18366-14-kwolf@redhat.com>
In-Reply-To: <20171221142251.18366-1-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/19] test-bdrv-drain: Tests for
 bdrv_subtree_drain
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

Add a subtree drain version to the existing test cases.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index ede5cf6e64..c00d96bb2f 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -85,6 +85,7 @@ static void aio_ret_cb(void *opaque, int ret)
 enum drain_type {
     BDRV_DRAIN_ALL,
     BDRV_DRAIN,
+    BDRV_SUBTREE_DRAIN,
     DRAIN_TYPE_MAX,
 };
 
@@ -93,6 +94,7 @@ static void do_drain_begin(enum drain_type drain_type, BlockDriverState *bs)
     switch (drain_type) {
     case BDRV_DRAIN_ALL:        bdrv_drain_all_begin(); break;
     case BDRV_DRAIN:            bdrv_drained_begin(bs); break;
+    case BDRV_SUBTREE_DRAIN:    bdrv_subtree_drained_begin(bs); break;
     default:                    g_assert_not_reached();
     }
 }
@@ -102,6 +104,7 @@ static void do_drain_end(enum drain_type drain_type, BlockDriverState *bs)
     switch (drain_type) {
     case BDRV_DRAIN_ALL:        bdrv_drain_all_end(); break;
     case BDRV_DRAIN:            bdrv_drained_end(bs); break;
+    case BDRV_SUBTREE_DRAIN:    bdrv_subtree_drained_end(bs); break;
     default:                    g_assert_not_reached();
     }
 }
@@ -180,6 +183,11 @@ static void test_drv_cb_drain(void)
     test_drv_cb_common(BDRV_DRAIN, false);
 }
 
+static void test_drv_cb_drain_subtree(void)
+{
+    test_drv_cb_common(BDRV_SUBTREE_DRAIN, true);
+}
+
 static void test_quiesce_common(enum drain_type drain_type, bool recursive)
 {
     BlockBackend *blk;
@@ -222,6 +230,11 @@ static void test_quiesce_drain(void)
     test_quiesce_common(BDRV_DRAIN, false);
 }
 
+static void test_quiesce_drain_subtree(void)
+{
+    test_quiesce_common(BDRV_SUBTREE_DRAIN, true);
+}
+
 static void test_nested(void)
 {
     BlockBackend *blk;
@@ -244,7 +257,8 @@ static void test_nested(void)
             /* XXX bdrv_drain_all() doesn't increase the quiesce_counter */
             int bs_quiesce      = (outer != BDRV_DRAIN_ALL) +
                                   (inner != BDRV_DRAIN_ALL);
-            int backing_quiesce = 0;
+            int backing_quiesce = (outer == BDRV_SUBTREE_DRAIN) +
+                                  (inner == BDRV_SUBTREE_DRAIN);
             int backing_cb_cnt  = (outer != BDRV_DRAIN) +
                                   (inner != BDRV_DRAIN);
 
@@ -391,6 +405,11 @@ static void test_blockjob_drain(void)
     test_blockjob_common(BDRV_DRAIN);
 }
 
+static void test_blockjob_drain_subtree(void)
+{
+    test_blockjob_common(BDRV_SUBTREE_DRAIN);
+}
+
 int main(int argc, char **argv)
 {
     bdrv_init();
@@ -400,14 +419,20 @@ int main(int argc, char **argv)
 
     g_test_add_func("/bdrv-drain/driver-cb/drain_all", test_drv_cb_drain_all);
     g_test_add_func("/bdrv-drain/driver-cb/drain", test_drv_cb_drain);
+    g_test_add_func("/bdrv-drain/driver-cb/drain_subtree",
+                    test_drv_cb_drain_subtree);
 
     g_test_add_func("/bdrv-drain/quiesce/drain_all", test_quiesce_drain_all);
     g_test_add_func("/bdrv-drain/quiesce/drain", test_quiesce_drain);
+    g_test_add_func("/bdrv-drain/quiesce/drain_subtree",
+                    test_quiesce_drain_subtree);
 
     g_test_add_func("/bdrv-drain/nested", test_nested);
 
     g_test_add_func("/bdrv-drain/blockjob/drain_all", test_blockjob_drain_all);
     g_test_add_func("/bdrv-drain/blockjob/drain", test_blockjob_drain);
+    g_test_add_func("/bdrv-drain/blockjob/drain_subtree",
+                    test_blockjob_drain_subtree);
 
     return g_test_run();
 }
-- 
2.13.6
