Received: from eggs.gnu.org ([2001:4830:134:3::10]:41475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6InT-0002ya-AR
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6InQ-0004ge-5n
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 11 Apr 2018 18:39:39 +0200
Message-Id: <20180411163940.2523-19-kwolf@redhat.com>
In-Reply-To: <20180411163940.2523-1-kwolf@redhat.com>
References: <20180411163940.2523-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 18/19] block: Allow graph changes in
 bdrv_drain_all_begin/end sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

bdrv_drain_all_*() used bdrv_next() to iterate over all root nodes and
did a subtree drain for each of them. This works fine as long as the
graph is static, but sadly, reality looks different.

If the graph changes so that root nodes are added or removed, we would
have to compensate for this. bdrv_next() returns each root node only
once even if it's the root node for multiple BlockBackends or for a
monitor-owned block driver tree, which would only complicate things.

The much easier and more obviously correct way is to fundamentally
change the way the functions work: Iterate over all BlockDriverStates,
no matter who owns them, and drain them individually. Compensation is
only necessary when a new BDS is created inside a drain_all section.
Removal of a BDS doesn't require any action because it's gone afterwards
anyway.

This change means that some nodes get a higher bs->quiesce_count now
because each node propagates its individual drain to all of its parents.
In the old subtree drain, propagation back to the parent that made the
recursive drain request was avoided. While this isn't perfectly
beautiful, accepting the higher counts seems preferable to adding drain
code to multiple other places that modify the graph.

The test case is changed to account for the higher counts where
necessary.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  1 +
 include/block/block_int.h |  1 +
 block.c                   | 20 +++++++++++++++-
 block/io.c                | 58 ++++++++++++++++++++++++++++++++++++-----------
 tests/test-bdrv-drain.c   | 37 +++++++++++++++++-------------
 5 files changed, 87 insertions(+), 30 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index de2cba2c74..0b59d519c5 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -412,6 +412,7 @@ BlockDriverState *bdrv_lookup_bs(const char *device,
                                  Error **errp);
 bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base);
 BlockDriverState *bdrv_next_node(BlockDriverState *bs);
