Received: from eggs.gnu.org ([2001:4830:134:3::10]:45432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHx-0003Ev-44
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHs-0003DD-7t
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcHr-0003Cw-Uv
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:40 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F944C05AA4E
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:43:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 17:43:16 +0100
Message-Id: <20170120164322.21851-12-pbonzini@redhat.com>
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/17] block: explicitly acquire aiocontext in
 timers that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c                |  2 ++
 block/io.c                  |  5 +++++
 block/iscsi.c               |  8 ++++++--
 block/null.c                |  4 ++++
 block/qed.c                 | 12 ++++++++++++
 block/qed.h                 |  3 +++
 block/throttle-groups.c     |  2 ++
 util/aio-posix.c            |  2 --
 util/aio-win32.c            |  2 --
 util/qemu-coroutine-sleep.c |  2 +-
 10 files changed, 35 insertions(+), 7 deletions(-)

        v1->v2: document restrictions in bdrv_aio_cancel due to qemu_aio_ref
	[Stefan]

diff --git a/block/curl.c b/block/curl.c
index 792fef8..65e6da1 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -424,9 +424,11 @@ static void curl_multi_timeout_do(void *arg)
         return;
     }
 
+    aio_context_acquire(s->aio_context);
     curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
 
     curl_multi_check_completion(s);
+    aio_context_release(s->aio_context);
 #else
     abort();
 #endif
diff --git a/block/io.c b/block/io.c
index 4f9178e..4e7834c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2092,6 +2092,11 @@ void bdrv_aio_cancel(BlockAIOCB *acb)
         if (acb->aiocb_info->get_aio_context) {
             aio_poll(acb->aiocb_info->get_aio_context(acb), true);
         } else if (acb->bs) {
+            /* qemu_aio_ref and qemu_aio_unref are not thread-safe, so
+             * assert that we're not using an I/O thread.  Thread-safe
+             * code should use bdrv_aio_cancel_async exclusively.
+             */
+            assert(bdrv_get_aio_context(acb->bs) == qemu_get_aio_context());
             aio_poll(bdrv_get_aio_context(acb->bs), true);
         } else {
             abort();
diff --git a/block/iscsi.c b/block/iscsi.c
index 6aeeb9e..e1f10d6 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -174,7 +174,7 @@ static void iscsi_retry_timer_expired(void *opaque)
     struct IscsiTask *iTask = opaque;
     iTask->complete = 1;
     if (iTask->co) {
-        qemu_coroutine_enter(iTask->co);
+        aio_co_wake(iTask->co);
     }
 }
 
@@ -1388,16 +1388,20 @@ static void iscsi_nop_timed_event(void *opaque)
 {
     IscsiLun *iscsilun = opaque;
 
+    aio_context_acquire(iscsilun->aio_context);
     if (iscsi_get_nops_in_flight(iscsilun->iscsi) >= MAX_NOP_FAILURES) {
         error_report("iSCSI: NOP timeout. Reconnecting...");
         iscsilun->request_timed_out = true;
     } else if (iscsi_nop_out_async(iscsilun->iscsi, NULL, NULL, 0, NULL) != 0) {
         error_report("iSCSI: failed to sent NOP-Out. Disabling NOP messages.");
-        return;
+        goto out;
     }
 
     timer_mod(iscsilun->nop_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + NOP_INTERVAL);
     iscsi_set_events(iscsilun);
+
+out:
+    aio_context_release(iscsilun->aio_context);
 }
 
 static void iscsi_readcapacity_sync(IscsiLun *iscsilun, Error **errp)
diff --git a/block/null.c b/block/null.c
index b300390..356209a 100644
--- a/block/null.c
+++ b/block/null.c
@@ -141,7 +141,11 @@ static void null_bh_cb(void *opaque)
 static void null_timer_cb(void *opaque)
 {
     NullAIOCB *acb = opaque;
+    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
+
+    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, 0);
+    aio_context_release(ctx);
     timer_deinit(&acb->timer);
     qemu_aio_unref(acb);
 }
diff --git a/block/qed.c b/block/qed.c
index 7f1c508..a21d025 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -345,10 +345,22 @@ static void qed_need_check_timer_cb(void *opaque)
 
     trace_qed_need_check_timer_cb(s);
 
+    qed_acquire(s);
     qed_plug_allocating_write_reqs(s);
 
     /* Ensure writes are on disk before clearing flag */
     bdrv_aio_flush(s->bs->file->bs, qed_clear_need_check, s);
+    qed_release(s);
+}
+
+void qed_acquire(BDRVQEDState *s)
+{
+    aio_context_acquire(bdrv_get_aio_context(s->bs));
+}
+
+void qed_release(BDRVQEDState *s)
+{
+    aio_context_release(bdrv_get_aio_context(s->bs));
 }
 
 static void qed_start_need_check_timer(BDRVQEDState *s)
diff --git a/block/qed.h b/block/qed.h
index 9676ab9..ce8c314 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -198,6 +198,9 @@ enum {
  */
 typedef void QEDFindClusterFunc(void *opaque, int ret, uint64_t offset, size_t len);
 
+void qed_acquire(BDRVQEDState *s);
+void qed_release(BDRVQEDState *s);
+
 /**
  * Generic callback for chaining async callbacks
  */
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 17b2efb..aade5de 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -416,7 +416,9 @@ static void timer_cb(BlockBackend *blk, bool is_write)
     qemu_mutex_unlock(&tg->lock);
 
     /* Run the request that was waiting for this timer */
+    aio_context_acquire(blk_get_aio_context(blk));
     empty_queue = !qemu_co_enter_next(&blkp->throttled_reqs[is_write]);
+    aio_context_release(blk_get_aio_context(blk));
 
     /* If the request queue was empty then we have to take care of
      * scheduling the next one */
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 3fd64fb..8d79cf3 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -454,9 +454,7 @@ bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
     }
 
     /* Run our timers */
-    aio_context_acquire(ctx);
     progress |= timerlistgroup_run_timers(&ctx->tlg);
-    aio_context_release(ctx);
 
     return progress;
 }
diff --git a/util/aio-win32.c b/util/aio-win32.c
index ab6d0e5..810e1c6 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -403,9 +403,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
         progress |= aio_dispatch_handlers(ctx, event);
     } while (count > 0);
 
-    aio_context_acquire(ctx);
     progress |= timerlistgroup_run_timers(&ctx->tlg);
-    aio_context_release(ctx);
     return progress;
 }
 
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 25de3ed..9c56550 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -25,7 +25,7 @@ static void co_sleep_cb(void *opaque)
 {
     CoSleepCB *sleep_cb = opaque;
 
-    qemu_coroutine_enter(sleep_cb->co);
+    aio_co_wake(sleep_cb->co);
 }
 
 void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
-- 
2.9.3
