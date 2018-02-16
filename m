Received: from eggs.gnu.org ([2001:4830:134:3::10]:59176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emjDX-0002fe-G6
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emjDU-0001KA-JL
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:50:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40152 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1emjDU-0001J6-9t
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:50:32 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 16 Feb 2018 16:50:11 +0000
Message-Id: <20180216165015.30715-2-stefanha@redhat.com>
In-Reply-To: <20180216165015.30715-1-stefanha@redhat.com>
References: <20180216165015.30715-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/5] aio: rename aio_context_in_iothread()
 to in_aio_context_home_thread()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, mark.kanda@oracle.com, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The name aio_context_in_iothread() is misleading because it also return
true when called on the main AioContext from the main loop thread, which
is not an IOThread.

This patch renames it to in_aio_context_home_thread() and expands the
doc comment to make the semantics clearer.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h   | 7 +++++--
 include/block/block.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index e9aeeaec94..fc14a2acda 100644
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
+ * still only has a one home thread that is responsible for running it.
  */
-static inline bool aio_context_in_iothread(AioContext *ctx)
+static inline bool in_aio_context_home_thread(AioContext *ctx)
 {
     return ctx == qemu_get_current_aio_context();
 }
diff --git a/include/block/block.h b/include/block/block.h
index 19b3ab9cb5..d559419722 100644
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
2.14.3
