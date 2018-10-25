Received: from eggs.gnu.org ([2001:4830:134:3::10]:59966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5J-0003lE-Aj
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgvP-0008QP-PB
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgvP-0008By-FQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:46:43 -0400
Message-Id: <20181025144644.15464-70-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 70/71] cpus-common: move exclusive_idle higher
 in the file
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

This will simplify the following commit's diff.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus-common.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 232cb12c46..ad8a8ef535 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -73,6 +73,15 @@ static void finish_safe_work(CPUState *cpu)
     cpu_exec_end(cpu);
 }
 
+/* Wait for pending exclusive operations to complete.  The CPU list lock
+   must be held.  */
+static inline void exclusive_idle(void)
+{
+    while (pending_cpus) {
+        qemu_cond_wait(&exclusive_resume, &qemu_cpu_list_lock);
+    }
+}
+
 void cpu_list_add(CPUState *cpu)
 {
     qemu_mutex_lock(&qemu_cpu_list_lock);
@@ -200,15 +209,6 @@ void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
     queue_work_on_cpu(cpu, wi);
 }
 
-/* Wait for pending exclusive operations to complete.  The CPU list lock
-   must be held.  */
-static inline void exclusive_idle(void)
-{
-    while (pending_cpus) {
-        qemu_cond_wait(&exclusive_resume, &qemu_cpu_list_lock);
-    }
-}
-
 /* Start an exclusive operation.
    Must only be called from outside cpu_exec.  */
 void start_exclusive(void)
-- 
2.17.1
