Received: from eggs.gnu.org ([2001:4830:134:3::10]:34874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07a-0004TG-M0
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07Z-0001e4-3N
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 29 Jan 2018 14:28:23 +1100
Message-Id: <20180129032826.16876-10-david@gibson.dropbear.id.au>
In-Reply-To: <20180129032826.16876-1-david@gibson.dropbear.id.au>
References: <20180129032826.16876-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/12] target/ppc/spapr_caps: Add new tristate
 cap safe_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, groug@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add new tristate cap cap-cfpc to represent the cache flush on privilege
change capability.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 36 ++++++++++++++++++++++++++----------
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 88a78d31eb..f881f814ca 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1791,6 +1791,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_htm,
         &vmstate_spapr_cap_vsx,
         &vmstate_spapr_cap_dfp,
+        &vmstate_spapr_cap_cfpc,
         NULL
     }
 };
@@ -3881,6 +3882,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
     spapr_caps_add_properties(smc, &error_abort);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index d6f82b18fc..d53da63b1c 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -73,11 +73,8 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
     spapr->eff.caps[cap->index] = value ? SPAPR_CAP_ON : SPAPR_CAP_OFF;
 }
 
-static void __attribute__ ((unused)) spapr_cap_get_tristate(Object *obj,
-                                                            Visitor *v,
-                                                            const char *name,
-                                                            void *opaque,
-                                                            Error **errp)
+static void spapr_cap_get_tristate(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
 {
     sPAPRCapabilityInfo *cap = opaque;
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
@@ -103,11 +100,8 @@ static void __attribute__ ((unused)) spapr_cap_get_tristate(Object *obj,
     g_free(val);
 }
 
-static void __attribute__ ((unused)) spapr_cap_set_tristate(Object *obj,
-                                                            Visitor *v,
-                                                            const char *name,
-                                                            void *opaque,
-                                                            Error **errp)
+static void spapr_cap_set_tristate(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
 {
     sPAPRCapabilityInfo *cap = opaque;
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
@@ -186,6 +180,18 @@ static void cap_dfp_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
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
+#define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
 
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
@@ -215,6 +221,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_dfp_apply,
     },
+    [SPAPR_CAP_CFPC] = {
+        .name = "cfpc",
+        .description = "Cache Flush on Privilege Change" VALUE_DESC_TRISTATE,
+        .index = SPAPR_CAP_CFPC,
+        .get = spapr_cap_get_tristate,
+        .set = spapr_cap_set_tristate,
+        .type = "string",
+        .apply = cap_safe_cache_apply,
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -320,6 +335,7 @@ const VMStateDescription vmstate_spapr_cap_##cap = {    \
 SPAPR_CAP_MIG_STATE(htm, HTM);
 SPAPR_CAP_MIG_STATE(vsx, VSX);
 SPAPR_CAP_MIG_STATE(dfp, DFP);
+SPAPR_CAP_MIG_STATE(cfpc, CFPC);
 
 void spapr_caps_reset(sPAPRMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 61bb3632c4..ff476693d1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -60,8 +60,10 @@ typedef enum {
 #define SPAPR_CAP_VSX                   0x01
 /* Decimal Floating Point */
 #define SPAPR_CAP_DFP                   0x02
+/* Cache Flush on Privilege Change */
+#define SPAPR_CAP_CFPC                  0x03
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_DFP + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_CFPC + 1)
 
 /*
  * Capability Values
@@ -779,6 +781,7 @@ int spapr_caps_pre_save(void *opaque);
 extern const VMStateDescription vmstate_spapr_cap_htm;
 extern const VMStateDescription vmstate_spapr_cap_vsx;
 extern const VMStateDescription vmstate_spapr_cap_dfp;
+extern const VMStateDescription vmstate_spapr_cap_cfpc;
 
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
-- 
2.14.3
