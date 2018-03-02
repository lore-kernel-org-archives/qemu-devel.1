Received: from eggs.gnu.org ([2001:4830:134:3::10]:38760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdng-0000mN-Gk
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnc-0004A4-PM
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Mar 2018 17:03:48 +1100
Message-Id: <20180302060350.24330-23-david@gibson.dropbear.id.au>
In-Reply-To: <20180302060350.24330-1-david@gibson.dropbear.id.au>
References: <20180302060350.24330-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/24] ppc/spapr-caps: Convert cap-ibs to custom
 spapr-cap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, surajjs@au1.ibm.com, mark.cave-ayland@ilande.co.uk, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Convert cap-ibs (indirect branch speculation) to a custom spapr-cap
type.

All tristate caps have now been converted to custom spapr-caps, so
remove the remaining support for them.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Don't explicitly list "?"/help option, trust convention]
[dwg: Fold tristate removal into here, to not break bisect]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c    | 81 ++++++++++----------------------------------------
 hw/ppc/spapr_hcall.c   |  5 +++-
 include/hw/ppc/spapr.h |  5 +++-
 target/ppc/kvm.c       |  6 ++--
 4 files changed, 28 insertions(+), 69 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f75d6ff211..c09febcf12 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -89,65 +89,6 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
     spapr->eff.caps[cap->index] = value ? SPAPR_CAP_ON : SPAPR_CAP_OFF;
 }
 
-static void spapr_cap_get_tristate(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    sPAPRCapabilityInfo *cap = opaque;
-    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
-    char *val = NULL;
-    uint8_t value = spapr_get_cap(spapr, cap->index);
-
-    switch (value) {
-    case SPAPR_CAP_BROKEN:
-        val = g_strdup("broken");
-        break;
-    case SPAPR_CAP_WORKAROUND:
-        val = g_strdup("workaround");
-        break;
-    case SPAPR_CAP_FIXED:
-        val = g_strdup("fixed");
-        break;
-    default:
-        error_setg(errp, "Invalid value (%d) for cap-%s", value, cap->name);
-        return;
-    }
-
-    visit_type_str(v, name, &val, errp);
-    g_free(val);
-}
-
-static void spapr_cap_set_tristate(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    sPAPRCapabilityInfo *cap = opaque;
-    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
-    char *val;
-    Error *local_err = NULL;
-    uint8_t value;
-
-    visit_type_str(v, name, &val, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    if (!strcasecmp(val, "broken")) {
-        value = SPAPR_CAP_BROKEN;
-    } else if (!strcasecmp(val, "workaround")) {
-        value = SPAPR_CAP_WORKAROUND;
-    } else if (!strcasecmp(val, "fixed")) {
-        value = SPAPR_CAP_FIXED;
-    } else {
-        error_setg(errp, "Invalid capability mode \"%s\" for cap-%s", val,
-                   cap->name);
-        goto out;
-    }
-
-    spapr->cmd_line_caps[cap->index] = true;
-    spapr->eff.caps[cap->index] = value;
-out:
-    g_free(val);
-}
 
 static void  spapr_cap_get_string(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
@@ -286,16 +227,25 @@ static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
     }
 }
 
+sPAPRCapPossible cap_ibs_possible = {
+    .num = 4,
+    /* Note workaround only maintained for compatibility */
+    .vals = {"broken", "workaround", "fixed-ibs", "fixed-ccd"},
+    .help = "broken - no protection, fixed-ibs - indirect branch serialisation, fixed-ccd - cache count disabled",
+};
+
 static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
                                            uint8_t val, Error **errp)
 {
+    uint8_t kvm_val = kvmppc_get_cap_safe_indirect_branch();
+
     if (val == SPAPR_CAP_WORKAROUND) { /* Can only be Broken or Fixed */
-        error_setg(errp, "Requested safe indirect branch capability level \"workaround\" not valid, try cap-ibs=fixed");
+        error_setg(errp, "Requested safe indirect branch capability level \"workaround\" not valid, try cap-ibs=%s", cap_ibs_possible.vals[kvm_val]);
     } else if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
         error_setg(errp, "Requested safe indirect branch capability level not supported by tcg, try a different value for cap-ibs");
-    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_branch())) {
-        error_setg(errp, "Requested safe indirect branch capability level not supported by kvm, try a different value for cap-ibs");
+    } else if (kvm_enabled() && val && (val != kvm_val)) {
+        error_setg(errp, "Requested safe indirect branch capability level not supported by kvm, try cap-ibs=%s", cap_ibs_possible.vals[kvm_val]);
     }
 }
 
