Received: from eggs.gnu.org ([2001:4830:134:3::10]:56755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da474-00017g-FK
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da471-000183-GC
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:18 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:59101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da471-00017T-AA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:15 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C8ADD116464
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:13 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 19:59:06 +0200
Message-ID: <150100554612.27487.13537614128295672408.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 05/26] spapr_iommu: convert TCE table
 object to realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_iommu.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 740d42608b61..d4eca2a77225 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -248,7 +248,7 @@ static const VMStateDescription vmstate_spapr_tce_table = {
     }
 };
 
-static int spapr_tce_table_realize(DeviceState *dev)
+static void spapr_tce_table_realize(DeviceState *dev, Error **errp)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(dev);
     Object *tcetobj = OBJECT(tcet);
@@ -270,8 +270,6 @@ static int spapr_tce_table_realize(DeviceState *dev)
 
     vmstate_register(DEVICE(tcet), tcet->liobn, &vmstate_spapr_tce_table,
                      tcet);
-
-    return 0;
 }
 
 void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
@@ -618,7 +616,7 @@ int spapr_tcet_dma_dt(void *fdt, int node_off, const char *propname,
 static void spapr_tce_table_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    dc->init = spapr_tce_table_realize;
+    dc->realize = spapr_tce_table_realize;
     dc->reset = spapr_tce_reset;
     dc->unrealize = spapr_tce_table_unrealize;
 
