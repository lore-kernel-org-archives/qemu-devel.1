Received: from eggs.gnu.org ([2001:4830:134:3::10]:52006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHV-0004yO-Ep
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHT-0006Kk-Ia
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:44 +0200
Message-Id: <20180618164504.24488-16-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/35] test-bdrv-drain: Test that
 bdrv_drain_invoke() doesn't poll
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

This adds a test case that goes wrong if bdrv_drain_invoke() calls
aio_poll().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 102 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 88 insertions(+), 14 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index abb287e597..5cc179a778 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -34,12 +34,16 @@ static QemuEvent done_event;
 typedef struct BDRVTestState {
     int drain_count;
     AioContext *bh_indirection_ctx;
+    bool sleep_in_drain_begin;
 } BDRVTestState;
 
 static void coroutine_fn bdrv_test_co_drain_begin(BlockDriverState *bs)
 {
     BDRVTestState *s = bs->opaque;
     s->drain_count++;
+    if (s->sleep_in_drain_begin) {
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
+    }
 }
 
 static void coroutine_fn bdrv_test_co_drain_end(BlockDriverState *bs)
@@ -80,6 +84,22 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
     return 0;
 }
 
+static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                 const BdrvChildRole *role,
+                                 BlockReopenQueue *reopen_queue,
+                                 uint64_t perm, uint64_t shared,
+                                 uint64_t *nperm, uint64_t *nshared)
+{
+    /* bdrv_format_default_perms() accepts only these two, so disguise
+     * detach_by_driver_cb_role as one of them. */
+    if (role != &child_file && role != &child_backing) {
+        role = &child_file;
+    }
+
+    bdrv_format_default_perms(bs, c, role, reopen_queue, perm, shared,
+                              nperm, nshared);
+}
+
 static BlockDriver bdrv_test = {
     .format_name            = "test",
     .instance_size          = sizeof(BDRVTestState),
@@ -90,7 +110,7 @@ static BlockDriver bdrv_test = {
     .bdrv_co_drain_begin    = bdrv_test_co_drain_begin,
     .bdrv_co_drain_end      = bdrv_test_co_drain_end,
 
-    .bdrv_child_perm        = bdrv_format_default_perms,
+    .bdrv_child_perm        = bdrv_test_child_perm,
 };
 
 static void aio_ret_cb(void *opaque, int ret)
@@ -987,13 +1007,14 @@ struct detach_by_parent_data {
     BdrvChild *child_b;
     BlockDriverState *c;
     BdrvChild *child_c;
+    bool by_parent_cb;
 };
+static struct detach_by_parent_data detach_by_parent_data;
 
-static void detach_by_parent_aio_cb(void *opaque, int ret)
+static void detach_indirect_bh(void *opaque)
 {
     struct detach_by_parent_data *data = opaque;
 
-    g_assert_cmpint(ret, ==, 0);
     bdrv_unref_child(data->parent_b, data->child_b);
 
     bdrv_ref(data->c);
@@ -1001,6 +1022,25 @@ static void detach_by_parent_aio_cb(void *opaque, int ret)
                                       &child_file, &error_abort);
 }
 
+static void detach_by_parent_aio_cb(void *opaque, int ret)
+{
+    struct detach_by_parent_data *data = &detach_by_parent_data;
+
+    g_assert_cmpint(ret, ==, 0);
+    if (data->by_parent_cb) {
+        detach_indirect_bh(data);
+    }
+}
+
+static void detach_by_driver_cb_drained_begin(BdrvChild *child)
+{
+    aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
+                            detach_indirect_bh, &detach_by_parent_data);
+    child_file.drained_begin(child);
+}
+
+static BdrvChildRole detach_by_driver_cb_role;
+
 /*
  * Initial graph:
  *
@@ -1008,17 +1048,25 @@ static void detach_by_parent_aio_cb(void *opaque, int ret)
  *    \ /   \
  *     A     B     C
  *
- * PA has a pending write request whose callback changes the child nodes of PB:
- * It removes B and adds C instead. The subtree of PB is drained, which will
- * indirectly drain the write request, too.
+ * by_parent_cb == true:  Test that parent callbacks don't poll
+ *
+ *     PA has a pending write request whose callback changes the child nodes of
+ *     PB: It removes B and adds C instead. The subtree of PB is drained, which
+ *     will indirectly drain the write request, too.
+ *
+ * by_parent_cb == false: Test that bdrv_drain_invoke() doesn't poll
+ *
+ *     PA's BdrvChildRole has a .drained_begin callback that schedules a BH
+ *     that does the same graph change. If bdrv_drain_invoke() calls it, the
+ *     state is messed up, but if it is only polled in the single
+ *     BDRV_POLL_WHILE() at the end of the drain, this should work fine.
  */
