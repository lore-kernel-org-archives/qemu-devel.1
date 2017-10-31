Received: from eggs.gnu.org ([2001:4830:134:3::10]:50495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ug9-0003I9-HK
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ug6-0007r9-Bx
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:25:57 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45098)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ug5-0007py-VY
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:25:54 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:25:54 +0300
Message-ID: <20171031112554.10516.8584.stgit@pasha-VirtualBox>
In-Reply-To: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 10/26] icount: fixed saving/restoring of
 icount warp timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

This patch adds saving and restoring of the icount warp
timers in the vmstate.
It is needed because there timers affect the virtual clock value.
Therefore determinism of the execution in icount record/replay mode
depends on determinism of the timers.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 cpus.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/cpus.c b/cpus.c
index c728f3a..2eec54f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -119,16 +119,11 @@ static bool all_cpu_threads_idle(void)
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
@@ -146,6 +141,11 @@ typedef struct TimersState {
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
@@ -431,14 +431,14 @@ static void icount_adjust(void)
 
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
@@ -459,7 +459,7 @@ static void icount_warp_rt(void)
      */
     do {
         seq = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        warp_start = vm_clock_warp_start;
+        warp_start = timers_state.vm_clock_warp_start;
     } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, seq));
 
     if (warp_start == -1) {
@@ -472,7 +472,7 @@ static void icount_warp_rt(void)
                                      cpu_get_clock_locked());
         int64_t warp_delta;
 
-        warp_delta = clock - vm_clock_warp_start;
+        warp_delta = clock - timers_state.vm_clock_warp_start;
         if (use_icount == 2) {
             /*
              * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
@@ -484,7 +484,7 @@ static void icount_warp_rt(void)
         }
         timers_state.qemu_icount_bias += warp_delta;
     }
-    vm_clock_warp_start = -1;
+    timers_state.vm_clock_warp_start = -1;
     seqlock_write_end(&timers_state.vm_clock_seqlock);
 
     if (qemu_clock_expired(QEMU_CLOCK_VIRTUAL)) {
@@ -593,11 +593,13 @@ void qemu_start_warp_timer(void)
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
@@ -622,7 +624,7 @@ static void qemu_account_warp_timer(void)
         return;
     }
 
-    timer_del(icount_warp_timer);
+    timer_del(timers_state.icount_warp_timer);
     icount_warp_rt();
 }
 
@@ -631,6 +633,44 @@ static bool icount_state_needed(void *opaque)
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
@@ -642,7 +682,13 @@ static const VMStateDescription icount_vmstate_timers = {
     .fields = (VMStateField[]) {
         VMSTATE_INT64(qemu_icount_bias, TimersState),
         VMSTATE_INT64(qemu_icount, TimersState),
+        VMSTATE_INT64(vm_clock_warp_start, TimersState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &icount_vmstate_warp_timer,
+        &icount_vmstate_adjust_timers,
+        NULL
     }
 };
 
@@ -753,7 +799,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
 
     icount_sleep = qemu_opt_get_bool(opts, "sleep", true);
     if (icount_sleep) {
-        icount_warp_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
+        timers_state.icount_warp_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
                                          icount_timer_cb, NULL);
     }
 
@@ -787,13 +833,14 @@ void configure_icount(QemuOpts *opts, Error **errp)
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
