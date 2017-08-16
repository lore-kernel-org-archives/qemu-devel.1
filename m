Received: from eggs.gnu.org ([2001:4830:134:3::10]:46578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dhuNx-0001Ld-32
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dhuNt-0004K3-PR
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:13:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49763
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dhuNt-0004Jo-Jg
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:13:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7G99w7r003679
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 05:13:05 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cceskuenb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 05:13:04 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 16 Aug 2017 03:13:03 -0600
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 16 Aug 2017 14:42:48 +0530
In-Reply-To: <150287457293.9760.17827532208744487789.stgit@aravinda>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <150287476880.9760.9354459130009292681.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v3 5/5] ppc: spapr: Enable FWNMI capability
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
 hw/ppc/spapr_rtas.c |   17 +++++++++++++++++
 target/ppc/kvm.c    |    2 ++
 2 files changed, 19 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 2f3c47b..c2a361a 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -47,6 +47,8 @@
 #include "trace.h"
 #include "hw/ppc/fdt.h"
 
+extern int cap_fwnmi;
+
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
                                    target_ulong args,
@@ -354,7 +356,22 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
                                   target_ulong args,
                                   uint32_t nret, target_ulong rets)
 {
+    int ret;
+    CPUState *cs = CPU(cpu);
+
+    if (!cap_fwnmi) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    }
+
     spapr->guest_machine_check_addr = rtas_ld(args, 1);
+
+    ret = kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
+    if (ret < 0) {
+        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+        return;
+    }
+
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 73f64ed..ca1ffa6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -90,6 +90,7 @@ static int cap_htm;             /* Hardware transactional memory support */
 static int cap_mmu_radix;
 static int cap_mmu_hash_v3;
 static int cap_resize_hpt;
+int cap_fwnmi;
 
 static uint32_t debug_inst_opcode;
 
@@ -147,6 +148,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
     cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
     cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
+    cap_fwnmi = kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
 
     if (!cap_interrupt_level) {
         fprintf(stderr, "KVM: Couldn't find level irq capability. Expect the "
