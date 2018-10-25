Received: from eggs.gnu.org ([2001:4830:134:3::10]:60234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5V-00045Y-Hi
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgun-0007mh-0i
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgum-0007ev-NY
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:45:39 -0400
Message-Id: <20181025144644.15464-6-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 06/71] cpu: introduce
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

This completes the conversion to cpu_mutex_lock/unlock in the file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus-common.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 3fccee5585..c2ad554d54 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -337,20 +337,19 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     queue_work_on_cpu(cpu, wi);
 }
 
-void process_queued_cpu_work(CPUState *cpu)
+/* Called with the CPU's lock held */
+static void process_queued_cpu_work_locked(CPUState *cpu)
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
@@ -376,13 +375,19 @@ void process_queued_cpu_work(CPUState *cpu)
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
