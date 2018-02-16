Received: from eggs.gnu.org ([2001:4830:134:3::10]:35465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuW-0001cK-Ex
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuT-0005F8-OH
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:32 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 16 Feb 2018 21:06:16 +1100
Message-Id: <20180216100617.25265-14-david@gibson.dropbear.id.au>
In-Reply-To: <20180216100617.25265-1-david@gibson.dropbear.id.au>
References: <20180216100617.25265-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/14] ppc/spapr-caps: Disallow setting
 workaround for spapr-cap-ibs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, surajjs@au1.ibm.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spapr-cap cap-ibs can only have values broken or fixed as there is
no explicit workaround required. Currently setting the value workaround
for this cap will hit an assert if the guest makes the hcall
h_get_cpu_characteristics.

Report an error when attempting to apply the setting with a more helpful
error message.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index e69d308560..99a4b71d19 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -205,7 +205,9 @@ static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
 static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
                                            uint8_t val, Error **errp)
 {
-    if (tcg_enabled() && val) {
+    if (val == SPAPR_CAP_WORKAROUND) { /* Can only be Broken or Fixed */
+        error_setg(errp, "Requested safe indirect branch capability level \"workaround\" not valid, try cap-ibs=fixed");
+    } else if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
         error_setg(errp, "Requested safe indirect branch capability level not supported by tcg, try a different value for cap-ibs");
     } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_branch())) {
@@ -263,7 +265,7 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     },
     [SPAPR_CAP_IBS] = {
         .name = "ibs",
-        .description = "Indirect Branch Serialisation" VALUE_DESC_TRISTATE,
+        .description = "Indirect Branch Serialisation (broken, fixed)",
         .index = SPAPR_CAP_IBS,
         .get = spapr_cap_get_tristate,
         .set = spapr_cap_set_tristate,
-- 
2.14.3
