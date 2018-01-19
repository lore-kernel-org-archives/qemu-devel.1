Received: from eggs.gnu.org ([2001:4830:134:3::10]:60378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ecOn9-0007Zw-QL
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ecOn8-0004sy-PL
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:00:39 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 19 Jan 2018 16:00:04 +1100
Message-Id: <20180119050005.29392-7-sjitindarsingh@gmail.com>
In-Reply-To: <20180119050005.29392-1-sjitindarsingh@gmail.com>
References: <20180119050005.29392-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V5 6/7] target/ppc/spapr_caps: Add
 new tristate cap safe_indirect_branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, paulus@ozlabs.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add new tristate cap cap-ibs to represent the indirect branch
serialisation capability.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

---

V4 -> V5:
 - Use macro to generate migration state
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 21 +++++++++++++++++++++
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4cbed31b16..5544eeb853 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1793,6 +1793,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_dfp,
         &vmstate_spapr_cap_cfpc,
         &vmstate_spapr_cap_sbbc,
+        &vmstate_spapr_cap_ibs,
         NULL
     }
 };
@@ -3882,6 +3883,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     spapr_caps_add_properties(smc, &error_abort);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index ce1f74f26d..62efdaee38 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -202,6 +202,17 @@ static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
     }
 }
 
+static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
+                                           uint8_t val, Error **errp)
+{
+    if (tcg_enabled() && val) {
+        /* TODO - for now only allow broken for TCG */
+        error_setg(errp, "Requested safe indirect branch capability level not supported by tcg, try a different value for cap-ibs");
+    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_branch())) {
+        error_setg(errp, "Requested safe indirect branch capability level not supported by kvm, try a different value for cap-ibs");
+    }
+}
+
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
 
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
@@ -250,6 +261,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "string",
         .apply = cap_safe_bounds_check_apply,
     },
+    [SPAPR_CAP_IBS] = {
+        .name = "ibs",
+        .description = "Indirect Branch Serialisation" VALUE_DESC_TRISTATE,
+        .index = SPAPR_CAP_IBS,
+        .get = spapr_cap_get_tristate,
+        .set = spapr_cap_set_tristate,
+        .type = "string",
+        .apply = cap_safe_indirect_branch_apply,
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -357,6 +377,7 @@ SPAPR_CAP_MIG_STATE(vsx, VSX);
 SPAPR_CAP_MIG_STATE(dfp, DFP);
 SPAPR_CAP_MIG_STATE(cfpc, CFPC);
 SPAPR_CAP_MIG_STATE(sbbc, SBBC);
+SPAPR_CAP_MIG_STATE(ibs, IBS);
 
 void spapr_caps_reset(sPAPRMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c65be62e92..549d7a4134 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -64,8 +64,10 @@ typedef enum {
 #define SPAPR_CAP_CFPC                  0x03
 /* Speculation Barrier Bounds Checking */
 #define SPAPR_CAP_SBBC                  0x04
+/* Indirect Branch Serialisation */
+#define SPAPR_CAP_IBS                   0x05
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_SBBC + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
 
 /*
  * Capability Values
@@ -785,6 +787,7 @@ extern const VMStateDescription vmstate_spapr_cap_vsx;
 extern const VMStateDescription vmstate_spapr_cap_dfp;
 extern const VMStateDescription vmstate_spapr_cap_cfpc;
 extern const VMStateDescription vmstate_spapr_cap_sbbc;
+extern const VMStateDescription vmstate_spapr_cap_ibs;
 
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
-- 
2.13.6
