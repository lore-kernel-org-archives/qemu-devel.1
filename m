Received: from eggs.gnu.org ([2001:4830:134:3::10]:58704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1fAUj6-0007Vv-KG
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1fAUj3-00067h-8c
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:13:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36018
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1fAUj3-00067P-3c
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:13:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3N68tIl121714
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 02:13:20 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hh39jb6g3-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 02:13:19 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 23 Apr 2018 07:13:15 +0100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 23 Apr 2018 11:43:02 +0530
Message-Id: <20180423061302.24201-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] target/ppc/kvm: set vcpu as online/offline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, paulus@samba.org

Set the newly added register(KVM_REG_PPC_ONLINE) to indicate if the vcpu is
online(1) or offline(0)

KVM will use this information to set the RWMR register, which controls the PURR
and SPURR accumulation.

CC: paulus@samba.org
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

---

http://patchwork.ozlabs.org/patch/901897/
---
 hw/ppc/spapr.c                  | 1 +
 hw/ppc/spapr_rtas.c             | 4 ++++
 linux-headers/asm-powerpc/kvm.h | 1 +
 target/ppc/kvm.c                | 9 +++++++++
 target/ppc/kvm_ppc.h            | 6 ++++++
 5 files changed, 21 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a81570e7c8..48bafe3765 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1549,6 +1549,7 @@ static void spapr_machine_reset(void)
     first_ppc_cpu->env.gpr[5] = 0;
     first_cpu->halted = 0;
     first_ppc_cpu->env.nip = SPAPR_ENTRY_POINT;
+    kvmppc_set_reg_ppc_online(first_ppc_cpu, 1);
 
     spapr->cas_reboot = false;
 }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0ec5fa4cfe..0874a746dd 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -33,6 +33,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
+#include "kvm_ppc.h"
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
@@ -184,6 +185,8 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
         spapr_cpu_set_endianness(cpu);
         spapr_cpu_update_tb_offset(cpu);
 
+        kvmppc_set_reg_ppc_online(cpu, 1);
+
         qemu_cpu_kick(cs);
 
         rtas_st(rets, 0, RTAS_OUT_SUCCESS);
@@ -204,6 +207,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
     cs->halted = 1;
+    kvmppc_set_reg_ppc_online(cpu, 0);
     qemu_cpu_kick(cs);
 
     /* Disable Power-saving mode Exit Cause exceptions for the CPU.
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 833ed9a16a..1b32b56a03 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -633,6 +633,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+#define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 79a436a384..32a146f838 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2877,3 +2877,12 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
 
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
index 4d2789eef6..7a915fe422 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -72,6 +72,7 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
 bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
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
 static inline off_t kvmppc_alloc_rma(void **rma)
 {
-- 
2.14.3
