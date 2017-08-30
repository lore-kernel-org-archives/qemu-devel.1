Received: from eggs.gnu.org ([2001:4830:134:3::10]:57197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dn7cp-00052U-IZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dn7cm-0006Pt-LT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dn7cm-0006Pc-DD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UIK3cr013782
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 14:21:58 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cny3c4wey-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 14:21:58 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 14:21:57 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 15:21:39 -0300
In-Reply-To: <20170830182141.19996-1-danielhb@linux.vnet.ibm.com>
References: <20170830182141.19996-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170830182141.19996-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.11 v3 1/3] hw/ppc/spapr_drc.c: change
 spapr_drc_needed to use drc->dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

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
---
 hw/ppc/spapr_drc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 6541a52..6670a76 100644
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
2.9.4
