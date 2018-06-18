Received: from eggs.gnu.org ([2001:4830:134:3::10]:51848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHQ-0004s1-EY
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHO-0006GL-Hb
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:38 +0200
Message-Id: <20180618164504.24488-10-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/35] test-bdrv-drain: Add test for node
 deletion
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

From: Max Reitz <mreitz@redhat.com>

This patch adds two bdrv-drain tests for what happens if some BDS goes
away during the drainage.

The basic idea is that you have a parent BDS with some child nodes.
Then, you drain one of the children.  Because of that, the party who
actually owns the parent decides to (A) delete it, or (B) detach all its
children from it -- both while the child is still being drained.

A real-world case where this can happen is the mirror block job, which
may exit if you drain one of its children.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 22d31c953e..e8a5515b08 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -797,6 +797,172 @@ static void test_blockjob_drain_subtree(void)
     test_blockjob_common(BDRV_SUBTREE_DRAIN);
 }
 
+
+typedef struct BDRVTestTopState {
+    BdrvChild *wait_child;
+} BDRVTestTopState;
+
+static void bdrv_test_top_close(BlockDriverState *bs)
+{
+    BdrvChild *c, *next_c;
+    QLIST_FOREACH_SAFE(c, &bs->children, next, next_c) {
+        bdrv_unref_child(bs, c);
+    }
+}
+
+static int coroutine_fn bdrv_test_top_co_preadv(BlockDriverState *bs,
+                                                uint64_t offset, uint64_t bytes,
+                                                QEMUIOVector *qiov, int flags)
+{
+    BDRVTestTopState *tts = bs->opaque;
+    return bdrv_co_preadv(tts->wait_child, offset, bytes, qiov, flags);
+}
+
+static BlockDriver bdrv_test_top_driver = {
+    .format_name            = "test_top_driver",
+    .instance_size          = sizeof(BDRVTestTopState),
+
+    .bdrv_close             = bdrv_test_top_close,
+    .bdrv_co_preadv         = bdrv_test_top_co_preadv,
+
+    .bdrv_child_perm        = bdrv_format_default_perms,
+};
+
+typedef struct TestCoDeleteByDrainData {
+    BlockBackend *blk;
+    bool detach_instead_of_delete;
+    bool done;
+} TestCoDeleteByDrainData;
+
+static void coroutine_fn test_co_delete_by_drain(void *opaque)
+{
+    TestCoDeleteByDrainData *dbdd = opaque;
+    BlockBackend *blk = dbdd->blk;
+    BlockDriverState *bs = blk_bs(blk);
+    BDRVTestTopState *tts = bs->opaque;
+    void *buffer = g_malloc(65536);
+    QEMUIOVector qiov;
+    struct iovec iov = {
+        .iov_base = buffer,
+        .iov_len  = 65536,
+    };
+
+    qemu_iovec_init_external(&qiov, &iov, 1);
+
+    /* Pretend some internal write operation from parent to child.
+     * Important: We have to read from the child, not from the parent!
+     * Draining works by first propagating it all up the tree to the
+     * root and then waiting for drainage from root to the leaves
+     * (protocol nodes).  If we have a request waiting on the root,
+     * everything will be drained before we go back down the tree, but
+     * we do not want that.  We want to be in the middle of draining
+     * when this following requests returns. */
+    bdrv_co_preadv(tts->wait_child, 0, 65536, &qiov, 0);
+
+    g_assert_cmpint(bs->refcnt, ==, 1);
+
+    if (!dbdd->detach_instead_of_delete) {
+        blk_unref(blk);
+    } else {
+        BdrvChild *c, *next_c;
+        QLIST_FOREACH_SAFE(c, &bs->children, next, next_c) {
+            bdrv_unref_child(bs, c);
+        }
+    }
+
+    dbdd->done = true;
+}
+
+/**
+ * Test what happens when some BDS has some children, you drain one of
+ * them and this results in the BDS being deleted.
+ *
+ * If @detach_instead_of_delete is set, the BDS is not going to be
+ * deleted but will only detach all of its children.
+ */
+static void do_test_delete_by_drain(bool detach_instead_of_delete)
+{
+    BlockBackend *blk;
+    BlockDriverState *bs, *child_bs, *null_bs;
+    BDRVTestTopState *tts;
+    TestCoDeleteByDrainData dbdd;
+    Coroutine *co;
+
+    bs = bdrv_new_open_driver(&bdrv_test_top_driver, "top", BDRV_O_RDWR,
+                              &error_abort);
+    bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
+    tts = bs->opaque;
+
+    null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
+                        &error_abort);
+    bdrv_attach_child(bs, null_bs, "null-child", &child_file, &error_abort);
+
+    /* This child will be the one to pass to requests through to, and
+     * it will stall until a drain occurs */
+    child_bs = bdrv_new_open_driver(&bdrv_test, "child", BDRV_O_RDWR,
+                                    &error_abort);
+    child_bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
+    /* Takes our reference to child_bs */
+    tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child", &child_file,
+                                        &error_abort);
+
+    /* This child is just there to be deleted
+     * (for detach_instead_of_delete == true) */
+    null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
+                        &error_abort);
+    bdrv_attach_child(bs, null_bs, "null-child", &child_file, &error_abort);
+
+    blk = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_insert_bs(blk, bs, &error_abort);
+
+    /* Referenced by blk now */
+    bdrv_unref(bs);
+
+    g_assert_cmpint(bs->refcnt, ==, 1);
+    g_assert_cmpint(child_bs->refcnt, ==, 1);
+    g_assert_cmpint(null_bs->refcnt, ==, 1);
+
+
+    dbdd = (TestCoDeleteByDrainData){
+        .blk = blk,
+        .detach_instead_of_delete = detach_instead_of_delete,
+        .done = false,
+    };
+    co = qemu_coroutine_create(test_co_delete_by_drain, &dbdd);
+    qemu_coroutine_enter(co);
+
+    /* Drain the child while the read operation is still pending.
+     * This should result in the operation finishing and
+     * test_co_delete_by_drain() resuming.  Thus, @bs will be deleted
+     * and the coroutine will exit while this drain operation is still
+     * in progress. */
+    bdrv_ref(child_bs);
+    bdrv_drain(child_bs);
+    bdrv_unref(child_bs);
+
+    while (!dbdd.done) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+
+    if (detach_instead_of_delete) {
+        /* Here, the reference has not passed over to the coroutine,
+         * so we have to delete the BB ourselves */
+        blk_unref(blk);
+    }
+}
+
+
+static void test_delete_by_drain(void)
+{
+    do_test_delete_by_drain(false);
+}
+
+static void test_detach_by_drain(void)
+{
+    do_test_delete_by_drain(true);
+}
+
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -844,6 +1010,9 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/blockjob/drain_subtree",
                     test_blockjob_drain_subtree);
 
+    g_test_add_func("/bdrv-drain/deletion", test_delete_by_drain);
+    g_test_add_func("/bdrv-drain/detach", test_detach_by_drain);
+
     ret = g_test_run();
     qemu_event_destroy(&done_event);
     return ret;
-- 
2.13.6
