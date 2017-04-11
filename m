Received: from eggs.gnu.org ([2001:4830:134:3::10]:49841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxtkP-00030v-G5
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxtkO-0006Hl-GA
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:14:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 11 Apr 2017 13:13:53 +0200
Message-Id: <1491909233-24890-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <20170410150542.30376-1-famz@redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.9 v3 11/10] block,
 async: Remove unused *_enter_if_inactive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, eswierk@skyportsystems.com, famz@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c               | 5 -----
 include/block/aio.h   | 9 ---------
 include/block/block.h | 6 ------
 util/async.c          | 7 -------
 4 files changed, 27 deletions(-)

diff --git a/block.c b/block.c
index e65b906..086a12d 100644
--- a/block.c
+++ b/block.c
@@ -4329,11 +4329,6 @@ void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
     aio_co_enter(bdrv_get_aio_context(bs), co);
 }
 
-void bdrv_coroutine_enter_if_inactive(BlockDriverState *bs, Coroutine *co)
-{
-    aio_co_enter_if_inactive(bdrv_get_aio_context(bs), co);
-}
-
 static void bdrv_do_remove_aio_context_notifier(BdrvAioNotifier *ban)
 {
     QLIST_REMOVE(ban, list);
diff --git a/include/block/aio.h b/include/block/aio.h
index b0a6bb3..406e323 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -520,15 +520,6 @@ void aio_co_wake(struct Coroutine *co);
 void aio_co_enter(AioContext *ctx, struct Coroutine *co);
 
 /**
- * aio_co_enter_if_inactive:
- * @ctx: the context to run the coroutine
- * @co: the coroutine to run
- *
- * Enter a coroutine in the specified AioContext, if it's not already entered.
- */
-void aio_co_enter_if_inactive(AioContext *ctx, struct Coroutine *co);
-
-/**
  * Return the AioContext whose event loop runs in the current thread.
  *
  * If called from an IOThread this will be the IOThread's AioContext.  If
diff --git a/include/block/block.h b/include/block/block.h
index dd9416e..97d4330 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -563,12 +563,6 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs);
 void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co);
 
 /**
- * Transfer control to @co in the aio context of @bs if it's not active (i.e.
- * part of the call stack of the running coroutine). Otherwise, do nothing.
- */
-void bdrv_coroutine_enter_if_inactive(BlockDriverState *bs, Coroutine *co);
-
-/**
  * bdrv_set_aio_context:
  *
  * Changes the #AioContext used for fd handlers, timers, and BHs by this
diff --git a/util/async.c b/util/async.c
index 507671a..355af73 100644
--- a/util/async.c
+++ b/util/async.c
@@ -474,13 +474,6 @@ void aio_co_enter(AioContext *ctx, struct Coroutine *co)
     }
 }
 
-void aio_co_enter_if_inactive(AioContext *ctx, struct Coroutine *co)
-{
-    if (!qemu_coroutine_entered(co)) {
-        aio_co_enter(ctx, co);
-    }
-}
-
 void aio_context_ref(AioContext *ctx)
 {
     g_source_ref(&ctx->source);
-- 
1.8.3.1
