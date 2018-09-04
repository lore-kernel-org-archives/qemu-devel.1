Received: from eggs.gnu.org ([2001:4830:134:3::10]:49935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.ibm.com>) id 1fx3w2-0001DS-D3
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 01:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.ibm.com>) id 1fx3vz-0001fY-7n
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 01:31:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44042
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.ibm.com>)
	id 1fx3vz-0001eu-22
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 01:31:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w845TOD7003804
	for <qemu-devel@nongnu.org>; Tue, 4 Sep 2018 01:31:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2m9eh2tjn7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 01:31:25 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.ibm.com>;
	Tue, 4 Sep 2018 06:31:23 +0100
From: Nikunj A Dadhania <nikunj@linux.ibm.com>
Date: Tue,  4 Sep 2018 11:00:39 +0530
Message-Id: <20180904053039.19543-1-nikunj@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2] target/ppc/kvm: set vcpu as online/offline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.ibm.com>, paulus@samba.org

Set the newly added register(KVM_REG_PPC_ONLINE) to indicate if the vcpu is
online(1) or offline(0)

KVM will use this information to set the RWMR register, which controls the PURR
and SPURR accumulation.

CC: paulus@samba.org
Signed-off-by: Nikunj A Dadhania <nikunj@linux.ibm.com>
---
 hw/ppc/spapr_cpu_core.c | 1 +
 hw/ppc/spapr_rtas.c     | 3 +++
 target/ppc/kvm.c        | 9 +++++++++
 target/ppc/kvm_ppc.h    | 6 ++++++
 4 files changed, 19 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 876f0b3d9d..9863221756 100644
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
index 4ac96bc94b..ce8072689b 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -33,6 +33,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
+#include "kvm_ppc.h"
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
@@ -187,6 +188,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr,
     newcpu->env.tb_env->tb_offset = callcpu->env.tb_env->tb_offset;
 
     spapr_cpu_set_entry_state(newcpu, start, r3);
+    kvmppc_set_reg_ppc_online(newcpu, 1);
 
     qemu_cpu_kick(CPU(newcpu));
 
@@ -207,6 +209,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
      * guest */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
     cs->halted = 1;
+    kvmppc_set_reg_ppc_online(cpu, 0);
     qemu_cpu_kick(cs);
 }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9211ee2ee1..7be8081968 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2785,3 +2785,12 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
 
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
index 657582bb32..d635032bd9 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -72,6 +72,7 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_hpt_needs_host_contiguous_pages(void);
 void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
+void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
 
 #else
 
@@ -187,6 +188,11 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
     return 0;
 }
 
+static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online)
+{
+    return;
+}
+
 #ifndef CONFIG_USER_ONLY
 static inline bool kvmppc_spapr_use_multitce(void)
 {
-- 
2.14.4
