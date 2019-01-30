Received: from eggs.gnu.org ([209.51.188.92]:35074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe36-0007t7-UY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe35-0000e2-8Y
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:16 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe35-0000dl-4U
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:15 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:05 -0500
Message-Id: <20190130004811.27372-8-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 07/73] cpu: make per-CPU locks an alias of
 the BQL in TCG rr mode
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

Before we can switch from the BQL to per-CPU locks in
the CPU loop, we have to accommodate the fact that TCG
rr mode (i.e. !MTTCG) cannot work with separate per-vCPU
locks. That would lead to deadlock since we need a single
lock/condvar pair on which to wait for events that affect
any vCPU, e.g. in qemu_tcg_rr_wait_io_event.

At the same time, we are moving towards an interface where
the BQL and CPU locks are independent, and the only requirement
is that the locking order is respected, i.e. the BQL is
acquired first if both locks have to be held at the same time.

In this patch we make the BQL a recursive lock under the hood.
This allows us to (1) keep the BQL and CPU locks interfaces
separate, and (2) use a single lock for all vCPUs in TCG rr mode.

Note that the BQL's API (qemu_mutex_lock/unlock_iothread) remains
non-recursive.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |  2 +-
 cpus-common.c     |  2 +-
 cpus.c            | 90 +++++++++++++++++++++++++++++++++++++++++------
 qom/cpu.c         |  3 +-
 stubs/cpu-lock.c  |  6 ++--
 5 files changed, 86 insertions(+), 17 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index fe389037c5..8b85a036cf 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -363,7 +363,7 @@ struct CPUState {
     int64_t icount_extra;
     sigjmp_buf jmp_env;
 
-    QemuMutex lock;
+    QemuMutex *lock;
     /* fields below protected by @lock */
     QemuCond cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
diff --git a/cpus-common.c b/cpus-common.c
index 99662bfa87..62e282bff1 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -171,7 +171,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
 
-        qemu_cond_wait(&cpu->cond, &cpu->lock);
+        qemu_cond_wait(&cpu->cond, cpu->lock);
         current_cpu = self_cpu;
     }
     cpu_mutex_unlock(cpu);
diff --git a/cpus.c b/cpus.c
index 755e4addab..c4fa3cc876 100644
--- a/cpus.c
+++ b/cpus.c
@@ -83,6 +83,12 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+static inline bool qemu_is_tcg_rr(void)
+{
+    /* in `make check-qtest', "use_icount && !tcg_enabled()" might be true */
+    return use_icount || (tcg_enabled() && !qemu_tcg_mttcg_enabled());
+}
+
 /* XXX: is this really the max number of CPUs? */
 #define CPU_LOCK_BITMAP_SIZE 2048
 
@@ -98,25 +104,76 @@ bool no_cpu_mutex_locked(void)
     return bitmap_empty(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
 }
 
-void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+static QemuMutex qemu_global_mutex;
+static __thread bool iothread_locked;
+/*
+ * In TCG rr mode, we make the BQL a recursive mutex, so that we can use it for
+ * all vCPUs while keeping the interface as if the locks were per-CPU.
+ *
+ * The fact that the BQL is implemented recursively is invisible to BQL users;
+ * the mutex API we export (qemu_mutex_lock_iothread() etc.) is non-recursive.
+ *
+ * Locking order: the BQL is always acquired before CPU locks.
+ */
+static __thread int iothread_lock_count;
+
+static void rr_cpu_mutex_lock(void)
+{
+    if (iothread_lock_count++ == 0) {
+        /*
+         * Circumvent qemu_mutex_lock_iothread()'s state keeping by
+         * acquiring the BQL directly.
+         */
+        qemu_mutex_lock(&qemu_global_mutex);
+    }
+}
+
+static void rr_cpu_mutex_unlock(void)
+{
+    g_assert(iothread_lock_count > 0);
+    if (--iothread_lock_count == 0) {
+        /*
+         * Circumvent qemu_mutex_unlock_iothread()'s state keeping by
+         * releasing the BQL directly.
+         */
+        qemu_mutex_unlock(&qemu_global_mutex);
+    }
+}
+
+static void do_cpu_mutex_lock(CPUState *cpu, const char *file, int line)
 {
-/* coverity gets confused by the indirect function call */
+    /* coverity gets confused by the indirect function call */
 #ifdef __COVERITY__
-    qemu_mutex_lock_impl(&cpu->lock, file, line);
+    qemu_mutex_lock_impl(cpu->lock, file, line);
 #else
     QemuMutexLockFunc f = atomic_read(&qemu_mutex_lock_func);
 
+    f(cpu->lock, file, line);
+#endif
+}
+
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+{
     g_assert(!cpu_mutex_locked(cpu));
     set_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
-    f(&cpu->lock, file, line);
-#endif
+
+    if (qemu_is_tcg_rr()) {
+        rr_cpu_mutex_lock();
+    } else {
+        do_cpu_mutex_lock(cpu, file, line);
+    }
 }
 
 void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
 {
     g_assert(cpu_mutex_locked(cpu));
-    qemu_mutex_unlock_impl(&cpu->lock, file, line);
     clear_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
+
+    if (qemu_is_tcg_rr()) {
+        rr_cpu_mutex_unlock();
+        return;
+    }
+    qemu_mutex_unlock_impl(cpu->lock, file, line);
 }
 
 bool cpu_mutex_locked(const CPUState *cpu)
