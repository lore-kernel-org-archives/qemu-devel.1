Received: from eggs.gnu.org ([2001:4830:134:3::10]:38619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnc-0000kI-St
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdna-00045X-JR
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Mar 2018 17:03:47 +1100
Message-Id: <20180302060350.24330-22-david@gibson.dropbear.id.au>
In-Reply-To: <20180302060350.24330-1-david@gibson.dropbear.id.au>
References: <20180302060350.24330-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 21/24] ppc/spapr-caps: Convert cap-sbbc to
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

Convert cap-sbbc (speculation barrier bounds checking) to a custom
spapr-cap type.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Removed trailing whitespace]
[dwg: Don't explicitly list "?"/help option, trust convention]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 4a93a3b4de..f75d6ff211 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -267,14 +267,22 @@ static void cap_safe_cache_apply(sPAPRMachineState *spapr, uint8_t val,
     }
 }
 
+sPAPRCapPossible cap_sbbc_possible = {
+    .num = 3,
+    .vals = {"broken", "workaround", "fixed"},
+    .help = "broken - no protection, workaround - workaround available, fixed - fixed in hardware",
+};
+
 static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
                                         Error **errp)
 {
+    uint8_t kvm_val =  kvmppc_get_cap_safe_bounds_check();
+
     if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
         error_setg(errp, "Requested safe bounds check capability level not supported by tcg, try a different value for cap-sbbc");
-    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_bounds_check())) {
-        error_setg(errp, "Requested safe bounds check capability level not supported by kvm, try a different value for cap-sbbc");
+    } else if (kvm_enabled() && (val > kvm_val)) {
+        error_setg(errp, "Requested safe bounds check capability level not supported by kvm, try cap-sbbc=%s", cap_sbbc_possible.vals[kvm_val]);
     }
 }
 
@@ -335,9 +343,10 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
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
