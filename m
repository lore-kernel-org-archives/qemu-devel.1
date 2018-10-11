Received: from eggs.gnu.org ([2001:4830:134:3::10]:36037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gAUGy-0002vd-P5
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 02:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gAUGw-00066k-JJ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 02:16:36 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 11 Oct 2018 17:16:09 +1100
Message-Id: <20181011061609.11423-4-sjitindarsingh@gmail.com>
In-Reply-To: <20181011061609.11423-1-sjitindarsingh@gmail.com>
References: <20181011061609.11423-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 3/3] ppc/spapr_caps: Add
 SPAPR_CAP_NESTED_KVM_HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, david@gibson.dropbear.id.au, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add the spapr cap SPAPR_CAP_NESTED_KVM_HV to be used to control the
availability of nested kvm-hv to the level 1 (L1) guest.

Assuming a hypervisor with support enabled an L1 guest can be allowed to
use the kvm-hv module (and thus run it's own kvm-hv guests) by setting:
-machine pseries,cap-nested-hv=true
or disabled with:
-machine pseries,cap-nested-hv=false

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 32 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  5 ++++-
 target/ppc/kvm.c       | 12 ++++++++++++
 target/ppc/kvm_ppc.h   | 12 ++++++++++++
 5 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 98868d893a..8ce97900e9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1915,6 +1915,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_sbbc,
         &vmstate_spapr_cap_ibs,
         &vmstate_spapr_irq_map,
+        &vmstate_spapr_cap_nested_kvm_hv,
         NULL
     }
 };
@@ -3886,6 +3887,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
+    smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_xics;
 }
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index aa605cea91..8e1d791c63 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -368,6 +368,28 @@ static void cap_hpt_maxpagesize_cpu_apply(sPAPRMachineState *spapr,
     ppc_hash64_filter_pagesizes(cpu, spapr_pagesize_cb, &maxshift);
 }
 
+static void cap_nested_kvm_hv_apply(sPAPRMachineState *spapr,
+                                    uint8_t val, Error **errp)
+{
+    if (!val) {
+        /* capability disabled by default */
+        return;
+    }
+
+    if (tcg_enabled()) {
+        error_setg(errp,
+                   "No Nested KVM-HV support in tcg, try cap-nested-hv=off");
+    } else if (kvm_enabled()) {
+        if (!kvmppc_has_cap_nested_kvm_hv()) {
+            error_setg(errp,
+"KVM implementation does not support Nested KVM-HV, try cap-nested-hv=off");
+        } else if (kvmppc_enable_nested_kvm_hv() < 0) {
+                error_setg(errp,
+"Error enabling cap-nested-hv with KVM, try cap-nested-hv=off");
+        }
+    }
+}
+
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -437,6 +459,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
     },
+    [SPAPR_CAP_NESTED_KVM_HV] = {
+        .name = "nested-hv",
+        .description = "Allow Nested KVM-HV",
+        .index = SPAPR_CAP_NESTED_KVM_HV,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_nested_kvm_hv_apply,
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -564,6 +595,7 @@ SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
 SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
 SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
+SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
 
 void spapr_caps_init(sPAPRMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ad4d7cfd97..bced85dd92 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -70,8 +70,10 @@ typedef enum {
 #define SPAPR_CAP_IBS                   0x05
 /* HPT Maximum Page Size (encoded as a shift) */
 #define SPAPR_CAP_HPT_MAXPAGESIZE       0x06
+/* Nested KVM-HV */
+#define SPAPR_CAP_NESTED_KVM_HV         0x07
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_HPT_MAXPAGESIZE + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_KVM_HV + 1)
 
 /*
  * Capability Values
@@ -793,6 +795,7 @@ extern const VMStateDescription vmstate_spapr_cap_dfp;
 extern const VMStateDescription vmstate_spapr_cap_cfpc;
 extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
+extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
 
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 30aeafa7de..8849180548 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -91,6 +91,7 @@ static int cap_ppc_pvr_compat;
 static int cap_ppc_safe_cache;
 static int cap_ppc_safe_bounds_check;
 static int cap_ppc_safe_indirect_branch;
+static int cap_ppc_nested_kvm_hv;
 
 static uint32_t debug_inst_opcode;
 
@@ -150,6 +151,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
     cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
     kvmppc_get_cpu_characteristics(s);
+    cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -2422,6 +2424,16 @@ int kvmppc_get_cap_safe_indirect_branch(void)
     return cap_ppc_safe_indirect_branch;
 }
 
+bool kvmppc_has_cap_nested_kvm_hv(void)
+{
+    return !!cap_ppc_nested_kvm_hv;
+}
+
+int kvmppc_enable_nested_kvm_hv(void)
+{
+    return kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_NESTED_HV, 0);
+}
+
 bool kvmppc_has_cap_spapr_vfio(void)
 {
     return cap_spapr_vfio;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f696c6e498..797271114e 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -62,6 +62,8 @@ bool kvmppc_has_cap_mmu_hash_v3(void);
 int kvmppc_get_cap_safe_cache(void);
 int kvmppc_get_cap_safe_bounds_check(void);
 int kvmppc_get_cap_safe_indirect_branch(void);
+bool kvmppc_has_cap_nested_kvm_hv(void);
+int kvmppc_enable_nested_kvm_hv(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -320,6 +322,16 @@ static inline int kvmppc_get_cap_safe_indirect_branch(void)
     return 0;
 }
 
+static inline bool kvmppc_has_cap_nested_kvm_hv(void)
+{
+    return false;
+}
+
+static inline int kvmppc_enable_nested_kvm_hv(void)
+{
+    return -1;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.13.6
