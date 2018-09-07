Received: from eggs.gnu.org ([2001:4830:134:3::10]:45815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFo-0000Ey-Q8
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFn-0005HP-O5
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:32 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  7 Sep 2018 17:31:54 +1000
Message-Id: <20180907073155.26200-14-david@gibson.dropbear.id.au>
In-Reply-To: <20180907073155.26200-1-david@gibson.dropbear.id.au>
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/14] target/ppc/kvm: set vcpu as online/offline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, mark.cave-ayland@ilande.co.uk, Nikunj A Dadhania <nikunj@linux.ibm.com>, paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.ibm.com>

Set the newly added register(KVM_REG_PPC_ONLINE) to indicate if the vcpu is
online(1) or offline(0)

KVM will use this information to set the RWMR register, which controls the PURR
and SPURR accumulation.

CC: paulus@samba.org
Signed-off-by: Nikunj A Dadhania <nikunj@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 1 +
 hw/ppc/spapr_rtas.c     | 2 ++
 target/ppc/kvm.c        | 9 +++++++++
 target/ppc/kvm_ppc.h    | 7 +++++++
 4 files changed, 19 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index a73b244a3f..2398ce62c0 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -90,6 +90,7 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r
 
     env->nip = nip;
     env->gpr[3] = r3;
+    kvmppc_set_reg_ppc_online(cpu, 1);
     CPU(cpu)->halted = 0;
     /* Enable Power-saving mode Exit Cause exceptions */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 4ac96bc94b..d6a0952154 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -33,6 +33,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
+#include "kvm_ppc.h"
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
@@ -207,6 +208,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
      * guest */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
     cs->halted = 1;
+    kvmppc_set_reg_ppc_online(cpu, 0);
     qemu_cpu_kick(cs);
 }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index ef63842217..30aeafa7de 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2783,3 +2783,12 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
 
     return !kvmppc_is_pr(cs->kvm_state);
 }
+
+void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online)
+{
+    CPUState *cs = CPU(cpu);
+
+    if (kvm_enabled()) {
+        kvm_set_one_reg(cs, KVM_REG_PPC_ONLINE, &online);
+    }
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 657582bb32..f696c6e498 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -72,6 +72,7 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_hpt_needs_host_contiguous_pages(void);
 void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
+void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
 
 #else
 
@@ -187,6 +188,12 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
     return 0;
 }
 
+static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
+                                             unsigned int online)
+{
+    return;
+}
+
 #ifndef CONFIG_USER_ONLY
 static inline bool kvmppc_spapr_use_multitce(void)
 {
-- 
2.17.1
