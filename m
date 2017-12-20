Received: from eggs.gnu.org ([2001:4830:134:3::10]:39660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbjC-0004t7-3M
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbj8-0005Jm-8v
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:35:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 11:34:04 +0100
Message-Id: <20171220103412.13048-12-kwolf@redhat.com>
In-Reply-To: <20171220103412.13048-1-kwolf@redhat.com>
References: <20171220103412.13048-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 11/19] block: Don't notify parents in drain
 call chain
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

This is in preparation for subtree drains, i.e. drained sections that
affect not only a single node, but recursively all child nodes, too.

Calling the parent callbacks for drain is pointless when we just came
from that parent node recursively and leads to multiple increases of
bs->quiesce_counter in a single drain call. Don't do it.

In order for this to work correctly, the parent callback must be called
for every bdrv_drain_begin/end() call, not only for the outermost one:

If we have a node N with two parents A and B, recursive draining of A
should cause the quiesce_counter of B to increased because its child N
is drained independently of B. If now B is recursively drained, too, A
must increase its quiesce_counter because N is drained independently of
A only now, even if N is going from quiesce_counter 1 to 2.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  4 ++--
 block.c               | 13 +++++++++----
 block/io.c            | 47 ++++++++++++++++++++++++++++++++++-------------
 3 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index c05cac57e5..60c5d11029 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -585,7 +585,7 @@ void bdrv_io_unplug(BlockDriverState *bs);
  * Begin a quiesced section of all users of @bs. This is part of
  * bdrv_drained_begin.
  */
-void bdrv_parent_drained_begin(BlockDriverState *bs);
+void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore);
 
 /**
  * bdrv_parent_drained_end:
@@ -593,7 +593,7 @@ void bdrv_parent_drained_begin(BlockDriverState *bs);
  * End a quiesced section of all users of @bs. This is part of
  * bdrv_drained_end.
  */
-void bdrv_parent_drained_end(BlockDriverState *bs);
+void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore);
 
 /**
  * bdrv_drained_begin:
diff --git a/block.c b/block.c
index ddb6836c52..5867a2a2a0 100644
--- a/block.c
+++ b/block.c
@@ -1972,13 +1972,16 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
                                       BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs = child->bs;
+    int i;
 
     if (old_bs && new_bs) {
         assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
     }
     if (old_bs) {
         if (old_bs->quiesce_counter && child->role->drained_end) {
-            child->role->drained_end(child);
+            for (i = 0; i < old_bs->quiesce_counter; i++) {
+                child->role->drained_end(child);
+            }
         }
         if (child->role->detach) {
             child->role->detach(child);
@@ -1991,7 +1994,9 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
     if (new_bs) {
         QLIST_INSERT_HEAD(&new_bs->parents, child, next_parent);
         if (new_bs->quiesce_counter && child->role->drained_begin) {
-            child->role->drained_begin(child);
+            for (i = 0; i < new_bs->quiesce_counter; i++) {
+                child->role->drained_begin(child);
+            }
         }
 
         if (child->role->attach) {
@@ -4750,7 +4755,7 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
     AioContext *ctx = bdrv_get_aio_context(bs);
 
     aio_disable_external(ctx);
-    bdrv_parent_drained_begin(bs);
+    bdrv_parent_drained_begin(bs, NULL);
     bdrv_drain(bs); /* ensure there are no in-flight requests */
 
     while (aio_poll(ctx, false)) {
@@ -4764,7 +4769,7 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
      */
     aio_context_acquire(new_context);
     bdrv_attach_aio_context(bs, new_context);
-    bdrv_parent_drained_end(bs);
+    bdrv_parent_drained_end(bs, NULL);
     aio_enable_external(ctx);
     aio_context_release(new_context);
 }
diff --git a/block/io.c b/block/io.c
index 6038a16c58..09de0a9070 100644
--- a/block/io.c
+++ b/block/io.c
@@ -40,22 +40,28 @@
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
 
-void bdrv_parent_drained_begin(BlockDriverState *bs)
+void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore)
 {
     BdrvChild *c, *next;
 
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
+        if (c == ignore) {
+            continue;
+        }
         if (c->role->drained_begin) {
             c->role->drained_begin(c);
         }
     }
 }
 
