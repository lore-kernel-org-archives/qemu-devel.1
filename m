Received: from eggs.gnu.org ([2001:4830:134:3::10]:48911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3wP-0003Q9-VE
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3wO-0003YC-0l
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:37 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX3wN-0003Xu-O3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:35 -0500
Received: by mail-wm0-x22f.google.com with SMTP id c206so130181812wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:39:35 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:39:08 +0000
Message-Id: <20170127103922.19658-12-alex.bennee@linaro.org>
In-Reply-To: <20170127103922.19658-1-alex.bennee@linaro.org>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 11/25] tcg: enable thread-per-vCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

There are a couple of changes that occur at the same time here:

  - introduce a single vCPU qemu_tcg_cpu_thread_fn

  One of these is spawned per vCPU with its own Thread and Condition
  variables. qemu_tcg_rr_cpu_thread_fn is the new name for the old
  single threaded function.

  - the TLS current_cpu variable is now live for the lifetime of MTTCG
    vCPU threads. This is for future work where async jobs need to know
    the vCPU context they are operating in.

The user to switch on multi-thread behaviour and spawn a thread
per-vCPU. For a simple test kvm-unit-test like:

  ./arm/run ./arm/locking-test.flat -smp 4 -accel tcg,thread=multi

Will now use 4 vCPU threads and have an expected FAIL (instead of the
unexpected PASS) as the default mode of the test has no protection when
incrementing a shared variable.

We enable the parallel_cpus flag to ensure we generate correct barrier
and atomic code if supported by the front and backends. As each back end
and front end is updated they can add CONFIG_MTTCG_TARGET and
CONFIG_MTTCG_HOST to their respective make configurations so
default_mttcg_enabled does the right thing.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[AJB: Some fixes, conditionally, commit rewording]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
v1 (ajb):
  - fix merge conflicts
  - maintain single-thread approach
v2
  - re-base fixes (no longer has tb_find_fast lock tweak ahead)
  - remove bogus break condition on cpu->stop/stopped
  - only process exiting cpus exit_request
  - handle all cpus idle case (fixes shutdown issues)
  - sleep on EXCP_HALTED in mttcg mode (prevent crash on start-up)
  - move icount timer into helper
v3
  - update the commit message
  - rm kick_timer tweaks (move to earlier tcg_current_cpu tweaks)
  - ensure linux-user clears cpu->exit_request in loop
  - purging of global exit_request and tcg_current_cpu in earlier patches
  - fix checkpatch warnings
v4
  - don't break loop on stopped, we may never schedule next in RR mode
  - make sure we flush iorequests of current cpu if we exited on one
  - add tcg_cpu_exec_start/end wraps for async work functions
  - stop killing of current_cpu on loop exit
  - set current_cpu in the single thread function
  - remove sleep special case, add qemu_tcg_should_sleep() for mttcg
  - no need to atomic set cpu->exit_request going into the loop
  - removed extraneous setting of exit_request
  - split tb_lock() part of patch
  - rename single thread fn to qemu_tcg_rr_cpu_thread_fn
v5
  - enable parallel_cpus for MTTCG (for barriers/atomics)
  - expand on CONFIG_ flags in commit message
v7
  - move parallel_cpus down into the mttcg leg
  - minor ws merge fix
---
 cpu-exec.c |   5 ---
 cpus.c     | 134 +++++++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 103 insertions(+), 36 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index cc09c1fc37..ef328087be 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -396,7 +396,6 @@ static inline bool cpu_handle_halt(CPUState *cpu)
         }
 #endif
         if (!cpu_has_work(cpu)) {
-            current_cpu = NULL;
             return true;
         }
 
@@ -540,7 +539,6 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
 
 
     if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
-        atomic_set(&cpu->exit_request, 0);
         cpu->exception_index = EXCP_INTERRUPT;
         cpu_loop_exit(cpu);
     }
@@ -675,8 +673,5 @@ int cpu_exec(CPUState *cpu)
     cc->cpu_exec_exit(cpu);
     rcu_read_unlock();
 
