Received: from eggs.gnu.org ([2001:4830:134:3::10]:38660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnd-0000ld-VX
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnb-00047u-N4
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:09 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Mar 2018 17:03:46 +1100
Message-Id: <20180302060350.24330-21-david@gibson.dropbear.id.au>
In-Reply-To: <20180302060350.24330-1-david@gibson.dropbear.id.au>
References: <20180302060350.24330-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 20/24] ppc/spapr-caps: Convert cap-cfpc to
 custom spapr-cap
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

Convert cap-cfpc (cache flush on privilege change) to a custom spapr-cap
type.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Don't explicitly list "?"/help option, trusting convention]
[dwg: Strip no-longer-necessary ATTRIBUTE_UNUSED back off]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 3d8b796df9..4a93a3b4de 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -149,9 +149,8 @@ out:
     g_free(val);
 }
 
-static void ATTRIBUTE_UNUSED spapr_cap_get_string(Object *obj, Visitor *v,
-                                                  const char *name,
-                                                  void *opaque, Error **errp)
+static void  spapr_cap_get_string(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
 {
     sPAPRCapabilityInfo *cap = opaque;
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
@@ -169,9 +168,8 @@ static void ATTRIBUTE_UNUSED spapr_cap_get_string(Object *obj, Visitor *v,
     g_free(val);
 }
 
-static void ATTRIBUTE_UNUSED spapr_cap_set_string(Object *obj, Visitor *v,
-                                                  const char *name,
-                                                  void *opaque, Error **errp)
+static void spapr_cap_set_string(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
 {
     sPAPRCapabilityInfo *cap = opaque;
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
@@ -250,14 +248,22 @@ static void cap_dfp_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
     }
 }
 
+sPAPRCapPossible cap_cfpc_possible = {
+    .num = 3,
+    .vals = {"broken", "workaround", "fixed"},
+    .help = "broken - no protection, workaround - workaround available, fixed - fixed in hardware",
+};
+
 static void cap_safe_cache_apply(sPAPRMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
+    uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
+
     if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
         error_setg(errp, "Requested safe cache capability level not supported by tcg, try a different value for cap-cfpc");
-    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_cache())) {
-        error_setg(errp, "Requested safe cache capability level not supported by kvm, try a different value for cap-cfpc");
+    } else if (kvm_enabled() && (val > kvm_val)) {
+        error_setg(errp, "Requested safe cache capability level not supported by kvm, try cap-cfpc=%s", cap_cfpc_possible.vals[kvm_val]);
     }
 }
 
@@ -319,9 +325,10 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .name = "cfpc",
         .description = "Cache Flush on Privilege Change" VALUE_DESC_TRISTATE,
         .index = SPAPR_CAP_CFPC,
-        .get = spapr_cap_get_tristate,
-        .set = spapr_cap_set_tristate,
+        .get = spapr_cap_get_string,
+        .set = spapr_cap_set_string,
         .type = "string",
+        .possible = &cap_cfpc_possible,
         .apply = cap_safe_cache_apply,
     },
     [SPAPR_CAP_SBBC] = {
-- 
2.14.3
