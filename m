Received: from eggs.gnu.org ([209.51.188.92]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sBe-00014J-IL
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sBX-0002dq-11
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:44 -0500
Message-Id: <20190304181813.8075-45-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v7 44/73] ppc: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/ppc/ppc.c                    |  2 +-
 target/ppc/kvm.c                |  4 ++--
 target/ppc/translate_init.inc.c | 14 +++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 45e212390a..100badefe4 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -89,7 +89,7 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 
     LOG_IRQ("%s: %p n_IRQ %d level %d => pending %08" PRIx32
                 "req %08x\n", __func__, env, n_IRQ, level,
-                env->pending_interrupts, CPU(cpu)->interrupt_request);
+                env->pending_interrupts, cpu_interrupt_request(CPU(cpu)));
 
     if (locked) {
         qemu_mutex_unlock_iothread();
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index faa757c417..16f09c504d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1339,7 +1339,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
      * interrupt, reset, etc) in PPC-specific env->irq_input_state. */
     if (!cap_interrupt_level &&
         run->ready_for_interrupt_injection &&
-        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+        (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
         (env->irq_input_state & (1<<PPC_INPUT_INT)))
     {
         /* For now KVM disregards the 'irq' argument. However, in the
@@ -1381,7 +1381,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) && (msr_ee)) {
+    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) && (msr_ee)) {
         cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index b2cad43e2a..f387404913 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8469,7 +8469,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8493,7 +8493,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8623,7 +8623,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8655,7 +8655,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8817,7 +8817,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
 
@@ -8863,7 +8863,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -10332,7 +10332,7 @@ static bool ppc_cpu_has_work(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+    return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
 }
 
 /* CPUClass::reset() */
-- 
2.17.1
