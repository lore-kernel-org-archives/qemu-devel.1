Received: from eggs.gnu.org ([2001:4830:134:3::10]:46252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7i-0007v0-Gi
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7g-0008Tq-Ur
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:22 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:24 +1100
Message-Id: <20170301044405.1792-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/50] target/ppc: Merge cpu_ppc_set_vhyp() with
 cpu_ppc_set_papr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

cpu_ppc_set_papr() sets up various aspects of CPU state for use with PAPR
paravirtualized guests.  However, it doesn't set the virtual hypervisor,
so callers must also call cpu_ppc_set_vhyp() so that PAPR hypercalls are
handled properly.  This is a bit silly, so fold setting the virtual
hypervisor into cpu_ppc_set_papr().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_cpu_core.c     |  3 +--
 target/ppc/cpu.h            |  3 +--
 target/ppc/translate_init.c | 10 +++-------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 55cd045..76563c4 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -57,8 +57,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
 
     /* Enable PAPR mode in TCG or KVM */
-    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
-    cpu_ppc_set_papr(cpu);
+    cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
 
     if (cpu->max_compat) {
         Error *local_err = NULL;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c022984..2a94e76 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1301,8 +1301,7 @@ void store_booke_tcr (CPUPPCState *env, target_ulong val);
 void store_booke_tsr (CPUPPCState *env, target_ulong val);
 void ppc_tlb_invalidate_all (CPUPPCState *env);
 void ppc_tlb_invalidate_one (CPUPPCState *env, target_ulong addr);
-void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
-void cpu_ppc_set_papr(PowerPCCPU *cpu);
+void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
 #endif
 #endif
 
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index be35cbd..a1405e9 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8835,18 +8835,14 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-
-void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
-{
-    cpu->vhyp = vhyp;
-}
-
-void cpu_ppc_set_papr(PowerPCCPU *cpu)
+void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
     CPUPPCState *env = &cpu->env;
     ppc_spr_t *lpcr = &env->spr_cb[SPR_LPCR];
     ppc_spr_t *amor = &env->spr_cb[SPR_AMOR];
 
+    cpu->vhyp = vhyp;
+
     /* PAPR always has exception vectors in RAM not ROM. To ensure this,
      * MSR[IP] should never be set.
      *
-- 
2.9.3
