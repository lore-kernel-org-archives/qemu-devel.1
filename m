Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD76DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DD422DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DD422DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0TsP-0002at-O9
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0TqU-0007mj-D9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0TqS-0004Q6-OY
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:52:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:53184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i0TqP-0004AP-4z; Wed, 21 Aug 2019 12:52:21 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i0TqK-0003Ry-QB; Wed, 21 Aug 2019 19:52:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed, 21 Aug 2019 19:52:13 +0300
Message-Id: <20190821165215.61406-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190821165215.61406-1-vsementsov@virtuozzo.com>
References: <20190821165215.61406-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v8 1/3] qemu-coroutine-sleep: introduce
 qemu_co_sleep_wake
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 sheepdog@lists.wpkg.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, namei.unix@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a function to gracefully wake a coroutine sleeping in
qemu_co_sleep_ns().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/coroutine.h    | 17 ++++++++++++--
 block/null.c                |  2 +-
 block/sheepdog.c            |  2 +-
 tests/test-bdrv-drain.c     |  6 ++---
 tests/test-block-iothread.c |  2 +-
 util/qemu-coroutine-sleep.c | 47 +++++++++++++++++++++++++++----------
 6 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9801e7f5a4..96780a4902 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -274,9 +274,22 @@ void qemu_co_rwlock_wrlock(CoRwlock *lock);
 void qemu_co_rwlock_unlock(CoRwlock *lock);
 
 /**
- * Yield the coroutine for a given duration
+ * Yield the coroutine for a given duration. During this yield @sleep_state (if
+ * not NULL) is set to opaque pointer, which may be used for
+ * qemu_co_sleep_wake(). Be careful, the pointer is set back to zero when timer
+ * shoots. Don't save obtained value to other variables and don't call
+ * qemu_co_sleep_wake from another aio context.
  */
-void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
+void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns,
+                                   void **sleep_state);
+
+/**
+ * Wake a coroutine if it is sleeping by qemu_co_sleep_ns. Timer will be
+ * deleted. @sleep_state must be the variable which address was given to
+ * qemu_co_sleep_ns() and should be checked to be non-NULL before calling
+ * qemu_co_sleep_wake().
+ */
+void qemu_co_sleep_wake(void *sleep_state);
 
 /**
  * Yield until a file descriptor becomes readable
diff --git a/block/null.c b/block/null.c
index 699aa295cb..1e3f26b07e 100644
--- a/block/null.c
+++ b/block/null.c
@@ -109,7 +109,7 @@ static coroutine_fn int null_co_common(BlockDriverState *bs)
     BDRVNullState *s = bs->opaque;
 
     if (s->latency_ns) {
-        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, s->latency_ns);
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, s->latency_ns, NULL);
     }
     return 0;
 }
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 773dfc6ab1..3a7ef2f209 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -743,7 +743,7 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
         if (s->fd < 0) {
             trace_sheepdog_reconnect_to_sdog();
             error_report_err(local_err);
-            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000000ULL);
+            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000000ULL, NULL);
         }
     };
 
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 374bef6bb2..2f53a7add5 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -43,7 +43,7 @@ static void coroutine_fn bdrv_test_co_drain_begin(BlockDriverState *bs)
     BDRVTestState *s = bs->opaque;
     s->drain_count++;
     if (s->sleep_in_drain_begin) {
-        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000, NULL);
     }
 }
 
@@ -74,7 +74,7 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
      * it to complete. We need to sleep a while as bdrv_drain_invoke() comes
      * first and polls its result, too, but it shouldn't accidentally complete
      * this request yet. */
-    qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
+    qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000, NULL);
 
     if (s->bh_indirection_ctx) {
         aio_bh_schedule_oneshot(s->bh_indirection_ctx, co_reenter_bh,
@@ -829,7 +829,7 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
         /* Avoid job_sleep_ns() because it marks the job as !busy. We want to
          * emulate some actual activity (probably some I/O) here so that drain
          * has to wait for this activity to stop. */
-        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000, NULL);
 
         job_pause_point(&s->common.job);
     }
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 926577b1f9..a1ac5efcaa 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -381,7 +381,7 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
          * emulate some actual activity (probably some I/O) here so that the
          * drain involved in AioContext switches has to wait for this activity
          * to stop. */
-        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000, NULL);
 
         job_pause_point(&s->common.job);
     }
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 4bfdd30cbf..48a64bb8d8 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -17,31 +17,52 @@
 #include "qemu/timer.h"
 #include "block/aio.h"
 
-static void co_sleep_cb(void *opaque)
-{
-    Coroutine *co = opaque;
+const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
+
+typedef struct QemuCoSleepState {
+    Coroutine *co;
+    QEMUTimer *ts;
+    void **user_state_pointer;
+} QemuCoSleepState;
 
+void qemu_co_sleep_wake(void *sleep_state)
+{
+    QemuCoSleepState *s = (QemuCoSleepState *)sleep_state;
     /* Write of schedule protected by barrier write in aio_co_schedule */
-    atomic_set(&co->scheduled, NULL);
-    aio_co_wake(co);
+    const char *scheduled = atomic_cmpxchg(&s->co->scheduled,
+                                           qemu_co_sleep_ns__scheduled, NULL);
+
+    assert(scheduled == qemu_co_sleep_ns__scheduled);
+    if (s->user_state_pointer) {
+        *s->user_state_pointer = NULL;
+    }
+    timer_del(s->ts);
+    aio_co_wake(s->co);
 }
 
-void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
+void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns,
+                                   void **sleep_state)
 {
     AioContext *ctx = qemu_get_current_aio_context();
-    QEMUTimer *ts;
-    Coroutine *co = qemu_coroutine_self();
+    QemuCoSleepState state = {
+        .co = qemu_coroutine_self(),
+        .ts = aio_timer_new(ctx, type, SCALE_NS, qemu_co_sleep_wake, &state),
+        .user_state_pointer = sleep_state,
+    };
 
-    const char *scheduled = atomic_cmpxchg(&co->scheduled, NULL, __func__);
+    const char *scheduled = atomic_cmpxchg(&state.co->scheduled, NULL,
+                                           qemu_co_sleep_ns__scheduled);
     if (scheduled) {
         fprintf(stderr,
                 "%s: Co-routine was already scheduled in '%s'\n",
                 __func__, scheduled);
         abort();
     }
-    ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, co);
-    timer_mod(ts, qemu_clock_get_ns(type) + ns);
+
+    if (sleep_state) {
+        *sleep_state = &state;
+    }
+    timer_mod(state.ts, qemu_clock_get_ns(type) + ns);
     qemu_coroutine_yield();
-    timer_del(ts);
-    timer_free(ts);
+    timer_free(state.ts);
 }
-- 
2.18.0


