Received: from eggs.gnu.org ([209.51.188.92]:57769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISzS-0006xD-Ci
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISzQ-0005Sx-Vb
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51324
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hISzQ-0005QY-Pe
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3M73gLW087257
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:03:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s1352hhaj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:03:43 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 22 Apr 2019 08:03:42 +0100
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2019 12:33:35 +0530
In-Reply-To: <155591636364.20338.844048953355207313.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155591661564.20338.10693276428550708820.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v8 5/6] ppc: spapr: Enable FWNMI capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com

Enable the KVM capability KVM_CAP_PPC_FWNMI so that
the KVM causes guest exit with NMI as exit reason
when it encounters a machine check exception on the
address belonging to a guest. Without this capability
enabled, KVM redirects machine check exceptions to
guest's 0x200 vector.

This patch also deals with the case when a guest with
the KVM_CAP_PPC_FWNMI capability enabled is attempted
to migrate to a host that does not support this
capability.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |    1 +
 hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c    |   14 ++++++++++++++
 include/hw/ppc/spapr.h |    4 +++-
 target/ppc/kvm.c       |   14 ++++++++++++++
 target/ppc/kvm_ppc.h   |    6 ++++++
 6 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ffd1715..44e09bb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4372,6 +4372,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_xics;
     smc->dr_phb_enabled = true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index edc5ed0..5b3af04 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -473,6 +473,22 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
     }
 }
 
+static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
+                                Error **errp)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+
+    if (!val) {
+        return; /* Disabled by default */
+    }
+
+    if (kvm_enabled()) {
+        if (kvmppc_fwnmi_enable(cpu)) {
+            error_setg(errp, "Requested fwnmi capability not support by KVM");
+        }
+    }
+}
+
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -571,6 +587,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_ccf_assist_apply,
     },
+    [SPAPR_CAP_FWNMI_MCE] = {
+        .name = "fwnmi-mce",
+        .description = "Handle fwnmi machine check exceptions",
+        .index = SPAPR_CAP_FWNMI_MCE,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_fwnmi_mce_apply,
+    },
 };
 
 static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
@@ -706,6 +731,7 @@ SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
+SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
 
 void spapr_caps_init(SpaprMachineState *spapr)
 {
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index d3499f9..997cf19 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -49,6 +49,7 @@
 #include "hw/ppc/fdt.h"
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/mmu-book3s-v3.h"
+#include "kvm_ppc.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -354,6 +355,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
                                   target_ulong args,
                                   uint32_t nret, target_ulong rets)
 {
+    int ret;
     uint64_t rtas_addr = spapr_get_rtas_addr();
 
     if (!rtas_addr) {
@@ -361,6 +363,18 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
         return;
     }
 
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
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 03f34bf..9d16ad1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -78,8 +78,10 @@ typedef enum {
 #define SPAPR_CAP_LARGE_DECREMENTER     0x08
 /* Count Cache Flush Assist HW Instruction */
 #define SPAPR_CAP_CCF_ASSIST            0x09
+/* FWNMI machine check handling */
+#define SPAPR_CAP_FWNMI_MCE             0x0A
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
 
 /*
  * Capability Values
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 5eedce8..9c7b71d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -83,6 +83,7 @@ static int cap_ppc_safe_indirect_branch;
 static int cap_ppc_count_cache_flush_assist;
 static int cap_ppc_nested_kvm_hv;
 static int cap_large_decr;
+static int cap_ppc_fwnmi;
 
 static uint32_t debug_inst_opcode;
 
@@ -150,6 +151,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     kvmppc_get_cpu_characteristics(s);
     cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
     cap_large_decr = kvmppc_get_dec_bits();
+    cap_ppc_fwnmi = kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -2117,6 +2119,18 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
     }
 }
 
+int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+
+    if (!cap_ppc_fwnmi) {
+        return 1;
+    }
+
+    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
+}
+
+
 int kvmppc_smt_threads(void)
 {
     return cap_ppc_smt ? cap_ppc_smt : 1;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 6edc42f..28919d3 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
 void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
+int kvmppc_fwnmi_enable(PowerPCCPU *cpu);
 int kvmppc_smt_threads(void);
 void kvmppc_hint_smt_possible(Error **errp);
 int kvmppc_set_smt_threads(int smt);
@@ -159,6 +160,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
 {
 }
 
+static inline int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
+{
+    return 1;
+}
+
 static inline int kvmppc_smt_threads(void)
 {
     return 1;