-    /* fail safe : never use current_cpu outside cpu_exec() */
-    current_cpu = NULL;
-
     return ret;
 }
diff --git a/cpus.c b/cpus.c
index 18daf41dae..ecd1ec08d3 100644
--- a/cpus.c
+++ b/cpus.c
@@ -808,7 +808,7 @@ static void kick_tcg_thread(void *opaque)
 
 static void start_tcg_kick_timer(void)
 {
-    if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
+    if (!mttcg_enabled && !tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
         tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                            kick_tcg_thread, NULL);
         timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
@@ -1062,27 +1062,34 @@ static void qemu_tcg_destroy_vcpu(CPUState *cpu)
 
 static void qemu_wait_io_event_common(CPUState *cpu)
 {
+    atomic_mb_set(&cpu->thread_kicked, false);
     if (cpu->stop) {
         cpu->stop = false;
         cpu->stopped = true;
         qemu_cond_broadcast(&qemu_pause_cond);
     }
     process_queued_cpu_work(cpu);
-    cpu->thread_kicked = false;
+}
+
+static bool qemu_tcg_should_sleep(CPUState *cpu)
+{
+    if (mttcg_enabled) {
+        return cpu_thread_is_idle(cpu);
+    } else {
+        return all_cpu_threads_idle();
+    }
 }
 
 static void qemu_tcg_wait_io_event(CPUState *cpu)
 {
-    while (all_cpu_threads_idle()) {
+    while (qemu_tcg_should_sleep(cpu)) {
         stop_tcg_kick_timer();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
 
     start_tcg_kick_timer();
 
-    CPU_FOREACH(cpu) {
-        qemu_wait_io_event_common(cpu);
-    }
+    qemu_wait_io_event_common(cpu);
 }
 
 static void qemu_kvm_wait_io_event(CPUState *cpu)
@@ -1153,6 +1160,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     cpu->can_do_io = 1;
+    current_cpu = cpu;
 
     sigemptyset(&waitset);
     sigaddset(&waitset, SIG_IPI);
@@ -1161,9 +1169,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
     cpu->created = true;
     qemu_cond_signal(&qemu_cpu_cond);
 
-    current_cpu = cpu;
     while (1) {
-        current_cpu = NULL;
         qemu_mutex_unlock_iothread();
         do {
             int sig;
@@ -1174,7 +1180,6 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
             exit(1);
         }
         qemu_mutex_lock_iothread();
-        current_cpu = cpu;
         qemu_wait_io_event_common(cpu);
     }
 
@@ -1286,7 +1291,7 @@ static void deal_with_unplugged_cpus(void)
  * elsewhere.
  */
 
-static void *qemu_tcg_cpu_thread_fn(void *arg)
+static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
 
@@ -1308,6 +1313,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 
         /* process any pending work */
         CPU_FOREACH(cpu) {
+            current_cpu = cpu;
             qemu_wait_io_event_common(cpu);
         }
     }
@@ -1329,6 +1335,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 
         while (cpu && !cpu->exit_request) {
             atomic_mb_set(&tcg_current_rr_cpu, cpu);
+            current_cpu = cpu;
 
             qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
                               (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
@@ -1340,7 +1347,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                     cpu_handle_guest_debug(cpu);
                     break;
                 }
-            } else if (cpu->stop || cpu->stopped) {
+            } else if (cpu->stop) {
                 if (cpu->unplug) {
                     cpu = CPU_NEXT(cpu);
                 }
@@ -1359,7 +1366,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 
         handle_icount_deadline();
 
-        qemu_tcg_wait_io_event(QTAILQ_FIRST(&cpus));
+        qemu_tcg_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
         deal_with_unplugged_cpus();
     }
 
@@ -1406,6 +1413,64 @@ static void CALLBACK dummy_apc_func(ULONG_PTR unused)
 }
 #endif
 
+/* Multi-threaded TCG
+ *
+ * In the multi-threaded case each vCPU has its own thread. The TLS
+ * variable current_cpu can be used deep in the code to find the
+ * current CPUState for a given thread.
+ */
+
+static void *qemu_tcg_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->created = true;
+    cpu->can_do_io = 1;
+    current_cpu = cpu;
+    qemu_cond_signal(&qemu_cpu_cond);
+
+    /* process any pending work */
+    cpu->exit_request = 1;
+
+    while (1) {
+        if (cpu_can_run(cpu)) {
+            int r;
+            r = tcg_cpu_exec(cpu);
+            switch (r) {
+            case EXCP_DEBUG:
+                cpu_handle_guest_debug(cpu);
+                break;
+            case EXCP_HALTED:
+                /* during start-up the vCPU is reset and the thread is
+                 * kicked several times. If we don't ensure we go back
+                 * to sleep in the halted state we won't cleanly
+                 * start-up when the vCPU is enabled.
+                 *
+                 * cpu->halted should ensure we sleep in wait_io_event
+                 */
+                g_assert(cpu->halted);
+                break;
+            default:
+                /* Ignore everything else? */
+                break;
+            }
+        }
+
+        handle_icount_deadline();
+
+        atomic_mb_set(&cpu->exit_request, 0);
+        qemu_tcg_wait_io_event(cpu);
+    }
+
+    return NULL;
+}
+
 static void qemu_cpu_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