-void bdrv_parent_drained_end(BlockDriverState *bs)
+void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore)
 {
     BdrvChild *c, *next;
 
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
+        if (c == ignore) {
+            continue;
+        }
         if (c->role->drained_end) {
             c->role->drained_end(c);
         }
@@ -139,6 +145,7 @@ typedef struct {
     BlockDriverState *bs;
     bool done;
     bool begin;
+    BdrvChild *parent;
 } BdrvCoDrainData;
 
 static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
@@ -211,6 +218,9 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
     return waited;
 }
 
+static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent);
+static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent);
+
 static void bdrv_co_drain_bh_cb(void *opaque)
 {
     BdrvCoDrainData *data = opaque;
@@ -219,9 +229,9 @@ static void bdrv_co_drain_bh_cb(void *opaque)
 
     bdrv_dec_in_flight(bs);
     if (data->begin) {
-        bdrv_drained_begin(bs);
+        bdrv_do_drained_begin(bs, data->parent);
     } else {
-        bdrv_drained_end(bs);
+        bdrv_do_drained_end(bs, data->parent);
     }
 
     data->done = true;
@@ -229,7 +239,7 @@ static void bdrv_co_drain_bh_cb(void *opaque)
 }
 
 static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
-                                                bool begin)
+                                                bool begin, BdrvChild *parent)
 {
     BdrvCoDrainData data;
 
@@ -243,6 +253,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
         .bs = bs,
         .done = false,
         .begin = begin,
+        .parent = parent,
     };
     bdrv_inc_in_flight(bs);
     aio_bh_schedule_oneshot(bdrv_get_aio_context(bs),
@@ -254,29 +265,34 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     assert(data.done);
 }
 
-void bdrv_drained_begin(BlockDriverState *bs)
+static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent)
 {
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, true);
+        bdrv_co_yield_to_drain(bs, true, parent);
         return;
     }
 
     /* Stop things in parent-to-child order */
     if (atomic_fetch_inc(&bs->quiesce_counter) == 0) {
         aio_disable_external(bdrv_get_aio_context(bs));
-        bdrv_parent_drained_begin(bs);
     }
 
+    bdrv_parent_drained_begin(bs, parent);
     bdrv_drain_invoke(bs, true, false);
     bdrv_drain_recurse(bs);
 }
 
-void bdrv_drained_end(BlockDriverState *bs)
+void bdrv_drained_begin(BlockDriverState *bs)
+{
+    bdrv_do_drained_begin(bs, NULL);
+}
+
+static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
 {
     int old_quiesce_counter;
 
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, false);
+        bdrv_co_yield_to_drain(bs, false, parent);
         return;
     }
     assert(bs->quiesce_counter > 0);
@@ -284,12 +300,17 @@ void bdrv_drained_end(BlockDriverState *bs)
 
     /* Re-enable things in child-to-parent order */
     bdrv_drain_invoke(bs, false, false);
+    bdrv_parent_drained_end(bs, parent);
     if (old_quiesce_counter == 1) {
-        bdrv_parent_drained_end(bs);
         aio_enable_external(bdrv_get_aio_context(bs));
     }
 }
 
+void bdrv_drained_end(BlockDriverState *bs)
+{
+    bdrv_do_drained_end(bs, NULL);
+}
+
 /*
  * Wait for pending requests to complete on a single BlockDriverState subtree,
  * and suspend block driver's internal I/O until next request arrives.
@@ -346,7 +367,7 @@ void bdrv_drain_all_begin(void)
         /* Stop things in parent-to-child order */
         aio_context_acquire(aio_context);
         aio_disable_external(aio_context);
-        bdrv_parent_drained_begin(bs);
+        bdrv_parent_drained_begin(bs, NULL);
         bdrv_drain_invoke(bs, true, true);
         aio_context_release(aio_context);
 
@@ -391,7 +412,7 @@ void bdrv_drain_all_end(void)
         /* Re-enable things in child-to-parent order */
         aio_context_acquire(aio_context);
         bdrv_drain_invoke(bs, false, true);
-        bdrv_parent_drained_end(bs);
+        bdrv_parent_drained_end(bs, NULL);
         aio_enable_external(aio_context);
         aio_context_release(aio_context);
     }
-- 
2.13.6
