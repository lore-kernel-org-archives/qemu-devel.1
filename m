Received: from eggs.gnu.org ([2001:4830:134:3::10]:58639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe3-00027P-UL
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdu-00037Z-Jo
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:19 +1000
Message-Id: <20170908103558.31632-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/40] hw/ppc/spapr_drc.c: change
 spapr_drc_needed to use drc->dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This patch makes a small fix in 'spapr_drc_needed' to change how we detect
if a DRC has a device attached. Previously it used dr_entity_sense for this,
which  works for physical DRCs.

However, for logical DRCs, it didn't cover the case where a logical DRC has
a drc->dev but the state is LOGICAL_UNUSABLE (e.g. a hotplugged CPU before
CAS). In this case, the dr_entity_sense of this DRC returns UNUSABLE and the
code was considering that there were no dev attached, making spapr_drc_needed
return 'false' when in fact we would like to migrate the DRC.

Changing it to check for drc->dev instead works for all DRC types.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 605697d8bd..031ba7c387 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -464,10 +464,9 @@ static bool spapr_drc_needed(void *opaque)
 {
     sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    sPAPRDREntitySense value = drck->dr_entity_sense(drc);
 
     /* If no dev is plugged in there is no need to migrate the DRC state */
-    if (value != SPAPR_DR_ENTITY_SENSE_PRESENT) {
+    if (!drc->dev) {
         return false;
     }
 
-- 
2.13.5
