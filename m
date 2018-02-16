Received: from eggs.gnu.org ([2001:4830:134:3::10]:60898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1emVqZ-0000rS-Kl
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1emVqY-0004AR-Nu
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:33:59 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 16 Feb 2018 13:33:27 +1100
Message-Id: <20180216023328.8407-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V4 1/2] ppc/spapr-caps: Disallow
 setting workaround for spapr-cap-ibs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spapr-cap cap-ibs can only have values broken or fixed as there is
no explicit workaround required. Currently setting the value workaround
for this cap will hit an assert if the guest makes the hcall
h_get_cpu_characteristics.

Report an error when attempting to apply the setting with a more helpful
error message.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

V3 -> V4:
 - Add this patch back from V1 to replace
   "ppc/spapr-caps: Convert spapr-cap-ibs to be a boolean"
   as this was deemed to be a better solution
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
2.13.6
