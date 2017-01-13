Received: from eggs.gnu.org ([2001:4830:134:3::10]:41190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jp-0007dI-0i
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jk-0002ZF-Vt
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:49 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cS1jk-0002YA-MA
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:44 -0500
Received: by mail-wm0-x244.google.com with SMTP id l2so11689502wml.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:17:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Jan 2017 14:17:25 +0100
Message-Id: <20170113131731.1246-11-pbonzini@redhat.com>
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/16] block: explicitly acquire aiocontext in
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
Cc: famz@redhat.com, stefanha@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 aio-posix.c                 |  2 --
 aio-win32.c                 |  2 --
 block/curl.c                |  2 ++
 block/iscsi.c               |  8 ++++++--
 block/null.c                |  4 ++++
 block/qed.c                 | 12 ++++++++++++
 block/qed.h                 |  3 +++
 block/throttle-groups.c     |  2 ++
 util/qemu-coroutine-sleep.c |  2 +-
 9 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/aio-posix.c b/aio-posix.c
index 3fd64fb..8d79cf3 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -454,9 +454,7 @@ bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
     }
 
     /* Run our timers */
-    aio_context_acquire(ctx);
     progress |= timerlistgroup_run_timers(&ctx->tlg);
-    aio_context_release(ctx);
 
     return progress;
 }
diff --git a/aio-win32.c b/aio-win32.c
index ab6d0e5..810e1c6 100644
--- a/aio-win32.c
+++ b/aio-win32.c
@@ -403,9 +403,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
         progress |= aio_dispatch_handlers(ctx, event);
     } while (count > 0);
 
-    aio_context_acquire(ctx);
     progress |= timerlistgroup_run_timers(&ctx->tlg);
-    aio_context_release(ctx);
     return progress;
 }
 
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
