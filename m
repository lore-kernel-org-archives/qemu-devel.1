Received: from eggs.gnu.org ([2001:4830:134:3::10]:54916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJC5-0007ES-O3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJC1-0000rj-NV
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:05:52 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJBx-0000gY-4i
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:05:47 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:03:41 -0500
Message-Id: <20181213050453.9677-2-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 01/73] cpu: convert queued work to a QSIMPLEQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Instead of open-coding it.

While at it, make sure that all accesses to the list are
performed while holding the list's lock.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |  6 +++---
 cpus-common.c     | 25 ++++++++-----------------
 cpus.c            | 14 ++++++++++++--
 qom/cpu.c         |  1 +
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1396f53e5b..10a408c999 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -315,8 +315,8 @@ struct qemu_work_item;
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @mem_io_vaddr: Target virtual address at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
- * @work_mutex: Lock to prevent multiple access to queued_work_*.
- * @queued_work_first: First asynchronous work pending.
+ * @work_mutex: Lock to prevent multiple access to @work_list.
+ * @work_list: List of pending asynchronous work.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
@@ -357,7 +357,7 @@ struct CPUState {
     sigjmp_buf jmp_env;
 
     QemuMutex work_mutex;
-    struct qemu_work_item *queued_work_first, *queued_work_last;
+    QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     CPUAddressSpace *cpu_ases;
     int num_ases;
diff --git a/cpus-common.c b/cpus-common.c
index 98dd8c6ff1..a2a6cd93a1 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -107,7 +107,7 @@ void cpu_list_remove(CPUState *cpu)
 }
 
 struct qemu_work_item {
-    struct qemu_work_item *next;
+    QSIMPLEQ_ENTRY(qemu_work_item) node;
     run_on_cpu_func func;
     run_on_cpu_data data;
     bool free, exclusive, done;
@@ -116,13 +116,7 @@ struct qemu_work_item {
 static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
 {
     qemu_mutex_lock(&cpu->work_mutex);
-    if (cpu->queued_work_first == NULL) {
-        cpu->queued_work_first = wi;
-    } else {
-        cpu->queued_work_last->next = wi;
-    }
-    cpu->queued_work_last = wi;
-    wi->next = NULL;
+    QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
     wi->done = false;
     qemu_mutex_unlock(&cpu->work_mutex);
 
@@ -314,17 +308,14 @@ void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
 
-    if (cpu->queued_work_first == NULL) {
+    qemu_mutex_lock(&cpu->work_mutex);
+    if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
+        qemu_mutex_unlock(&cpu->work_mutex);
         return;
     }
-
-    qemu_mutex_lock(&cpu->work_mutex);
-    while (cpu->queued_work_first != NULL) {
-        wi = cpu->queued_work_first;
-        cpu->queued_work_first = wi->next;
-        if (!cpu->queued_work_first) {
-            cpu->queued_work_last = NULL;
-        }
+    while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
+        wi = QSIMPLEQ_FIRST(&cpu->work_list);
+        QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
         qemu_mutex_unlock(&cpu->work_mutex);
         if (wi->exclusive) {
             /* Running work items outside the BQL avoids the following deadlock:
diff --git a/cpus.c b/cpus.c
index 0ddeeefc14..7531723d61 100644
--- a/cpus.c
+++ b/cpus.c
@@ -88,9 +88,19 @@ bool cpu_is_stopped(CPUState *cpu)
     return cpu->stopped || !runstate_is_running();
 }
 
+static inline bool cpu_work_list_empty(CPUState *cpu)
+{
+    bool ret;
+
+    qemu_mutex_lock(&cpu->work_mutex);
+    ret = QSIMPLEQ_EMPTY(&cpu->work_list);
+    qemu_mutex_unlock(&cpu->work_mutex);
+    return ret;
+}
+
 static bool cpu_thread_is_idle(CPUState *cpu)
 {
-    if (cpu->stop || cpu->queued_work_first) {
+    if (cpu->stop || !cpu_work_list_empty(cpu)) {
         return false;
     }
     if (cpu_is_stopped(cpu)) {
@@ -1513,7 +1523,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
+        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
 
             atomic_mb_set(&tcg_current_rr_cpu, cpu);
             current_cpu = cpu;
diff --git a/qom/cpu.c b/qom/cpu.c
index 9ad1372d57..eb270169ed 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -372,6 +372,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_threads = 1;
 
     qemu_mutex_init(&cpu->work_mutex);
+    QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
-- 
2.17.1
