Received: from eggs.gnu.org ([2001:4830:134:3::10]:58550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFO-0004U6-TC
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFL-0002kp-S3
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFL-0002aQ-Dp
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:34 -0400
Message-Id: <20181019010625.25294-6-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 05/56] cpu: move run_on_cpu to cpus-common
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

We don't pass a pointer to qemu_global_mutex anymore.

Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 10 ----------
 cpus-common.c     |  2 +-
 cpus.c            |  5 -----
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 82937881ef..90fd685899 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -759,16 +759,6 @@ void qemu_cpu_kick(CPUState *cpu);
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
index 2881707c35..20096ec3c6 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -127,7 +127,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
     cpu_mutex_unlock(cpu);
 }
 
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
     struct qemu_work_item wi;
 
diff --git a/cpus.c b/cpus.c
index e844335386..a101e8863c 100644
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
