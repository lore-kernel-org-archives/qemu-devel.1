Received: from eggs.gnu.org ([2001:4830:134:3::10]:59635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJGJ-0005MV-1D
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJG7-0003jE-5Z
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:27 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJG4-0003Hl-Oy
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:23 -0400
Message-Id: <20181019010625.25294-55-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 54/56] cpu: protect most CPU state with
 cpu->lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Instead of taking the BQL every time we exit the exec loop,
have a per-CPU lock to serialize accesses the the CPU's state.

Differently from the BQL, this lock is uncontended so
acquiring it is cheap.

Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |  20 ++--
 cpus.c            | 290 ++++++++++++++++++++++++++++++++--------------
 qom/cpu.c         |  23 ++--
 3 files changed, 221 insertions(+), 112 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index ca7d92c360..b351fe6164 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -286,10 +286,6 @@ struct qemu_work_item;
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
@@ -318,6 +314,10 @@ struct qemu_work_item;
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
@@ -341,12 +341,7 @@ struct CPUState {
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
@@ -360,7 +355,13 @@ struct CPUState {
     QemuMutex lock;
     /* fields below protected by @lock */
     QemuCond cond;
+    QemuCond halt_cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
+    uint32_t halted;
+    bool created;
+    bool stop;
+    bool stopped;
+    bool unplug;
 
     CPUAddressSpace *cpu_ases;
     int num_ases;
@@ -407,7 +408,6 @@ struct CPUState {
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
-    uint32_t halted;
     uint32_t can_do_io;
     int32_t exception_index;
 
diff --git a/cpus.c b/cpus.c
index a101e8863c..c92776507e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -124,30 +124,36 @@ bool cpu_mutex_locked(const CPUState *cpu)
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
         return true;
     }
-    if (!cpu->halted || cpu_has_work(cpu) ||
+    if (!cpu_halted(cpu) || cpu_has_work(cpu) ||
         kvm_halt_in_kernel()) {
         return false;
     }
@@ -157,13 +163,23 @@ static bool cpu_thread_is_idle(CPUState *cpu)
 static bool all_cpu_threads_idle(void)
 {
     CPUState *cpu;
+    bool ret = true;
+
+    g_assert(no_cpu_mutex_locked());
 
+    CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
+    }
     CPU_FOREACH(cpu) {
         if (!cpu_thread_is_idle(cpu)) {
-            return false;
+            ret = false;
+            break;
         }
     }
-    return true;
+    CPU_FOREACH(cpu) {
+        cpu_mutex_unlock(cpu);
+    }
+    return ret;
 }
 
 /***********************************************************/
@@ -721,6 +737,8 @@ void qemu_start_warp_timer(void)
 
 static void qemu_account_warp_timer(void)
 {
+    g_assert(qemu_mutex_iothread_locked());
+
     if (!use_icount || !icount_sleep) {
         return;
     }
@@ -1031,6 +1049,7 @@ static void kick_tcg_thread(void *opaque)
 static void start_tcg_kick_timer(void)
 {
     assert(!mttcg_enabled);
+    g_assert(qemu_mutex_iothread_locked());
     if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
         tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                            kick_tcg_thread, NULL);
@@ -1043,6 +1062,7 @@ static void start_tcg_kick_timer(void)
 static void stop_tcg_kick_timer(void)
 {
     assert(!mttcg_enabled);
+    g_assert(qemu_mutex_iothread_locked());
     if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
         timer_del(tcg_kick_vcpu_timer);
     }
@@ -1145,6 +1165,8 @@ int vm_shutdown(void)
 
 static bool cpu_can_run(CPUState *cpu)
 {
+    g_assert(cpu_mutex_locked(cpu));
+
     if (cpu->stop) {
         return false;
     }
@@ -1221,14 +1243,11 @@ static QemuThread io_thread;
 
 /* cpu creation */
 static QemuCond qemu_cpu_cond;
-/* system init */
-static QemuCond qemu_pause_cond;
 
 void qemu_init_cpu_loop(void)
 {
     qemu_init_sigbus();
     qemu_cond_init(&qemu_cpu_cond);
-    qemu_cond_init(&qemu_pause_cond);
     qemu_mutex_init(&qemu_global_mutex);
 
     qemu_thread_get_self(&io_thread);
@@ -1246,42 +1265,66 @@ static void qemu_tcg_destroy_vcpu(CPUState *cpu)
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
-    process_queued_cpu_work(cpu);
+    process_queued_cpu_work_locked(cpu);
 }
 
 static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
 {
+    g_assert(qemu_mutex_iothread_locked());
+    g_assert(no_cpu_mutex_locked());
+
     while (all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
-        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_mutex_unlock_iothread();
+
+        cpu_mutex_lock(cpu);
+        qemu_cond_wait(&cpu->halt_cond, &cpu->lock);
+        cpu_mutex_unlock(cpu);
+
+        qemu_mutex_lock_iothread();
     }
 
     start_tcg_kick_timer();
 
+    cpu_mutex_lock(cpu);
     qemu_wait_io_event_common(cpu);
+    cpu_mutex_unlock(cpu);
 }
 
 static void qemu_wait_io_event(CPUState *cpu)
 {
+    g_assert(cpu_mutex_locked(cpu));
+    g_assert(!qemu_mutex_iothread_locked());
+
     while (cpu_thread_is_idle(cpu)) {
-        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait(&cpu->halt_cond, &cpu->lock);
     }
 
 #ifdef _WIN32
@@ -1301,6 +1344,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     cpu->can_do_io = 1;
@@ -1313,14 +1357,20 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
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
@@ -1328,10 +1378,16 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
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
@@ -1348,7 +1404,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 
     rcu_register_thread();
 
-    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     cpu->can_do_io = 1;
@@ -1359,10 +1415,10 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 
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
@@ -1371,10 +1427,11 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
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
@@ -1405,6 +1462,8 @@ static int64_t tcg_get_icount_limit(void)
 static void handle_icount_deadline(void)
 {
     assert(qemu_in_vcpu_thread());
+    g_assert(qemu_mutex_iothread_locked());
+
     if (use_icount) {
         int64_t deadline =
             qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
@@ -1485,12 +1544,15 @@ static void deal_with_unplugged_cpus(void)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         if (cpu->unplug && !cpu_can_run(cpu)) {
             qemu_tcg_destroy_vcpu(cpu);
             cpu->created = false;
             qemu_cond_signal(&qemu_cpu_cond);
+            cpu_mutex_unlock(cpu);
             break;
         }
+        cpu_mutex_unlock(cpu);
     }
 }
 
@@ -1511,25 +1573,33 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     rcu_register_thread();
     tcg_register_thread();
 
-    qemu_mutex_lock_iothread();
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
+        qemu_cond_wait(&first_cpu->halt_cond, &first_cpu->lock);
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
 
+    qemu_mutex_lock_iothread();
     start_tcg_kick_timer();
 
     cpu = first_cpu;
@@ -1555,7 +1625,12 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
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
@@ -1566,6 +1641,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             if (cpu_can_run(cpu)) {
                 int r;
 
+                cpu_mutex_unlock(cpu);
                 qemu_mutex_unlock_iothread();
                 prepare_icount_for_run(cpu);
 
@@ -1573,11 +1649,14 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
 
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
@@ -1587,11 +1666,13 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
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
 
         /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
         atomic_set(&tcg_current_rr_cpu, NULL);
@@ -1615,19 +1696,26 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
     rcu_register_thread();
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
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
@@ -1635,6 +1723,8 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
+
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 }
@@ -1652,6 +1742,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
@@ -1659,14 +1750,20 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
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
@@ -1674,10 +1771,16 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
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
@@ -1690,6 +1793,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     current_cpu = cpu;
@@ -1699,28 +1803,40 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
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
+            qemu_cond_wait(&cpu->halt_cond, &cpu->lock);
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
@@ -1748,14 +1864,14 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
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
@@ -1763,9 +1879,9 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
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
@@ -1778,12 +1894,12 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                  *
                  * cpu->halted should ensure we sleep in wait_io_event
                  */
-                g_assert(cpu->halted);
+                g_assert(cpu_halted(cpu));
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
@@ -1796,8 +1912,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 
     qemu_tcg_destroy_vcpu(cpu);
     cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 }
@@ -1831,7 +1947,7 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
 
 void qemu_cpu_kick(CPUState *cpu)
 {
-    qemu_cond_broadcast(cpu->halt_cond);
+    qemu_cond_broadcast(&cpu->halt_cond);
     if (tcg_enabled()) {
         cpu_exit(cpu);
         /* NOP unless doing single-thread RR */
@@ -1894,19 +2010,6 @@ void qemu_mutex_unlock_iothread(void)
     qemu_mutex_unlock(&qemu_global_mutex);
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
@@ -1925,23 +2028,38 @@ void pause_all_vcpus(void)
      * can finish their replay tasks
      */
     replay_mutex_unlock();
+    qemu_mutex_unlock_iothread();
 
-    while (!all_vcpus_paused()) {
-        qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
-        CPU_FOREACH(cpu) {
-            qemu_cpu_kick(cpu);
+    CPU_FOREACH(cpu) {
+        CPUState *cs;
+
+        /* XXX: is this necessary, or just paranoid? */
+        CPU_FOREACH(cs) {
+            qemu_cpu_kick(cs);
+        }
+
+        cpu_mutex_lock(cpu);
+        if (!cpu->stopped) {
+            qemu_cond_wait(&cpu->cond, &cpu->lock);
         }
+        cpu_mutex_unlock(cpu);
     }
 
-    qemu_mutex_unlock_iothread();
     replay_mutex_lock();
     qemu_mutex_lock_iothread();
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
 
@@ -1957,8 +2075,11 @@ void resume_all_vcpus(void)
 
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
@@ -1971,7 +2092,6 @@ void cpu_remove_sync(CPUState *cpu)
 static void qemu_tcg_init_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
-    static QemuCond *single_tcg_halt_cond;
     static QemuThread *single_tcg_cpu_thread;
     static int tcg_region_inited;
 
@@ -1989,8 +2109,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
 
     if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
         cpu->thread = g_malloc0(sizeof(QemuThread));
-        cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-        qemu_cond_init(cpu->halt_cond);
 
         if (qemu_tcg_mttcg_enabled()) {
             /* create a thread per vCPU with TCG (MTTCG) */
@@ -2008,7 +2126,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
                                qemu_tcg_rr_cpu_thread_fn,
                                cpu, QEMU_THREAD_JOINABLE);
 
-            single_tcg_halt_cond = cpu->halt_cond;
             single_tcg_cpu_thread = cpu->thread;
         }
 #ifdef _WIN32
@@ -2017,7 +2134,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     } else {
         /* For non-MTTCG cases we share the thread */
         cpu->thread = single_tcg_cpu_thread;
-        cpu->halt_cond = single_tcg_halt_cond;
         cpu->thread_id = first_cpu->thread_id;
         cpu->can_do_io = 1;
         cpu->created = true;
@@ -2029,8 +2145,6 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
              cpu->cpu_index);
@@ -2046,8 +2160,6 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
@@ -2063,8 +2175,6 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
     assert(hvf_enabled());
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
              cpu->cpu_index);
@@ -2077,8 +2187,6 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
@@ -2093,8 +2201,6 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn, cpu,
@@ -2129,9 +2235,15 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_dummy_start_vcpu(cpu);
     }
 
+    qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
     while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+        qemu_cond_wait(&cpu->cond, &cpu->lock);
     }
+    cpu_mutex_unlock(cpu);
+
+    qemu_mutex_lock_iothread();
 }
 
 void cpu_stop_current(void)
@@ -2261,7 +2373,7 @@ CpuInfoList *qmp_query_cpus(Error **errp)
         info->value = g_malloc0(sizeof(*info->value));
         info->value->CPU = cpu->cpu_index;
         info->value->current = (cpu == first_cpu);
-        info->value->halted = cpu->halted;
+        info->value->halted = cpu_halted(cpu);
         info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
         info->value->thread_id = cpu->thread_id;
 #if defined(TARGET_I386)
diff --git a/qom/cpu.c b/qom/cpu.c
index bb031a3a6a..2aa760eed0 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -94,18 +94,14 @@ static void cpu_common_get_memory_mapping(CPUState *cpu,
     error_setg(errp, "Obtaining memory mappings is unsupported on this CPU.");
 }
 
-/* Resetting the IRQ comes from across the code base so we take the
- * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool need_lock = !qemu_mutex_iothread_locked();
-
-    if (need_lock) {
-        qemu_mutex_lock_iothread();
-    }
-    cpu->interrupt_request &= ~mask;
-    if (need_lock) {
-        qemu_mutex_unlock_iothread();
+    if (cpu_mutex_locked(cpu)) {
+        cpu->interrupt_request &= ~mask;
+    } else {
+        cpu_mutex_lock(cpu);
+        cpu->interrupt_request &= ~mask;
+        cpu_mutex_unlock(cpu);
     }
 }
 
@@ -261,8 +257,8 @@ static void cpu_common_reset(CPUState *cpu)
         log_cpu_state(cpu, cc->reset_dump_flags);
     }
 
-    cpu->interrupt_request = 0;
-    cpu->halted = 0;
+    cpu_interrupt_request_set(cpu, 0);
+    cpu_halted_set(cpu, 0);
     cpu->mem_io_pc = 0;
     cpu->mem_io_vaddr = 0;
     cpu->icount_extra = 0;
@@ -374,6 +370,7 @@ static void cpu_common_initfn(Object *obj)
 
     qemu_mutex_init(&cpu->lock);
     qemu_cond_init(&cpu->cond);
+    qemu_cond_init(&cpu->halt_cond);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
@@ -397,7 +394,7 @@ static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
 
 static void generic_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-- 
2.17.1
