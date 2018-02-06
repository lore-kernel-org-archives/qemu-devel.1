Received: from eggs.gnu.org ([2001:4830:134:3::10]:44704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j9-0005lA-Hl
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iz-0008GZ-Ac
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iy-0008FR-Ty
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:13 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JFLd1057807
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:12 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyg4xphj0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:11 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:10 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:12 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-52-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 51/54] target/ppc/spapr_caps: Add new tristate
 cap safe_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add new tristate cap cap-cfpc to represent the cache flush on privilege
change capability.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 8f38eaf8f9dd194c9961cf76c675724930ce4570)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 36 ++++++++++++++++++++++++++----------
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6ab39a0e61..37a414ffe6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1765,6 +1765,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_htm,
         &vmstate_spapr_cap_vsx,
         &vmstate_spapr_cap_dfp,
+        &vmstate_spapr_cap_cfpc,
         NULL
     }
 };
@@ -3709,6 +3710,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
     spapr_caps_add_properties(smc, &error_abort);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 3a195c8fef..183916895c 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -74,11 +74,8 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
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
@@ -104,11 +101,8 @@ static void __attribute__ ((unused)) spapr_cap_get_tristate(Object *obj,
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
@@ -187,6 +181,18 @@ static void cap_dfp_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
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
@@ -219,6 +225,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
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
@@ -324,6 +339,7 @@ const VMStateDescription vmstate_spapr_cap_##cap = {    \
 SPAPR_CAP_MIG_STATE(htm, HTM);
 SPAPR_CAP_MIG_STATE(vsx, VSX);
 SPAPR_CAP_MIG_STATE(dfp, DFP);
+SPAPR_CAP_MIG_STATE(cfpc, CFPC);
 
 void spapr_caps_reset(sPAPRMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5d78024433..fdb80f2118 100644
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
@@ -761,6 +763,7 @@ int spapr_caps_pre_save(void *opaque);
 extern const VMStateDescription vmstate_spapr_cap_htm;
 extern const VMStateDescription vmstate_spapr_cap_vsx;
 extern const VMStateDescription vmstate_spapr_cap_dfp;
+extern const VMStateDescription vmstate_spapr_cap_cfpc;
 
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
-- 
2.11.0