+BlockDriverState *bdrv_next_all_states(BlockDriverState *bs);
 
 typedef struct BdrvNextIterator {
     enum {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dc6985e3ae..2c86a7b53f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -804,6 +804,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 
+extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_parent);
 
diff --git a/block.c b/block.c
index 330238de19..c1b339c4a4 100644
--- a/block.c
+++ b/block.c
@@ -332,6 +332,10 @@ BlockDriverState *bdrv_new(void)
 
     qemu_co_queue_init(&bs->flush_queue);
 
+    for (i = 0; i < bdrv_drain_all_count; i++) {
+        bdrv_drained_begin(bs);
+    }
+
     QTAILQ_INSERT_TAIL(&all_bdrv_states, bs, bs_list);
 
     return bs;
@@ -1160,7 +1164,7 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
                             int open_flags, Error **errp)
 {
     Error *local_err = NULL;
-    int ret;
+    int i, ret;
 
     bdrv_assign_node_name(bs, node_name, &local_err);
     if (local_err) {
@@ -1208,6 +1212,12 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
     assert(bdrv_min_mem_align(bs) != 0);
     assert(is_power_of_2(bs->bl.request_alignment));
 
+    for (i = 0; i < bs->quiesce_counter; i++) {
+        if (drv->bdrv_co_drain_begin) {
+            drv->bdrv_co_drain_begin(bs);
+        }
+    }
+
     return 0;
 open_failed:
     bs->drv = NULL;
@@ -4034,6 +4044,14 @@ BlockDriverState *bdrv_next_node(BlockDriverState *bs)
     return QTAILQ_NEXT(bs, node_list);
 }
 
+BlockDriverState *bdrv_next_all_states(BlockDriverState *bs)
+{
+    if (!bs) {
+        return QTAILQ_FIRST(&all_bdrv_states);
+    }
+    return QTAILQ_NEXT(bs, bs_list);
+}
+
 const char *bdrv_get_node_name(const BlockDriverState *bs)
 {
     return bs->node_name;
diff --git a/block/io.c b/block/io.c
index db6810b35f..af65c3ec2f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -38,6 +38,8 @@
 /* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
 
+static AioWait drain_all_aio_wait;
+
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
 
@@ -445,6 +447,29 @@ static void bdrv_drain_assert_idle(BlockDriverState *bs)
     }
 }
 
+unsigned int bdrv_drain_all_count = 0;
+
+static bool bdrv_drain_all_poll(void)
+{
+    BlockDriverState *bs = NULL;
+    bool result = false;
+
+    /* Execute pending BHs first (may modify the graph) and check everything
+     * else only after the BHs have executed. */
+    while (aio_poll(qemu_get_aio_context(), false));
+
+    /* bdrv_drain_poll() with top_level = false can't make changes to the
+     * graph, so iterating bdrv_next_all_states() is safe. */
+    while ((bs = bdrv_next_all_states(bs))) {
+        AioContext *aio_context = bdrv_get_aio_context(bs);
+        aio_context_acquire(aio_context);
+        result |= bdrv_drain_poll(bs, false, false);
+        aio_context_release(aio_context);
+    }
+
+    return result;
+}
+
 /*
  * Wait for pending requests to complete across all BlockDriverStates
  *
@@ -459,45 +484,51 @@ static void bdrv_drain_assert_idle(BlockDriverState *bs)
  */
 void bdrv_drain_all_begin(void)
 {
-    BlockDriverState *bs;
-    BdrvNextIterator it;
+    BlockDriverState *bs = NULL;
 
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(NULL, true, false, NULL, true);
         return;
     }
 
-    /* BDRV_POLL_WHILE() for a node can only be called from its own I/O thread
-     * or the main loop AioContext. We potentially use BDRV_POLL_WHILE() on
-     * nodes in several different AioContexts, so make sure we're in the main
-     * context. */
+    /* AIO_WAIT_WHILE() with a NULL context can only be called from the main
+     * loop AioContext, so make sure we're in the main context. */
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
+    assert(bdrv_drain_all_count < INT_MAX);
+    bdrv_drain_all_count++;
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+    /* Quiesce all nodes, without polling in-flight requests yet. The graph
+     * cannot change during this loop. */
+    while ((bs = bdrv_next_all_states(bs))) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
         aio_context_acquire(aio_context);
-        bdrv_do_drained_begin(bs, true, NULL, true);
+        bdrv_do_drained_begin(bs, false, NULL, false);
         aio_context_release(aio_context);
     }
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+    /* Now poll the in-flight requests */
+    AIO_WAIT_WHILE(&drain_all_aio_wait, NULL, bdrv_drain_all_poll());
+
+    while ((bs = bdrv_next_all_states(bs))) {
         bdrv_drain_assert_idle(bs);
     }
 }
 
 void bdrv_drain_all_end(void)
 {
-    BlockDriverState *bs;
-    BdrvNextIterator it;
+    BlockDriverState *bs = NULL;
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+    while ((bs = bdrv_next_all_states(bs))) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
         aio_context_acquire(aio_context);
-        bdrv_do_drained_end(bs, true, NULL);
+        bdrv_do_drained_end(bs, false, NULL);
         aio_context_release(aio_context);
     }
+
+    assert(bdrv_drain_all_count > 0);
+    bdrv_drain_all_count--;
 }
 
 void bdrv_drain_all(void)
@@ -620,6 +651,7 @@ void bdrv_inc_in_flight(BlockDriverState *bs)
 void bdrv_wakeup(BlockDriverState *bs)
 {
     aio_wait_kick(bdrv_get_aio_wait(bs));
+    aio_wait_kick(&drain_all_aio_wait);
 }
 
 void bdrv_dec_in_flight(BlockDriverState *bs)
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 79d845ecbb..97ca0743c6 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -174,7 +174,8 @@ static void do_drain_end(enum drain_type drain_type, BlockDriverState *bs)
     }
 }
 
