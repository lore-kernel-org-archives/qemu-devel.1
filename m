Received: from eggs.gnu.org ([2001:4830:134:3::10]:43129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1lZ-0003UX-5H
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1lW-0002R5-6h
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:24:09 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:49 +0100
Message-Id: <20171221142251.18366-18-kwolf@redhat.com>
In-Reply-To: <20171221142251.18366-1-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/19] test-bdrv-drain: Test graph changes
 in drained section
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 9e66b40465..7e8bd591a4 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -411,6 +411,85 @@ static void test_multiparent(void)
     blk_unref(blk_b);
 }
 
+static void test_graph_change(void)
+{
+    BlockBackend *blk_a, *blk_b;
+    BlockDriverState *bs_a, *bs_b, *backing;
+    BDRVTestState *a_s, *b_s, *backing_s;
+
+    blk_a = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs_a = bdrv_new_open_driver(&bdrv_test, "test-node-a", BDRV_O_RDWR,
+                                &error_abort);
+    a_s = bs_a->opaque;
+    blk_insert_bs(blk_a, bs_a, &error_abort);
+
+    blk_b = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs_b = bdrv_new_open_driver(&bdrv_test, "test-node-b", BDRV_O_RDWR,
+                                &error_abort);
+    b_s = bs_b->opaque;
+    blk_insert_bs(blk_b, bs_b, &error_abort);
+
+    backing = bdrv_new_open_driver(&bdrv_test, "backing", 0, &error_abort);
+    backing_s = backing->opaque;
+    bdrv_set_backing_hd(bs_a, backing, &error_abort);
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 0);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 0);
+    g_assert_cmpint(backing->quiesce_counter, ==, 0);
+    g_assert_cmpint(a_s->drain_count, ==, 0);
+    g_assert_cmpint(b_s->drain_count, ==, 0);
+    g_assert_cmpint(backing_s->drain_count, ==, 0);
+
+    do_drain_begin(BDRV_SUBTREE_DRAIN, bs_a);
+    do_drain_begin(BDRV_SUBTREE_DRAIN, bs_a);
+    do_drain_begin(BDRV_SUBTREE_DRAIN, bs_a);
+    do_drain_begin(BDRV_SUBTREE_DRAIN, bs_b);
+    do_drain_begin(BDRV_SUBTREE_DRAIN, bs_b);
+
+    bdrv_set_backing_hd(bs_b, backing, &error_abort);
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 5);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 5);
+    g_assert_cmpint(backing->quiesce_counter, ==, 5);
+    g_assert_cmpint(a_s->drain_count, ==, 5);
+    g_assert_cmpint(b_s->drain_count, ==, 5);
+    g_assert_cmpint(backing_s->drain_count, ==, 5);
+
+    bdrv_set_backing_hd(bs_b, NULL, &error_abort);
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 3);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 2);
+    g_assert_cmpint(backing->quiesce_counter, ==, 3);
+    g_assert_cmpint(a_s->drain_count, ==, 3);
+    g_assert_cmpint(b_s->drain_count, ==, 2);
+    g_assert_cmpint(backing_s->drain_count, ==, 3);
+
+    bdrv_set_backing_hd(bs_b, backing, &error_abort);
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 5);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 5);
+    g_assert_cmpint(backing->quiesce_counter, ==, 5);
+    g_assert_cmpint(a_s->drain_count, ==, 5);
+    g_assert_cmpint(b_s->drain_count, ==, 5);
+    g_assert_cmpint(backing_s->drain_count, ==, 5);
+
+    do_drain_end(BDRV_SUBTREE_DRAIN, bs_b);
+    do_drain_end(BDRV_SUBTREE_DRAIN, bs_b);
+    do_drain_end(BDRV_SUBTREE_DRAIN, bs_a);
+    do_drain_end(BDRV_SUBTREE_DRAIN, bs_a);
+    do_drain_end(BDRV_SUBTREE_DRAIN, bs_a);
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 0);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 0);
+    g_assert_cmpint(backing->quiesce_counter, ==, 0);
+    g_assert_cmpint(a_s->drain_count, ==, 0);
+    g_assert_cmpint(b_s->drain_count, ==, 0);
+    g_assert_cmpint(backing_s->drain_count, ==, 0);
+
+    bdrv_unref(backing);
+    bdrv_unref(bs_a);
+    bdrv_unref(bs_b);
+    blk_unref(blk_a);
+    blk_unref(blk_b);
+}
+
 
 typedef struct TestBlockJob {
     BlockJob common;
@@ -561,6 +640,7 @@ int main(int argc, char **argv)
 
     g_test_add_func("/bdrv-drain/nested", test_nested);
     g_test_add_func("/bdrv-drain/multiparent", test_multiparent);
+    g_test_add_func("/bdrv-drain/graph-change", test_graph_change);
 
     g_test_add_func("/bdrv-drain/blockjob/drain_all", test_blockjob_drain_all);
     g_test_add_func("/bdrv-drain/blockjob/drain", test_blockjob_drain);
-- 
2.13.6
