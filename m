Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKh-0006ht-93
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKc-0000Mn-Ja
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKb-0000CB-RV
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:53 -0400
Message-Id: <20181025172057.20414-45-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 44/48] cpus: lockstep execution support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |  27 +++++++++++
 cpus.c            | 113 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1ac56fe84b..5841421a20 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -279,6 +279,12 @@ typedef void (*run_on_cpu_func)(CPUState *cpu, run_on_cpu_data data);
 
 struct qemu_work_item;
 
+enum cpu_lockstep {
+    CPU_LOCKSTEP_RUN,
+    CPU_LOCKSTEP_STOP_REQUEST,
+    CPU_LOCKSTEP_WAIT,
+};
+
 #define CPU_UNSET_NUMA_NODE_ID -1
 #define CPU_TRACE_DSTATE_MAX_EVENTS 32
 
@@ -364,6 +370,7 @@ struct CPUState {
     QemuCond halt_cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
     uint32_t halted;
+    enum cpu_lockstep lockstep;
     bool created;
     bool stop;
     bool stopped;
@@ -1019,6 +1026,26 @@ static inline void cpu_interrupt(CPUState *cpu, int mask)
     cpu_interrupt_handler(cpu, mask);
 }
 
+/**
+ * cpu_lockstep_enable - Enable execution of CPUs in lockstep
+ *
+ * Note: this feature is MTTCG-only.
+ * Lockstep execution allows CPUs to partition their execution into windows
+ * whose start is synchronized with that of other CPUs. This can have many
+ * uses, e.g. limiting execution skew in the guest.
+ *
+ * See also: cpu_lockstep_request_stop()
+ */
+void cpu_lockstep_enable(void);
+
+/**
+ * cpu_lockstep_request_stop - Finish the CPU's execution window
+ * @cpu: the CPU of interest
+ *
+ * See also: cpu_lockstep_enable()
+ */
+void cpu_lockstep_request_stop(CPUState *cpu);
+
 #else /* USER_ONLY */
 
 void cpu_interrupt(CPUState *cpu, int mask);
diff --git a/cpus.c b/cpus.c
index 3efe89354d..a446632a5c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -80,6 +80,14 @@ int64_t max_advance;
 static QEMUTimer *throttle_timer;
 static unsigned int throttle_percentage;
 
+/* lockstep execution */
+static bool lockstep_enabled;
+static bool lockstep_ongoing_wakeup;
+static QemuMutex lockstep_lock;
+static int n_lockstep_running_cpus;
+static int n_lockstep_cpus;
+static CPUState **lockstep_cpus;
+
 #define CPU_THROTTLE_PCT_MIN 1
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
@@ -1174,6 +1182,11 @@ static bool cpu_can_run(CPUState *cpu)
     if (cpu_is_stopped(cpu)) {
         return false;
     }
+    if (lockstep_enabled &&
+        (cpu->lockstep == CPU_LOCKSTEP_STOP_REQUEST ||
+         cpu->lockstep == CPU_LOCKSTEP_WAIT)) {
+        return false;
+    }
     return true;
 }
 
@@ -1246,6 +1259,7 @@ void qemu_init_cpu_loop(void)
 {
     qemu_init_sigbus();
     qemu_mutex_init(&qemu_global_mutex);
+    qemu_mutex_init(&lockstep_lock);
 
     qemu_thread_get_self(&io_thread);
 }
@@ -1298,6 +1312,90 @@ static void qemu_wait_io_event_common(CPUState *cpu)
     cpu_mutex_lock(cpu);
 }
 
