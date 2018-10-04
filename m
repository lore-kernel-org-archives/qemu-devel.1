Received: from eggs.gnu.org ([2001:4830:134:3::10]:53639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85aF-0000c1-HW
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85aE-0005rF-B1
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:35 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:57 +0200
Message-Id: <20181004152857.14525-16-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/15] hw/s390x/s390-pci-bus: Convert sysbus
 init function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The SysBusDeviceClass->init() interface is considered as a legacy interfa=
ce
and there are currently some efforts going on to get rid of it. Thus let'=
s
convert the init function in the s390x code to realize() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1538466491-2073-1-git-send-email-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e3e0ebb7f6..e42e1b80d6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -692,27 +692,35 @@ static void s390_pci_iommu_free(S390pciState *s, PC=
IBus *bus, int32_t devfn)
     object_unref(OBJECT(iommu));
 }
=20
-static int s390_pcihost_init(SysBusDevice *dev)
+static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
     BusState *bus;
     PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
     S390pciState *s =3D S390_PCI_HOST_BRIDGE(dev);
+    Error *local_err =3D NULL;
=20
     DPRINTF("host_init\n");
=20
-    b =3D pci_register_root_bus(DEVICE(dev), NULL,
-                              s390_pci_set_irq, s390_pci_map_irq, NULL,
-                              get_system_memory(), get_system_io(), 0, 6=
4,
-                              TYPE_PCI_BUS);
+    b =3D pci_register_root_bus(dev, NULL, s390_pci_set_irq, s390_pci_ma=
p_irq,
+                              NULL, get_system_memory(), get_system_io()=
, 0,
+                              64, TYPE_PCI_BUS);
     pci_setup_iommu(b, s390_pci_dma_iommu, s);
=20
     bus =3D BUS(b);
-    qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
+    qbus_set_hotplug_handler(bus, dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     phb->bus =3D b;
=20
-    s->bus =3D S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, DEVICE(s), NU=
LL));
-    qbus_set_hotplug_handler(BUS(s->bus), DEVICE(s), NULL);
+    s->bus =3D S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, dev, NULL));
+    qbus_set_hotplug_handler(BUS(s->bus), dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
     s->iommu_table =3D g_hash_table_new_full(g_int64_hash, g_int64_equal=
,
                                            NULL, g_free);
@@ -722,9 +730,10 @@ static int s390_pcihost_init(SysBusDevice *dev)
     QTAILQ_INIT(&s->zpci_devs);
=20
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
-                             S390_ADAPTER_SUPPRESSIBLE, &error_abort);
-
-    return 0;
+                             S390_ADAPTER_SUPPRESSIBLE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
 }
=20
 static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
@@ -1018,12 +1027,11 @@ static void s390_pcihost_reset(DeviceState *dev)
=20
 static void s390_pcihost_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(klass);
=20
     dc->reset =3D s390_pcihost_reset;
-    k->init =3D s390_pcihost_init;
+    dc->realize =3D s390_pcihost_realize;
     hc->plug =3D s390_pcihost_hot_plug;
     hc->unplug =3D s390_pcihost_hot_unplug;
     msi_nonbroken =3D true;
--=20
2.14.4