-static void test_detach_by_parent_cb(void)
+static void test_detach_indirect(bool by_parent_cb)
 {
     BlockBackend *blk;
     BlockDriverState *parent_a, *parent_b, *a, *b, *c;
     BdrvChild *child_a, *child_b;
     BlockAIOCB *acb;
-    struct detach_by_parent_data data;
 
     QEMUIOVector qiov;
     struct iovec iov = {
@@ -1027,6 +1075,12 @@ static void test_detach_by_parent_cb(void)
     };
     qemu_iovec_init_external(&qiov, &iov, 1);
 
+    if (!by_parent_cb) {
+        detach_by_driver_cb_role = child_file;
+        detach_by_driver_cb_role.drained_begin =
+            detach_by_driver_cb_drained_begin;
+    }
+
     /* Create all involved nodes */
     parent_a = bdrv_new_open_driver(&bdrv_test, "parent-a", BDRV_O_RDWR,
                                     &error_abort);
@@ -1042,6 +1096,13 @@ static void test_detach_by_parent_cb(void)
     blk_insert_bs(blk, parent_a, &error_abort);
     bdrv_unref(parent_a);
 
+    /* If we want to get bdrv_drain_invoke() to call aio_poll(), the driver
+     * callback must not return immediately. */
+    if (!by_parent_cb) {
+        BDRVTestState *s = parent_a->opaque;
+        s->sleep_in_drain_begin = true;
+    }
+
     /* Set child relationships */
     bdrv_ref(b);
     bdrv_ref(a);
@@ -1049,7 +1110,9 @@ static void test_detach_by_parent_cb(void)
     child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_backing, &error_abort);
 
     bdrv_ref(a);
-    bdrv_attach_child(parent_a, a, "PA-A", &child_file, &error_abort);
+    bdrv_attach_child(parent_a, a, "PA-A",
+                      by_parent_cb ? &child_file : &detach_by_driver_cb_role,
+                      &error_abort);
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
@@ -1062,18 +1125,19 @@ static void test_detach_by_parent_cb(void)
     g_assert(QLIST_NEXT(child_b, next) == NULL);
 
     /* Start the evil write request */
-    data = (struct detach_by_parent_data) {
+    detach_by_parent_data = (struct detach_by_parent_data) {
         .parent_b = parent_b,
         .child_b = child_b,
         .c = c,
+        .by_parent_cb = by_parent_cb,
     };
-    acb = blk_aio_preadv(blk, 0, &qiov, 0, detach_by_parent_aio_cb, &data);
+    acb = blk_aio_preadv(blk, 0, &qiov, 0, detach_by_parent_aio_cb, NULL);
     g_assert(acb != NULL);
 
     /* Drain and check the expected result */
     bdrv_subtree_drained_begin(parent_b);
 
-    g_assert(data.child_c != NULL);
+    g_assert(detach_by_parent_data.child_c != NULL);
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
@@ -1081,8 +1145,8 @@ static void test_detach_by_parent_cb(void)
     g_assert_cmpint(b->refcnt, ==, 1);
     g_assert_cmpint(c->refcnt, ==, 2);
 
-    g_assert(QLIST_FIRST(&parent_b->children) == data.child_c);
-    g_assert(QLIST_NEXT(data.child_c, next) == child_a);
+    g_assert(QLIST_FIRST(&parent_b->children) == detach_by_parent_data.child_c);
+    g_assert(QLIST_NEXT(detach_by_parent_data.child_c, next) == child_a);
     g_assert(QLIST_NEXT(child_a, next) == NULL);
 
     g_assert_cmpint(parent_a->quiesce_counter, ==, 1);
@@ -1110,6 +1174,15 @@ static void test_detach_by_parent_cb(void)
     bdrv_unref(c);
 }
 
+static void test_detach_by_parent_cb(void)
+{
+    test_detach_indirect(true);
+}
+
+static void test_detach_by_driver_cb(void)
+{
+    test_detach_indirect(false);
+}
 
 int main(int argc, char **argv)
 {
@@ -1162,6 +1235,7 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/detach/drain", test_detach_by_drain);
     g_test_add_func("/bdrv-drain/detach/drain_subtree", test_detach_by_drain_subtree);
     g_test_add_func("/bdrv-drain/detach/parent_cb", test_detach_by_parent_cb);
+    g_test_add_func("/bdrv-drain/detach/driver_cb", test_detach_by_driver_cb);
 
     ret = g_test_run();
     qemu_event_destroy(&done_event);
-- 
2.13.6
