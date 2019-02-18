Received: from eggs.gnu.org ([209.51.188.92]:39043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxh-0006Js-Qk
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxd-00030X-Um
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:00 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:18 +1100
Message-Id: <20190218143049.17142-13-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/43] qdev: pass an Object * to
 qbus_set_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Certain devices types, like memory/CPU, are now being handled using a
hotplug interface provided by a top-level MachineClass. Hotpluggable
host bridges are another such device where it makes sense to use a
machine-level hotplug handler. However, unlike those devices,
host-bridges have a parent bus (the main system bus), and devices with
a parent bus use a different mechanism for registering their hotplug
handlers: qbus_set_hotplug_handler(). This interface currently expects
a handler to be a subclass of DeviceClass, but this is not the case
for MachineClass, which derives directly from ObjectClass.

Internally, the interface only requires an ObjectClass, so expose that
in qbus_set_hotplug_handler().

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <154999589921.690774.3640149277362188566.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/acpi/pcihp.c               |  2 +-
 hw/acpi/piix4.c               |  2 +-
 hw/char/virtio-serial-bus.c   |  2 +-
 hw/core/bus.c                 | 11 ++---------
 hw/pci/pcie.c                 |  2 +-
 hw/pci/shpc.c                 |  2 +-
 hw/ppc/spapr_pci.c            |  2 +-
 hw/s390x/css-bridge.c         |  2 +-
 hw/s390x/s390-pci-bus.c       |  6 +++---
 hw/scsi/virtio-scsi.c         |  2 +-
 hw/scsi/vmw_pvscsi.c          |  2 +-
 hw/usb/dev-smartcard-reader.c |  2 +-
 include/hw/qdev-core.h        |  3 +--
 13 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 7bc7a72340..9429181323 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -251,7 +251,7 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplu=
g_dev, AcpiPciHpState *s,
             object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
             PCIBus *sec =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
=20
-            qbus_set_hotplug_handler(BUS(sec), DEVICE(hotplug_dev),
+            qbus_set_hotplug_handler(BUS(sec), OBJECT(hotplug_dev),
                                      &error_abort);
             /* We don't have to overwrite any other hotplug handler yet =
*/
             assert(QLIST_EMPTY(&sec->child));
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 88f9a9ec09..df8c0db909 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -536,7 +536,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **=
errp)
=20
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), DEVICE(s), &error_ab=
ort);
+    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &error_ab=
ort);
=20
     piix4_pm_add_propeties(s);
 }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index d76351d748..bdd917bbb8 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1052,7 +1052,7 @@ static void virtio_serial_device_realize(DeviceStat=
e *dev, Error **errp)
     /* Spawn a new virtio-serial bus on which the ports will ride as dev=
ices */
     qbus_create_inplace(&vser->bus, sizeof(vser->bus), TYPE_VIRTIO_SERIA=
L_BUS,
                         dev, vdev->bus_name);
-    qbus_set_hotplug_handler(BUS(&vser->bus), DEVICE(vser), errp);
+    qbus_set_hotplug_handler(BUS(&vser->bus), OBJECT(vser), errp);
     vser->bus.vser =3D vser;
     QTAILQ_INIT(&vser->ports);
=20
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 4651f24486..e09843f6ab 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -22,22 +22,15 @@
 #include "hw/qdev.h"
 #include "qapi/error.h"
=20
-static void qbus_set_hotplug_handler_internal(BusState *bus, Object *han=
dler,
-                                              Error **errp)
+void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **er=
rp)
 {
-
     object_property_set_link(OBJECT(bus), OBJECT(handler),
                              QDEV_HOTPLUG_HANDLER_PROPERTY, errp);
 }
=20
-void qbus_set_hotplug_handler(BusState *bus, DeviceState *handler, Error=
 **errp)
-{
-    qbus_set_hotplug_handler_internal(bus, OBJECT(handler), errp);
-}
-
 void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp)
 {
-    qbus_set_hotplug_handler_internal(bus, OBJECT(bus), errp);
+    qbus_set_hotplug_handler(bus, OBJECT(bus), errp);
 }
=20
 int qbus_walk_children(BusState *bus,
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 230478faab..3f7c366093 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -543,7 +543,7 @@ void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot=
)
     dev->exp.hpev_notified =3D false;
