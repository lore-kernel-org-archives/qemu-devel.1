Received: from eggs.gnu.org ([209.51.188.92]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe36-0007sr-1I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe35-0000dr-42
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:15 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe34-0000da-VY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:15 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:04 -0500
Message-Id: <20190130004811.27372-7-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 06/73] cpu: introduce
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This completes the conversion to cpu_mutex_lock/unlock in the file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus-common.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 85a61eb970..99662bfa87 100644
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