@@ -351,11 +301,12 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     },
     [SPAPR_CAP_IBS] = {
         .name = "ibs",
-        .description = "Indirect Branch Serialisation (broken, fixed)",
+        .description = "Indirect Branch Speculation (broken, fixed-ibs, fixed-ccd)",
         .index = SPAPR_CAP_IBS,
-        .get = spapr_cap_get_tristate,
-        .set = spapr_cap_set_tristate,
+        .get = spapr_cap_get_string,
+        .set = spapr_cap_set_string,
         .type = "string",
+        .possible = &cap_ibs_possible,
         .apply = cap_safe_indirect_branch_apply,
     },
 };
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 1986560480..16bccdd5c0 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1705,7 +1705,10 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
     }
 
     switch (safe_indirect_branch) {
-    case SPAPR_CAP_FIXED:
+    case SPAPR_CAP_FIXED_CCD:
+        characteristics |= H_CPU_CHAR_CACHE_COUNT_DIS;
+        break;
+    case SPAPR_CAP_FIXED_IBS:
         characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;
         break;
     default: /* broken */
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 36942b378d..d60b7c6d7a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -75,10 +75,12 @@ typedef enum {
 /* Bool Caps */
 #define SPAPR_CAP_OFF                   0x00
 #define SPAPR_CAP_ON                    0x01
-/* Broken | Workaround | Fixed Caps */
+/* Custom Caps */
 #define SPAPR_CAP_BROKEN                0x00
 #define SPAPR_CAP_WORKAROUND            0x01
 #define SPAPR_CAP_FIXED                 0x02
+#define SPAPR_CAP_FIXED_IBS             0x02
+#define SPAPR_CAP_FIXED_CCD             0x03
 
 typedef struct sPAPRCapabilities sPAPRCapabilities;
 struct sPAPRCapabilities {
@@ -313,6 +315,7 @@ struct sPAPRMachineState {
 #define H_CPU_CHAR_L1D_THREAD_PRIV              PPC_BIT(4)
 #define H_CPU_CHAR_HON_BRANCH_HINTS             PPC_BIT(5)
 #define H_CPU_CHAR_THR_RECONF_TRIG              PPC_BIT(6)
+#define H_CPU_CHAR_CACHE_COUNT_DIS              PPC_BIT(7)
 #define H_CPU_BEHAV_FAVOUR_SECURITY             PPC_BIT(0)
 #define H_CPU_BEHAV_L1D_FLUSH_PR                PPC_BIT(1)
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR           PPC_BIT(2)
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2c183f61e2..79a436a384 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2494,8 +2494,10 @@ static void kvmppc_get_cpu_characteristics(KVMState *s)
         cap_ppc_safe_bounds_check = 1;
     }
     /* Parse and set cap_ppc_safe_indirect_branch */
-    if (c.character & c.character_mask & H_CPU_CHAR_BCCTRL_SERIALISED) {
-        cap_ppc_safe_indirect_branch = 2;
+    if (c.character & c.character_mask & H_CPU_CHAR_CACHE_COUNT_DIS) {
+        cap_ppc_safe_indirect_branch = SPAPR_CAP_FIXED_CCD;
+    } else if (c.character & c.character_mask & H_CPU_CHAR_BCCTRL_SERIALISED) {
+        cap_ppc_safe_indirect_branch = SPAPR_CAP_FIXED_IBS;
     }
 }
 
-- 
2.14.3
