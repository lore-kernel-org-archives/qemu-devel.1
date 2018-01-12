Received: from eggs.gnu.org ([2001:4830:134:3::10]:41965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZA-0007oT-Dp
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ6-0005o4-3F
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:08 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZ5-0005n7-Q0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:04 -0500
Received: by mail-wr0-x244.google.com with SMTP id p6so5053646wrd.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:01 +0100
Message-Id: <1515756676-3860-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/52] icount: fixed saving/restoring of icount
 warp timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds saving and restoring of the icount warp
timers in the vmstate.
It is needed because there timers affect the virtual clock value.
Therefore determinism of the execution in icount record/replay mode
depends on determinism of the timers.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 cpus.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/cpus.c b/cpus.c
index e8139de..f992537 100644
--- a/cpus.c
+++ b/cpus.c
@@ -120,16 +120,11 @@ static bool all_cpu_threads_idle(void)
 /* Protected by TimersState seqlock */
 
 static bool icount_sleep = true;
-static int64_t vm_clock_warp_start = -1;
 /* Conversion factor from emulated instructions to virtual clock ticks.  */
 static int icount_time_shift;
 /* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
 #define MAX_ICOUNT_SHIFT 10
 
-static QEMUTimer *icount_rt_timer;
-static QEMUTimer *icount_vm_timer;
-static QEMUTimer *icount_warp_timer;
-
 typedef struct TimersState {
     /* Protected by BQL.  */
     int64_t cpu_ticks_prev;
@@ -147,6 +142,11 @@ typedef struct TimersState {
     int64_t qemu_icount_bias;
     /* Only written by TCG thread */
     int64_t qemu_icount;
+    /* for adjusting icount */
+    int64_t vm_clock_warp_start;
+    QEMUTimer *icount_rt_timer;
+    QEMUTimer *icount_vm_timer;
+    QEMUTimer *icount_warp_timer;
 } TimersState;
 
 static TimersState timers_state;
@@ -432,14 +432,14 @@ static void icount_adjust(void)
 
 static void icount_adjust_rt(void *opaque)
 {
-    timer_mod(icount_rt_timer,
+    timer_mod(timers_state.icount_rt_timer,
               qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
     icount_adjust();
 }
 
 static void icount_adjust_vm(void *opaque)
 {
-    timer_mod(icount_vm_timer,
+    timer_mod(timers_state.icount_vm_timer,
                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                    NANOSECONDS_PER_SECOND / 10);
     icount_adjust();
@@ -460,7 +460,7 @@ static void icount_warp_rt(void)
      */
     do {
         seq = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        warp_start = vm_clock_warp_start;
+        warp_start = timers_state.vm_clock_warp_start;
     } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, seq));
 
     if (warp_start == -1) {
@@ -473,7 +473,7 @@ static void icount_warp_rt(void)
                                      cpu_get_clock_locked());
         int64_t warp_delta;
 
-        warp_delta = clock - vm_clock_warp_start;
+        warp_delta = clock - timers_state.vm_clock_warp_start;
         if (use_icount == 2) {
             /*
              * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
@@ -485,7 +485,7 @@ static void icount_warp_rt(void)
         }
         timers_state.qemu_icount_bias += warp_delta;
     }
-    vm_clock_warp_start = -1;
+    timers_state.vm_clock_warp_start = -1;
     seqlock_write_end(&timers_state.vm_clock_seqlock);
 
     if (qemu_clock_expired(QEMU_CLOCK_VIRTUAL)) {
@@ -594,11 +594,13 @@ void qemu_start_warp_timer(void)
              * every 100ms.
              */
             seqlock_write_begin(&timers_state.vm_clock_seqlock);
-            if (vm_clock_warp_start == -1 || vm_clock_warp_start > clock) {
-                vm_clock_warp_start = clock;
+            if (timers_state.vm_clock_warp_start == -1
+                || timers_state.vm_clock_warp_start > clock) {
+                timers_state.vm_clock_warp_start = clock;
             }
             seqlock_write_end(&timers_state.vm_clock_seqlock);
-            timer_mod_anticipate(icount_warp_timer, clock + deadline);
+            timer_mod_anticipate(timers_state.icount_warp_timer,
+                                 clock + deadline);
         }
     } else if (deadline == 0) {
         qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
@@ -623,7 +625,7 @@ static void qemu_account_warp_timer(void)
         return;
     }
 
-    timer_del(icount_warp_timer);
+    timer_del(timers_state.icount_warp_timer);
     icount_warp_rt();
 }
 
@@ -632,6 +634,45 @@ static bool icount_state_needed(void *opaque)
     return use_icount;
 }
 
+static bool warp_timer_state_needed(void *opaque)
+{
+    TimersState *s = opaque;
+    return s->icount_warp_timer != NULL;
+}
+
+static bool adjust_timers_state_needed(void *opaque)
+{
+    TimersState *s = opaque;
+    return s->icount_rt_timer != NULL;
+}
+
+/*
+ * Subsection for warp timer migration is optional, because may not be created
+ */
+static const VMStateDescription icount_vmstate_warp_timer = {
+    .name = "timer/icount/warp_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = warp_timer_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT64(vm_clock_warp_start, TimersState),
+        VMSTATE_TIMER_PTR(icount_warp_timer, TimersState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription icount_vmstate_adjust_timers = {
+    .name = "timer/icount/timers",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = adjust_timers_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_TIMER_PTR(icount_rt_timer, TimersState),
+        VMSTATE_TIMER_PTR(icount_vm_timer, TimersState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /*
  * This is a subsection for icount migration.
  */
@@ -644,6 +685,11 @@ static const VMStateDescription icount_vmstate_timers = {
         VMSTATE_INT64(qemu_icount_bias, TimersState),
         VMSTATE_INT64(qemu_icount, TimersState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &icount_vmstate_warp_timer,
+        &icount_vmstate_adjust_timers,
+        NULL
     }
 };
 
@@ -754,7 +800,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
 
     icount_sleep = qemu_opt_get_bool(opts, "sleep", true);
     if (icount_sleep) {
-        icount_warp_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
+        timers_state.icount_warp_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
                                          icount_timer_cb, NULL);
     }
 
@@ -788,13 +834,14 @@ void configure_icount(QemuOpts *opts, Error **errp)
        the virtual time trigger catches emulated time passing too fast.
        Realtime triggers occur even when idle, so use them less frequently
        than VM triggers.  */
-    icount_rt_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
+    timers_state.vm_clock_warp_start = -1;
+    timers_state.icount_rt_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
                                    icount_adjust_rt, NULL);
-    timer_mod(icount_rt_timer,
+    timer_mod(timers_state.icount_rt_timer,
                    qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
-    icount_vm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+    timers_state.icount_vm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                         icount_adjust_vm, NULL);
-    timer_mod(icount_vm_timer,
+    timer_mod(timers_state.icount_vm_timer,
                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                    NANOSECONDS_PER_SECOND / 10);
 }
-- 
1.8.3.1
