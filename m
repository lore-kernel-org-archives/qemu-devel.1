Received: from eggs.gnu.org ([2001:4830:134:3::10]:54293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfO-0006r9-Uf
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfN-0003RS-6e
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:26 +1000
Message-Id: <20170915035130.8354-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/18] spapr_pci: convert sprintf() to
 g_strdup_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

In order to follow a QEMU common practice.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 75cd939223..7d84b9766e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1609,34 +1609,37 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
 
     sphb->dtbusname = g_strdup_printf("pci@%" PRIx64, sphb->buid);
 
-    namebuf = alloca(strlen(sphb->dtbusname) + 32);
-
     /* Initialize memory regions */
-    sprintf(namebuf, "%s.mmio", sphb->dtbusname);
+    namebuf = g_strdup_printf("%s.mmio", sphb->dtbusname);
     memory_region_init(&sphb->memspace, OBJECT(sphb), namebuf, UINT64_MAX);
+    g_free(namebuf);
 
-    sprintf(namebuf, "%s.mmio32-alias", sphb->dtbusname);
+    namebuf = g_strdup_printf("%s.mmio32-alias", sphb->dtbusname);
     memory_region_init_alias(&sphb->mem32window, OBJECT(sphb),
                              namebuf, &sphb->memspace,
                              SPAPR_PCI_MEM_WIN_BUS_OFFSET, sphb->mem_win_size);
+    g_free(namebuf);
     memory_region_add_subregion(get_system_memory(), sphb->mem_win_addr,
                                 &sphb->mem32window);
 
-    sprintf(namebuf, "%s.mmio64-alias", sphb->dtbusname);
+    namebuf = g_strdup_printf("%s.mmio64-alias", sphb->dtbusname);
     memory_region_init_alias(&sphb->mem64window, OBJECT(sphb),
                              namebuf, &sphb->memspace,
                              sphb->mem64_win_pciaddr, sphb->mem64_win_size);
+    g_free(namebuf);
     memory_region_add_subregion(get_system_memory(), sphb->mem64_win_addr,
                                 &sphb->mem64window);
 
     /* Initialize IO regions */
-    sprintf(namebuf, "%s.io", sphb->dtbusname);
+    namebuf = g_strdup_printf("%s.io", sphb->dtbusname);
     memory_region_init(&sphb->iospace, OBJECT(sphb),
                        namebuf, SPAPR_PCI_IO_WIN_SIZE);
+    g_free(namebuf);
 
-    sprintf(namebuf, "%s.io-alias", sphb->dtbusname);
+    namebuf = g_strdup_printf("%s.io-alias", sphb->dtbusname);
     memory_region_init_alias(&sphb->iowindow, OBJECT(sphb), namebuf,
                              &sphb->iospace, 0, SPAPR_PCI_IO_WIN_SIZE);
+    g_free(namebuf);
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
 
@@ -1654,10 +1657,10 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
      * Later the guest might want to create another DMA window
      * which will become another memory subregion.
      */
-    sprintf(namebuf, "%s.iommu-root", sphb->dtbusname);
-
+    namebuf = g_strdup_printf("%s.iommu-root", sphb->dtbusname);
     memory_region_init(&sphb->iommu_root, OBJECT(sphb),
                        namebuf, UINT64_MAX);
+    g_free(namebuf);
     address_space_init(&sphb->iommu_as, &sphb->iommu_root,
                        sphb->dtbusname);
 
-- 
2.13.5
