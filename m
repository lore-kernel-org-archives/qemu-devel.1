Received: from eggs.gnu.org ([209.51.188.92]:49551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3vw-0004np-PQ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3vu-0001hR-Pg
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:01:40 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:43118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gi3vs-0001dK-PR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:01:38 -0500
Received: from player726.ha.ovh.net (unknown [10.109.143.216])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 10A631F0ACC
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 22:01:31 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 11 Jan 2019 22:01:11 +0100
Message-ID: <154724047146.525985.16163962086149442020.stgit@bahia.lan>
In-Reply-To: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 03/13] spapr_pci: add PHB unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

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

The unrealize function is able to cope with partially realized PHBs.
It is hence used to implement proper rollback on the realize error
path.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - implement rollback with unrealize function
---
 hw/ppc/spapr_pci.c          |   73 ++++++++++++++++++++++++++++++++++++++++---
 include/hw/pci-host/spapr.h |    4 ++
 2 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 24f95a400623..0d680b71b5d6 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1559,6 +1559,64 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
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
+    if (sphb->msi) {
+        g_hash_table_unref(sphb->msi);
+        sphb->msi = NULL;
+    }
+
+    /*
+     * Remove IO/MMIO subregions and aliases, rest should get cleaned
+     * via PHB's unrealize->object_finalize
+     */
+    for (i = windows_supported - 1; i >= 0; i--) {
+        tcet = spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
+        if (tcet) {
+            memory_region_del_subregion(&sphb->iommu_root,
+                                        spapr_tce_get_iommu(tcet));
+        }
+    }
+
+    for (i = PCI_NUM_PINS - 1; i >= 0; i--) {
+        if (sphb->lsi_table[i].irq) {
+            spapr_irq_free(spapr, sphb->lsi_table[i].irq, 1);
+            sphb->lsi_table[i].irq = 0;
+        }
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
@@ -1576,8 +1634,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     PCIBus *bus;
     uint64_t msi_window_size = 4096;
     sPAPRTCETable *tcet;
-    const unsigned windows_supported =
-        sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
 
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries machine");
@@ -1734,14 +1791,14 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
             if (local_err) {
                 error_propagate_prepend(errp, local_err,
                                         "can't allocate LSIs: ");
-                return;
+                goto unrealize;
             }
         }
 
         spapr_irq_claim(spapr, irq, true, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err, "can't allocate LSIs: ");
-            return;
+            goto unrealize;
         }
 
         sphb->lsi_table[i].irq = irq;
@@ -1761,13 +1818,17 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         if (!tcet) {
             error_setg(errp, "Creating window#%d failed for %s",
                        i, sphb->dtbusname);
-            return;
+            goto unrealize;
         }
         memory_region_add_subregion(&sphb->iommu_root, 0,
                                     spapr_tce_get_iommu(tcet));
     }
 
     sphb->msi = g_hash_table_new_full(g_int_hash, g_int_equal, g_free, g_free);
+    return;
+
+unrealize:
+    spapr_phb_unrealize(dev, NULL);
 }
 
 static int spapr_phb_children_reset(Object *child, void *opaque)
@@ -1966,6 +2027,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
 
     hc->root_bus_path = spapr_phb_root_bus_path;
     dc->realize = spapr_phb_realize;
+    dc->unrealize = spapr_phb_unrealize;
     dc->props = spapr_phb_properties;
     dc->reset = spapr_phb_reset;
     dc->vmsd = &vmstate_spapr_pci;
@@ -1981,6 +2043,7 @@ static const TypeInfo spapr_phb_info = {
     .name          = TYPE_SPAPR_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(sPAPRPHBState),
+    .instance_finalize = spapr_phb_finalizefn,
     .class_init    = spapr_phb_class_init,
     .interfaces    = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index e0e683c32469..16f42d0c0254 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -164,4 +164,8 @@ static inline void spapr_phb_vfio_reset(DeviceState *qdev)
 
 void spapr_phb_dma_reset(sPAPRPHBState *sphb);
 
+static inline unsigned spapr_phb_windows_supported(sPAPRPHBState *sphb)
+{
+    return sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+}
 #endif /* PCI_HOST_SPAPR_H */
