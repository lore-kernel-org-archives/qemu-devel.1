Received: from eggs.gnu.org ([2001:4830:134:3::10]:56796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6D-0005Il-K1
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6C-0001ti-ET
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:01 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:14 +0100
Message-Id: <20171222151846.28110-4-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 03/35] block: Make bdrv_drain_invoke()
 recursive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

This change separates bdrv_drain_invoke(), which calls the BlockDriver
drain callbacks, from bdrv_drain_recurse(). Instead, the function
performs its own recursion now.

One reason for this is that bdrv_drain_recurse() can be called multiple
times by bdrv_drain_all_begin(), but the callbacks may only be called
once. The separation is necessary to fix this bug.

The other reason is that we intend to go to a model where we call all
driver callbacks first, and only then start polling. This is not fully
achieved yet with this patch, as bdrv_drain_invoke() contains a
BDRV_POLL_WHILE() loop for the block driver callbacks, which can still
call callbacks for any unrelated event. It's a step in this direction
anyway.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 6773926fc1..096468b761 100644
--- a/block/io.c
+++ b/block/io.c
@@ -175,8 +175,10 @@ static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
     bdrv_wakeup(bs);
 }
 
+/* Recursively call BlockDriver.bdrv_co_drain_begin/end callbacks */
 static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 {
+    BdrvChild *child, *tmp;
     BdrvCoDrainData data = { .bs = bs, .done = false, .begin = begin};
 
     if (!bs->drv || (begin && !bs->drv->bdrv_co_drain_begin) ||
@@ -187,6 +189,10 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
     data.co = qemu_coroutine_create(bdrv_drain_invoke_entry, &data);
     bdrv_coroutine_enter(bs, data.co);
     BDRV_POLL_WHILE(bs, !data.done);
+
+    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
+        bdrv_drain_invoke(child->bs, begin);
+    }
 }
 
 static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
@@ -194,9 +200,6 @@ static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
     BdrvChild *child, *tmp;
     bool waited;
 
-    /* Ensure any pending metadata writes are submitted to bs->file.  */
-    bdrv_drain_invoke(bs, begin);
-
     /* Wait for drained requests to finish */
     waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
 
@@ -279,6 +282,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
         bdrv_parent_drained_begin(bs);
     }
 
+    bdrv_drain_invoke(bs, true);
     bdrv_drain_recurse(bs, true);
 }
 
@@ -294,6 +298,7 @@ void bdrv_drained_end(BlockDriverState *bs)
     }
 
     bdrv_parent_drained_end(bs);
+    bdrv_drain_invoke(bs, false);
     bdrv_drain_recurse(bs, false);
     aio_enable_external(bdrv_get_aio_context(bs));
 }
@@ -372,6 +377,8 @@ void bdrv_drain_all_begin(void)
             aio_context_acquire(aio_context);
             for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
                 if (aio_context == bdrv_get_aio_context(bs)) {
+                    /* FIXME Calling this multiple times is wrong */
+                    bdrv_drain_invoke(bs, true);
                     waited |= bdrv_drain_recurse(bs, true);
                 }
             }
@@ -393,6 +400,7 @@ void bdrv_drain_all_end(void)
         aio_context_acquire(aio_context);
         aio_enable_external(aio_context);
         bdrv_parent_drained_end(bs);
+        bdrv_drain_invoke(bs, false);
         bdrv_drain_recurse(bs, false);
         aio_context_release(aio_context);
     }
-- 
2.13.6
