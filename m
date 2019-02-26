Received: from eggs.gnu.org ([209.51.188.92]:39618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyT4B-0003mP-F2
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyT49-0007e7-GW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:05:58 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Tue, 26 Feb 2019 14:05:28 +1100
Message-Id: <20190226030531.9932-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 1/4] target/ppc/spapr: Add
 SPAPR_CAP_LARGE_DECREMENTER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, clg@kaod.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add spapr_cap SPAPR_CAP_LARGE_DECREMENTER to be used to control the
availability and size of the large decrementer made available to the
guest.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b6a571b6f1..acf62a2b9f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2077,6 +2077,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_irq_map,
         &vmstate_spapr_cap_nested_kvm_hv,
         &vmstate_spapr_dtb,
+        &vmstate_spapr_cap_large_decr,
         NULL
     }
 };
@@ -4288,6 +4289,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = 0;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_xics;
     smc->dr_phb_enabled = true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 64f98ae68d..1545a02729 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -182,6 +182,34 @@ static void spapr_cap_set_pagesize(Object *obj, Visitor *v, const char *name,
     spapr->eff.caps[cap->index] = val;
 }
 
+static void spapr_cap_get_uint8(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    uint8_t val = spapr_get_cap(spapr, cap->index);
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void spapr_cap_set_uint8(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    Error *local_err = NULL;
+    uint8_t val;
+
+    visit_type_uint8(v, name, &val, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    spapr->cmd_line_caps[cap->index] = true;
+    spapr->eff.caps[cap->index] = val;
+}
+
 static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
 {
     if (!val) {
@@ -390,6 +418,13 @@ static void cap_nested_kvm_hv_apply(sPAPRMachineState *spapr,
     }
 }
 
+static void cap_large_decr_apply(sPAPRMachineState *spapr,
+                                 uint8_t val, Error **errp)
+{
+    if (val)
+        error_setg(errp, "No large decrementer support, try cap-large-decr=0");
+}
+
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -468,6 +503,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_nested_kvm_hv_apply,
     },
+    [SPAPR_CAP_LARGE_DECREMENTER] = {
+        .name = "large-decr",
+        .description = "Size of Large Decrementer for the Guest (bits) 0=disabled",
+        .index = SPAPR_CAP_LARGE_DECREMENTER,
+        .get = spapr_cap_get_uint8,
+        .set = spapr_cap_set_uint8,
+        .type = "int",
+        .apply = cap_large_decr_apply,
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -596,6 +640,7 @@ SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
 SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
+SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 
 void spapr_caps_init(sPAPRMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 59073a7579..8efc5e0779 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -74,8 +74,10 @@ typedef enum {
 #define SPAPR_CAP_HPT_MAXPAGESIZE       0x06
 /* Nested KVM-HV */
 #define SPAPR_CAP_NESTED_KVM_HV         0x07
+/* Large Decrementer */
+#define SPAPR_CAP_LARGE_DECREMENTER     0x08
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_KVM_HV + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_LARGE_DECREMENTER + 1)
 
 /*
  * Capability Values
@@ -828,6 +830,7 @@ extern const VMStateDescription vmstate_spapr_cap_cfpc;
 extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
+extern const VMStateDescription vmstate_spapr_cap_large_decr;
 
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
-- 
2.13.6