+void cpu_lockstep_enable(void)
+{
+    atomic_xchg(&lockstep_enabled, true);
+}
+
+void cpu_lockstep_request_stop(CPUState *cpu)
+{
+    bool locked = cpu_mutex_locked(cpu);
+
+    g_assert(lockstep_enabled);
+    if (!locked) {
+        cpu_mutex_lock(cpu);
+    }
+    g_assert(cpu->lockstep == CPU_LOCKSTEP_RUN ||
+             cpu->lockstep == CPU_LOCKSTEP_STOP_REQUEST);
+    cpu->lockstep = CPU_LOCKSTEP_STOP_REQUEST;
+    if (!locked) {
+        cpu_mutex_unlock(cpu);
+    }
+    cpu_exit(cpu);
+}
+
+static void lockstep_resume(CPUState *cpu, run_on_cpu_data ignored)
+{
+    g_assert(lockstep_enabled);
+    cpu_mutex_lock(cpu);
+    g_assert(cpu->lockstep == CPU_LOCKSTEP_WAIT);
+    cpu->lockstep = CPU_LOCKSTEP_RUN;
+    cpu_mutex_unlock(cpu);
+}
+
+static void lockstep_check_stop(CPUState *cpu)
+{
+    if (!lockstep_enabled) {
+        return;
+    }
+    if (cpu->lockstep == CPU_LOCKSTEP_STOP_REQUEST ||
+        (cpu->lockstep == CPU_LOCKSTEP_RUN && cpu_thread_is_idle(cpu))) {
+        qemu_mutex_lock(&lockstep_lock);
+        cpu->lockstep = CPU_LOCKSTEP_WAIT;
+        n_lockstep_running_cpus--;
+        if (n_lockstep_running_cpus == 0) {
+            int i;
+
+            /* wake up all waiting cpus */
+            lockstep_ongoing_wakeup = true;
+            n_lockstep_running_cpus = n_lockstep_cpus;
+            qemu_mutex_unlock(&lockstep_lock);
+            cpu_mutex_unlock(cpu);
+            for (i = 0; i < n_lockstep_cpus; i++) {
+                run_on_cpu_no_bql(lockstep_cpus[i], lockstep_resume,
+                                  RUN_ON_CPU_NULL);
+            }
+            cpu_mutex_lock(cpu);
+            qemu_mutex_lock(&lockstep_lock);
+            lockstep_ongoing_wakeup = false;
+        }
+        qemu_mutex_unlock(&lockstep_lock);
+    }
+}
+
+static void cpu_lockstep_init(CPUState *cpu)
+{
+    if (!lockstep_enabled) {
+        return;
+    }
+    qemu_mutex_lock(&lockstep_lock);
+    /*
+     * HACK: avoid racing with a wakeup, which would miss the addition
+     * of this CPU; just wait until no wakeup is ongoing.
+     */
+    while (unlikely(lockstep_ongoing_wakeup)) {
+        qemu_mutex_unlock(&lockstep_lock);
+        sched_yield();
+        qemu_mutex_lock(&lockstep_lock);
+    }
+    lockstep_cpus = g_realloc(lockstep_cpus,
+                              (n_lockstep_cpus + 1) * sizeof(CPUState *));
+    lockstep_cpus[n_lockstep_cpus++] = cpu;
+    n_lockstep_running_cpus++;
+    qemu_mutex_unlock(&lockstep_lock);
+    cpu->lockstep = CPU_LOCKSTEP_RUN;
+}
+
 static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
 {
     g_assert(qemu_mutex_iothread_locked());
@@ -1321,6 +1419,15 @@ static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
     cpu_mutex_unlock(cpu);
 }
 
+static inline bool lockstep_is_waiting(CPUState *cpu)
+{
+    if (!lockstep_enabled) {
+        return true;
+    }
+    g_assert(cpu_mutex_locked(cpu));
+    return cpu->lockstep == CPU_LOCKSTEP_WAIT;
+}
+
 static void qemu_wait_io_event(CPUState *cpu)
 {
     bool asleep = false;
@@ -1328,7 +1435,9 @@ static void qemu_wait_io_event(CPUState *cpu)
     g_assert(cpu_mutex_locked(cpu));
     g_assert(!qemu_mutex_iothread_locked());
 
-    while (cpu_thread_is_idle(cpu)) {
+    lockstep_check_stop(cpu);
+
+    while (cpu_thread_is_idle(cpu) && lockstep_is_waiting(cpu)) {
         if (!asleep) {
             asleep = true;
             qemu_plugin_vcpu_idle_cb(cpu);
@@ -1884,6 +1993,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     cpu->can_do_io = 1;
     current_cpu = cpu;
     qemu_cond_signal(&cpu->cond);
+    /* init lockstep */
+    cpu_lockstep_init(cpu);
 
     /* process any pending work */
     cpu->exit_request = 1;
-- 
2.17.1
