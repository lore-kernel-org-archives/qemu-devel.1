Received: from eggs.gnu.org ([2001:4830:134:3::10]:52117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHa-00054J-4b
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHZ-0006OO-0L
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:34 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:49 +0200
Message-Id: <20180618164504.24488-21-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/35] test-bdrv-drain: Test graph changes in
 drain_all section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This tests both adding and remove a node between bdrv_drain_all_begin()
and bdrv_drain_all_end(), and enabled the existing detach test for
drain_all.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 5cc179a778..291a050f86 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -452,7 +452,7 @@ static void test_multiparent(void)
     blk_unref(blk_b);
 }
 
-static void test_graph_change(void)
+static void test_graph_change_drain_subtree(void)
 {
     BlockBackend *blk_a, *blk_b;
     BlockDriverState *bs_a, *bs_b, *backing;
@@ -531,6 +531,63 @@ static void test_graph_change(void)
     blk_unref(blk_b);
 }
 
+static void test_graph_change_drain_all(void)
+{
+    BlockBackend *blk_a, *blk_b;
+    BlockDriverState *bs_a, *bs_b;
+    BDRVTestState *a_s, *b_s;
+
+    /* Create node A with a BlockBackend */
+    blk_a = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs_a = bdrv_new_open_driver(&bdrv_test, "test-node-a", BDRV_O_RDWR,
+                                &error_abort);
+    a_s = bs_a->opaque;
+    blk_insert_bs(blk_a, bs_a, &error_abort);
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 0);
+    g_assert_cmpint(a_s->drain_count, ==, 0);
+
+    /* Call bdrv_drain_all_begin() */
+    bdrv_drain_all_begin();
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 1);
+    g_assert_cmpint(a_s->drain_count, ==, 1);
+
+    /* Create node B with a BlockBackend */
+    blk_b = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs_b = bdrv_new_open_driver(&bdrv_test, "test-node-b", BDRV_O_RDWR,
+                                &error_abort);
+    b_s = bs_b->opaque;
+    blk_insert_bs(blk_b, bs_b, &error_abort);
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 1);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 1);
+    g_assert_cmpint(a_s->drain_count, ==, 1);
+    g_assert_cmpint(b_s->drain_count, ==, 1);
+
+    /* Unref and finally delete node A */
+    blk_unref(blk_a);
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 1);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 1);
+    g_assert_cmpint(a_s->drain_count, ==, 1);
+    g_assert_cmpint(b_s->drain_count, ==, 1);
+
+    bdrv_unref(bs_a);
+
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 1);
+    g_assert_cmpint(b_s->drain_count, ==, 1);
+
+    /* End the drained section */
+    bdrv_drain_all_end();
+
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 0);
+    g_assert_cmpint(b_s->drain_count, ==, 0);
+
+    bdrv_unref(bs_b);
+    blk_unref(blk_b);
+}
+
 struct test_iothread_data {
     BlockDriverState *bs;
     enum drain_type drain_type;
@@ -971,6 +1028,10 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
         bdrv_subtree_drained_begin(bs);
         bdrv_subtree_drained_end(bs);
         break;
+    case BDRV_DRAIN_ALL:
+        bdrv_drain_all_begin();
+        bdrv_drain_all_end();
+        break;
     default:
         g_assert_not_reached();
     }
@@ -991,6 +1052,11 @@ static void test_delete_by_drain(void)
     do_test_delete_by_drain(false, BDRV_DRAIN);
 }
 
+static void test_detach_by_drain_all(void)
+{
+    do_test_delete_by_drain(true, BDRV_DRAIN_ALL);
+}
+
 static void test_detach_by_drain(void)
 {
     do_test_delete_by_drain(true, BDRV_DRAIN);
@@ -1219,7 +1285,11 @@ int main(int argc, char **argv)
 
     g_test_add_func("/bdrv-drain/nested", test_nested);
     g_test_add_func("/bdrv-drain/multiparent", test_multiparent);
-    g_test_add_func("/bdrv-drain/graph-change", test_graph_change);
+
+    g_test_add_func("/bdrv-drain/graph-change/drain_subtree",
+                    test_graph_change_drain_subtree);
+    g_test_add_func("/bdrv-drain/graph-change/drain_all",
+                    test_graph_change_drain_all);
 
     g_test_add_func("/bdrv-drain/iothread/drain_all", test_iothread_drain_all);
     g_test_add_func("/bdrv-drain/iothread/drain", test_iothread_drain);
@@ -1232,6 +1302,7 @@ int main(int argc, char **argv)
                     test_blockjob_drain_subtree);
 
     g_test_add_func("/bdrv-drain/deletion/drain", test_delete_by_drain);
+    g_test_add_func("/bdrv-drain/detach/drain_all", test_detach_by_drain_all);
     g_test_add_func("/bdrv-drain/detach/drain", test_detach_by_drain);
     g_test_add_func("/bdrv-drain/detach/drain_subtree", test_detach_by_drain_subtree);
     g_test_add_func("/bdrv-drain/detach/parent_cb", test_detach_by_parent_cb);
-- 
2.13.6
