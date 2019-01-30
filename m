Received: from eggs.gnu.org ([209.51.188.92]:35020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe35-0007sn-L9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe34-0000dh-R2
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:15 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe34-0000dH-M3
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:14 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:03 -0500
Message-Id: <20190130004811.27372-6-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 05/73] cpu: move run_on_cpu to cpus-common
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

We don't pass a pointer to qemu_global_mutex anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 10 ----------
 cpus-common.c     |  2 +-
 cpus.c            |  5 -----
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 46e3c164aa..fe389037c5 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -768,16 +768,6 @@ void qemu_cpu_kick(CPUState *cpu);
  */
 bool cpu_is_stopped(CPUState *cpu);
 
-/**
- * do_run_on_cpu:
- * @cpu: The vCPU to run on.
- * @func: The function to be executed.
- * @data: Data to pass to the function.
- *
- * Used internally in the implementation of run_on_cpu.
- */
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
-
 /**
  * run_on_cpu:
  * @cpu: The vCPU to run on.
diff --git a/cpus-common.c b/cpus-common.c
index daf1531868..85a61eb970 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -127,7 +127,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
     cpu_mutex_unlock(cpu);
 }
 
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
     struct qemu_work_item wi;
     bool has_bql = qemu_mutex_iothread_locked();
diff --git a/cpus.c b/cpus.c
index 42ea8cfbb5..755e4addab 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1234,11 +1234,6 @@ void qemu_init_cpu_loop(void)
     qemu_thread_get_self(&io_thread);
 }
 
-void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
-{
-    do_run_on_cpu(cpu, func, data);
-}
-
 static void qemu_kvm_destroy_vcpu(CPUState *cpu)
 {
     if (kvm_destroy_vcpu(cpu) < 0) {
-- 
2.17.1
