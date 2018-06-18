Received: from eggs.gnu.org ([2001:4830:134:3::10]:51730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHL-0004lF-CG
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHK-0006Dq-F1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:35 +0200
Message-Id: <20180618164504.24488-7-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/35] block: Avoid unnecessary aio_poll() in
 AIO_WAIT_WHILE()
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

Commit 91af091f923 added an additional aio_poll() to BDRV_POLL_WHILE()
in order to make sure that all pending BHs are executed on drain. This
was the wrong place to make the fix, as it is useless overhead for all
other users of the macro and unnecessarily complicates the mechanism.

This patch effectively reverts said commit (the context has changed a
bit and the code has moved to AIO_WAIT_WHILE()) and instead polls in the
loop condition for drain.

The effect is probably hard to measure in any real-world use case
because actual I/O will dominate, but if I run only the initialisation
part of 'qemu-img convert' where it calls bdrv_block_status() for the
whole image to find out how much data there is copy, this phase actually
needs only roughly half the time after this patch.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio-wait.h | 22 ++++++++--------------
 block/io.c               | 11 ++++++++++-
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
index 8c90a2e66e..783d3678dd 100644
--- a/include/block/aio-wait.h
+++ b/include/block/aio-wait.h
@@ -73,29 +73,23 @@ typedef struct {
  */
 #define AIO_WAIT_WHILE(wait, ctx, cond) ({                         \
     bool waited_ = false;                                          \
-    bool busy_ = true;                                             \
     AioWait *wait_ = (wait);                                       \
     AioContext *ctx_ = (ctx);                                      \
     if (in_aio_context_home_thread(ctx_)) {                        \
-        while ((cond) || busy_) {                                  \
-            busy_ = aio_poll(ctx_, (cond));                        \
-            waited_ |= !!(cond) | busy_;                           \
+        while ((cond)) {                                           \
+            aio_poll(ctx_, true);                                  \
+            waited_ = true;                                        \
         }                                                          \
     } else {                                                       \
         assert(qemu_get_current_aio_context() ==                   \
                qemu_get_aio_context());                            \
         /* Increment wait_->num_waiters before evaluating cond. */ \
         atomic_inc(&wait_->num_waiters);                           \
-        while (busy_) {                                            \
-            if ((cond)) {                                          \
-                waited_ = busy_ = true;                            \
-                aio_context_release(ctx_);                         \
-                aio_poll(qemu_get_aio_context(), true);            \
-                aio_context_acquire(ctx_);                         \
-            } else {                                               \
-                busy_ = aio_poll(ctx_, false);                     \
-                waited_ |= busy_;                                  \
-            }                                                      \
+        while ((cond)) {                                           \
+            aio_context_release(ctx_);                             \
+            aio_poll(qemu_get_aio_context(), true);                \
+            aio_context_acquire(ctx_);                             \
+            waited_ = true;                                        \
         }                                                          \
         atomic_dec(&wait_->num_waiters);                           \
     }                                                              \
diff --git a/block/io.c b/block/io.c
index 983307cf03..bc7a2d78b8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -182,13 +182,22 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
     BDRV_POLL_WHILE(bs, !data.done);
 }
 
+/* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll() */
+static bool bdrv_drain_poll(BlockDriverState *bs)
+{
+    /* Execute pending BHs first and check everything else only after the BHs
+     * have executed. */
+    while (aio_poll(bs->aio_context, false));
+    return atomic_read(&bs->in_flight);
+}
+
 static bool bdrv_drain_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *tmp;
     bool waited;
 
     /* Wait for drained requests to finish */
-    waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
+    waited = BDRV_POLL_WHILE(bs, bdrv_drain_poll(bs));
 
     QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
         BlockDriverState *bs = child->bs;
-- 
2.13.6
