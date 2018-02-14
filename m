Received: from eggs.gnu.org ([2001:4830:134:3::10]:36822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eloRb-0001a7-70
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:13:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eloRa-0007Sf-Cu
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:13:19 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 14 Feb 2018 15:12:55 +1100
Message-Id: <20180214041256.25473-2-sjitindarsingh@gmail.com>
In-Reply-To: <20180214041256.25473-1-sjitindarsingh@gmail.com>
References: <20180214041256.25473-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC PATCH 2/3] ppc/spapr-caps: Disallow setting
 workaround for spapr-cap-ibs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spapr-cap cap-ibs can only have values broken or fixed as there is
no workaround. Currently setting the value workaround will hit an assert
if the guest makes the hcall h_get_cpu_characteristics.

Report an error when attempting to apply the setting with a more helpful
error message.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_caps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index e69d308560..1cd73b617f 100644
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
-- 
2.13.6
