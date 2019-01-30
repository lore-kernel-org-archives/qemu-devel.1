Received: from eggs.gnu.org ([209.51.188.92]:36148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe4B-0000Sm-LQ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe4A-0001fo-51
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:23 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:42 -0500
Message-Id: <20190130004811.27372-45-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 44/73] ppc: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/ppc/ppc.c                    |  2 +-
 target/ppc/excp_helper.c        |  2 +-
 target/ppc/kvm.c                |  4 ++--
 target/ppc/translate_init.inc.c | 14 +++++++-------
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index d1a5a0b877..bc1cefa13f 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -91,7 +91,7 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 
     LOG_IRQ("%s: %p n_IRQ %d level %d => pending %08" PRIx32
                 "req %08x\n", __func__, env, n_IRQ, level,
-                env->pending_interrupts, CPU(cpu)->interrupt_request);
+                env->pending_interrupts, cpu_interrupt_request(CPU(cpu)));
 
     if (locked) {
         qemu_mutex_unlock_iothread();
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 737c9c72be..75a434f46b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -753,7 +753,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
 
     qemu_log_mask(CPU_LOG_INT, "%s: %p pending %08x req %08x me %d ee %d\n",
                   __func__, env, env->pending_interrupts,
-                  cs->interrupt_request, (int)msr_me, (int)msr_ee);
+                  cpu_interrupt_request(cs), (int)msr_me, (int)msr_ee);
 #endif
     /* External reset */
     if (env->pending_interrupts & (1 << PPC_INTERRUPT_RESET)) {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 0efdb71532..50919da6af 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1340,7 +1340,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
      * interrupt, reset, etc) in PPC-specific env->irq_input_state. */
     if (!cap_interrupt_level &&
         run->ready_for_interrupt_injection &&
-        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+        (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
         (env->irq_input_state & (1<<PPC_INPUT_INT)))
     {
         /* For now KVM disregards the 'irq' argument. However, in the
@@ -1382,7 +1382,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) && (msr_ee)) {
+    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) && (msr_ee)) {
         cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index a757e02f52..e1059d9ed6 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8455,7 +8455,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8479,7 +8479,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8609,7 +8609,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8641,7 +8641,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8801,7 +8801,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         /* External Exception */
@@ -8834,7 +8834,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -10247,7 +10247,7 @@ static bool ppc_cpu_has_work(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+    return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
 }
 
 /* CPUClass::reset() */
-- 
2.17.1
