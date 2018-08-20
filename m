Received: from eggs.gnu.org ([2001:4830:134:3::10]:38164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnw-0006vd-RH
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnq-00069w-Tl
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frlnn-00066n-I3
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:09 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Aug 2018 17:09:02 +0200
Message-Id: <20180820150903.1224-4-pbonzini@redhat.com>
In-Reply-To: <20180820150903.1224-1-pbonzini@redhat.com>
References: <20180820150903.1224-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] cpus: protect TimerState writes with a
 spinlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>

In the next patch, we will need to write cpu_ticks_offset from any
thread, even outside the BQL.  Currently, it is protected by the BQL
just because cpu_enable_ticks and cpu_disable_ticks happen to hold it,
but the critical sections are well delimited and it's easy to remove
the BQL dependency.

Add a spinlock that matches vm_clock_seqlock, and hold it when writing
to the TimerState.  This also lets us fix cpu_update_icount when 64-bit
atomics are not available.

Fields of TiemrState are reordered to avoid padding.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 72 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/cpus.c b/cpus.c
index 680706aefa..63ddd4fd21 100644
--- a/cpus.c
+++ b/cpus.c
@@ -129,21 +129,27 @@ typedef struct TimersState {
     int64_t cpu_ticks_prev;
     int64_t cpu_ticks_offset;
 
-    /* cpu_clock_offset can be read out of BQL, so protect it with
-     * this lock.
+    /* Protect fields that can be respectively read outside the
+     * BQL, and written from multiple threads.
      */
     QemuSeqLock vm_clock_seqlock;
-    int64_t cpu_clock_offset;
-    int32_t cpu_ticks_enabled;
+    QemuSpin vm_clock_lock;
+
+    int16_t cpu_ticks_enabled;
 
     /* Conversion factor from emulated instructions to virtual clock ticks.  */
-    int icount_time_shift;
+    int16_t icount_time_shift;
+
     /* Compensate for varying guest execution speed.  */
     int64_t qemu_icount_bias;
+
+    int64_t vm_clock_warp_start;
+    int64_t cpu_clock_offset;
+
     /* Only written by TCG thread */
     int64_t qemu_icount;
+
     /* for adjusting icount */
-    int64_t vm_clock_warp_start;
     QEMUTimer *icount_rt_timer;
     QEMUTimer *icount_vm_timer;
     QEMUTimer *icount_warp_timer;
@@ -244,11 +250,15 @@ void cpu_update_icount(CPUState *cpu)
     int64_t executed = cpu_get_icount_executed(cpu);
     cpu->icount_budget -= executed;
 
-#ifdef CONFIG_ATOMIC64
+#ifndef CONFIG_ATOMIC64
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
+#endif
     atomic_set__nocheck(&timers_state.qemu_icount,
                         timers_state.qemu_icount + executed);
-#else /* FIXME: we need 64bit atomics to do this safely */
-    timers_state.qemu_icount += executed;
+#ifndef CONFIG_ATOMIC64
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                         &timers_state.vm_clock_lock);
 #endif
 }
 
@@ -369,14 +379,15 @@ int64_t cpu_get_clock(void)
  */
 void cpu_enable_ticks(void)
 {
-    /* Here, the really thing protected by seqlock is cpu_clock_offset. */
-    seqlock_write_begin(&timers_state.vm_clock_seqlock);
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
     if (!timers_state.cpu_ticks_enabled) {
         timers_state.cpu_ticks_offset -= cpu_get_host_ticks();
         timers_state.cpu_clock_offset -= get_clock();
         timers_state.cpu_ticks_enabled = 1;
     }
-    seqlock_write_end(&timers_state.vm_clock_seqlock);
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
 }
 
 /* disable cpu_get_ticks() : the clock is stopped. You must not call
@@ -385,14 +396,15 @@ void cpu_enable_ticks(void)
  */
 void cpu_disable_ticks(void)
 {
-    /* Here, the really thing protected by seqlock is cpu_clock_offset. */
-    seqlock_write_begin(&timers_state.vm_clock_seqlock);
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
     if (timers_state.cpu_ticks_enabled) {
         timers_state.cpu_ticks_offset += cpu_get_host_ticks();
         timers_state.cpu_clock_offset = cpu_get_clock_locked();
         timers_state.cpu_ticks_enabled = 0;
     }
-    seqlock_write_end(&timers_state.vm_clock_seqlock);
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                         &timers_state.vm_clock_lock);
 }
 
 /* Correlation between real and virtual time is always going to be
@@ -415,7 +427,8 @@ static void icount_adjust(void)
         return;
     }
 
-    seqlock_write_begin(&timers_state.vm_clock_seqlock);
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
     cur_time = cpu_get_clock_locked();
     cur_icount = cpu_get_icount_locked();
 
@@ -439,7 +452,8 @@ static void icount_adjust(void)
     atomic_set__nocheck(&timers_state.qemu_icount_bias,
                         cur_icount - (timers_state.qemu_icount
                                       << timers_state.icount_time_shift));
-    seqlock_write_end(&timers_state.vm_clock_seqlock);
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                         &timers_state.vm_clock_lock);
 }
 
 static void icount_adjust_rt(void *opaque)
@@ -480,7 +494,8 @@ static void icount_warp_rt(void)
         return;
     }
 
-    seqlock_write_begin(&timers_state.vm_clock_seqlock);
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
     if (runstate_is_running()) {
         int64_t clock = REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT,
                                      cpu_get_clock_locked());
@@ -500,7 +515,8 @@ static void icount_warp_rt(void)
                             timers_state.qemu_icount_bias + warp_delta);
     }
     timers_state.vm_clock_warp_start = -1;
-    seqlock_write_end(&timers_state.vm_clock_seqlock);
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
 
     if (qemu_clock_expired(QEMU_CLOCK_VIRTUAL)) {
         qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
@@ -525,10 +541,12 @@ void qtest_clock_warp(int64_t dest)
         int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
-        seqlock_write_begin(&timers_state.vm_clock_seqlock);
+        seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                           &timers_state.vm_clock_lock);
         atomic_set__nocheck(&timers_state.qemu_icount_bias,
                             timers_state.qemu_icount_bias + warp);
-        seqlock_write_end(&timers_state.vm_clock_seqlock);
+        seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                             &timers_state.vm_clock_lock);
 
         qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
         timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
@@ -595,10 +613,12 @@ void qemu_start_warp_timer(void)
              * It is useful when we want a deterministic execution time,
              * isolated from host latencies.
              */
-            seqlock_write_begin(&timers_state.vm_clock_seqlock);
+            seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                               &timers_state.vm_clock_lock);
             atomic_set__nocheck(&timers_state.qemu_icount_bias,
                                 timers_state.qemu_icount_bias + deadline);
-            seqlock_write_end(&timers_state.vm_clock_seqlock);
+            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                                 &timers_state.vm_clock_lock);
             qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
         } else {
             /*
@@ -609,12 +629,14 @@ void qemu_start_warp_timer(void)
              * you will not be sending network packets continuously instead of
              * every 100ms.
              */
-            seqlock_write_begin(&timers_state.vm_clock_seqlock);
+            seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                               &timers_state.vm_clock_lock);
             if (timers_state.vm_clock_warp_start == -1
                 || timers_state.vm_clock_warp_start > clock) {
                 timers_state.vm_clock_warp_start = clock;
             }
-            seqlock_write_end(&timers_state.vm_clock_seqlock);
+            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                                 &timers_state.vm_clock_lock);
             timer_mod_anticipate(timers_state.icount_warp_timer,
                                  clock + deadline);
         }
-- 
2.17.1
