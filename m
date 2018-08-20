Received: from eggs.gnu.org ([2001:4830:134:3::10]:38169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnw-0006vh-RV
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnp-00068l-Aw
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frlnn-000666-5w
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:07 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Aug 2018 17:09:00 +0200
Message-Id: <20180820150903.1224-2-pbonzini@redhat.com>
In-Reply-To: <20180820150903.1224-1-pbonzini@redhat.com>
References: <20180820150903.1224-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] cpus: protect all icount computation with
 seqlock
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

Using the seqlock makes the atomic_read__nocheck safe, because it now
happens always inside a seqlock and any torn reads will be retried.
qemu_icount_bias and icount_time_shift also need to be accessed with
atomics.  At the same time, however, you don't need atomic_read within
the writer, because no concurrent writes are possible.

The fix to vmstate lets us keep the struct nicely packed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 69 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/cpus.c b/cpus.c
index 91613491b7..680706aefa 100644
--- a/cpus.c
+++ b/cpus.c
@@ -121,8 +121,6 @@ static bool all_cpu_threads_idle(void)
 /* Protected by TimersState seqlock */
 
 static bool icount_sleep = true;
-/* Conversion factor from emulated instructions to virtual clock ticks.  */
-static int icount_time_shift;
 /* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
 #define MAX_ICOUNT_SHIFT 10
 
@@ -137,8 +135,9 @@ typedef struct TimersState {
     QemuSeqLock vm_clock_seqlock;
     int64_t cpu_clock_offset;
     int32_t cpu_ticks_enabled;
-    int64_t dummy;
 
+    /* Conversion factor from emulated instructions to virtual clock ticks.  */
+    int icount_time_shift;
     /* Compensate for varying guest execution speed.  */
     int64_t qemu_icount_bias;
     /* Only written by TCG thread */
@@ -247,14 +246,13 @@ void cpu_update_icount(CPUState *cpu)
 
 #ifdef CONFIG_ATOMIC64
     atomic_set__nocheck(&timers_state.qemu_icount,
-                        atomic_read__nocheck(&timers_state.qemu_icount) +
-                        executed);
+                        timers_state.qemu_icount + executed);
 #else /* FIXME: we need 64bit atomics to do this safely */
     timers_state.qemu_icount += executed;
 #endif
 }
 
-int64_t cpu_get_icount_raw(void)
+static int64_t cpu_get_icount_raw_locked(void)
 {
     CPUState *cpu = current_cpu;
 
@@ -266,20 +264,30 @@ int64_t cpu_get_icount_raw(void)
         /* Take into account what has run */
         cpu_update_icount(cpu);
     }
-#ifdef CONFIG_ATOMIC64
+    /* The read is protected by the seqlock, so __nocheck is okay.  */
     return atomic_read__nocheck(&timers_state.qemu_icount);
-#else /* FIXME: we need 64bit atomics to do this safely */
-    return timers_state.qemu_icount;
-#endif
 }
 
