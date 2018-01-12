Received: from eggs.gnu.org ([2001:4830:134:3::10]:34414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZryj-0004oN-M0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 00:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZryh-0007Oy-TL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 00:34:09 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 12 Jan 2018 16:33:44 +1100
Message-Id: <20180112053345.13075-3-sjitindarsingh@gmail.com>
In-Reply-To: <20180112053345.13075-1-sjitindarsingh@gmail.com>
References: <20180112053345.13075-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 2/3] hw/spapr/spapr_caps: Add new
 caps safe_[cache/bounds_check/indirect_branch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, paulus@ozlabs.org, sjitindarsingh@gmail.com

This patch adds three new capabilities:
cap-cfpc -> safe_cache
cap-sbbc -> safe_bounds_check
cap-ibs  -> safe_indirect_branch

Each capability is tristate with the possible values "broken",
"workaround" or "fixed". Add generic getter and setter functions for
this new capability type. Add these new capabilities to the capabilities
list. The maximum value for the capabilities is queried from kvm through
new kvm capabilities. The requested values are considered to be
compatible if kvm can support an equal or higher value for each
capability.

Note: For TCG we only allow broken for each of these until we decide on
      a mitigation technique.
---
 hw/ppc/spapr.c            |   6 ++
 hw/ppc/spapr_caps.c       | 181 ++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h    |  15 +++-
 linux-headers/linux/kvm.h |   3 +
 target/ppc/kvm.c          |  28 +++++++
 target/ppc/kvm_ppc.h      |  18 +++++
 6 files changed, 250 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3e528fe91e..269c1c7857 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1791,6 +1791,9 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_htm,
         &vmstate_spapr_cap_vsx,
         &vmstate_spapr_cap_dfp,
+        &vmstate_spapr_cap_cfpc,
+        &vmstate_spapr_cap_sbbc,
+        &vmstate_spapr_cap_ibs,
         NULL
     }
 };
@@ -3863,6 +3866,9 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     spapr_caps_add_properties(smc, &error_abort);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f95a78547d..1c0c2c8253 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -74,6 +74,66 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
     spapr->eff.caps[cap->index] = value ? SPAPR_CAP_ON : SPAPR_CAP_OFF;
 }
 
+static void spapr_cap_get_tristate(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    char *val = NULL;
+    uint8_t value = spapr_get_cap(spapr, cap->index);
+
+    switch (value) {
+    case SPAPR_CAP_BROKEN:
+        val = g_strdup("broken");
+        break;
+    case SPAPR_CAP_WORKAROUND:
+        val = g_strdup("workaround");
+        break;
+    case SPAPR_CAP_FIXED:
+        val = g_strdup("fixed");
+        break;
+    default:
+        error_setg(errp, "Invalid value (%d) for cap-%s", value, cap->name);
+        return;
+    }
+
+    visit_type_str(v, name, &val, errp);
+    g_free(val);
+}
+
+static void spapr_cap_set_tristate(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    char *val;
+    Error *local_err = NULL;
+    uint8_t value;
+
+    visit_type_str(v, name, &val, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (!strcasecmp(val, "broken")) {
+        value = SPAPR_CAP_BROKEN;
+    } else if (!strcasecmp(val, "workaround")) {
+        value = SPAPR_CAP_WORKAROUND;
+    } else if (!strcasecmp(val, "fixed")) {
+        value = SPAPR_CAP_FIXED;
+    } else {
+        error_setg(errp, "Invalid capability mode \"%s\" for cap-%s", val,
+                   cap->name);
+        goto out;
+    }
+
+    spapr->cmd_line_caps[cap->index] = true;
+    spapr->eff.caps[cap->index] = value;
+out:
+    g_free(val);
+}
+
 static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
 {
     if (!val) {
@@ -121,6 +181,40 @@ static void cap_dfp_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
     }
 }
 
+static void cap_safe_cache_apply(sPAPRMachineState *spapr, uint8_t val,
+                                 Error **errp)
+{
+    if (tcg_enabled() && val) {
+        /* TODO - for now only allow broken for TCG */
+        error_setg(errp, "Requested safe cache capability level not supported by tcg, try a different value for cap-cfpc");
+    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_cache())) {
+        error_setg(errp, "Requested safe cache capability level not supported by kvm, try a different value for cap-cfpc");
+    }
+}
+
+static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
+                                        Error **errp)
+{
+    if (tcg_enabled() && val) {
+        /* TODO - for now only allow broken for TCG */
+        error_setg(errp, "Requested safe bounds check capability level not supported by tcg, try a different value for cap-cfpc");
+    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_bounds_check())) {
+        error_setg(errp, "Requested safe bounds check capability level not supported by kvm, try a different value for cap-sbbc");
+    }
+}
+
+static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
+                                           uint8_t val, Error **errp)
+{
+    if (tcg_enabled() && val) {
+        /* TODO - for now only allow broken for TCG */
+        error_setg(errp, "Requested safe indirect branch capability level not supported by tcg, try a different value for cap-cfpc");
+    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_branch())) {
+        error_setg(errp, "Requested safe indirect branch capability level not supported by kvm, try a different value for cap-ibs");
+    }
+}
+
+#define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
 
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
@@ -153,6 +247,36 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_dfp_apply,
     },
