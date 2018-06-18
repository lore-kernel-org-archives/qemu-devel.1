Received: from eggs.gnu.org ([2001:4830:134:3::10]:51702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHK-0004jS-Bl
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHI-0006CX-Nl
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:33 +0200
Message-Id: <20180618164504.24488-5-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/35] block: Don't manually poll in
 bdrv_drain_all()
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

All involved nodes are already idle, we called bdrv_do_drain_begin() on
them.

The comment in the code suggested that this was not correct because the
completion of a request on one node could spawn a new request on a
different node (which might have been drained before, so we wouldn't
drain the new request). In reality, new requests to different nodes
aren't spawned out of nothing, but only in the context of a parent
request, and they aren't submitted to random nodes, but only to child
nodes. As long as we still poll for the completion of the parent request
(which we do), draining each root node separately is good enough.

Remove the additional polling code from bdrv_drain_all_begin() and
replace it with an assertion that all nodes are already idle after we
drained them separately.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/block/io.c b/block/io.c
index b75d68886a..983307cf03 100644
--- a/block/io.c
+++ b/block/io.c
@@ -377,6 +377,16 @@ void bdrv_drain(BlockDriverState *bs)
     bdrv_drained_end(bs);
 }
 
+static void bdrv_drain_assert_idle(BlockDriverState *bs)
+{
+    BdrvChild *child, *next;
+
+    assert(atomic_read(&bs->in_flight) == 0);
+    QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
+        bdrv_drain_assert_idle(child->bs);
+    }
+}
+
 /*
  * Wait for pending requests to complete across all BlockDriverStates
  *
@@ -391,11 +401,8 @@ void bdrv_drain(BlockDriverState *bs)
  */
 void bdrv_drain_all_begin(void)
 {
-    /* Always run first iteration so any pending completion BHs run */
-    bool waited = true;
     BlockDriverState *bs;
     BdrvNextIterator it;
-    GSList *aio_ctxs = NULL, *ctx;
 
     /* BDRV_POLL_WHILE() for a node can only be called from its own I/O thread
      * or the main loop AioContext. We potentially use BDRV_POLL_WHILE() on
@@ -409,35 +416,11 @@ void bdrv_drain_all_begin(void)
         aio_context_acquire(aio_context);
         bdrv_do_drained_begin(bs, true, NULL);
         aio_context_release(aio_context);
-
-        if (!g_slist_find(aio_ctxs, aio_context)) {
-            aio_ctxs = g_slist_prepend(aio_ctxs, aio_context);
-        }
     }
 
-    /* Note that completion of an asynchronous I/O operation can trigger any
-     * number of other I/O operations on other devices---for example a
-     * coroutine can submit an I/O request to another device in response to
-     * request completion.  Therefore we must keep looping until there was no
-     * more activity rather than simply draining each device independently.
-     */
-    while (waited) {
-        waited = false;
-
-        for (ctx = aio_ctxs; ctx != NULL; ctx = ctx->next) {
-            AioContext *aio_context = ctx->data;
-
-            aio_context_acquire(aio_context);
-            for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-                if (aio_context == bdrv_get_aio_context(bs)) {
-                    waited |= bdrv_drain_recurse(bs);
-                }
-            }
-            aio_context_release(aio_context);
-        }
+    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+        bdrv_drain_assert_idle(bs);
     }
-
-    g_slist_free(aio_ctxs);
 }
 
 void bdrv_drain_all_end(void)
-- 
2.13.6
