Received: from eggs.gnu.org ([2001:4830:134:3::10]:41141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7dL-0007cH-U8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7dH-0002bQ-82
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  3 May 2018 16:21:39 +1000
Message-Id: <20180503062145.17899-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180503062145.17899-1-david@gibson.dropbear.id.au>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 2/8] spapr: Clean up rtas_start_cpu() &
 rtas_stop_self()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

This makes several minor cleanups to these functions:
  * Follow usual convention of an early exit on error, rather than having
    most of the body in an if
  * Clearer naming of cpu and cpu_.  Now callcpu is the cpu from which the
    RTAS call is invoked, newcpu is the cpu which we're starting
  * Use cpu_synchronize_state() instead of kvm_cpu_synchronize_state()
    directly
  * Remove pointless comment describing what cpu_synchronize_state() does
  * Use ppc_store_lpcr() instead of directly writing the register field

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas.c | 66 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0ec5fa4cfe..b251c130cb 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -32,7 +32,7 @@
 #include "hw/qdev.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
@@ -45,6 +45,7 @@
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "hw/ppc/fdt.h"
+#include "target/ppc/mmu-hash64.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -140,13 +141,15 @@ static void spapr_cpu_set_endianness(PowerPCCPU *cpu)
     }
 }
 
-static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
+static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr,
                            uint32_t token, uint32_t nargs,
                            target_ulong args,
                            uint32_t nret, target_ulong rets)
 {
     target_ulong id, start, r3;
-    PowerPCCPU *cpu;
+    PowerPCCPU *newcpu;
+    CPUPPCState *env;
+    PowerPCCPUClass *pcc;
 
     if (nargs != 3 || nret != 1) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -157,41 +160,37 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
     start = rtas_ld(args, 1);
     r3 = rtas_ld(args, 2);
 
-    cpu = spapr_find_cpu(id);
-    if (cpu != NULL) {
-        CPUState *cs = CPU(cpu);
-        CPUPPCState *env = &cpu->env;
-        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    newcpu = spapr_find_cpu(id);
+    if (!newcpu) {
+        /* Didn't find a matching cpu */
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
 
-        if (!cs->halted) {
-            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
-            return;
-        }
+    env = &newcpu->env;
+    pcc = POWERPC_CPU_GET_CLASS(newcpu);
 
-        /* This will make sure qemu state is up to date with kvm, and
-         * mark it dirty so our changes get flushed back before the
-         * new cpu enters */
-        kvm_cpu_synchronize_state(cs);
+    if (!CPU(newcpu)->halted) {
+        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+        return;
+    }
 
-        env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
+    cpu_synchronize_state(CPU(newcpu));
 
-        /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
-        env->spr[SPR_LPCR] |= pcc->lpcr_pm;
+    env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
+    spapr_cpu_set_endianness(newcpu);
+    spapr_cpu_update_tb_offset(newcpu);
+    /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
+    ppc_store_lpcr(newcpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
 
-        env->nip = start;
-        env->gpr[3] = r3;
-        cs->halted = 0;
-        spapr_cpu_set_endianness(cpu);
-        spapr_cpu_update_tb_offset(cpu);
+    env->nip = start;
+    env->gpr[3] = r3;
 
-        qemu_cpu_kick(cs);
+    CPU(newcpu)->halted = 0;
 
-        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
-        return;
-    }
+    qemu_cpu_kick(CPU(newcpu));
 
-    /* Didn't find a matching cpu */
-    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
 
 static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
@@ -203,13 +202,12 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    cs->halted = 1;
-    qemu_cpu_kick(cs);
-
     /* Disable Power-saving mode Exit Cause exceptions for the CPU.
      * This could deliver an interrupt on a dying CPU and crash the
      * guest */
-    env->spr[SPR_LPCR] &= ~pcc->lpcr_pm;
+    ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
+    cs->halted = 1;
+    qemu_cpu_kick(cs);
 }
 
 static inline int sysparm_st(target_ulong addr, target_ulong len,
-- 
2.17.0