@@ -1436,7 +1501,7 @@ void qemu_cpu_kick(CPUState *cpu)
     qemu_cond_broadcast(cpu->halt_cond);
     if (tcg_enabled()) {
         cpu_exit(cpu);
-        /* Also ensure current RR cpu is kicked */
+        /* NOP unless doing single-thread RR */
         qemu_cpu_kick_rr_cpu();
     } else {
         if (hax_enabled()) {
@@ -1512,13 +1577,6 @@ void pause_all_vcpus(void)
 
     if (qemu_in_vcpu_thread()) {
         cpu_stop_current();
-        if (!kvm_enabled()) {
-            CPU_FOREACH(cpu) {
-                cpu->stop = false;
-                cpu->stopped = true;
-            }
-            return;
-        }
     }
 
     while (!all_vcpus_paused()) {
@@ -1567,29 +1625,43 @@ void cpu_remove_sync(CPUState *cpu)
 static void qemu_tcg_init_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
-    static QemuCond *tcg_halt_cond;
-    static QemuThread *tcg_cpu_thread;
+    static QemuCond *single_tcg_halt_cond;
+    static QemuThread *single_tcg_cpu_thread;
 
-    /* share a single thread for all cpus with TCG */
-    if (!tcg_cpu_thread) {
+    if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
         cpu->thread = g_malloc0(sizeof(QemuThread));
         cpu->halt_cond = g_malloc0(sizeof(QemuCond));
         qemu_cond_init(cpu->halt_cond);
-        tcg_halt_cond = cpu->halt_cond;
-        snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
+
+        if (qemu_tcg_mttcg_enabled()) {
+            /* create a thread per vCPU with TCG (MTTCG) */
+            parallel_cpus = true;
+            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
                  cpu->cpu_index);
-        qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                           cpu, QEMU_THREAD_JOINABLE);
+
+            qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
+                               cpu, QEMU_THREAD_JOINABLE);
+
+        } else {
+            /* share a single thread for all cpus with TCG */
+            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
+            qemu_thread_create(cpu->thread, thread_name,
+                               qemu_tcg_rr_cpu_thread_fn,
+                               cpu, QEMU_THREAD_JOINABLE);
+
+            single_tcg_halt_cond = cpu->halt_cond;
+            single_tcg_cpu_thread = cpu->thread;
+        }
 #ifdef _WIN32
         cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
         while (!cpu->created) {
             qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
         }
-        tcg_cpu_thread = cpu->thread;
     } else {
-        cpu->thread = tcg_cpu_thread;
-        cpu->halt_cond = tcg_halt_cond;
+        /* For non-MTTCG cases we share the thread */
+        cpu->thread = single_tcg_cpu_thread;
+        cpu->halt_cond = single_tcg_halt_cond;
     }
 }
 
-- 
2.11.0