=20
     qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))=
),
-                             DEVICE(dev), NULL);
+                             OBJECT(dev), NULL);
 }
=20
 void pcie_cap_slot_reset(PCIDevice *dev)
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 45053b39b9..52ccdc5ae3 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -648,7 +648,7 @@ int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRe=
gion *bar,
     shpc_cap_update_dword(d);
     memory_region_add_subregion(bar, offset, &shpc->mmio);
=20
-    qbus_set_hotplug_handler(BUS(sec_bus), DEVICE(d), NULL);
+    qbus_set_hotplug_handler(BUS(sec_bus), OBJECT(d), NULL);
=20
     d->cap_present |=3D QEMU_PCI_CAP_SHPC;
     return 0;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c3fb0ac884..60777b2355 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1686,7 +1686,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_=
BUS);
     phb->bus =3D bus;
-    qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
+    qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
=20
     /*
      * Initialize PHB address space.
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 1bd6c8b458..7573c40bad 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -108,7 +108,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     cbus =3D VIRTUAL_CSS_BUS(bus);
=20
     /* Enable hotplugging */
-    qbus_set_hotplug_handler(bus, dev, &error_abort);
+    qbus_set_hotplug_handler(bus, OBJECT(dev), &error_abort);
=20
     css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
                              0, &error_abort);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 80ff1ce33f..5998942b4c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -742,7 +742,7 @@ static void s390_pcihost_realize(DeviceState *dev, Er=
ror **errp)
     pci_setup_iommu(b, s390_pci_dma_iommu, s);
=20
     bus =3D BUS(b);
-    qbus_set_hotplug_handler(bus, dev, &local_err);
+    qbus_set_hotplug_handler(bus, OBJECT(dev), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -750,7 +750,7 @@ static void s390_pcihost_realize(DeviceState *dev, Er=
ror **errp)
     phb->bus =3D b;
=20
     s->bus =3D S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, dev, NULL));
-    qbus_set_hotplug_handler(BUS(s->bus), dev, &local_err);
+    qbus_set_hotplug_handler(BUS(s->bus), OBJECT(dev), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -912,7 +912,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
         pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
         pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
=20
-        qbus_set_hotplug_handler(BUS(&pb->sec_bus), DEVICE(s), errp);
+        qbus_set_hotplug_handler(BUS(&pb->sec_bus), OBJECT(s), errp);
=20
         if (dev->hotplugged) {
             pci_default_write_config(pdev, PCI_PRIMARY_BUS,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index eb90288f47..ce99d288b0 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -906,7 +906,7 @@ static void virtio_scsi_device_realize(DeviceState *d=
ev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), dev,
                  &virtio_scsi_scsi_info, vdev->bus_name);
     /* override default SCSI bus hotplug-handler, with virtio-scsi's one=
 */
-    qbus_set_hotplug_handler(BUS(&s->bus), dev, &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev), &error_abort);
=20
     virtio_scsi_dataplane_setup(s, errp);
 }
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index a3a019e30a..584b4be07e 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1142,7 +1142,7 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
                  &pvscsi_scsi_info, NULL);
     /* override default SCSI bus hotplug-handler, with pvscsi's one */
-    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(s), &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(s), &error_abort);
     pvscsi_reset_state(s);
 }
=20
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index 8f716fc165..6b0137bb76 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1322,7 +1322,7 @@ static void ccid_realize(USBDevice *dev, Error **er=
rp)
     usb_desc_init(dev);
     qbus_create_inplace(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(d=
ev),
                         NULL);
-    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(dev), &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev), &error_abort);
     s->intr =3D usb_ep_get(dev, USB_TOKEN_IN, CCID_INT_IN_EP);
     s->bulk =3D usb_ep_get(dev, USB_TOKEN_IN, CCID_BULK_IN_EP);
     s->card =3D NULL;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0a84c42756..e70a4bfa49 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -430,8 +430,7 @@ char *qdev_get_dev_path(DeviceState *dev);
=20
 GSList *qdev_build_hotpluggable_device_list(Object *peripheral);
=20
-void qbus_set_hotplug_handler(BusState *bus, DeviceState *handler,
-                              Error **errp);
+void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **er=
rp);
=20
 void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp);
=20
--=20
2.20.1
