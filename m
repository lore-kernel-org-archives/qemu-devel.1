Received: from eggs.gnu.org ([2001:4830:134:3::10]:41235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6InE-0002nC-VY
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6InD-0004Zz-Lz
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 11 Apr 2018 18:39:31 +0200
Message-Id: <20180411163940.2523-11-kwolf@redhat.com>
In-Reply-To: <20180411163940.2523-1-kwolf@redhat.com>
References: <20180411163940.2523-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 10/19] block: Drain recursively with a single
 BDRV_POLL_WHILE()
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

Anything can happen inside BDRV_POLL_WHILE(), including graph
changes that may interfere with its callers (e.g. child list iteration
in recursive callers of bdrv_do_drained_begin).

Switch to a single BDRV_POLL_WHILE() call for the whole subtree at the
end of bdrv_do_drained_begin() to avoid such effects. The recursion
happens now inside the loop condition. As the graph can only change
between bdrv_drain_poll() calls, but not inside of it, doing the
recursion here is safe.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  2 +-
 block.c               |  2 +-
 block/io.c            | 58 +++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 23dee3c114..91bf3b4e36 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -563,7 +563,7 @@ void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore);
  *
  * Poll for pending requests in @bs. This is part of bdrv_drained_begin.
  */
-bool bdrv_drain_poll(BlockDriverState *bs, bool top_level);
+bool bdrv_drain_poll(BlockDriverState *bs, bool top_level, bool recursive);
 
 /**
  * bdrv_drained_begin:
diff --git a/block.c b/block.c
index 462287bdfb..9fe39ac8c1 100644
--- a/block.c
+++ b/block.c
@@ -823,7 +823,7 @@ static void bdrv_child_cb_drained_begin(BdrvChild *child)
 static bool bdrv_child_cb_drained_poll(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
-    return bdrv_drain_poll(bs, false);
+    return bdrv_drain_poll(bs, false, false);
 }
 
 static void bdrv_child_cb_drained_end(BdrvChild *child)
diff --git a/block/io.c b/block/io.c
index f24f39c278..1287630c58 100644
--- a/block/io.c
+++ b/block/io.c
@@ -161,6 +161,7 @@ typedef struct {
     bool done;
     bool begin;
     bool recursive;
+    bool poll;
     BdrvChild *parent;
 } BdrvCoDrainData;
 
@@ -196,8 +197,10 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 }
 
 /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll() */
-bool bdrv_drain_poll(BlockDriverState *bs, bool top_level)
+bool bdrv_drain_poll(BlockDriverState *bs, bool top_level, bool recursive)
 {
+    BdrvChild *child, *next;
+
     /* Execute pending BHs first and check everything else only after the BHs
      * have executed. */
     if (top_level) {
@@ -208,11 +211,23 @@ bool bdrv_drain_poll(BlockDriverState *bs, bool top_level)
         return true;
     }
 
-    return atomic_read(&bs->in_flight);
+    if (atomic_read(&bs->in_flight)) {
+        return true;
+    }
+
+    if (recursive) {
+        QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
+            if (bdrv_drain_poll(child->bs, false, recursive)) {
+                return true;
+            }
+        }
+    }
+
+    return false;
 }
 
 static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
-                                  BdrvChild *parent);
+                                  BdrvChild *parent, bool poll);
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
                                 BdrvChild *parent);
 
@@ -224,7 +239,7 @@ static void bdrv_co_drain_bh_cb(void *opaque)
 
     bdrv_dec_in_flight(bs);
     if (data->begin) {
-        bdrv_do_drained_begin(bs, data->recursive, data->parent);
+        bdrv_do_drained_begin(bs, data->recursive, data->parent, data->poll);
     } else {
         bdrv_do_drained_end(bs, data->recursive, data->parent);
     }
@@ -235,7 +250,7 @@ static void bdrv_co_drain_bh_cb(void *opaque)
 
 static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
                                                 bool begin, bool recursive,
-                                                BdrvChild *parent)
+                                                BdrvChild *parent, bool poll)
 {
     BdrvCoDrainData data;
 
@@ -250,6 +265,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
         .begin = begin,
         .recursive = recursive,
         .parent = parent,
+        .poll = poll,
     };
     bdrv_inc_in_flight(bs);
     aio_bh_schedule_oneshot(bdrv_get_aio_context(bs),
@@ -262,12 +278,12 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
 }
 
 void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
-                           BdrvChild *parent)
+                           BdrvChild *parent, bool poll)
 {
     BdrvChild *child, *next;
 
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, true, recursive, parent);
+        bdrv_co_yield_to_drain(bs, true, recursive, parent, poll);
         return;
     }
 
@@ -279,25 +295,35 @@ void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
     bdrv_parent_drained_begin(bs, parent);
     bdrv_drain_invoke(bs, true);
 
-    /* Wait for drained requests to finish */
-    BDRV_POLL_WHILE(bs, bdrv_drain_poll(bs, true));
-
     if (recursive) {
         bs->recursive_quiesce_counter++;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
-            bdrv_do_drained_begin(child->bs, true, child);
+            bdrv_do_drained_begin(child->bs, true, child, false);
         }
     }
+
+    /*
+     * Wait for drained requests to finish.
+     *
+     * Calling BDRV_POLL_WHILE() only once for the top-level node is okay: The
+     * call is needed so things in this AioContext can make progress even
+     * though we don't return to the main AioContext loop - this automatically
+     * includes other nodes in the same AioContext and therefore all child
+     * nodes.
+     */
+    if (poll) {
+        BDRV_POLL_WHILE(bs, bdrv_drain_poll(bs, true, recursive));
+    }
 }
 
 void bdrv_drained_begin(BlockDriverState *bs)
 {
-    bdrv_do_drained_begin(bs, false, NULL);
+    bdrv_do_drained_begin(bs, false, NULL, true);
 }
 
 void bdrv_subtree_drained_begin(BlockDriverState *bs)
 {
-    bdrv_do_drained_begin(bs, true, NULL);
+    bdrv_do_drained_begin(bs, true, NULL, true);
 }
 
 void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
@@ -307,7 +333,7 @@ void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
     int old_quiesce_counter;
 
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, false, recursive, parent);
+        bdrv_co_yield_to_drain(bs, false, recursive, parent, false);
         return;
     }
     assert(bs->quiesce_counter > 0);
@@ -343,7 +369,7 @@ void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent)
     int i;
 
     for (i = 0; i < new_parent->recursive_quiesce_counter; i++) {
-        bdrv_do_drained_begin(child->bs, true, child);
+        bdrv_do_drained_begin(child->bs, true, child, true);
     }
 }
 
@@ -413,7 +439,7 @@ void bdrv_drain_all_begin(void)
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
         aio_context_acquire(aio_context);
-        bdrv_do_drained_begin(bs, true, NULL);
+        bdrv_do_drained_begin(bs, true, NULL, true);
         aio_context_release(aio_context);
     }
 
-- 
2.13.6
