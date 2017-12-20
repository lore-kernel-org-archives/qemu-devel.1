Received: from eggs.gnu.org ([2001:4830:134:3::10]:39891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbjL-00053M-4E
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbjD-0005Q4-Jm
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:36:07 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 11:34:08 +0100
Message-Id: <20171220103412.13048-16-kwolf@redhat.com>
In-Reply-To: <20171220103412.13048-1-kwolf@redhat.com>
References: <20171220103412.13048-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 15/19] test-bdrv-drain: Recursive draining with
 multiple parents
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

Test that drain sections are correctly propagated through the graph.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index a1e5693f33..b7322c5826 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -338,6 +338,79 @@ static void test_nested(void)
     blk_unref(blk);
 }
 
+static void test_multiparent(void)
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
+    bdrv_set_backing_hd(bs_b, backing, &error_abort);
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 0);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 0);
+    g_assert_cmpint(backing->quiesce_counter, ==, 0);
+    g_assert_cmpint(a_s->drain_count, ==, 0);
+    g_assert_cmpint(b_s->drain_count, ==, 0);
+    g_assert_cmpint(backing_s->drain_count, ==, 0);
+
+    do_drain_begin(BDRV_SUBTREE_DRAIN, bs_a);
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 1);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 1);
+    g_assert_cmpint(backing->quiesce_counter, ==, 1);
+    g_assert_cmpint(a_s->drain_count, ==, 1);
+    g_assert_cmpint(b_s->drain_count, ==, 1);
+    g_assert_cmpint(backing_s->drain_count, ==, 1);
+
+    do_drain_begin(BDRV_SUBTREE_DRAIN, bs_b);
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 2);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 2);
+    g_assert_cmpint(backing->quiesce_counter, ==, 2);
+    g_assert_cmpint(a_s->drain_count, ==, 2);
+    g_assert_cmpint(b_s->drain_count, ==, 2);
+    g_assert_cmpint(backing_s->drain_count, ==, 2);
+
+    do_drain_end(BDRV_SUBTREE_DRAIN, bs_b);
+
+    g_assert_cmpint(bs_a->quiesce_counter, ==, 1);
+    g_assert_cmpint(bs_b->quiesce_counter, ==, 1);
+    g_assert_cmpint(backing->quiesce_counter, ==, 1);
+    g_assert_cmpint(a_s->drain_count, ==, 1);
+    g_assert_cmpint(b_s->drain_count, ==, 1);
+    g_assert_cmpint(backing_s->drain_count, ==, 1);
+
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
@@ -479,6 +552,7 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/quiesce/coroutine", test_quiesce_coroutine);
 
     g_test_add_func("/bdrv-drain/nested", test_nested);
+    g_test_add_func("/bdrv-drain/multiparent", test_multiparent);
 
     g_test_add_func("/bdrv-drain/blockjob/drain_all", test_blockjob_drain_all);
     g_test_add_func("/bdrv-drain/blockjob/drain", test_blockjob_drain);
-- 
2.13.6
