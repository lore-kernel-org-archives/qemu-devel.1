Received: from eggs.gnu.org ([2001:4830:134:3::10]:46187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGh9-0002nH-BX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGh7-0001fK-Qi
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:04:59 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Jun 2018 11:04:46 +1000
Message-Id: <20180614010446.30854-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180614010446.30854-1-david@gibson.dropbear.id.au>
References: <20180614010446.30854-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 7/7] target/ppc,
 spapr: Move VPA information to machine_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

CPUPPCState currently contains a number of fields containing the state of
the VPA.  The VPA is a PAPR specific concept covering several guest/host
shared memory areas used to communicate some information with the
hypervisor.

As a PAPR concept this is really machine specific information, although it
is per-cpu, so it doesn't really belong in the core CPU state structure.
So, move it to the PAPR specific 'machine_data' structure.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c         |  7 +++
 hw/ppc/spapr_hcall.c            | 77 ++++++++++++++++++---------------
 include/hw/ppc/spapr_cpu_core.h |  3 ++
 target/ppc/cpu.h                |  6 ---
 target/ppc/translate_init.inc.c |  8 ----
 5 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 544bda93e2..f642c95967 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -28,6 +28,7 @@ static void spapr_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
     target_ulong lpcr;
 
     cpu_reset(cs);
@@ -69,6 +70,12 @@ static void spapr_cpu_reset(void *opaque)
 
     /* Set a full AMOR so guest can use the AMR as it sees fit */
     env->spr[SPR_AMOR] = 0xffffffffffffffffull;
+
+    spapr_cpu->vpa_addr = 0;
+    spapr_cpu->slb_shadow_addr = 0;
+    spapr_cpu->slb_shadow_size = 0;
+    spapr_cpu->dtl_addr = 0;
+    spapr_cpu->dtl_size = 0;
 }
 
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8b9a4b577f..ae913d070f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -8,6 +8,7 @@
 #include "exec/exec-all.h"
 #include "helper_regs.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_cpu_core.h"
 #include "mmu-hash64.h"
 #include "cpu-models.h"
 #include "trace.h"
@@ -908,9 +909,11 @@ unmap_out:
 #define VPA_SHARED_PROC_OFFSET 0x9
 #define VPA_SHARED_PROC_VAL    0x2
 
-static target_ulong register_vpa(CPUPPCState *env, target_ulong vpa)
+static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
 {
-    CPUState *cs = CPU(ppc_env_get_cpu(env));
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
     uint16_t size;
     uint8_t tmp;
 
@@ -935,32 +938,34 @@ static target_ulong register_vpa(CPUPPCState *env, target_ulong vpa)
         return H_PARAMETER;
     }
 
-    env->vpa_addr = vpa;
+    spapr_cpu->vpa_addr = vpa;
 
-    tmp = ldub_phys(cs->as, env->vpa_addr + VPA_SHARED_PROC_OFFSET);
+    tmp = ldub_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET);
     tmp |= VPA_SHARED_PROC_VAL;
-    stb_phys(cs->as, env->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp);
+    stb_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp);
 
     return H_SUCCESS;
 }
 
