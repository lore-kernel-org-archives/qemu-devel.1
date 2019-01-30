Received: from eggs.gnu.org ([209.51.188.92]:35241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3X-0008Cf-Es
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3W-0000uG-1I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:43 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:16 -0500
Message-Id: <20190130004811.27372-19-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 18/73] ppc: convert to cpu_halted
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

In ppce500_spin.c, acquire the lock just once to update
both cpu->halted and cpu->stopped.

In hw/ppc/spapr_hcall.c, acquire the lock just once to
update cpu->halted and call cpu_has_work, since later
in the series we'll acquire the BQL (if not already held)
from cpu_has_work.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/ppc/helper_regs.h        |  2 +-
 hw/ppc/e500.c                   |  4 ++--
 hw/ppc/ppc.c                    | 10 +++++-----
 hw/ppc/ppce500_spin.c           |  6 ++++--
 hw/ppc/spapr_cpu_core.c         |  4 ++--
 hw/ppc/spapr_hcall.c            |  4 +++-
 hw/ppc/spapr_rtas.c             |  6 +++---
 target/ppc/excp_helper.c        |  4 ++--
 target/ppc/kvm.c                |  4 ++--
 target/ppc/translate_init.inc.c |  6 +++---
 10 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 5efd18049e..9298052ac5 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -161,7 +161,7 @@ static inline int hreg_store_msr(CPUPPCState *env, target_ulong value,
 #if !defined(CONFIG_USER_ONLY)
     if (unlikely(msr_pow == 1)) {
         if (!env->pending_interrupts && (*env->check_pow)(env)) {
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             excp = EXCP_HALTED;
         }
     }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 0581e9e3d4..d685c36767 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -657,7 +657,7 @@ static void ppce500_cpu_reset_sec(void *opaque)
 
     /* Secondary CPU starts in halted state for now. Needs to change when
        implementing non-kernel boot. */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
 }
 
@@ -671,7 +671,7 @@ static void ppce500_cpu_reset(void *opaque)
     cpu_reset(cs);
 
     /* Set initial guest state. */
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     env->gpr[1] = (16 * MiB) - 8;
     env->gpr[3] = bi->dt_base;
     env->gpr[4] = 0;
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index ec4be25f49..d1a5a0b877 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -151,7 +151,7 @@ static void ppc6xx_set_irq(void *opaque, int pin, int level)
             /* XXX: Note that the only way to restart the CPU is to reset it */
             if (level) {
                 LOG_IRQ("%s: stop the CPU\n", __func__);
-                cs->halted = 1;
+                cpu_halted_set(cs, 1);
             }
             break;
         case PPC6xx_INPUT_HRESET:
@@ -230,10 +230,10 @@ static void ppc970_set_irq(void *opaque, int pin, int level)
             /* XXX: TODO: relay the signal to CKSTP_OUT pin */
             if (level) {
                 LOG_IRQ("%s: stop the CPU\n", __func__);
-                cs->halted = 1;
+                cpu_halted_set(cs, 1);
             } else {
                 LOG_IRQ("%s: restart the CPU\n", __func__);
-                cs->halted = 0;
+                cpu_halted_set(cs, 0);
                 qemu_cpu_kick(cs);
             }
             break;
@@ -361,10 +361,10 @@ static void ppc40x_set_irq(void *opaque, int pin, int level)
             /* Level sensitive - active low */
             if (level) {
                 LOG_IRQ("%s: stop the CPU\n", __func__);
-                cs->halted = 1;
+                cpu_halted_set(cs, 1);
             } else {
                 LOG_IRQ("%s: restart the CPU\n", __func__);
-                cs->halted = 0;
+                cpu_halted_set(cs, 0);
                 qemu_cpu_kick(cs);
             }
             break;
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index c45fc858de..4b3532730f 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -107,9 +107,11 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
     map_start = ldq_p(&curspin->addr) & ~(map_size - 1);
     mmubooke_create_initial_mapping(env, 0, map_start, map_size);
 
-    cs->halted = 0;
-    cs->exception_index = -1;
+    cpu_mutex_lock(cs);
+    cpu_halted_set(cs, 0);
     cs->stopped = false;
+    cpu_mutex_unlock(cs);
+    cs->exception_index = -1;
     qemu_cpu_kick(cs);
 }
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 0405306d1e..797fd5c1a8 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -36,7 +36,7 @@ static void spapr_cpu_reset(void *opaque)
     /* All CPUs start halted.  CPU0 is unhalted from the machine level
      * reset code and the rest are explicitly started up by the guest
      * using an RTAS call */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
 
     /* Set compatibility mode to match the boot CPU, which was either set
      * by the machine reset code or by CAS. This should never fail.
@@ -90,7 +90,7 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r
     env->nip = nip;
     env->gpr[3] = r3;
     kvmppc_set_reg_ppc_online(cpu, 1);
-    CPU(cpu)->halted = 0;
+    cpu_halted_set(CPU(cpu), 0);
     /* Enable Power-saving mode Exit Cause exceptions */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 17bcaa3822..a889eef4f7 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1088,11 +1088,13 @@ static target_ulong h_cede(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 
     env->msr |= (1ULL << MSR_EE);
     hreg_compute_hflags(env);
+    cpu_mutex_lock(cs);
     if (!cpu_has_work(cs)) {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
         cs->exit_request = 1;
     }
+    cpu_mutex_unlock(cs);
     return H_SUCCESS;
 }
 
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index d6a0952154..925f67123c 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -109,7 +109,7 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *cpu_,
     id = rtas_ld(args, 0);
     cpu = spapr_find_cpu(id);
     if (cpu != NULL) {
-        if (CPU(cpu)->halted) {
+        if (cpu_halted(CPU(cpu))) {
             rtas_st(rets, 1, 0);
         } else {
             rtas_st(rets, 1, 2);
@@ -153,7 +153,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr,
     env = &newcpu->env;
     pcc = POWERPC_CPU_GET_CLASS(newcpu);
 
-    if (!CPU(newcpu)->halted) {
+    if (!cpu_halted(CPU(newcpu))) {
         rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
         return;
     }
@@ -207,7 +207,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
      * This could deliver an interrupt on a dying CPU and crash the
      * guest */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     kvmppc_set_reg_ppc_online(cpu, 0);
     qemu_cpu_kick(cs);
 }
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0ec7ae1ad4..5e1778584a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -206,7 +206,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
                 qemu_log("Machine check while not allowed. "
                         "Entering checkstop state\n");
             }
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             cpu_interrupt_exittb(cs);
         }
         if (env->msr_mask & MSR_HVB) {
@@ -954,7 +954,7 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_t insn)
     CPUState *cs;
 
     cs = CPU(ppc_env_get_cpu(env));
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     env->in_pm_state = true;
 
     /* The architecture specifies that HDEC interrupts are
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index ebbb48c42f..0efdb71532 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1374,7 +1374,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 static int kvmppc_handle_halt(PowerPCCPU *cpu)
@@ -1383,7 +1383,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
     CPUPPCState *env = &cpu->env;
 
     if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) && (msr_ee)) {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
 
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 59e0b86762..a757e02f52 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8454,7 +8454,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
@@ -8608,7 +8608,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
@@ -8800,7 +8800,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
-- 
2.17.1
