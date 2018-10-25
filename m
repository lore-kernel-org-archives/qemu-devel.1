Received: from eggs.gnu.org ([2001:4830:134:3::10]:57123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfmp-00026L-4o
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfm8-0007U9-Ay
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:34:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:26 -0300
Message-Id: <20181025133301.16578-9-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 08/43] hw/sh4/sh_pci: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Move from the legacy SysBusDevice::init method to using DeviceState::real=
ize.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20181002212522.23303-6-f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/sh4/sh_pci.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 4ec2e35500..379d0685ed 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -120,16 +120,15 @@ static void sh_pci_set_irq(void *opaque, int irq_nu=
m, int level)
     qemu_set_irq(pic[irq_num], level);
 }
=20
-static int sh_pci_device_init(SysBusDevice *dev)
+static void sh_pci_device_realize(DeviceState *dev, Error **errp)
 {
-    PCIHostState *phb;
-    SHPCIState *s;
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    SHPCIState *s =3D SH_PCI_HOST_BRIDGE(dev);
+    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
     int i;
=20
-    s =3D SH_PCI_HOST_BRIDGE(dev);
-    phb =3D PCI_HOST_BRIDGE(s);
     for (i =3D 0; i < 4; i++) {
-        sysbus_init_irq(dev, &s->irq[i]);
+        sysbus_init_irq(sbd, &s->irq[i]);
     }
     phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
                                      sh_pci_set_irq, sh_pci_map_irq,
@@ -143,13 +142,12 @@ static int sh_pci_device_init(SysBusDevice *dev)
                              &s->memconfig_p4, 0, 0x224);
     memory_region_init_alias(&s->isa, OBJECT(s), "sh_pci.isa",
                              get_system_io(), 0, 0x40000);
-    sysbus_init_mmio(dev, &s->memconfig_p4);
-    sysbus_init_mmio(dev, &s->memconfig_a7);
+    sysbus_init_mmio(sbd, &s->memconfig_p4);
+    sysbus_init_mmio(sbd, &s->memconfig_a7);
     s->iobr =3D 0xfe240000;
     memory_region_add_subregion(get_system_memory(), s->iobr, &s->isa);
=20
     s->dev =3D pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "sh_pci_host=
");
-    return 0;
 }
=20
 static void sh_pci_host_realize(PCIDevice *d, Error **errp)
@@ -187,9 +185,9 @@ static const TypeInfo sh_pci_host_info =3D {
=20
 static void sh_pci_device_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc =3D SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    sdc->init =3D sh_pci_device_init;
+    dc->realize =3D sh_pci_device_realize;
 }
=20
 static const TypeInfo sh_pci_device_info =3D {
--=20
2.18.0.rc1.1.g3f1ff2140
