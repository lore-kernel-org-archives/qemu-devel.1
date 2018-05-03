Received: from eggs.gnu.org ([2001:4830:134:3::10]:41139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7dL-0007cD-T1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7dH-0002bP-7e
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  3 May 2018 16:21:40 +1000
Message-Id: <20180503062145.17899-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180503062145.17899-1-david@gibson.dropbear.id.au>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 3/8] spapr: Remove unhelpful helpers from
 rtas_start_cpu()
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

rtas_start_cpu() calls spapr_cpu_update_tb_offset() and
spapr_cpu_set_endianness() to initialize certain things in the new cpu's
state.  This is the only caller of those helpers, and they're each only
a few lines long, so we might as well just fold them into the caller.

In addition, those helpers initialize state on the new cpu to match that of
the first cpu.  That will generally work, but might be at least logically
incorrect if the first cpu has been set offline by the guest.  So, instead
base the state on that of the cpu invoking the RTAS call, which is
obviously active already.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index b251c130cb..df073447c5 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -120,27 +120,6 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *cpu_,
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
 
-/*
- * Set the timebase offset of the CPU to that of first CPU.
- * This helps hotplugged CPU to have the correct timebase offset.
- */
-static void spapr_cpu_update_tb_offset(PowerPCCPU *cpu)
-{
-    PowerPCCPU *fcpu = POWERPC_CPU(first_cpu);
-
-    cpu->env.tb_env->tb_offset = fcpu->env.tb_env->tb_offset;
-}
-
-static void spapr_cpu_set_endianness(PowerPCCPU *cpu)
-{
-    PowerPCCPU *fcpu = POWERPC_CPU(first_cpu);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(fcpu);
-
-    if (!pcc->interrupts_big_endian(fcpu)) {
-        cpu->env.spr[SPR_LPCR] |= LPCR_ILE;
-    }
-}
-
 static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr,
                            uint32_t token, uint32_t nargs,
                            target_ulong args,
@@ -150,6 +129,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr,
     PowerPCCPU *newcpu;
     CPUPPCState *env;
     PowerPCCPUClass *pcc;
+    target_ulong lpcr;
 
     if (nargs != 3 || nret != 1) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -178,10 +158,20 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr,
     cpu_synchronize_state(CPU(newcpu));
 
     env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
-    spapr_cpu_set_endianness(newcpu);
-    spapr_cpu_update_tb_offset(newcpu);
+
     /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
-    ppc_store_lpcr(newcpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
+    lpcr = env->spr[SPR_LPCR] | pcc->lpcr_pm;
+    if (!pcc->interrupts_big_endian(callcpu)) {
+        lpcr |= LPCR_ILE;
+    }
+    ppc_store_lpcr(newcpu, lpcr);
+
+    /*
+     * Set the timebase offset of the new CPU to that of the invoking
+     * CPU.  This helps hotplugged CPU to have the correct timebase
+     * offset.
+     */
+    newcpu->env.tb_env->tb_offset = callcpu->env.tb_env->tb_offset;
 
     env->nip = start;
     env->gpr[3] = r3;
-- 
2.17.0
