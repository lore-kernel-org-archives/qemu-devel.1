Received: from eggs.gnu.org ([2001:4830:134:3::10]:36820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9m-0003bY-Ra
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9l-0006kE-Ao
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:42 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9l-0006iT-1p
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:41 -0400
Received: by mail-wm0-x244.google.com with SMTP id v190so583538wme.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:40 -0700 (PDT)
Received: from 640k.lan (94-39-132-181.adsl-ull.clienti.tiscali.it.
	[94.39.132.181])
	by smtp.gmail.com with ESMTPSA id k195sm408197wmd.7.2017.03.14.09.18.38
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 Mar 2017 09:18:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:18 +0100
Message-Id: <1489508300-48184-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/18] icount: process QEMU_CLOCK_VIRTUAL timers
 in vCPU thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

icount has become much slower after tcg_cpu_exec has stopped
using the BQL.  There is also a latent bug that is masked by
the slowness.

The slowness happens because every occurrence of a QEMU_CLOCK_VIRTUAL
timer now has to wake up the I/O thread and wait for it.  The rendez-vous
is mediated by the BQL QemuMutex:

- handle_icount_deadline wakes up the I/O thread with BQL taken
- the I/O thread wakes up and waits on the BQL
- the VCPU thread releases the BQL a little later
- the I/O thread raises an interrupt, which calls qemu_cpu_kick
- the VCPU thread notices the interrupt, takes the BQL to
  process it and waits on it

All this back and forth is extremely expensive, causing a 6 to 8-fold
slowdown when icount is turned on.

One may think that the issue is that the VCPU thread is too dependent
on the BQL, but then the latent bug comes in.  I first tried removing
the BQL completely from the x86 cpu_exec, only to see everything break.
The only way to fix it (and make everything slow again) was to add a dummy
BQL lock/unlock pair.

This is because in -icount mode you really have to process the events
before the CPU restarts executing the next instruction.  Therefore, this
series moves the processing of QEMU_CLOCK_VIRTUAL timers straight in
the vCPU thread when running in icount mode.

The required changes include:

- make the timer notification callback wake up TCG's single vCPU thread
  when run from another thread.  By using async_run_on_cpu, the callback
  can override all_cpu_threads_idle() when the CPU is halted.

- move handle_icount_deadline after qemu_tcg_wait_io_event, so that
  the timer notification callback is invoked after the dummy work item
  wakes up the vCPU thread

- make handle_icount_deadline run the timers instead of just waking the
  I/O thread.

- stop processing the timers in the main loop

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c               | 28 +++++++++++++++++++++++++---
 include/qemu/timer.h | 24 ++++++++++++++++++++++++
 util/qemu-timer.c    |  4 +++-
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index e9da3bc..b84a392 100644
--- a/cpus.c
+++ b/cpus.c
@@ -800,9 +800,25 @@ static void qemu_cpu_kick_rr_cpu(void)
     } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
 }
 
+static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
+{
+}
+
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
 {
-    qemu_notify_event();
+    if (!use_icount || type != QEMU_CLOCK_VIRTUAL) {
+        qemu_notify_event();
+        return;
+    }
+
+    if (!qemu_in_vcpu_thread() && first_cpu) {
+        /* qemu_cpu_kick is not enough to kick a halted CPU out of
+         * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
+         * causes cpu_thread_is_idle to return false.  This way,
+         * handle_icount_deadline can run.
+         */
+        async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
+    }
 }
 
 static void kick_tcg_thread(void *opaque)
@@ -1150,12 +1166,15 @@ static int64_t tcg_get_icount_limit(void)
 
 static void handle_icount_deadline(void)
 {
+    assert(qemu_in_vcpu_thread());
     if (use_icount) {
         int64_t deadline =
             qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
 
         if (deadline == 0) {
+            /* Wake up other AioContexts.  */
             qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+            qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
         }
     }
 }
@@ -1268,6 +1287,11 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
         /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
         qemu_account_warp_timer();
 
+        /* Run the timers here.  This is much more efficient than
+         * waking up the I/O thread and waiting for completion.
+         */
+        handle_icount_deadline();
+
         if (!cpu) {
             cpu = first_cpu;
         }
@@ -1309,8 +1333,6 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
 
-        handle_icount_deadline();
-
         qemu_tcg_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
         deal_with_unplugged_cpus();
     }
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 1441b42..e1742f2 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -533,6 +533,12 @@ static inline QEMUTimer *timer_new_tl(QEMUTimerList *timer_list,
  * Create a new timer and associate it with the default
  * timer list for the clock type @type.
  *
+ * The default timer list has one special feature: in icount mode,
+ * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
+ * not true of other timer lists, which are typically associated
+ * with an AioContext---each of them runs its timer callbacks in its own
+ * AioContext thread.
+ *
  * Returns: a pointer to the timer
  */
 static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
@@ -550,6 +556,12 @@ static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
  * Create a new timer with nanosecond scale on the default timer list
  * associated with the clock.
  *
+ * The default timer list has one special feature: in icount mode,
+ * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
+ * not true of other timer lists, which are typically associated
+ * with an AioContext---each of them runs its timer callbacks in its own
+ * AioContext thread.
+ *
  * Returns: a pointer to the newly created timer
  */
 static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
@@ -564,6 +576,12 @@ static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
  * @cb: the callback to call when the timer expires
  * @opaque: the opaque pointer to pass to the callback
  *
+ * The default timer list has one special feature: in icount mode,
+ * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
+ * not true of other timer lists, which are typically associated
+ * with an AioContext---each of them runs its timer callbacks in its own
+ * AioContext thread.
+ *
  * Create a new timer with microsecond scale on the default timer list
  * associated with the clock.
  *
@@ -581,6 +599,12 @@ static inline QEMUTimer *timer_new_us(QEMUClockType type, QEMUTimerCB *cb,
  * @cb: the callback to call when the timer expires
  * @opaque: the opaque pointer to pass to the callback
  *
+ * The default timer list has one special feature: in icount mode,
+ * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
+ * not true of other timer lists, which are typically associated
+ * with an AioContext---each of them runs its timer callbacks in its own
+ * AioContext thread.
+ *
  * Create a new timer with millisecond scale on the default timer list
  * associated with the clock.
  *
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index dc3181e..82d5650 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -658,7 +658,9 @@ bool qemu_clock_run_all_timers(void)
     QEMUClockType type;
 
     for (type = 0; type < QEMU_CLOCK_MAX; type++) {
-        progress |= qemu_clock_run_timers(type);
+        if (qemu_clock_use_for_deadline(type)) {
+            progress |= qemu_clock_run_timers(type);
+        }
     }
 
     return progress;
-- 
1.8.3.1
