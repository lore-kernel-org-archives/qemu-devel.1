Received: from eggs.gnu.org ([209.51.188.92]:35027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe35-0007sq-SO
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe34-0000dI-Gb
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:15 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe34-0000cu-CJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:14 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:02 -0500
Message-Id: <20190130004811.27372-5-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 04/73] cpu: make qemu_work_cond per-cpu
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

This eliminates the need to use the BQL to queue CPU work.

While at it, give the per-cpu field a generic name ("cond") since
it will soon be used for more than just queueing CPU work.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |  6 ++--
 cpus-common.c     | 72 ++++++++++++++++++++++++++++++++++++++---------
 cpus.c            |  2 +-
 qom/cpu.c         |  1 +
 4 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 403c48695b..46e3c164aa 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -322,6 +322,7 @@ struct qemu_work_item;
  * @mem_io_vaddr: Target virtual address at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
  * @lock: Lock to prevent multiple access to per-CPU fields.
+ * @cond: Condition variable for per-CPU events.
  * @work_list: List of pending asynchronous work.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
@@ -364,6 +365,7 @@ struct CPUState {
 
     QemuMutex lock;
     /* fields below protected by @lock */
+    QemuCond cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     CPUAddressSpace *cpu_ases;
@@ -771,12 +773,10 @@ bool cpu_is_stopped(CPUState *cpu);
  * @cpu: The vCPU to run on.
  * @func: The function to be executed.
  * @data: Data to pass to the function.
- * @mutex: Mutex to release while waiting for @func to run.
  *
  * Used internally in the implementation of run_on_cpu.
  */
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
-                   QemuMutex *mutex);
+void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
 /**
  * run_on_cpu:
diff --git a/cpus-common.c b/cpus-common.c
index d0e619f149..daf1531868 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -26,7 +26,6 @@
 static QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
 static QemuCond exclusive_resume;
-static QemuCond qemu_work_cond;
 
 /* >= 1 if a thread is inside start_exclusive/end_exclusive.  Written
  * under qemu_cpu_list_lock, read with atomic operations.
@@ -42,7 +41,6 @@ void qemu_init_cpu_list(void)
     qemu_mutex_init(&qemu_cpu_list_lock);
     qemu_cond_init(&exclusive_cond);
     qemu_cond_init(&exclusive_resume);
-    qemu_cond_init(&qemu_work_cond);
 }
 
 void cpu_list_lock(void)
@@ -113,23 +111,37 @@ struct qemu_work_item {
     bool free, exclusive, done;
 };
 
-static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
+/* Called with the CPU's lock held */
+static void queue_work_on_cpu_locked(CPUState *cpu, struct qemu_work_item *wi)
 {
-    qemu_mutex_lock(&cpu->lock);
     QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
     wi->done = false;
-    qemu_mutex_unlock(&cpu->lock);
 
     qemu_cpu_kick(cpu);
 }
 
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
-                   QemuMutex *mutex)
+static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
+{
+    cpu_mutex_lock(cpu);
+    queue_work_on_cpu_locked(cpu, wi);
+    cpu_mutex_unlock(cpu);
+}
+
+void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
     struct qemu_work_item wi;
+    bool has_bql = qemu_mutex_iothread_locked();
+
+    g_assert(no_cpu_mutex_locked());
 
     if (qemu_cpu_is_self(cpu)) {
-        func(cpu, data);
+        if (has_bql) {
+            func(cpu, data);
+        } else {
+            qemu_mutex_lock_iothread();
+            func(cpu, data);
+            qemu_mutex_unlock_iothread();
+        }
         return;
     }
 
@@ -139,13 +151,34 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
     wi.free = false;
     wi.exclusive = false;
 
-    queue_work_on_cpu(cpu, &wi);
+    cpu_mutex_lock(cpu);
+    queue_work_on_cpu_locked(cpu, &wi);
+
+    /*
+     * We are going to sleep on the CPU lock, so release the BQL.
+     *
+     * During the transition to per-CPU locks, we release the BQL _after_
+     * having kicked the destination CPU (from queue_work_on_cpu_locked above).
+     * This makes sure that the enqueued work will be seen by the CPU
+     * after being woken up from the kick, since the CPU sleeps on the BQL.
+     * Once we complete the transition to per-CPU locks, we will release
+     * the BQL earlier in this function.
+     */
+    if (has_bql) {
+        qemu_mutex_unlock_iothread();
+    }
+
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
 
-        qemu_cond_wait(&qemu_work_cond, mutex);
+        qemu_cond_wait(&cpu->cond, &cpu->lock);
         current_cpu = self_cpu;
     }
+    cpu_mutex_unlock(cpu);
+
+    if (has_bql) {
+        qemu_mutex_lock_iothread();
+    }
 }
 
 void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
@@ -307,6 +340,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
 void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
+    bool has_bql = qemu_mutex_iothread_locked();
 
     qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
@@ -324,13 +358,23 @@ void process_queued_cpu_work(CPUState *cpu)
              * BQL, so it goes to sleep; start_exclusive() is sleeping too, so
              * neither CPU can proceed.
              */
-            qemu_mutex_unlock_iothread();
+            if (has_bql) {
+                qemu_mutex_unlock_iothread();
+            }
             start_exclusive();
             wi->func(cpu, wi->data);
             end_exclusive();
-            qemu_mutex_lock_iothread();
+            if (has_bql) {
+                qemu_mutex_lock_iothread();
+            }
         } else {
-            wi->func(cpu, wi->data);
+            if (has_bql) {
+                wi->func(cpu, wi->data);
+            } else {
+                qemu_mutex_lock_iothread();
+                wi->func(cpu, wi->data);
+                qemu_mutex_unlock_iothread();
+            }
         }
         qemu_mutex_lock(&cpu->lock);
         if (wi->free) {
@@ -340,5 +384,5 @@ void process_queued_cpu_work(CPUState *cpu)
         }
     }
     qemu_mutex_unlock(&cpu->lock);
-    qemu_cond_broadcast(&qemu_work_cond);
+    qemu_cond_broadcast(&cpu->cond);
 }
diff --git a/cpus.c b/cpus.c
index 187aed2533..42ea8cfbb5 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1236,7 +1236,7 @@ void qemu_init_cpu_loop(void)
 
 void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
-    do_run_on_cpu(cpu, func, data, &qemu_global_mutex);
+    do_run_on_cpu(cpu, func, data);
 }
 
 static void qemu_kvm_destroy_vcpu(CPUState *cpu)
diff --git a/qom/cpu.c b/qom/cpu.c
index a2964e53c6..be8393e589 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -372,6 +372,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_threads = 1;
 
     qemu_mutex_init(&cpu->lock);
+    qemu_cond_init(&cpu->cond);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
-- 
2.17.1
