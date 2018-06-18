Received: from eggs.gnu.org ([2001:4830:134:3::10]:52090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHZ-00053V-Ad
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHX-0006NI-L0
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:48 +0200
Message-Id: <20180618164504.24488-20-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/35] block: Allow graph changes in
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  1 +
 include/block/block_int.h |  1 +
 block.c                   | 34 ++++++++++++++++++++++++---
 block/io.c                | 60 ++++++++++++++++++++++++++++++++++++-----------
 4 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 836746e4e1..b1d6fdb97a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -421,6 +421,7 @@ BlockDriverState *bdrv_lookup_bs(const char *device,
                                  Error **errp);
 bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base);
 BlockDriverState *bdrv_next_node(BlockDriverState *bs);
+BlockDriverState *bdrv_next_all_states(BlockDriverState *bs);
 
 typedef struct BdrvNextIterator {
     enum {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1abfc26d76..7cd7eed83b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -854,6 +854,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 
+extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_parent);
 
diff --git a/block.c b/block.c
index c8586f41ba..6c128007fd 100644
--- a/block.c
+++ b/block.c
@@ -333,6 +333,10 @@ BlockDriverState *bdrv_new(void)
 
     qemu_co_queue_init(&bs->flush_queue);
 
+    for (i = 0; i < bdrv_drain_all_count; i++) {
+        bdrv_drained_begin(bs);
+    }
+
     QTAILQ_INSERT_TAIL(&all_bdrv_states, bs, bs_list);
 
     return bs;
@@ -1164,7 +1168,7 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
                             int open_flags, Error **errp)
 {
     Error *local_err = NULL;
-    int ret;
+    int i, ret;
 
     bdrv_assign_node_name(bs, node_name, &local_err);
     if (local_err) {
@@ -1212,6 +1216,12 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
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
@@ -2033,7 +2043,12 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
             child->role->detach(child);
         }
         if (old_bs->quiesce_counter && child->role->drained_end) {
-            for (i = 0; i < old_bs->quiesce_counter; i++) {
+            int num = old_bs->quiesce_counter;
+            if (child->role->parent_is_bds) {
+                num -= bdrv_drain_all_count;
+            }
+            assert(num >= 0);
+            for (i = 0; i < num; i++) {
                 child->role->drained_end(child);
             }
         }
@@ -2045,7 +2060,12 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
     if (new_bs) {
         QLIST_INSERT_HEAD(&new_bs->parents, child, next_parent);
         if (new_bs->quiesce_counter && child->role->drained_begin) {
-            for (i = 0; i < new_bs->quiesce_counter; i++) {
+            int num = new_bs->quiesce_counter;
+            if (child->role->parent_is_bds) {
+                num -= bdrv_drain_all_count;
+            }
+            assert(num >= 0);
+            for (i = 0; i < num; i++) {
                 child->role->drained_begin(child);
             }
         }
@@ -4049,6 +4069,14 @@ BlockDriverState *bdrv_next_node(BlockDriverState *bs)
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
index 1834a14aa6..ef4fedd364 100644
--- a/block/io.c
+++ b/block/io.c
@@ -38,6 +38,8 @@
 /* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
 
+static AioWait drain_all_aio_wait;
+
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
 
@@ -472,6 +474,29 @@ static void bdrv_drain_assert_idle(BlockDriverState *bs)
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
+    /* bdrv_drain_poll() can't make changes to the graph and we are holding the
+     * main AioContext lock, so iterating bdrv_next_all_states() is safe. */
+    while ((bs = bdrv_next_all_states(bs))) {
+        AioContext *aio_context = bdrv_get_aio_context(bs);
+        aio_context_acquire(aio_context);
+        result |= bdrv_drain_poll(bs, false, NULL, true);
+        aio_context_release(aio_context);
+    }
+
+    return result;
+}
+
 /*
  * Wait for pending requests to complete across all BlockDriverStates
  *
@@ -486,45 +511,51 @@ static void bdrv_drain_assert_idle(BlockDriverState *bs)
  */
 void bdrv_drain_all_begin(void)
 {
-    BlockDriverState *bs;
-    BdrvNextIterator it;
+    BlockDriverState *bs = NULL;
 
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(NULL, true, false, NULL, false, true);
+        bdrv_co_yield_to_drain(NULL, true, false, NULL, true, true);
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
-        bdrv_do_drained_begin(bs, true, NULL, false, true);
+        bdrv_do_drained_begin(bs, false, NULL, true, false);
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
-        bdrv_do_drained_end(bs, true, NULL, false);
+        bdrv_do_drained_end(bs, false, NULL, true);
         aio_context_release(aio_context);
     }
+
+    assert(bdrv_drain_all_count > 0);
+    bdrv_drain_all_count--;
 }
 
 void bdrv_drain_all(void)
@@ -647,6 +678,7 @@ void bdrv_inc_in_flight(BlockDriverState *bs)
 void bdrv_wakeup(BlockDriverState *bs)
 {
     aio_wait_kick(bdrv_get_aio_wait(bs));
+    aio_wait_kick(&drain_all_aio_wait);
 }
 
 void bdrv_dec_in_flight(BlockDriverState *bs)
-- 
2.13.6
