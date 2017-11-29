Received: from eggs.gnu.org ([2001:4830:134:3::10]:41632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3ia-0006KV-PK
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3iZ-0006M8-Qg
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:08 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:54 +0800
Message-Id: <20171129144956.11409-8-famz@redhat.com>
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
References: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 7/9] block: Switch to use AIO drained
 begin/end API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Instead of the recursion of the "disable/enable external requests"
operations on the graph, we switch to AioContext's API to disable/enable
on the whole AioContext altogether. Strictly it is be a bit more than
necessary, but as all drained sections are short, it is not a big
problem.

Drained end can just get away with that.  The other half of drained
begin is to wait for requests, which we can do with BDRV_POLL_WHILE() in
a loop.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 116 ++++++-------------------------------------------------------
 1 file changed, 10 insertions(+), 106 deletions(-)

diff --git a/block/io.c b/block/io.c
index 7f07972489..914037b21a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -40,28 +40,6 @@
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
 
-void bdrv_parent_drained_begin(BlockDriverState *bs)
-{
-    BdrvChild *c;
-
-    QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role->drained_begin) {
-            c->role->drained_begin(c);
-        }
-    }
-}
-
-void bdrv_parent_drained_end(BlockDriverState *bs)
-{
-    BdrvChild *c;
-
-    QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role->drained_end) {
-            c->role->drained_end(c);
-        }
-    }
-}
-
 static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
 {
     dst->opt_transfer = MAX(dst->opt_transfer, src->opt_transfer);
@@ -141,71 +119,6 @@ typedef struct {
     bool begin;
 } BdrvCoDrainData;
 
-static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
-{
-    BdrvCoDrainData *data = opaque;
-    BlockDriverState *bs = data->bs;
-
-    if (data->begin) {
-        bs->drv->bdrv_co_drain_begin(bs);
-    } else {
-        bs->drv->bdrv_co_drain_end(bs);
-    }
-
-    /* Set data->done before reading bs->wakeup.  */
-    atomic_mb_set(&data->done, true);
-    bdrv_wakeup(bs);
-}
-
-static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
-{
-    BdrvCoDrainData data = { .bs = bs, .done = false, .begin = begin};
-
-    if (!bs->drv || (begin && !bs->drv->bdrv_co_drain_begin) ||
-            (!begin && !bs->drv->bdrv_co_drain_end)) {
-        return;
-    }
-
-    data.co = qemu_coroutine_create(bdrv_drain_invoke_entry, &data);
-    bdrv_coroutine_enter(bs, data.co);
-    BDRV_POLL_WHILE(bs, !data.done);
-}
-
-static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
-{
-    BdrvChild *child, *tmp;
-    bool waited;
-
-    /* Ensure any pending metadata writes are submitted to bs->file.  */
-    bdrv_drain_invoke(bs, begin);
-
-    /* Wait for drained requests to finish */
-    waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
-
-    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
-        BlockDriverState *bs = child->bs;
-        bool in_main_loop =
-            qemu_get_current_aio_context() == qemu_get_aio_context();
-        assert(bs->refcnt > 0);
-        if (in_main_loop) {
-            /* In case the recursive bdrv_drain_recurse processes a
-             * block_job_defer_to_main_loop BH and modifies the graph,
-             * let's hold a reference to bs until we are done.
-             *
-             * IOThread doesn't have such a BH, and it is not safe to call
-             * bdrv_unref without BQL, so skip doing it there.
-             */
-            bdrv_ref(bs);
-        }
-        waited |= bdrv_drain_recurse(bs, begin);
-        if (in_main_loop) {
-            bdrv_unref(bs);
-        }
-    }
-
-    return waited;
-}
-
 static void bdrv_co_drain_bh_cb(void *opaque)
 {
     BdrvCoDrainData *data = opaque;
@@ -256,12 +169,13 @@ void bdrv_drained_begin(BlockDriverState *bs)
         return;
     }
 
-    if (atomic_fetch_inc(&bs->quiesce_counter) == 0) {
-        aio_disable_external(bdrv_get_aio_context(bs));
-        bdrv_parent_drained_begin(bs);
+    if (atomic_fetch_inc(&bs->quiesce_counter) > 0) {
+        return;
+    }
+    aio_context_drained_begin(bdrv_get_aio_context(bs));
+    while (BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0)) {
+        /* Loop until no progress is made. */
     }
-
-    bdrv_drain_recurse(bs, true);
 }
 
 void bdrv_drained_end(BlockDriverState *bs)
@@ -275,9 +189,7 @@ void bdrv_drained_end(BlockDriverState *bs)
         return;
     }
 
-    bdrv_parent_drained_end(bs);
-    bdrv_drain_recurse(bs, false);
-    aio_enable_external(bdrv_get_aio_context(bs));
+    aio_context_drained_end(bdrv_get_aio_context(bs));
 }
 
 /*
@@ -324,14 +236,11 @@ void bdrv_drain_all_begin(void)
     BdrvNextIterator it;
     GSList *aio_ctxs = NULL, *ctx;
 
-    block_job_pause_all();
-
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
         aio_context_acquire(aio_context);
-        bdrv_parent_drained_begin(bs);
-        aio_disable_external(aio_context);
+        aio_context_drained_begin(aio_context);
         aio_context_release(aio_context);
 
         if (!g_slist_find(aio_ctxs, aio_context)) {
@@ -347,14 +256,13 @@ void bdrv_drain_all_begin(void)
      */
     while (waited) {
         waited = false;
-
         for (ctx = aio_ctxs; ctx != NULL; ctx = ctx->next) {
             AioContext *aio_context = ctx->data;
 
             aio_context_acquire(aio_context);
             for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
                 if (aio_context == bdrv_get_aio_context(bs)) {
-                    waited |= bdrv_drain_recurse(bs, true);
+                    waited |= BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
                 }
             }
             aio_context_release(aio_context);
@@ -373,13 +281,9 @@ void bdrv_drain_all_end(void)
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
         aio_context_acquire(aio_context);
-        aio_enable_external(aio_context);
-        bdrv_parent_drained_end(bs);
-        bdrv_drain_recurse(bs, false);
+        aio_context_drained_end(aio_context);
         aio_context_release(aio_context);
     }
-
-    block_job_resume_all();
 }
 
 void bdrv_drain_all(void)
-- 
2.14.3
