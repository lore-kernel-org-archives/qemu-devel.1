Received: from eggs.gnu.org ([209.51.188.92]:36090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe49-0000Pv-DI
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe46-0001cm-Sa
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:21 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51399)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe46-0001GH-MS
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:18 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:48:08 -0500
Message-Id: <20190130004811.27372-71-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 70/73] cpu: protect CPU state with cpu->lock
 instead of the BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Use the per-CPU locks to protect the CPUs' state, instead of
using the BQL. These locks are uncontended (they are mostly
acquired by the corresponding vCPU thread), so acquiring them
is cheaper than acquiring the BQL, which particularly in
MTTCG can be contended at high core counts.

In this conversion we drop qemu_cpu_cond and qemu_pause_cond,
and use cpu->cond instead.

In qom/cpu.c we can finally remove the ugliness that
results from having to hold both the BQL and the CPU lock;
now we just have to grab the CPU lock.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |  20 ++--
 cpus.c            | 280 ++++++++++++++++++++++++++++++++++------------
 qom/cpu.c         |  29 +----
 3 files changed, 225 insertions(+), 104 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 27a80bc113..30ed2fae0b 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -297,10 +297,6 @@ struct qemu_work_item;
  * valid under cpu_list_lock.
  * @created: Indicates whether the CPU thread has been successfully created.
  * @interrupt_request: Indicates a pending interrupt request.
- * @halted: Nonzero if the CPU is in suspended state.
- * @stop: Indicates a pending stop request.
- * @stopped: Indicates the CPU has been artificially stopped.
- * @unplug: Indicates a pending CPU unplug request.
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
  * @singlestep_enabled: Flags for single-stepping.
  * @icount_extra: Instructions until next timer event.
@@ -329,6 +325,10 @@ struct qemu_work_item;
  * @lock: Lock to prevent multiple access to per-CPU fields.
  * @cond: Condition variable for per-CPU events.
  * @work_list: List of pending asynchronous work.
