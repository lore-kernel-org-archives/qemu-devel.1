Received: from eggs.gnu.org ([2001:4830:134:3::10]:57216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da48u-0002nj-Rb
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da48r-0002Pm-Rn
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:12 -0400
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:34015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da48r-0002Ou-LC
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:09 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id CC12F116651
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:01:07 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:01:00 +0200
Message-ID: <150100566015.27487.526106415682092173.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 14/26] spapr_pci: add PHB unrealize
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

From: Michael Roth <mdroth@linux.vnet.ibm.com>

To support PHB hotplug we need to clean up lingering references,
memory, child properties, etc. prior to the PHB object being
finalized. Generally this will be called as a result of calling
object_unparent() on the PHB object, which in turn would normally
be called as the result of an unplug() operation.

When the PHB is finalized, child objects will be unparented in
turn, and finalized if the PHB was the only reference holder. so
we don't bother to explicitly unparent child objects of the PHB
(spapr_iommu, spapr_drc, etc).

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes since RFC:
- rebased against ppc-for-2.10
- s/object_unref/object_unparent/ in the changelog
- adapted to DDW and 64-bit MMIO window
- free dtbusname in finalize function
- don't bother to unparent memory regions: they seem to drop any reference
  on the PHB during unrealize (ie, I couldn't find a scenario where the
  PHB isn't finalized)
---
 hw/ppc/spapr_pci.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 4e4165b44b9a..994d2f36105f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1530,6 +1530,50 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     }
 }
 
+static void spapr_phb_finalizefn(Object *obj)
+{
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(obj);
+
+    g_free(sphb->dtbusname);
+    sphb->dtbusname = NULL;
+}
+
+static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(phb);
+    sPAPRTCETable *tcet;
+    int i;
+    const unsigned windows_supported =
+        sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+
+    g_hash_table_unref(sphb->msi);
+
+    /* remove IO/MMIO subregions and aliases, rest should get cleaned
+     * via PHB's unrealize->object_finalize
+     */
+    for (i = windows_supported - 1; i >= 0; i--) {
+        tcet = spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
+        g_assert(tcet);
+        memory_region_del_subregion(&sphb->iommu_root,
+                                    spapr_tce_get_iommu(tcet));
+    }
+
+    QLIST_REMOVE(sphb, list);
+
+    memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
+
+    address_space_destroy(&sphb->iommu_as);
+
+    qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
+    pci_unregister_bus(phb->bus);
+
+    memory_region_del_subregion(get_system_memory(), &sphb->iowindow);
+    memory_region_del_subregion(get_system_memory(), &sphb->mem64window);
+    memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
+}
+
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
@@ -1961,6 +2005,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
 
     hc->root_bus_path = spapr_phb_root_bus_path;
     dc->realize = spapr_phb_realize;
+    dc->unrealize = spapr_phb_unrealize;
     dc->props = spapr_phb_properties;
     dc->reset = spapr_phb_reset;
     dc->vmsd = &vmstate_spapr_pci;
@@ -1975,6 +2020,7 @@ static const TypeInfo spapr_phb_info = {
     .name          = TYPE_SPAPR_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(sPAPRPHBState),
+    .instance_finalize = spapr_phb_finalizefn,
     .class_init    = spapr_phb_class_init,
     .interfaces    = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
