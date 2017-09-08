Received: from eggs.gnu.org ([2001:4830:134:3::10]:58597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe2-00025s-01
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdx-0003AY-Ak
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:26 +1000
Message-Id: <20170908103558.31632-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/40] spapr_pci: parent the MSI memory region
 to the PHB
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

This memory region should be owned by the PHB. This ensures the PHB
cannot be finalized as long as the the region is guest visible, or
used by a CPU or a device.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d258bc08d5..d7880f257a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1703,7 +1703,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     }
 #endif
 
-    memory_region_init_io(&sphb->msiwindow, NULL, &spapr_msi_ops, spapr,
+    memory_region_init_io(&sphb->msiwindow, OBJECT(sphb), &spapr_msi_ops, spapr,
                           "msi", msi_window_size);
     memory_region_add_subregion(&sphb->iommu_root, SPAPR_PCI_MSI_WINDOW,
                                 &sphb->msiwindow);
-- 
2.13.5
