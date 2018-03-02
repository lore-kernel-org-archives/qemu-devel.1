Received: from eggs.gnu.org ([2001:4830:134:3::10]:52986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqZ-0001hi-5W
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqX-000383-Ul
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:59 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:37 +0100
Message-Id: <20180302185448.6314-27-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/37] aio: rename aio_context_in_iothread() to
 in_aio_context_home_thread()
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The name aio_context_in_iothread() is misleading because it also returns
true when called on the main AioContext from the main loop thread, which
is not an IOThread.

This patch renames it to in_aio_context_home_thread() and expands the
doc comment to make the semantics clearer.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h   | 7 +++++--
 include/block/block.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index e9aeeaec94..a1d6b9e249 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -534,11 +534,14 @@ void aio_co_enter(AioContext *ctx, struct Coroutine *co);
 AioContext *qemu_get_current_aio_context(void);
 
 /**
+ * in_aio_context_home_thread:
  * @ctx: the aio context
  *
- * Return whether we are running in the I/O thread that manages @ctx.
+ * Return whether we are running in the thread that normally runs @ctx.  Note
+ * that acquiring/releasing ctx does not affect the outcome, each AioContext
+ * still only has one home thread that is responsible for running it.
  */
-static inline bool aio_context_in_iothread(AioContext *ctx)
+static inline bool in_aio_context_home_thread(AioContext *ctx)
 {
     return ctx == qemu_get_current_aio_context();
 }
diff --git a/include/block/block.h b/include/block/block.h
index 947e8876cd..bc41ed253b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -372,7 +372,7 @@ void bdrv_drain_all(void);
     bool busy_ = true;                                     \
     BlockDriverState *bs_ = (bs);                          \
     AioContext *ctx_ = bdrv_get_aio_context(bs_);          \
-    if (aio_context_in_iothread(ctx_)) {                   \
+    if (in_aio_context_home_thread(ctx_)) {                \
         while ((cond) || busy_) {                          \
             busy_ = aio_poll(ctx_, (cond));                \
             waited_ |= !!(cond) | busy_;                   \
-- 
2.13.6