+    [SPAPR_CAP_CFPC] = {
+        .name = "cfpc",
+        .description = "Cache Flush on Privilege Change",
+        .options = VALUE_DESC_TRISTATE,
+        .index = SPAPR_CAP_CFPC,
+        .get = spapr_cap_get_tristate,
+        .set = spapr_cap_set_tristate,
+        .type = "string",
+        .apply = cap_safe_cache_apply,
+    },
+    [SPAPR_CAP_SBBC] = {
+        .name = "sbbc",
+        .description = "Speculation Barrier Bounds Checking",
+        .options = VALUE_DESC_TRISTATE,
+        .index = SPAPR_CAP_SBBC,
+        .get = spapr_cap_get_tristate,
+        .set = spapr_cap_set_tristate,
+        .type = "string",
+        .apply = cap_safe_bounds_check_apply,
+    },
+    [SPAPR_CAP_IBS] = {
+        .name = "ibs",
+        .description = "Indirect Branch Serialisation",
+        .options = VALUE_DESC_TRISTATE,
+        .index = SPAPR_CAP_IBS,
+        .get = spapr_cap_get_tristate,
+        .set = spapr_cap_set_tristate,
+        .type = "string",
+        .apply = cap_safe_indirect_branch_apply,
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -289,6 +413,63 @@ const VMStateDescription vmstate_spapr_cap_dfp = {
     },
 };
 