-static void test_drv_cb_common(enum drain_type drain_type, bool recursive)
+static void test_drv_cb_common(enum drain_type drain_type, int top_drain_count,
+                               int backing_drain_count)
 {
     BlockBackend *blk;
     BlockDriverState *bs, *backing;
@@ -205,8 +206,8 @@ static void test_drv_cb_common(enum drain_type drain_type, bool recursive)
 
     do_drain_begin(drain_type, bs);
 
-    g_assert_cmpint(s->drain_count, ==, 1);
-    g_assert_cmpint(backing_s->drain_count, ==, !!recursive);
+    g_assert_cmpint(s->drain_count, ==, top_drain_count);
+    g_assert_cmpint(backing_s->drain_count, ==, backing_drain_count);
 
     do_drain_end(drain_type, bs);
 
@@ -225,8 +226,8 @@ static void test_drv_cb_common(enum drain_type drain_type, bool recursive)
     do_drain_begin(drain_type, bs);
 
     g_assert_cmpint(aio_ret, ==, 0);
-    g_assert_cmpint(s->drain_count, ==, 1);
-    g_assert_cmpint(backing_s->drain_count, ==, !!recursive);
+    g_assert_cmpint(s->drain_count, ==, top_drain_count);
+    g_assert_cmpint(backing_s->drain_count, ==, backing_drain_count);
 
     do_drain_end(drain_type, bs);
 
@@ -240,17 +241,17 @@ static void test_drv_cb_common(enum drain_type drain_type, bool recursive)
 
 static void test_drv_cb_drain_all(void)
 {
-    test_drv_cb_common(BDRV_DRAIN_ALL, true);
+    test_drv_cb_common(BDRV_DRAIN_ALL, 2, 1);
 }
 
 static void test_drv_cb_drain(void)
 {
-    test_drv_cb_common(BDRV_DRAIN, false);
+    test_drv_cb_common(BDRV_DRAIN, 1, 0);
 }
 
 static void test_drv_cb_drain_subtree(void)
 {
-    test_drv_cb_common(BDRV_SUBTREE_DRAIN, true);
+    test_drv_cb_common(BDRV_SUBTREE_DRAIN, 1, 1);
 }
 
 static void test_drv_cb_co_drain_all(void)
@@ -268,7 +269,9 @@ static void test_drv_cb_co_drain_subtree(void)
     call_in_coroutine(test_drv_cb_drain_subtree);
 }
 
-static void test_quiesce_common(enum drain_type drain_type, bool recursive)
+static void test_quiesce_common(enum drain_type drain_type,
+                                int top_quiesce_count,
+                                int backing_quiesce_count)
 {
     BlockBackend *blk;
     BlockDriverState *bs, *backing;
@@ -286,8 +289,8 @@ static void test_quiesce_common(enum drain_type drain_type, bool recursive)
 
     do_drain_begin(drain_type, bs);
 
-    g_assert_cmpint(bs->quiesce_counter, ==, 1);
-    g_assert_cmpint(backing->quiesce_counter, ==, !!recursive);
+    g_assert_cmpint(bs->quiesce_counter, ==, top_quiesce_count);
+    g_assert_cmpint(backing->quiesce_counter, ==, backing_quiesce_count);
 
     do_drain_end(drain_type, bs);
 
@@ -301,17 +304,17 @@ static void test_quiesce_common(enum drain_type drain_type, bool recursive)
 
 static void test_quiesce_drain_all(void)
 {
-    test_quiesce_common(BDRV_DRAIN_ALL, true);
+    test_quiesce_common(BDRV_DRAIN_ALL, 2, 1);
 }
 
 static void test_quiesce_drain(void)
 {
-    test_quiesce_common(BDRV_DRAIN, false);
+    test_quiesce_common(BDRV_DRAIN, 1, 0);
 }
 
 static void test_quiesce_drain_subtree(void)
 {
-    test_quiesce_common(BDRV_SUBTREE_DRAIN, true);
+    test_quiesce_common(BDRV_SUBTREE_DRAIN, 1, 1);
 }
 
 static void test_quiesce_co_drain_all(void)
@@ -348,6 +351,8 @@ static void test_nested(void)
 
     for (outer = 0; outer < DRAIN_TYPE_MAX; outer++) {
         for (inner = 0; inner < DRAIN_TYPE_MAX; inner++) {
+            int top_quiesce = 2 + (outer == BDRV_DRAIN_ALL) +
+                                  (inner == BDRV_DRAIN_ALL);
             int backing_quiesce = (outer != BDRV_DRAIN) +
                                   (inner != BDRV_DRAIN);
 
@@ -359,9 +364,9 @@ static void test_nested(void)
             do_drain_begin(outer, bs);
             do_drain_begin(inner, bs);
 
-            g_assert_cmpint(bs->quiesce_counter, ==, 2);
+            g_assert_cmpint(bs->quiesce_counter, ==, top_quiesce);
             g_assert_cmpint(backing->quiesce_counter, ==, backing_quiesce);
-            g_assert_cmpint(s->drain_count, ==, 2);
+            g_assert_cmpint(s->drain_count, ==, top_quiesce);
             g_assert_cmpint(backing_s->drain_count, ==, backing_quiesce);
 
             do_drain_end(inner, bs);
-- 
2.13.6
