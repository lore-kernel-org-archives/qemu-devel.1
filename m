Received: from eggs.gnu.org ([2001:4830:134:3::10]:51938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHT-0004vL-2t
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHR-0006Ih-3J
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:42 +0200
Message-Id: <20180618164504.24488-14-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/35] test-bdrv-drain: Graph change through
 parent callback
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 0c8f632f2d..abb287e597 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -982,6 +982,135 @@ static void test_detach_by_drain_subtree(void)
 }
 
 
+struct detach_by_parent_data {
+    BlockDriverState *parent_b;
+    BdrvChild *child_b;
+    BlockDriverState *c;
+    BdrvChild *child_c;
+};
+
+static void detach_by_parent_aio_cb(void *opaque, int ret)
+{
+    struct detach_by_parent_data *data = opaque;
+
+    g_assert_cmpint(ret, ==, 0);
+    bdrv_unref_child(data->parent_b, data->child_b);
+
+    bdrv_ref(data->c);
+    data->child_c = bdrv_attach_child(data->parent_b, data->c, "PB-C",
+                                      &child_file, &error_abort);
+}
+
+/*
+ * Initial graph:
+ *
+ * PA     PB
+ *    \ /   \
+ *     A     B     C
+ *
+ * PA has a pending write request whose callback changes the child nodes of PB:
+ * It removes B and adds C instead. The subtree of PB is drained, which will
+ * indirectly drain the write request, too.
+ */
+static void test_detach_by_parent_cb(void)
+{
+    BlockBackend *blk;
+    BlockDriverState *parent_a, *parent_b, *a, *b, *c;
+    BdrvChild *child_a, *child_b;
+    BlockAIOCB *acb;
+    struct detach_by_parent_data data;
+
+    QEMUIOVector qiov;
+    struct iovec iov = {
+        .iov_base = NULL,
+        .iov_len = 0,
+    };
+    qemu_iovec_init_external(&qiov, &iov, 1);
+
+    /* Create all involved nodes */
+    parent_a = bdrv_new_open_driver(&bdrv_test, "parent-a", BDRV_O_RDWR,
+                                    &error_abort);
+    parent_b = bdrv_new_open_driver(&bdrv_test, "parent-b", 0,
+                                    &error_abort);
+
+    a = bdrv_new_open_driver(&bdrv_test, "a", BDRV_O_RDWR, &error_abort);
+    b = bdrv_new_open_driver(&bdrv_test, "b", BDRV_O_RDWR, &error_abort);
+    c = bdrv_new_open_driver(&bdrv_test, "c", BDRV_O_RDWR, &error_abort);
+
+    /* blk is a BB for parent-a */
+    blk = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_insert_bs(blk, parent_a, &error_abort);
+    bdrv_unref(parent_a);
+
+    /* Set child relationships */
+    bdrv_ref(b);
+    bdrv_ref(a);
+    child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_file, &error_abort);
+    child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_backing, &error_abort);
+
+    bdrv_ref(a);
+    bdrv_attach_child(parent_a, a, "PA-A", &child_file, &error_abort);
+
+    g_assert_cmpint(parent_a->refcnt, ==, 1);
+    g_assert_cmpint(parent_b->refcnt, ==, 1);
+    g_assert_cmpint(a->refcnt, ==, 3);
+    g_assert_cmpint(b->refcnt, ==, 2);
+    g_assert_cmpint(c->refcnt, ==, 1);
+
+    g_assert(QLIST_FIRST(&parent_b->children) == child_a);
+    g_assert(QLIST_NEXT(child_a, next) == child_b);
+    g_assert(QLIST_NEXT(child_b, next) == NULL);
+
+    /* Start the evil write request */
+    data = (struct detach_by_parent_data) {
+        .parent_b = parent_b,
+        .child_b = child_b,
+        .c = c,
+    };
+    acb = blk_aio_preadv(blk, 0, &qiov, 0, detach_by_parent_aio_cb, &data);
+    g_assert(acb != NULL);
+
+    /* Drain and check the expected result */
+    bdrv_subtree_drained_begin(parent_b);
+
+    g_assert(data.child_c != NULL);
+
+    g_assert_cmpint(parent_a->refcnt, ==, 1);
+    g_assert_cmpint(parent_b->refcnt, ==, 1);
+    g_assert_cmpint(a->refcnt, ==, 3);
+    g_assert_cmpint(b->refcnt, ==, 1);
+    g_assert_cmpint(c->refcnt, ==, 2);
+
+    g_assert(QLIST_FIRST(&parent_b->children) == data.child_c);
+    g_assert(QLIST_NEXT(data.child_c, next) == child_a);
+    g_assert(QLIST_NEXT(child_a, next) == NULL);
+
+    g_assert_cmpint(parent_a->quiesce_counter, ==, 1);
+    g_assert_cmpint(parent_b->quiesce_counter, ==, 1);
+    g_assert_cmpint(a->quiesce_counter, ==, 1);
+    g_assert_cmpint(b->quiesce_counter, ==, 0);
+    g_assert_cmpint(c->quiesce_counter, ==, 1);
+
+    bdrv_subtree_drained_end(parent_b);
+
+    bdrv_unref(parent_b);
+    blk_unref(blk);
+
+    /* XXX Once bdrv_close() unref's children instead of just detaching them,
+     * this won't be necessary any more. */
+    bdrv_unref(a);
+    bdrv_unref(a);
+    bdrv_unref(c);
+
+    g_assert_cmpint(a->refcnt, ==, 1);
+    g_assert_cmpint(b->refcnt, ==, 1);
+    g_assert_cmpint(c->refcnt, ==, 1);
+    bdrv_unref(a);
+    bdrv_unref(b);
+    bdrv_unref(c);
+}
+
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -1032,6 +1161,7 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/deletion/drain", test_delete_by_drain);
     g_test_add_func("/bdrv-drain/detach/drain", test_detach_by_drain);
     g_test_add_func("/bdrv-drain/detach/drain_subtree", test_detach_by_drain_subtree);
+    g_test_add_func("/bdrv-drain/detach/parent_cb", test_detach_by_parent_cb);
 
     ret = g_test_run();
     qemu_event_destroy(&done_event);
-- 
2.13.6
