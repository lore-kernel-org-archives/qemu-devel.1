Received: from eggs.gnu.org ([2001:4830:134:3::10]:59966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5W-0003lE-3M
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFguV-0007fR-Pi
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:46:58 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50339)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFguT-0007U3-WE
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:46:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:45:38 -0400
Message-Id: <20181025144644.15464-5-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 05/71] cpu: move run_on_cpu to cpus-common
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

We don't pass a pointer to qemu_global_mutex anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 10 ----------
 cpus-common.c     |  2 +-
 cpus.c            |  5 -----
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 2fad537a4f..11cbf21f00 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -766,16 +766,6 @@ void qemu_cpu_kick(CPUState *cpu);
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
index 71469c85ce..3fccee5585 100644
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
index d0b7f8e02d..913db6a8a4 100644
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
