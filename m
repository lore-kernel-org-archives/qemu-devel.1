Received: from eggs.gnu.org ([2001:4830:134:3::10]:58628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFR-0004UK-4z
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFN-0002my-1P
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFM-0002aO-6T
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:33 -0400
Message-Id: <20181019010625.25294-5-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 04/56] cpu: make qemu_work_cond per-cpu
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

This eliminates the need to use the BQL to queue CPU work.

While at it, give the per-cpu field a generic name ("cond") since
it will soon be used for more than just queueing CPU work.

Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |  6 +++---
 cpus-common.c     | 48 ++++++++++++++++++++++++++++++++++-------------
 cpus.c            |  2 +-
 qom/cpu.c         |  1 +
 4 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1292e7aa33..82937881ef 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -316,6 +316,7 @@ struct qemu_work_item;
  * @mem_io_vaddr: Target virtual address at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
  * @lock: Lock to prevent multiple access to per-CPU fields.
+ * @cond: Condition variable for per-CPU events.
  * @work_list: List of pending asynchronous work.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
@@ -358,6 +359,7 @@ struct CPUState {
 
     QemuMutex lock;
     /* fields below protected by @lock */
+    QemuCond cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     CPUAddressSpace *cpu_ases;
@@ -762,12 +764,10 @@ bool cpu_is_stopped(CPUState *cpu);
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
index 2913294cb7..2881707c35 100644
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
@@ -113,39 +111,52 @@ struct qemu_work_item {
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
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (qemu_cpu_is_self(cpu)) {
         func(cpu, data);
         return;
     }
 
+    qemu_mutex_unlock_iothread();
+
     wi.func = func;
     wi.data = data;
     wi.done = false;
     wi.free = false;
     wi.exclusive = false;
 
-    queue_work_on_cpu(cpu, &wi);
+    cpu_mutex_lock(cpu);
+    queue_work_on_cpu_locked(cpu, &wi);
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
 
-        qemu_cond_wait(&qemu_work_cond, mutex);
+        qemu_cond_wait(&cpu->cond, &cpu->lock);
         current_cpu = self_cpu;
     }
+    cpu_mutex_unlock(cpu);
+
+    qemu_mutex_lock_iothread();
 }
 
 void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
@@ -307,6 +318,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
 void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
+    bool has_bql = qemu_mutex_iothread_locked();
 
     qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
@@ -324,13 +336,23 @@ void process_queued_cpu_work(CPUState *cpu)
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
@@ -340,5 +362,5 @@ void process_queued_cpu_work(CPUState *cpu)
         }
     }
     qemu_mutex_unlock(&cpu->lock);
-    qemu_cond_broadcast(&qemu_work_cond);
+    qemu_cond_broadcast(&cpu->cond);
 }
diff --git a/cpus.c b/cpus.c
index a190651653..e844335386 100644
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
index d0758c907d..bb031a3a6a 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -373,6 +373,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_threads = 1;
 
     qemu_mutex_init(&cpu->lock);
+    qemu_cond_init(&cpu->cond);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
-- 
2.17.1