-/* Return the virtual CPU time, based on the instruction counter.  */
 static int64_t cpu_get_icount_locked(void)
 {
-    int64_t icount = cpu_get_icount_raw();
-    return timers_state.qemu_icount_bias + cpu_icount_to_ns(icount);
+    int64_t icount = cpu_get_icount_raw_locked();
+    return atomic_read(&timers_state.qemu_icount_bias) + cpu_icount_to_ns(icount);
+}
+
+int64_t cpu_get_icount_raw(void)
+{
+    int64_t icount;
+    unsigned start;
+
+    do {
+        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
+        icount = cpu_get_icount_raw_locked();
+    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
+
+    return icount;
 }
 
+/* Return the virtual CPU time, based on the instruction counter.  */
 int64_t cpu_get_icount(void)
 {
     int64_t icount;
@@ -295,7 +303,7 @@ int64_t cpu_get_icount(void)
 
 int64_t cpu_icount_to_ns(int64_t icount)
 {
-    return icount << icount_time_shift;
+    return icount << atomic_read(&timers_state.icount_time_shift);
 }
 
 /* return the time elapsed in VM between vm_start and vm_stop.  Unless
@@ -415,19 +423,22 @@ static void icount_adjust(void)
     /* FIXME: This is a very crude algorithm, somewhat prone to oscillation.  */
     if (delta > 0
         && last_delta + ICOUNT_WOBBLE < delta * 2
-        && icount_time_shift > 0) {
+        && timers_state.icount_time_shift > 0) {
         /* The guest is getting too far ahead.  Slow time down.  */
-        icount_time_shift--;
+        atomic_set(&timers_state.icount_time_shift,
+                   timers_state.icount_time_shift - 1);
     }
     if (delta < 0
         && last_delta - ICOUNT_WOBBLE > delta * 2
-        && icount_time_shift < MAX_ICOUNT_SHIFT) {
+        && timers_state.icount_time_shift < MAX_ICOUNT_SHIFT) {
         /* The guest is getting too far behind.  Speed time up.  */
-        icount_time_shift++;
+        atomic_set(&timers_state.icount_time_shift,
+                   timers_state.icount_time_shift + 1);
     }
     last_delta = delta;
-    timers_state.qemu_icount_bias = cur_icount
-                              - (timers_state.qemu_icount << icount_time_shift);
+    atomic_set__nocheck(&timers_state.qemu_icount_bias,
+                        cur_icount - (timers_state.qemu_icount
+                                      << timers_state.icount_time_shift));
     seqlock_write_end(&timers_state.vm_clock_seqlock);
 }
 
@@ -448,7 +459,8 @@ static void icount_adjust_vm(void *opaque)
 
 static int64_t qemu_icount_round(int64_t count)
 {
-    return (count + (1 << icount_time_shift) - 1) >> icount_time_shift;
+    int shift = atomic_read(&timers_state.icount_time_shift);
+    return (count + (1 << shift) - 1) >> shift;
 }
 
 static void icount_warp_rt(void)
@@ -484,7 +496,8 @@ static void icount_warp_rt(void)
             int64_t delta = clock - cur_icount;
             warp_delta = MIN(warp_delta, delta);
         }
-        timers_state.qemu_icount_bias += warp_delta;
+        atomic_set__nocheck(&timers_state.qemu_icount_bias,
+                            timers_state.qemu_icount_bias + warp_delta);
     }
     timers_state.vm_clock_warp_start = -1;
     seqlock_write_end(&timers_state.vm_clock_seqlock);
@@ -513,7 +526,8 @@ void qtest_clock_warp(int64_t dest)
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
         seqlock_write_begin(&timers_state.vm_clock_seqlock);
-        timers_state.qemu_icount_bias += warp;
+        atomic_set__nocheck(&timers_state.qemu_icount_bias,
+                            timers_state.qemu_icount_bias + warp);
         seqlock_write_end(&timers_state.vm_clock_seqlock);
 
         qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
@@ -582,7 +596,8 @@ void qemu_start_warp_timer(void)
              * isolated from host latencies.
              */
             seqlock_write_begin(&timers_state.vm_clock_seqlock);
-            timers_state.qemu_icount_bias += deadline;
+            atomic_set__nocheck(&timers_state.qemu_icount_bias,
+                                timers_state.qemu_icount_bias + deadline);
             seqlock_write_end(&timers_state.vm_clock_seqlock);
             qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
         } else {
@@ -700,7 +715,7 @@ static const VMStateDescription vmstate_timers = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_INT64(cpu_ticks_offset, TimersState),
-        VMSTATE_INT64(dummy, TimersState),
+        VMSTATE_UNUSED(8),
         VMSTATE_INT64_V(cpu_clock_offset, TimersState, 2),
         VMSTATE_END_OF_LIST()
     },
@@ -812,7 +827,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
     }
     if (strcmp(option, "auto") != 0) {
         errno = 0;
-        icount_time_shift = strtol(option, &rem_str, 0);
+        timers_state.icount_time_shift = strtol(option, &rem_str, 0);
         if (errno != 0 || *rem_str != '\0' || !strlen(option)) {
             error_setg(errp, "icount: Invalid shift value");
         }
@@ -828,7 +843,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
 
     /* 125MIPS seems a reasonable initial guess at the guest speed.
        It will be corrected fairly quickly anyway.  */
-    icount_time_shift = 3;
+    timers_state.icount_time_shift = 3;
 
     /* Have both realtime and virtual time triggers for speed adjustment.
        The realtime trigger catches emulated time passing too slowly,
-- 
2.17.1
