Received: from eggs.gnu.org ([2001:4830:134:3::10]:50704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dxWDE-00044n-DA
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dxWDA-0007qH-Dq
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:38:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57854
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dxWDA-0007qB-86
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:38:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8SAYAPf071931
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 06:38:31 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d8w9mqkq4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 06:38:31 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Thu, 28 Sep 2017 04:38:30 -0600
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 28 Sep 2017 16:08:21 +0530
In-Reply-To: <150659494872.25889.2069124544245723984.stgit@aravinda>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <150659510129.25889.17733386928036958909.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v5 5/6] ppc: spapr: Enable FWNMI capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com

Enable the KVM capability KVM_CAP_PPC_FWNMI so that
the KVM causes guest exit with NMI as exit reason
when it encounters a machine check exception on the
address belonging to a guest. Without this capability
enabled, KVM redirects machine check exceptions to
guest's 0x200 vector.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr_rtas.c  |   15 +++++++++++++++
 target/ppc/kvm.c     |   13 +++++++++++++
 target/ppc/kvm_ppc.h |    6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 08e9a5e..d017a67 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -46,6 +46,7 @@
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "hw/ppc/fdt.h"
+#include "kvm_ppc.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -354,6 +355,20 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
                                   target_ulong args,
                                   uint32_t nret, target_ulong rets)
 {
+    int ret;
+
+    ret = kvmppc_fwnmi_enable(cpu);
+
+    if (ret == 1) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    }
+
+    if (ret < 0) {
+        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+        return;
+    }
+
     spapr->guest_machine_check_addr = rtas_ld(args, 1);
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7e4ce02..59b3322 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -92,6 +92,7 @@ static int cap_mmu_radix;
 static int cap_mmu_hash_v3;
 static int cap_resize_hpt;
 static int cap_ppc_pvr_compat;
+static int cap_fwnmi;
 
 static uint32_t debug_inst_opcode;
 
@@ -150,6 +151,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
     cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
     cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
+    cap_fwnmi = kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -2142,6 +2144,17 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
     }
 }
 
+int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+
+    if (!cap_fwnmi) {
+        return 1;
+    }
+
+    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
+}
+
 int kvmppc_smt_threads(void)
 {
     return cap_ppc_smt ? cap_ppc_smt : 1;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 0139dae..55b6df2 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -28,6 +28,7 @@ void kvmppc_enable_clear_ref_mod_hcalls(void);
 void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
+int kvmppc_fwnmi_enable(PowerPCCPU *cpu);
 int kvmppc_smt_threads(void);
 void kvmppc_hint_smt_possible(Error **errp);
 int kvmppc_set_smt_threads(int smt);
@@ -157,6 +158,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
 {
 }
 
+int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
+{
+    return 1;
+}
+
 static inline int kvmppc_smt_threads(void)
 {
     return 1;