@@ -1215,8 +1272,6 @@ static void qemu_init_sigbus(void)
 }
 #endif /* !CONFIG_LINUX */
 
-static QemuMutex qemu_global_mutex;
-
 static QemuThread io_thread;
 
 /* cpu creation */
@@ -1876,8 +1931,6 @@ bool qemu_in_vcpu_thread(void)
     return current_cpu && qemu_cpu_is_self(current_cpu);
 }
 
-static __thread bool iothread_locked = false;
-
 bool qemu_mutex_iothread_locked(void)
 {
     return iothread_locked;
@@ -1896,6 +1949,8 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line)
 
     g_assert(!qemu_mutex_iothread_locked());
     bql_lock(&qemu_global_mutex, file, line);
+    g_assert(iothread_lock_count == 0);
+    iothread_lock_count++;
     iothread_locked = true;
 }
 
@@ -1903,7 +1958,10 @@ void qemu_mutex_unlock_iothread(void)
 {
     g_assert(qemu_mutex_iothread_locked());
     iothread_locked = false;
-    qemu_mutex_unlock(&qemu_global_mutex);
+    g_assert(iothread_lock_count > 0);
+    if (--iothread_lock_count == 0) {
+        qemu_mutex_unlock(&qemu_global_mutex);
+    }
 }
 
 static bool all_vcpus_paused(void)
@@ -2127,6 +2185,16 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
+    /*
+     * In TCG RR, cpu->lock is the BQL under the hood. In all other modes,
+     * cpu->lock is a standalone per-CPU lock.
+     */
+    if (qemu_is_tcg_rr()) {
+        qemu_mutex_destroy(cpu->lock);
+        g_free(cpu->lock);
+        cpu->lock = &qemu_global_mutex;
+    }
+
     if (kvm_enabled()) {
         qemu_kvm_start_vcpu(cpu);
     } else if (hax_enabled()) {
diff --git a/qom/cpu.c b/qom/cpu.c
index be8393e589..2c05aa1bca 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -371,7 +371,8 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
 
-    qemu_mutex_init(&cpu->lock);
+    cpu->lock = g_new(QemuMutex, 1);
+    qemu_mutex_init(cpu->lock);
     qemu_cond_init(&cpu->cond);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
diff --git a/stubs/cpu-lock.c b/stubs/cpu-lock.c
index 3f07d3a28b..7406a66d97 100644
--- a/stubs/cpu-lock.c
+++ b/stubs/cpu-lock.c
@@ -5,16 +5,16 @@ void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
 {
 /* coverity gets confused by the indirect function call */
 #ifdef __COVERITY__
-    qemu_mutex_lock_impl(&cpu->lock, file, line);
+    qemu_mutex_lock_impl(cpu->lock, file, line);
 #else
     QemuMutexLockFunc f = atomic_read(&qemu_mutex_lock_func);
-    f(&cpu->lock, file, line);
+    f(cpu->lock, file, line);
 #endif
 }
 
 void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
 {
-    qemu_mutex_unlock_impl(&cpu->lock, file, line);
+    qemu_mutex_unlock_impl(cpu->lock, file, line);
 }
 
 bool cpu_mutex_locked(const CPUState *cpu)
-- 
2.17.1
