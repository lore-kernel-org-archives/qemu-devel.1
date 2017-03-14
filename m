Received: from eggs.gnu.org ([2001:4830:134:3::10]:36779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9k-0003ZN-OF
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9j-0006hb-H5
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:40 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9j-0006gW-7F
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:39 -0400
Received: by mail-wm0-x244.google.com with SMTP id u132so610686wmg.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:39 -0700 (PDT)
Received: from 640k.lan (94-39-132-181.adsl-ull.clienti.tiscali.it.
	[94.39.132.181])
	by smtp.gmail.com with ESMTPSA id k195sm408197wmd.7.2017.03.14.09.18.37
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 Mar 2017 09:18:37 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:16 +0100
Message-Id: <1489508300-48184-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/18] cpus: define QEMUTimerListNotifyCB for
 QEMU system emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is no change for now, because the callback just invokes
qemu_notify_event.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c                       |  5 +++++
 include/qemu/timer.h         |  4 ++--
 include/sysemu/cpus.h        |  1 +
 stubs/cpu-get-icount.c       |  6 ++++++
 tests/test-aio-multithread.c |  2 +-
 tests/test-aio.c             |  2 +-
 util/async.c                 |  2 +-
 util/main-loop.c             |  2 +-
 util/qemu-timer.c            | 10 +++++-----
 9 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/cpus.c b/cpus.c
index 69e2185..e9da3bc 100644
--- a/cpus.c
+++ b/cpus.c
@@ -800,6 +800,11 @@ static void qemu_cpu_kick_rr_cpu(void)
     } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
 }
 
+void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
+{
+    qemu_notify_event();
+}
+
 static void kick_tcg_thread(void *opaque)
 {
     timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 91cd8c8..1441b42 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -59,7 +59,7 @@ struct QEMUTimerListGroup {
 };
 
 typedef void QEMUTimerCB(void *opaque);
-typedef void QEMUTimerListNotifyCB(void *opaque);
+typedef void QEMUTimerListNotifyCB(void *opaque, QEMUClockType type);
 
 struct QEMUTimer {
     int64_t expire_time;        /* in nanoseconds */
@@ -776,7 +776,7 @@ static inline int64_t qemu_soonest_timeout(int64_t timeout1, int64_t timeout2)
  *
  * Initialise the clock & timer infrastructure
  */
-void init_clocks(void);
+void init_clocks(QEMUTimerListNotifyCB *notify_cb);
 
 int64_t cpu_get_ticks(void);
 /* Caller must hold BQL */
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index e521a91..a8053f1 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -22,6 +22,7 @@ void dump_drift_info(FILE *f, fprintf_function cpu_fprintf);
 
 /* Unblock cpu */
 void qemu_cpu_kick_self(void);
+void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
 
 void cpu_synchronize_all_states(void);
 void cpu_synchronize_all_post_reset(void);
diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
index 2e8b63b..0b7239d 100644
--- a/stubs/cpu-get-icount.c
+++ b/stubs/cpu-get-icount.c
@@ -2,6 +2,7 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "sysemu/cpus.h"
+#include "qemu/main-loop.h"
 
 int use_icount;
 
@@ -9,3 +10,8 @@ int64_t cpu_get_icount(void)
 {
     abort();
 }
+
+void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
+{
+    qemu_notify_event();
+}
diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index 8b0b40e..549d784 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -438,7 +438,7 @@ static void test_multi_mutex_10(void)
 
 int main(int argc, char **argv)
 {
-    init_clocks();
+    init_clocks(NULL);
 
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/aio/multi/lifecycle", test_lifecycle);
diff --git a/tests/test-aio.c b/tests/test-aio.c
index 2754f15..54e20d6 100644
--- a/tests/test-aio.c
+++ b/tests/test-aio.c
@@ -835,7 +835,7 @@ int main(int argc, char **argv)
     Error *local_error = NULL;
     GSource *src;
 
-    init_clocks();
+    init_clocks(NULL);
 
     ctx = aio_context_new(&local_error);
     if (!ctx) {
diff --git a/util/async.c b/util/async.c
index 7d469eb..663e297 100644
--- a/util/async.c
+++ b/util/async.c
@@ -351,7 +351,7 @@ void aio_notify_accept(AioContext *ctx)
     }
 }
 
-static void aio_timerlist_notify(void *opaque)
+static void aio_timerlist_notify(void *opaque, QEMUClockType type)
 {
     aio_notify(opaque);
 }
diff --git a/util/main-loop.c b/util/main-loop.c
index 7efc229..4534c89 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -144,7 +144,7 @@ int qemu_init_main_loop(Error **errp)
     GSource *src;
     Error *local_error = NULL;
 
-    init_clocks();
+    init_clocks(qemu_timer_notify_cb);
 
     ret = qemu_signal_init();
     if (ret) {
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index ac99340..dc3181e 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -122,7 +122,7 @@ void timerlist_free(QEMUTimerList *timer_list)
     g_free(timer_list);
 }
 
-static void qemu_clock_init(QEMUClockType type)
+static void qemu_clock_init(QEMUClockType type, QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClock *clock = qemu_clock_ptr(type);
 
@@ -134,7 +134,7 @@ static void qemu_clock_init(QEMUClockType type)
     clock->last = INT64_MIN;
     QLIST_INIT(&clock->timerlists);
     notifier_list_init(&clock->reset_notifiers);
-    main_loop_tlg.tl[type] = timerlist_new(type, NULL, NULL);
+    main_loop_tlg.tl[type] = timerlist_new(type, notify_cb, NULL);
 }
 
 bool qemu_clock_use_for_deadline(QEMUClockType type)
@@ -278,7 +278,7 @@ QEMUTimerList *qemu_clock_get_main_loop_timerlist(QEMUClockType type)
 void timerlist_notify(QEMUTimerList *timer_list)
 {
     if (timer_list->notify_cb) {
-        timer_list->notify_cb(timer_list->notify_opaque);
+        timer_list->notify_cb(timer_list->notify_opaque, timer_list->clock->type);
     } else {
         qemu_notify_event();
     }
@@ -635,11 +635,11 @@ void qemu_clock_unregister_reset_notifier(QEMUClockType type,
     notifier_remove(notifier);
 }
 
-void init_clocks(void)
+void init_clocks(QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClockType type;
     for (type = 0; type < QEMU_CLOCK_MAX; type++) {
-        qemu_clock_init(type);
+        qemu_clock_init(type, notify_cb);
     }
 
 #ifdef CONFIG_PRCTL_PR_SET_TIMERSLACK
-- 
1.8.3.1
