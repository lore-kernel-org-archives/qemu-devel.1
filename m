Received: from eggs.gnu.org ([2001:4830:134:3::10]:59613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8no-0005PY-Hc
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8nl-0006LG-7f
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:36:32 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:58381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ga8nk-0006IO-Ua
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:36:29 -0500
Received: from player168.ha.ovh.net (unknown [10.109.160.62])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A56E51EE989
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 01:36:27 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 01:36:12 +0100
Message-ID: <154535257235.862554.618590581497296693.stgit@bahia.lan>
In-Reply-To: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 05/15] spapr_pci: add PHB unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

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

The formula that gives the number of DMA windows is moved to an
inline function in the hw/pci-host/spapr.h header because it
will have other users.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c          |   56 +++++++++++++++++++++++++++++++++++++++++--
 include/hw/pci-host/spapr.h |    4 +++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 46d7062dd143..b772b72d6a48 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1551,6 +1551,57 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
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
+    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(phb);
+    sPAPRTCETable *tcet;
+    int i;
+    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
+
+    g_hash_table_unref(sphb->msi);
+
+    /*
+     * Remove IO/MMIO subregions and aliases, rest should get cleaned
+     * via PHB's unrealize->object_finalize
+     */
+    for (i = windows_supported - 1; i >= 0; i--) {
+        tcet = spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
+        assert(tcet);
+        memory_region_del_subregion(&sphb->iommu_root,
+                                    spapr_tce_get_iommu(tcet));
+    }
+
+    for (i = PCI_NUM_PINS - 1; i >= 0; i--) {
+        spapr_irq_free(spapr, sphb->lsi_table[i].irq, 1);
+    }
+
+    QLIST_REMOVE(sphb, list);
+
+    memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
+
+    address_space_destroy(&sphb->iommu_as);
+
+    qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
+    pci_unregister_root_bus(phb->bus);
+
+    memory_region_del_subregion(get_system_memory(), &sphb->iowindow);
+    if (sphb->mem64_win_pciaddr != (hwaddr)-1) {
+        memory_region_del_subregion(get_system_memory(), &sphb->mem64window);
+    }
+    memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
+}
+
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
@@ -1568,8 +1619,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     PCIBus *bus;
     uint64_t msi_window_size = 4096;
     sPAPRTCETable *tcet;
-    const unsigned windows_supported =
-        sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
     Object *drcs[PCI_SLOT_MAX * 8];
 
     if (!spapr) {
@@ -1988,6 +2038,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
 
     hc->root_bus_path = spapr_phb_root_bus_path;
     dc->realize = spapr_phb_realize;
+    dc->unrealize = spapr_phb_unrealize;
     dc->props = spapr_phb_properties;
     dc->reset = spapr_phb_reset;
     dc->vmsd = &vmstate_spapr_pci;
@@ -2002,6 +2053,7 @@ static const TypeInfo spapr_phb_info = {
     .name          = TYPE_SPAPR_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(sPAPRPHBState),
+    .instance_finalize = spapr_phb_finalizefn,
     .class_init    = spapr_phb_class_init,
     .interfaces    = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index a65cfef16945..9d2ec1a410e8 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -162,4 +162,8 @@ static inline void spapr_phb_vfio_reset(DeviceState *qdev)
 
 void spapr_phb_dma_reset(sPAPRPHBState *sphb);
 
+static inline unsigned spapr_phb_windows_supported(sPAPRPHBState *sphb)
+{
+    return sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+}
 #endif /* PCI_HOST_SPAPR_H */
