Received: from eggs.gnu.org ([2001:4830:134:3::10]:57406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eayKZ-0007tP-9k
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eayKY-0006vV-9g
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:33:15 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 15 Jan 2018 17:32:34 +1100
Message-Id: <20180115063235.7518-6-sjitindarsingh@gmail.com>
In-Reply-To: <20180115063235.7518-1-sjitindarsingh@gmail.com>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 5/6] target/ppc/spapr_caps: Add
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
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, paulus@ozlabs.org, sjitindarsingh@gmail.com

Add new tristate cap cap-ibs to represent the indirect branch
serialisation capability.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 39 +++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 02a0cb656b..269c1c7857 100644
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
@@ -3867,6 +3868,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     spapr_caps_add_properties(smc, &error_abort);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 518e019cf7..0b36333a85 100644
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
@@ -424,6 +444,25 @@ const VMStateDescription vmstate_spapr_cap_sbbc = {
     },
 };
 
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
