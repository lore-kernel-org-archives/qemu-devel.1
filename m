Received: from eggs.gnu.org ([2001:4830:134:3::10]:58547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdz-00024K-V5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdu-00037z-Qi
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:15 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:25 +1000
Message-Id: <20170908103558.31632-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/40] spapr_iommu: convert TCE table object to
 realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index ed4388bd75..84d03df5ef 100644
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
     /* Reason: This is just an internal device for handling the hypercalls */
-- 
2.13.5
