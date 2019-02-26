Received: from eggs.gnu.org ([209.51.188.92]:58435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlo-0005w9-HK
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUln-0003EP-7d
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:51 +1100
Message-Id: <20190226045304.25618-38-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/50] spapr_pci: add PHB unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

To support PHB hotplug we need to clean up lingering references,
memory, child properties, etc. prior to the PHB object being
finalized. Generally this will be called as a result of calling
object_unparent() on the PHB object, which in turn would normally
be called as the result of an unplug() operation.

When the PHB is finalized, child objects will be unparented in
turn, and finalized if the PHB was the only reference holder. so
we don't bother to explicitly unparent child objects of the PHB,
with the notable exception of DRCs. This is needed to avoid a QEMU
crash when unplugging a PHB and resetting the machine before the
guest could handle the event. The DRCs are removed from the QOM tree
by  pci_unregister_root_bus() and we must make sure we're not leaving
stale aliases under the global /dr-connector path.

The formula that gives the number of DMA windows is moved to an
inline function in the hw/pci-host/spapr.h header because it
will have other users.

The unrealize function is able to cope with partially realized PHBs.
It is hence used to implement proper rollback on the realize error
path.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <155059669881.1466090.13515030705986041517.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c          | 86 +++++++++++++++++++++++++++++++++++--
 include/hw/pci-host/spapr.h |  5 +++
 2 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e2bc9fec82..ede928b0bf 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1570,6 +1570,75 @@ static void spapr_pci_unplug_request(HotplugHandle=
r *plug_handler,
     }
 }
=20
+static void spapr_phb_finalizefn(Object *obj)
+{
+    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(obj);
+
+    g_free(sphb->dtbusname);
+    sphb->dtbusname =3D NULL;
+}
+
+static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
+    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
+    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(phb);
+    sPAPRTCETable *tcet;
+    int i;
+    const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
+
+    if (sphb->msi) {
+        g_hash_table_unref(sphb->msi);
+        sphb->msi =3D NULL;
+    }
+
+    /*
+     * Remove IO/MMIO subregions and aliases, rest should get cleaned
+     * via PHB's unrealize->object_finalize
+     */
+    for (i =3D windows_supported - 1; i >=3D 0; i--) {
+        tcet =3D spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
+        if (tcet) {
+            memory_region_del_subregion(&sphb->iommu_root,
+                                        spapr_tce_get_iommu(tcet));
+        }
+    }
+
+    if (sphb->dr_enabled) {
+        for (i =3D PCI_SLOT_MAX * 8 - 1; i >=3D 0; i--) {
+            sPAPRDRConnector *drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PCI=
,
+                                                    (sphb->index << 16) =
| i);
+
+            if (drc) {
+                object_unparent(OBJECT(drc));
+            }
+        }
+    }
+
+    for (i =3D PCI_NUM_PINS - 1; i >=3D 0; i--) {
+        if (sphb->lsi_table[i].irq) {
+            spapr_irq_free(spapr, sphb->lsi_table[i].irq, 1);
+            sphb->lsi_table[i].irq =3D 0;
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
+    if (sphb->mem64_win_pciaddr !=3D (hwaddr)-1) {
+        memory_region_del_subregion(get_system_memory(), &sphb->mem64win=
dow);
+    }
+    memory_region_del_subregion(get_system_memory(), &sphb->mem32window)=
;
+}
+
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
@@ -1587,8 +1656,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     PCIBus *bus;
     uint64_t msi_window_size =3D 4096;
     sPAPRTCETable *tcet;
-    const unsigned windows_supported =3D
-        sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+    const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
=20
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries ma=
chine");
@@ -1745,6 +1813,10 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
             if (local_err) {
                 error_propagate_prepend(errp, local_err,
                                         "can't allocate LSIs: ");
+                /*
+                 * Older machines will never support PHB hotplug, ie, th=
is is an
+                 * init only path and QEMU will terminate. No need to ro=
llback.
+                 */
                 return;
             }
         }
@@ -1752,7 +1824,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
         spapr_irq_claim(spapr, irq, true, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err, "can't allocate LSI=
s: ");
-            return;
+            goto unrealize;
         }
=20
         sphb->lsi_table[i].irq =3D irq;
@@ -1772,13 +1844,17 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
         if (!tcet) {
             error_setg(errp, "Creating window#%d failed for %s",
                        i, sphb->dtbusname);
-            return;
+            goto unrealize;
         }
         memory_region_add_subregion(&sphb->iommu_root, 0,
                                     spapr_tce_get_iommu(tcet));
     }
=20
     sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_free,=
 g_free);
+    return;
+
+unrealize:
+    spapr_phb_unrealize(dev, NULL);
 }
=20
 static int spapr_phb_children_reset(Object *child, void *opaque)
@@ -1977,6 +2053,7 @@ static void spapr_phb_class_init(ObjectClass *klass=
, void *data)
=20
     hc->root_bus_path =3D spapr_phb_root_bus_path;
     dc->realize =3D spapr_phb_realize;
+    dc->unrealize =3D spapr_phb_unrealize;
     dc->props =3D spapr_phb_properties;
     dc->reset =3D spapr_phb_reset;
     dc->vmsd =3D &vmstate_spapr_pci;
@@ -1992,6 +2069,7 @@ static const TypeInfo spapr_phb_info =3D {
     .name          =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
     .parent        =3D TYPE_PCI_HOST_BRIDGE,
     .instance_size =3D sizeof(sPAPRPHBState),
+    .instance_finalize =3D spapr_phb_finalizefn,
     .class_init    =3D spapr_phb_class_init,
     .interfaces    =3D (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index f6e43f48fe..4b0443f4cf 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -165,4 +165,9 @@ static inline void spapr_phb_vfio_reset(DeviceState *=
qdev)
=20
 void spapr_phb_dma_reset(sPAPRPHBState *sphb);
=20
+static inline unsigned spapr_phb_windows_supported(sPAPRPHBState *sphb)
+{
+    return sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+}
+
 #endif /* PCI_HOST_SPAPR_H */
--=20
2.20.1