+static bool spapr_cap_cfpc_needed(void *opaque)
+{
+    sPAPRMachineState *spapr = opaque;
+
+    return spapr->cmd_line_caps[SPAPR_CAP_CFPC] &&
+           (spapr->eff.caps[SPAPR_CAP_CFPC] != spapr->def.caps[SPAPR_CAP_CFPC]);
+}
+
+const VMStateDescription vmstate_spapr_cap_cfpc = {
+    .name = "spapr/cap/cfpc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_cap_cfpc_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(mig.caps[SPAPR_CAP_CFPC], sPAPRMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static bool spapr_cap_sbbc_needed(void *opaque)
+{
+    sPAPRMachineState *spapr = opaque;
+
+    return spapr->cmd_line_caps[SPAPR_CAP_SBBC] &&
+           (spapr->eff.caps[SPAPR_CAP_SBBC] != spapr->def.caps[SPAPR_CAP_SBBC]);
+}
+
+const VMStateDescription vmstate_spapr_cap_sbbc = {
+    .name = "spapr/cap/sbbc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_cap_sbbc_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(mig.caps[SPAPR_CAP_SBBC], sPAPRMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static bool spapr_cap_ibs_needed(void *opaque)
+{
+    sPAPRMachineState *spapr = opaque;
+
+    return spapr->cmd_line_caps[SPAPR_CAP_IBS] &&
+           (spapr->eff.caps[SPAPR_CAP_IBS] != spapr->def.caps[SPAPR_CAP_IBS]);
+}
+
+const VMStateDescription vmstate_spapr_cap_ibs = {
+    .name = "spapr/cap/ibs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_cap_ibs_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(mig.caps[SPAPR_CAP_IBS], sPAPRMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 void spapr_caps_reset(sPAPRMachineState *spapr)
 {
     sPAPRCapabilities default_caps;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 0f5628f22e..63ffd422b5 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -60,8 +60,14 @@ typedef enum {
 #define SPAPR_CAP_VSX                   0x01
 /* Decimal Floating Point */
 #define SPAPR_CAP_DFP                   0x02
+/* Cache Flush on Privilege Change */
+#define SPAPR_CAP_CFPC                  0x03
+/* Speculation Barrier Bounds Checking */
+#define SPAPR_CAP_SBBC                  0x04
+/* Indirect Branch Serialisation */
+#define SPAPR_CAP_IBS                   0x05
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_DFP + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
 
 /*
  * Capability Values
@@ -69,6 +75,10 @@ typedef enum {
 /* Bool Caps */
 #define SPAPR_CAP_OFF                   0x00
 #define SPAPR_CAP_ON                    0x01
+/* Broken | Workaround | Fixed Caps */
+#define SPAPR_CAP_BROKEN                0x00
+#define SPAPR_CAP_WORKAROUND            0x01
+#define SPAPR_CAP_FIXED                 0x02
 
 typedef struct sPAPRCapabilities sPAPRCapabilities;
 struct sPAPRCapabilities {
@@ -763,6 +773,9 @@ int spapr_caps_pre_save(void *opaque);
 extern const VMStateDescription vmstate_spapr_cap_htm;
 extern const VMStateDescription vmstate_spapr_cap_vsx;
 extern const VMStateDescription vmstate_spapr_cap_dfp;
+extern const VMStateDescription vmstate_spapr_cap_cfpc;
+extern const VMStateDescription vmstate_spapr_cap_sbbc;
+extern const VMStateDescription vmstate_spapr_cap_ibs;
 
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index ce6c2f11f4..0abe0a0abb 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -932,6 +932,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
 #define KVM_CAP_S390_AIS_MIGRATION 150
+#define KVM_CAP_PPC_SAFE_CACHE 151
+#define KVM_CAP_PPC_SAFE_BOUNDS_CHECK 152
+#define KVM_CAP_PPC_SAFE_INDIRECT_BRANCH 153
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 914be687e7..94b7ee67e2 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -89,6 +89,9 @@ static int cap_mmu_radix;
 static int cap_mmu_hash_v3;
 static int cap_resize_hpt;
 static int cap_ppc_pvr_compat;
+static int cap_ppc_safe_cache;
+static int cap_ppc_safe_bounds_check;
+static int cap_ppc_safe_indirect_branch;
 
 static uint32_t debug_inst_opcode;
 
@@ -147,6 +150,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
     cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
     cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
+    cap_ppc_safe_cache = kvm_vm_check_extension(s, KVM_CAP_PPC_SAFE_CACHE);
+    cap_ppc_safe_cache = cap_ppc_safe_cache > 0 ? cap_ppc_safe_cache : 0;
+    cap_ppc_safe_bounds_check = kvm_vm_check_extension(s,
+                                KVM_CAP_PPC_SAFE_BOUNDS_CHECK);
+    cap_ppc_safe_bounds_check = cap_ppc_safe_bounds_check > 0 ?
+                                cap_ppc_safe_bounds_check : 0;
+    cap_ppc_safe_indirect_branch = kvm_vm_check_extension(s,
+                                   KVM_CAP_PPC_SAFE_INDIRECT_BRANCH);
+    cap_ppc_safe_indirect_branch = cap_ppc_safe_indirect_branch > 0 ?
+                                   cap_ppc_safe_indirect_branch : 0;
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -2456,6 +2469,21 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
     return cap_mmu_hash_v3;
 }
 
+int kvmppc_get_cap_safe_cache(void)
+{
+    return cap_ppc_safe_cache;
+}
+
+int kvmppc_get_cap_safe_bounds_check(void)
+{
+    return cap_ppc_safe_bounds_check;
+}
+
+int kvmppc_get_cap_safe_indirect_branch(void)
+{
+    return cap_ppc_safe_indirect_branch;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index ecb55493cc..39830baa77 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -59,6 +59,9 @@ bool kvmppc_has_cap_fixup_hcalls(void);
 bool kvmppc_has_cap_htm(void);
 bool kvmppc_has_cap_mmu_radix(void);
 bool kvmppc_has_cap_mmu_hash_v3(void);
+int kvmppc_get_cap_safe_cache(void);
+int kvmppc_get_cap_safe_bounds_check(void);
+int kvmppc_get_cap_safe_indirect_branch(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -290,6 +293,21 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
     return false;
 }
 
+static inline int kvmppc_get_cap_safe_cache(void)
+{
+    return 0;
+}
+
+static inline int kvmppc_get_cap_safe_bounds_check(void)
+{
+    return 0;
+}
+
+static inline int kvmppc_get_cap_safe_indirect_branch(void)
+{
+    return 0;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.13.6