+ * @halted: Nonzero if the CPU is in suspended state.
+ * @stop: Indicates a pending stop request.
+ * @stopped: Indicates the CPU has been artificially stopped.
+ * @unplug: Indicates a pending CPU unplug request.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
@@ -352,12 +352,7 @@ struct CPUState {
 #endif
     int thread_id;
     bool running, has_waiter;
-    struct QemuCond *halt_cond;
     bool thread_kicked;
-    bool created;
-    bool stop;
-    bool stopped;
-    bool unplug;
     bool crash_occurred;
     bool exit_request;
     uint32_t cflags_next_tb;
@@ -371,7 +366,13 @@ struct CPUState {
     QemuMutex *lock;
     /* fields below protected by @lock */
     QemuCond cond;
+    QemuCond *halt_cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
+    uint32_t halted;
+    bool created;
+    bool stop;
+    bool stopped;
+    bool unplug;
 
     CPUAddressSpace *cpu_ases;
     int num_ases;
@@ -419,7 +420,6 @@ struct CPUState {
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
-    uint32_t halted;
     uint32_t can_do_io;
     int32_t exception_index;
 
diff --git a/cpus.c b/cpus.c
index 0d255c2655..4f17fe25bf 100644
--- a/cpus.c
+++ b/cpus.c
@@ -181,24 +181,30 @@ bool cpu_mutex_locked(const CPUState *cpu)
     return test_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
 }
 
-bool cpu_is_stopped(CPUState *cpu)
+/* Called with the CPU's lock held */
+static bool cpu_is_stopped_locked(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
 }
 
-static inline bool cpu_work_list_empty(CPUState *cpu)
+bool cpu_is_stopped(CPUState *cpu)
 {
-    bool ret;
+    if (!cpu_mutex_locked(cpu)) {
+        bool ret;
 
-    cpu_mutex_lock(cpu);
-    ret = QSIMPLEQ_EMPTY(&cpu->work_list);
-    cpu_mutex_unlock(cpu);
-    return ret;
+        cpu_mutex_lock(cpu);
+        ret = cpu_is_stopped_locked(cpu);
+        cpu_mutex_unlock(cpu);
+        return ret;
+    }
+    return cpu_is_stopped_locked(cpu);
 }
 
 static bool cpu_thread_is_idle(CPUState *cpu)
 {
-    if (cpu->stop || !cpu_work_list_empty(cpu)) {
+    g_assert(cpu_mutex_locked(cpu));
+
+    if (cpu->stop || !QSIMPLEQ_EMPTY(&cpu->work_list)) {
         return false;
     }
     if (cpu_is_stopped(cpu)) {
@@ -216,9 +222,17 @@ static bool qemu_tcg_rr_all_cpu_threads_idle(void)
     CPUState *cpu;
 
     g_assert(qemu_is_tcg_rr());
+    g_assert(qemu_mutex_iothread_locked());
+    g_assert(no_cpu_mutex_locked());
 
     CPU_FOREACH(cpu) {
-        if (!cpu_thread_is_idle(cpu)) {
+        bool is_idle;
+
+        cpu_mutex_lock(cpu);
+        is_idle = cpu_thread_is_idle(cpu);
+        cpu_mutex_unlock(cpu);
+
+        if (!is_idle) {
             return false;
         }
     }
@@ -780,6 +794,8 @@ void qemu_start_warp_timer(void)
 
 static void qemu_account_warp_timer(void)
 {
+    g_assert(qemu_mutex_iothread_locked());
+
     if (!use_icount || !icount_sleep) {
         return;
     }
@@ -1090,6 +1106,7 @@ static void kick_tcg_thread(void *opaque)
 static void start_tcg_kick_timer(void)
 {
     assert(!mttcg_enabled);
+    g_assert(qemu_mutex_iothread_locked());
     if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
         tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                            kick_tcg_thread, NULL);
@@ -1102,6 +1119,7 @@ static void start_tcg_kick_timer(void)
 static void stop_tcg_kick_timer(void)
 {
     assert(!mttcg_enabled);
+    g_assert(qemu_mutex_iothread_locked());
     if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
         timer_del(tcg_kick_vcpu_timer);
     }
@@ -1204,6 +1222,8 @@ int vm_shutdown(void)
 
 static bool cpu_can_run(CPUState *cpu)
 {
+    g_assert(cpu_mutex_locked(cpu));
+
     if (cpu->stop) {
         return false;
     }
@@ -1276,16 +1296,9 @@ static void qemu_init_sigbus(void)
 
 static QemuThread io_thread;
 
-/* cpu creation */
-static QemuCond qemu_cpu_cond;
-/* system init */
-static QemuCond qemu_pause_cond;
-
 void qemu_init_cpu_loop(void)
 {
     qemu_init_sigbus();
-    qemu_cond_init(&qemu_cpu_cond);
-    qemu_cond_init(&qemu_pause_cond);
     qemu_mutex_init(&qemu_global_mutex);
 
     qemu_thread_get_self(&io_thread);
@@ -1303,46 +1316,70 @@ static void qemu_tcg_destroy_vcpu(CPUState *cpu)
 {
 }
 
-static void qemu_cpu_stop(CPUState *cpu, bool exit)
+static void qemu_cpu_stop_locked(CPUState *cpu, bool exit)
 {
+    g_assert(cpu_mutex_locked(cpu));
     g_assert(qemu_cpu_is_self(cpu));
     cpu->stop = false;
     cpu->stopped = true;
     if (exit) {
         cpu_exit(cpu);
     }
-    qemu_cond_broadcast(&qemu_pause_cond);
+    qemu_cond_broadcast(&cpu->cond);
+}
+
+static void qemu_cpu_stop(CPUState *cpu, bool exit)
+{
+    cpu_mutex_lock(cpu);
+    qemu_cpu_stop_locked(cpu, exit);
+    cpu_mutex_unlock(cpu);
 }
 
 static void qemu_wait_io_event_common(CPUState *cpu)
 {
+    g_assert(cpu_mutex_locked(cpu));
+
     atomic_mb_set(&cpu->thread_kicked, false);
     if (cpu->stop) {
-        qemu_cpu_stop(cpu, false);
+        qemu_cpu_stop_locked(cpu, false);
     }
+    /*
+     * unlock+lock cpu_mutex, so that other vCPUs have a chance to grab the
+     * lock and queue some work for this vCPU.
+     */
+    cpu_mutex_unlock(cpu);
     process_queued_cpu_work(cpu);
+    cpu_mutex_lock(cpu);
 }
 
 static void qemu_tcg_rr_wait_io_event(void)
 {
     CPUState *cpu;
 
+    g_assert(qemu_mutex_iothread_locked());
+    g_assert(no_cpu_mutex_locked());
+
     while (qemu_tcg_rr_all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait(first_cpu->halt_cond, first_cpu->lock);
     }
 
     start_tcg_kick_timer();
 
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         qemu_wait_io_event_common(cpu);
+        cpu_mutex_unlock(cpu);
     }
 }
 
 static void qemu_wait_io_event(CPUState *cpu)
 {
+    g_assert(cpu_mutex_locked(cpu));
+    g_assert(!qemu_mutex_iothread_locked());
+
     while (cpu_thread_is_idle(cpu)) {
-        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait(cpu->halt_cond, cpu->lock);
     }
 
 #ifdef _WIN32
@@ -1362,6 +1399,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     cpu->can_do_io = 1;
@@ -1374,14 +1412,20 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     }
 
     kvm_init_cpu_signals(cpu);
+    qemu_mutex_unlock_iothread();
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = kvm_cpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
@@ -1389,10 +1433,16 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    cpu_mutex_unlock(cpu);
+    qemu_mutex_lock_iothread();
     qemu_kvm_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
+
     rcu_unregister_thread();
     return NULL;
 }
@@ -1409,7 +1459,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 
     rcu_register_thread();
 
-    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     cpu->can_do_io = 1;
@@ -1420,10 +1470,10 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
 
     do {
-        qemu_mutex_unlock_iothread();
+        cpu_mutex_unlock(cpu);
         do {
             int sig;
             r = sigwait(&waitset, &sig);
@@ -1432,10 +1482,11 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
             perror("sigwait");
             exit(1);
         }
-        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cpu);
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug);
 
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 #endif
@@ -1466,6 +1517,8 @@ static int64_t tcg_get_icount_limit(void)
 static void handle_icount_deadline(void)
 {
     assert(qemu_in_vcpu_thread());
+    g_assert(qemu_mutex_iothread_locked());
+
     if (use_icount) {
         int64_t deadline =
             qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
@@ -1546,12 +1599,15 @@ static void deal_with_unplugged_cpus(void)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         if (cpu->unplug && !cpu_can_run(cpu)) {
             qemu_tcg_destroy_vcpu(cpu);
             cpu->created = false;
-            qemu_cond_signal(&qemu_cpu_cond);
+            qemu_cond_signal(&cpu->cond);
+            cpu_mutex_unlock(cpu);
             break;
         }
+        cpu_mutex_unlock(cpu);
     }
 }
 
@@ -1572,24 +1628,36 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     rcu_register_thread();
     tcg_register_thread();
 
+    /*
+     * We call cpu_mutex_lock/unlock just to please the assertions in common
+     * code, since here cpu->lock is an alias to the BQL.
+     */
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
-
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
     cpu->can_do_io = 1;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
 
     /* wait for initial kick-off after machine start */
+    cpu_mutex_lock(first_cpu);
     while (first_cpu->stopped) {
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait(first_cpu->halt_cond, first_cpu->lock);
+        cpu_mutex_unlock(first_cpu);
 
         /* process any pending work */
         CPU_FOREACH(cpu) {
             current_cpu = cpu;
+            cpu_mutex_lock(cpu);
             qemu_wait_io_event_common(cpu);
+            cpu_mutex_unlock(cpu);
         }
+
+        cpu_mutex_lock(first_cpu);
     }
+    cpu_mutex_unlock(first_cpu);
 
     start_tcg_kick_timer();
 
@@ -1616,7 +1684,12 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
+        while (cpu) {
+            cpu_mutex_lock(cpu);
+            if (!QSIMPLEQ_EMPTY(&cpu->work_list) || cpu->exit_request) {
+                cpu_mutex_unlock(cpu);
+                break;
+            }
 
             atomic_mb_set(&tcg_current_rr_cpu, cpu);
             current_cpu = cpu;
@@ -1627,6 +1700,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             if (cpu_can_run(cpu)) {
                 int r;
 
+                cpu_mutex_unlock(cpu);
                 qemu_mutex_unlock_iothread();
                 prepare_icount_for_run(cpu);
 
@@ -1634,11 +1708,14 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
 
                 process_icount_data(cpu);
                 qemu_mutex_lock_iothread();
+                cpu_mutex_lock(cpu);
 
                 if (r == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
+                    cpu_mutex_unlock(cpu);
                     break;
                 } else if (r == EXCP_ATOMIC) {
+                    cpu_mutex_unlock(cpu);
                     qemu_mutex_unlock_iothread();
                     cpu_exec_step_atomic(cpu);
                     qemu_mutex_lock_iothread();
@@ -1648,11 +1725,15 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
                 if (cpu->unplug) {
                     cpu = CPU_NEXT(cpu);
                 }
+                cpu_mutex_unlock(current_cpu);
                 break;
             }
 
+            cpu_mutex_unlock(cpu);
             cpu = CPU_NEXT(cpu);
-        } /* while (cpu && !cpu->exit_request).. */
+        } /* for (;;) .. */
+
+        g_assert(no_cpu_mutex_locked());
 
         /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
         atomic_set(&tcg_current_rr_cpu, NULL);
@@ -1684,6 +1765,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
     rcu_register_thread();
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
@@ -1692,11 +1774,17 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     current_cpu = cpu;
 
     hax_init_vcpu(cpu);
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    qemu_cond_signal(&cpu->cond);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = hax_smp_cpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
@@ -1704,6 +1792,8 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
+
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 }
@@ -1721,6 +1811,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
@@ -1728,14 +1819,20 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     current_cpu = cpu;
 
     hvf_init_vcpu(cpu);
+    qemu_mutex_unlock_iothread();
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = hvf_vcpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
@@ -1743,10 +1840,16 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    cpu_mutex_unlock(cpu);
+    qemu_mutex_lock_iothread();
     hvf_vcpu_destroy(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
+
     rcu_unregister_thread();
     return NULL;
 }
@@ -1759,6 +1862,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     current_cpu = cpu;
@@ -1768,28 +1872,40 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
         fprintf(stderr, "whpx_init_vcpu failed: %s\n", strerror(-r));
         exit(1);
     }
+    qemu_mutex_unlock_iothread();
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = whpx_vcpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
         while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+            qemu_cond_wait(cpu->halt_cond, cpu->lock);
         }
         qemu_wait_io_event_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    cpu_mutex_unlock(cpu);
+    qemu_mutex_lock_iothread();
     whpx_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
+
     rcu_unregister_thread();
     return NULL;
 }
@@ -1817,14 +1933,14 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     rcu_register_thread();
     tcg_register_thread();
 
-    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
     cpu->can_do_io = 1;
     current_cpu = cpu;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
 
     /* process any pending work */
     cpu->exit_request = 1;
@@ -1832,9 +1948,9 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     do {
         if (cpu_can_run(cpu)) {
             int r;
-            qemu_mutex_unlock_iothread();
+            cpu_mutex_unlock(cpu);
             r = tcg_cpu_exec(cpu);
-            qemu_mutex_lock_iothread();
+            cpu_mutex_lock(cpu);
             switch (r) {
             case EXCP_DEBUG:
                 cpu_handle_guest_debug(cpu);
@@ -1850,9 +1966,9 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 g_assert(cpu_halted(cpu));
                 break;
             case EXCP_ATOMIC:
-                qemu_mutex_unlock_iothread();
+                cpu_mutex_unlock(cpu);
                 cpu_exec_step_atomic(cpu);
-                qemu_mutex_lock_iothread();
+                cpu_mutex_lock(cpu);
             default:
                 /* Ignore everything else? */
                 break;
@@ -1865,8 +1981,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 
     qemu_tcg_destroy_vcpu(cpu);
     cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 }
@@ -1966,54 +2082,69 @@ void qemu_mutex_unlock_iothread(void)
     }
 }
 
-static bool all_vcpus_paused(void)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (!cpu->stopped) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
 void pause_all_vcpus(void)
 {
     CPUState *cpu;
 
+    g_assert(no_cpu_mutex_locked());
+
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         if (qemu_cpu_is_self(cpu)) {
             qemu_cpu_stop(cpu, true);
         } else {
             cpu->stop = true;
             qemu_cpu_kick(cpu);
         }
+        cpu_mutex_unlock(cpu);
     }
 
+ drop_locks_and_stop_all_vcpus:
     /* We need to drop the replay_lock so any vCPU threads woken up
      * can finish their replay tasks
      */
     replay_mutex_unlock();
+    qemu_mutex_unlock_iothread();
 
-    while (!all_vcpus_paused()) {
-        qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
-        CPU_FOREACH(cpu) {
+    CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
+        if (!cpu->stopped) {
+            cpu->stop = true;
             qemu_cpu_kick(cpu);
+            qemu_cond_wait(&cpu->cond, cpu->lock);
         }
+        cpu_mutex_unlock(cpu);
     }
 
-    qemu_mutex_unlock_iothread();
     replay_mutex_lock();
     qemu_mutex_lock_iothread();
+
+    /* a CPU might have been hot-plugged while we weren't holding the BQL */
+    CPU_FOREACH(cpu) {
+        bool stopped;
+
+        cpu_mutex_lock(cpu);
+        stopped = cpu->stopped;
+        cpu_mutex_unlock(cpu);
+
+        if (!stopped) {
+            goto drop_locks_and_stop_all_vcpus;
+        }
+    }
 }
 
 void cpu_resume(CPUState *cpu)
 {
-    cpu->stop = false;
-    cpu->stopped = false;
+    if (cpu_mutex_locked(cpu)) {
+        cpu->stop = false;
+        cpu->stopped = false;
+    } else {
+        cpu_mutex_lock(cpu);
+        cpu->stop = false;
+        cpu->stopped = false;
+        cpu_mutex_unlock(cpu);
+    }
     qemu_cpu_kick(cpu);
 }
 
@@ -2029,8 +2160,11 @@ void resume_all_vcpus(void)
 
 void cpu_remove_sync(CPUState *cpu)
 {
+    cpu_mutex_lock(cpu);
     cpu->stop = true;
     cpu->unplug = true;
+    cpu_mutex_unlock(cpu);
+
     qemu_cpu_kick(cpu);
     qemu_mutex_unlock_iothread();
     qemu_thread_join(cpu->thread);
@@ -2211,9 +2345,15 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_dummy_start_vcpu(cpu);
     }
 
+    qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
     while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+        qemu_cond_wait(&cpu->cond, cpu->lock);
     }
+    cpu_mutex_unlock(cpu);
+
+    qemu_mutex_lock_iothread();
 }
 
 void cpu_stop_current(void)
diff --git a/qom/cpu.c b/qom/cpu.c
index f2695be9b2..65b070a570 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -94,32 +94,13 @@ static void cpu_common_get_memory_mapping(CPUState *cpu,
     error_setg(errp, "Obtaining memory mappings is unsupported on this CPU.");
 }
 
-/* Resetting the IRQ comes from across the code base so we take the
- * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool has_bql = qemu_mutex_iothread_locked();
-    bool has_cpu_lock = cpu_mutex_locked(cpu);
-
-    if (has_bql) {
-        if (has_cpu_lock) {
-            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
-        } else {
-            cpu_mutex_lock(cpu);
-            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
-            cpu_mutex_unlock(cpu);
-        }
-        return;
-    }
-
-    if (has_cpu_lock) {
-        cpu_mutex_unlock(cpu);
-    }
-    qemu_mutex_lock_iothread();
-    cpu_mutex_lock(cpu);
-    atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
-    qemu_mutex_unlock_iothread();
-    if (!has_cpu_lock) {
+    if (cpu_mutex_locked(cpu)) {
+        atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+    } else {
+        cpu_mutex_lock(cpu);
+        atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
         cpu_mutex_unlock(cpu);
     }
 }
-- 
2.17.1
