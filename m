Received: from eggs.gnu.org ([2001:4830:134:3::10]:58561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFP-0004U9-27
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFM-0002mM-Or
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFM-0002jY-5T
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:35 -0400
Message-Id: <20181019010625.25294-7-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 06/56] cpu: introduce
 process_queued_cpu_work_locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

It will gain a user once we protect more of CPUState under cpu->lock.

This completes the conversion to cpu_mutex_lock/unlock in the file.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |  9 +++++++++
 cpus-common.c     | 17 +++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 90fd685899..30d1c260dc 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -986,6 +986,15 @@ void cpu_remove_sync(CPUState *cpu);
  */
 void process_queued_cpu_work(CPUState *cpu);
 
+/**
+ * process_queued_cpu_work_locked - process all items on CPU work queue
+ * @cpu: The CPU which work queue to process.
+ *
+ * Call with @cpu->lock held.
+ * See also: process_queued_cpu_work()
+ */
+void process_queued_cpu_work_locked(CPUState *cpu);
+
 /**
  * cpu_exec_start:
  * @cpu: The CPU for the current thread.
diff --git a/cpus-common.c b/cpus-common.c
index 20096ec3c6..d559f94ef1 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -315,20 +315,19 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     queue_work_on_cpu(cpu, wi);
 }
 
-void process_queued_cpu_work(CPUState *cpu)
+/* Called with the CPU's lock held */
+void process_queued_cpu_work_locked(CPUState *cpu)
 {
     struct qemu_work_item *wi;
     bool has_bql = qemu_mutex_iothread_locked();
 
-    qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
-        qemu_mutex_unlock(&cpu->lock);
         return;
     }
     while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
         wi = QSIMPLEQ_FIRST(&cpu->work_list);
         QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
-        qemu_mutex_unlock(&cpu->lock);
+        cpu_mutex_unlock(cpu);
         if (wi->exclusive) {
             /* Running work items outside the BQL avoids the following deadlock:
              * 1) start_exclusive() is called with the BQL taken while another
@@ -354,13 +353,19 @@ void process_queued_cpu_work(CPUState *cpu)
                 qemu_mutex_unlock_iothread();
             }
         }
-        qemu_mutex_lock(&cpu->lock);
+        cpu_mutex_lock(cpu);
         if (wi->free) {
             g_free(wi);
         } else {
             atomic_mb_set(&wi->done, true);
         }
     }
-    qemu_mutex_unlock(&cpu->lock);
     qemu_cond_broadcast(&cpu->cond);
 }
+
+void process_queued_cpu_work(CPUState *cpu)
+{
+    cpu_mutex_lock(cpu);
+    process_queued_cpu_work_locked(cpu);
+    cpu_mutex_unlock(cpu);
+}
-- 
2.17.1