-static target_ulong deregister_vpa(CPUPPCState *env, target_ulong vpa)
+static target_ulong deregister_vpa(PowerPCCPU *cpu, target_ulong vpa)
 {
-    if (env->slb_shadow_addr) {
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
+
+    if (spapr_cpu->slb_shadow_addr) {
         return H_RESOURCE;
     }
 
-    if (env->dtl_addr) {
+    if (spapr_cpu->dtl_addr) {
         return H_RESOURCE;
     }
 
-    env->vpa_addr = 0;
+    spapr_cpu->vpa_addr = 0;
     return H_SUCCESS;
 }
 
-static target_ulong register_slb_shadow(CPUPPCState *env, target_ulong addr)
+static target_ulong register_slb_shadow(PowerPCCPU *cpu, target_ulong addr)
 {
-    CPUState *cs = CPU(ppc_env_get_cpu(env));
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
     uint32_t size;
 
     if (addr == 0) {
@@ -968,7 +973,7 @@ static target_ulong register_slb_shadow(CPUPPCState *env, target_ulong addr)
         return H_HARDWARE;
     }
 
-    size = ldl_be_phys(cs->as, addr + 0x4);
+    size = ldl_be_phys(CPU(cpu)->as, addr + 0x4);
     if (size < 0x8) {
         return H_PARAMETER;
     }
@@ -977,26 +982,28 @@ static target_ulong register_slb_shadow(CPUPPCState *env, target_ulong addr)
         return H_PARAMETER;
     }
 
-    if (!env->vpa_addr) {
+    if (!spapr_cpu->vpa_addr) {
         return H_RESOURCE;
     }
 
-    env->slb_shadow_addr = addr;
-    env->slb_shadow_size = size;
+    spapr_cpu->slb_shadow_addr = addr;
+    spapr_cpu->slb_shadow_size = size;
 
     return H_SUCCESS;
 }
 
-static target_ulong deregister_slb_shadow(CPUPPCState *env, target_ulong addr)
+static target_ulong deregister_slb_shadow(PowerPCCPU *cpu, target_ulong addr)
 {
-    env->slb_shadow_addr = 0;
-    env->slb_shadow_size = 0;
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
+
+    spapr_cpu->slb_shadow_addr = 0;
+    spapr_cpu->slb_shadow_size = 0;
     return H_SUCCESS;
 }
 
-static target_ulong register_dtl(CPUPPCState *env, target_ulong addr)
+static target_ulong register_dtl(PowerPCCPU *cpu, target_ulong addr)
 {
-    CPUState *cs = CPU(ppc_env_get_cpu(env));
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
     uint32_t size;
 
     if (addr == 0) {
@@ -1004,26 +1011,28 @@ static target_ulong register_dtl(CPUPPCState *env, target_ulong addr)
         return H_HARDWARE;
     }
 
-    size = ldl_be_phys(cs->as, addr + 0x4);
+    size = ldl_be_phys(CPU(cpu)->as, addr + 0x4);
 
     if (size < 48) {
         return H_PARAMETER;
     }
 
-    if (!env->vpa_addr) {
+    if (!spapr_cpu->vpa_addr) {
         return H_RESOURCE;
     }
 
-    env->dtl_addr = addr;
-    env->dtl_size = size;
+    spapr_cpu->dtl_addr = addr;
+    spapr_cpu->dtl_size = size;
 
     return H_SUCCESS;
 }
 
-static target_ulong deregister_dtl(CPUPPCState *env, target_ulong addr)
+static target_ulong deregister_dtl(PowerPCCPU *cpu, target_ulong addr)
 {
-    env->dtl_addr = 0;
-    env->dtl_size = 0;
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
+
+    spapr_cpu->dtl_addr = 0;
+    spapr_cpu->dtl_size = 0;
 
     return H_SUCCESS;
 }
@@ -1035,38 +1044,36 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     target_ulong procno = args[1];
     target_ulong vpa = args[2];
     target_ulong ret = H_PARAMETER;
-    CPUPPCState *tenv;
     PowerPCCPU *tcpu;
 
     tcpu = spapr_find_cpu(procno);
     if (!tcpu) {
         return H_PARAMETER;
     }
-    tenv = &tcpu->env;
 
     switch (flags) {
     case FLAGS_REGISTER_VPA:
-        ret = register_vpa(tenv, vpa);
+        ret = register_vpa(tcpu, vpa);
         break;
 
     case FLAGS_DEREGISTER_VPA:
-        ret = deregister_vpa(tenv, vpa);
+        ret = deregister_vpa(tcpu, vpa);
         break;
 
     case FLAGS_REGISTER_SLBSHADOW:
-        ret = register_slb_shadow(tenv, vpa);
+        ret = register_slb_shadow(tcpu, vpa);
         break;
 
     case FLAGS_DEREGISTER_SLBSHADOW:
-        ret = deregister_slb_shadow(tenv, vpa);
+        ret = deregister_slb_shadow(tcpu, vpa);
         break;
 
     case FLAGS_REGISTER_DTL:
-        ret = register_dtl(tenv, vpa);
+        ret = register_dtl(tcpu, vpa);
         break;
 
     case FLAGS_DEREGISTER_DTL:
-        ret = deregister_dtl(tenv, vpa);
+        ret = deregister_dtl(tcpu, vpa);
         break;
     }
 
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index e3d2aa45a4..40129cc452 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -44,6 +44,9 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r
 typedef struct ICPState ICPState;
 typedef struct sPAPRCPUState {
     ICPState *icp;
+    uint64_t vpa_addr;
+    uint64_t slb_shadow_addr, slb_shadow_size;
+    uint64_t dtl_addr, dtl_size;
 } sPAPRCPUState;
 
 static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU *cpu)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index abf0bf0224..6c2f4d29f2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1091,12 +1091,6 @@ struct CPUPPCState {
     target_ulong rmls;
 #endif
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-    uint64_t vpa_addr;
-    uint64_t slb_shadow_addr, slb_shadow_size;
-    uint64_t dtl_addr, dtl_size;
-#endif /* TARGET_PPC64 */
-
     int error_code;
     uint32_t pending_interrupts;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index bb9296f5a3..76d6f3fd5e 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10316,14 +10316,6 @@ static void ppc_cpu_reset(CPUState *s)
     s->exception_index = POWERPC_EXCP_NONE;
     env->error_code = 0;
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-    env->vpa_addr = 0;
-    env->slb_shadow_addr = 0;
-    env->slb_shadow_size = 0;
-    env->dtl_addr = 0;
-    env->dtl_size = 0;
-#endif /* TARGET_PPC64 */
-
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
 
-- 
2.17.1
