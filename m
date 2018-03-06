Received: from eggs.gnu.org ([2001:4830:134:3::10]:49528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nz-0001Yq-FJ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nx-0004W8-LA
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:23 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:48 +1100
Message-Id: <20180306040154.3669-25-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 24/30] ppc/spapr-caps: Convert cap-sbbc to
 custom spapr-cap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Convert cap-sbbc (speculation barrier bounds checking) to a custom
spapr-cap type.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Removed trailing whitespace]
[dwg: Don't explicitly list "?"/help option, trust convention]
[dwg: Fix some minor style problems]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index b5a991f97a..8748692425 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -271,14 +271,26 @@ static void cap_safe_cache_apply(sPAPRMachineState *spapr, uint8_t val,
     }
 }
 
+sPAPRCapPossible cap_sbbc_possible = {
+    .num = 3,
+    .vals = {"broken", "workaround", "fixed"},
+    .help = "broken - no protection, workaround - workaround available,"
+            " fixed - fixed in hardware",
+};
+
 static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
                                         Error **errp)
 {
+    uint8_t kvm_val =  kvmppc_get_cap_safe_bounds_check();
+
     if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
-        error_setg(errp, "Requested safe bounds check capability level not supported by tcg, try a different value for cap-sbbc");
-    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_bounds_check())) {
-        error_setg(errp, "Requested safe bounds check capability level not supported by kvm, try a different value for cap-sbbc");
+        error_setg(errp,
+"Requested safe bounds check capability level not supported by tcg, try a different value for cap-sbbc");
+    } else if (kvm_enabled() && (val > kvm_val)) {
+        error_setg(errp,
+"Requested safe bounds check capability level not supported by kvm, try cap-sbbc=%s",
+                   cap_sbbc_possible.vals[kvm_val]);
     }
 }
 
@@ -339,9 +351,10 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .name = "sbbc",
         .description = "Speculation Barrier Bounds Checking" VALUE_DESC_TRISTATE,
         .index = SPAPR_CAP_SBBC,
-        .get = spapr_cap_get_tristate,
-        .set = spapr_cap_set_tristate,
+        .get = spapr_cap_get_string,
+        .set = spapr_cap_set_string,
         .type = "string",
+        .possible = &cap_sbbc_possible,
         .apply = cap_safe_bounds_check_apply,
     },
     [SPAPR_CAP_IBS] = {
-- 
2.14.3
