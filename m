Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB082C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA9520665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA9520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAH4X-0008Hx-6Z
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAH2g-0006lt-Tq
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAH2f-00033L-Ir
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:13:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:55314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAH2c-000303-N7; Tue, 17 Sep 2019 13:13:26 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAH2Z-0003rq-NJ; Tue, 17 Sep 2019 20:13:23 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 20:13:20 +0300
Message-Id: <20190917171322.4127-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917171322.4127-1-vsementsov@virtuozzo.com>
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v9 1/3] qemu-coroutine-sleep: introduce
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a function to gracefully wake a coroutine sleeping in
qemu_co_sleep_ns().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/coroutine.h    | 23 +++++++++++++++--
 util/qemu-coroutine-sleep.c | 51 +++++++++++++++++++++++++++----------
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9801e7f5a4..8d55663062 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -273,10 +273,29 @@ void qemu_co_rwlock_wrlock(CoRwlock *lock);
  */
 void qemu_co_rwlock_unlock(CoRwlock *lock);
 
+typedef struct QemuCoSleepState QemuCoSleepState;
+
+/**
+ * Yield the coroutine for a given duration. During this yield, @sleep_state
+ * (if not NULL) is set to an opaque pointer, which may be used for
+ * qemu_co_sleep_wake(). Be careful, the pointer is set back to zero when the
+ * timer fires. Don't save the obtained value to other variables and don't call
+ * qemu_co_sleep_wake from another aio context.
+ */
+void coroutine_fn qemu_co_sleep_ns_wakeable(QEMUClockType type, int64_t ns,
+                                            QemuCoSleepState **sleep_state);
+static inline void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
+{
+    qemu_co_sleep_ns_wakeable(type, ns, NULL);
+}
+
 /**
- * Yield the coroutine for a given duration
+ * Wake a coroutine if it is sleeping in qemu_co_sleep_ns. The timer will be
+ * deleted. @sleep_state must be the variable whose address was given to
+ * qemu_co_sleep_ns() and should be checked to be non-NULL before calling
+ * qemu_co_sleep_wake().
  */
-void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
+void qemu_co_sleep_wake(QemuCoSleepState *sleep_state);
 
 /**
  * Yield until a file descriptor becomes readable
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 4bfdd30cbf..ae91b92b6e 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -17,31 +17,56 @@
 #include "qemu/timer.h"
 #include "block/aio.h"
 
-static void co_sleep_cb(void *opaque)
-{
-    Coroutine *co = opaque;
+static const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
+
+struct QemuCoSleepState {
+    Coroutine *co;
+    QEMUTimer *ts;
+    QemuCoSleepState **user_state_pointer;
+};
 
+void qemu_co_sleep_wake(QemuCoSleepState *sleep_state)
+{
     /* Write of schedule protected by barrier write in aio_co_schedule */
-    atomic_set(&co->scheduled, NULL);
-    aio_co_wake(co);
+    const char *scheduled = atomic_cmpxchg(&sleep_state->co->scheduled,
+                                           qemu_co_sleep_ns__scheduled, NULL);
+
+    assert(scheduled == qemu_co_sleep_ns__scheduled);
+    if (sleep_state->user_state_pointer) {
+        *sleep_state->user_state_pointer = NULL;
+    }
+    timer_del(sleep_state->ts);
+    aio_co_wake(sleep_state->co);
 }
 
-void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
+static void co_sleep_cb(void *opaque)
+{
+    qemu_co_sleep_wake(opaque);
+}
+
+void coroutine_fn qemu_co_sleep_ns_wakeable(QEMUClockType type, int64_t ns,
+                                            QemuCoSleepState **sleep_state)
 {
     AioContext *ctx = qemu_get_current_aio_context();
-    QEMUTimer *ts;
-    Coroutine *co = qemu_coroutine_self();
+    QemuCoSleepState state = {
+        .co = qemu_coroutine_self(),
+        .ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &state),
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
2.21.0


