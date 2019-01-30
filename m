Received: from eggs.gnu.org ([209.51.188.92]:35022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe35-0007so-Lb
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe34-0000dP-Iu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:15 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe34-0000cn-7x
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:14 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:00 -0500
Message-Id: <20190130004811.27372-3-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 02/73] cpu: rename cpu->work_mutex to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This lock will soon protect more fields of the struct. Give
it a more appropriate name.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |  5 +++--
 cpus-common.c     | 14 +++++++-------
 cpus.c            |  4 ++--
 qom/cpu.c         |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index fc39f5d529..6224b83ada 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -321,7 +321,7 @@ struct qemu_work_item;
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @mem_io_vaddr: Target virtual address at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
- * @work_mutex: Lock to prevent multiple access to @work_list.
+ * @lock: Lock to prevent multiple access to per-CPU fields.
  * @work_list: List of pending asynchronous work.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
@@ -362,7 +362,8 @@ struct CPUState {
     int64_t icount_extra;
     sigjmp_buf jmp_env;
 
-    QemuMutex work_mutex;
+    QemuMutex lock;
+    /* fields below protected by @lock */
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     CPUAddressSpace *cpu_ases;
diff --git a/cpus-common.c b/cpus-common.c
index a1bbf4139f..d0e619f149 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -115,10 +115,10 @@ struct qemu_work_item {
 
 static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
 {
-    qemu_mutex_lock(&cpu->work_mutex);
+    qemu_mutex_lock(&cpu->lock);
     QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
     wi->done = false;
-    qemu_mutex_unlock(&cpu->work_mutex);
+    qemu_mutex_unlock(&cpu->lock);
 
     qemu_cpu_kick(cpu);
 }
@@ -308,15 +308,15 @@ void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
 
-    qemu_mutex_lock(&cpu->work_mutex);
+    qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
-        qemu_mutex_unlock(&cpu->work_mutex);
+        qemu_mutex_unlock(&cpu->lock);
         return;
     }
     while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
         wi = QSIMPLEQ_FIRST(&cpu->work_list);
         QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
-        qemu_mutex_unlock(&cpu->work_mutex);
+        qemu_mutex_unlock(&cpu->lock);
         if (wi->exclusive) {
             /* Running work items outside the BQL avoids the following deadlock:
              * 1) start_exclusive() is called with the BQL taken while another
@@ -332,13 +332,13 @@ void process_queued_cpu_work(CPUState *cpu)
         } else {
             wi->func(cpu, wi->data);
         }
-        qemu_mutex_lock(&cpu->work_mutex);
+        qemu_mutex_lock(&cpu->lock);
         if (wi->free) {
             g_free(wi);
         } else {
             atomic_mb_set(&wi->done, true);
         }
     }
-    qemu_mutex_unlock(&cpu->work_mutex);
+    qemu_mutex_unlock(&cpu->lock);
     qemu_cond_broadcast(&qemu_work_cond);
 }
diff --git a/cpus.c b/cpus.c
index edde8268b9..9a3a1d8a6a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -92,9 +92,9 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
 {
     bool ret;
 
-    qemu_mutex_lock(&cpu->work_mutex);
+    qemu_mutex_lock(&cpu->lock);
     ret = QSIMPLEQ_EMPTY(&cpu->work_list);
-    qemu_mutex_unlock(&cpu->work_mutex);
+    qemu_mutex_unlock(&cpu->lock);
     return ret;
 }
 
diff --git a/qom/cpu.c b/qom/cpu.c
index 06d6b6044d..a2964e53c6 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -371,7 +371,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
 
-    qemu_mutex_init(&cpu->work_mutex);
+    qemu_mutex_init(&cpu->lock);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
-- 
2.17.1
