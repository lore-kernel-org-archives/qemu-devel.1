Received: from eggs.gnu.org ([2001:4830:134:3::10]:57123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfmj-00026L-NU
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfmI-0007cu-HX
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:34:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:27 -0300
Message-Id: <20181025133301.16578-10-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 09/43] hw/pci-host/bonito: Use
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
Message-Id: <20181002212522.23303-7-f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci-host/bonito.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 9868e2eccc..9f33582706 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -595,7 +595,7 @@ static const VMStateDescription vmstate_bonito =3D {
     }
 };
=20
-static int bonito_pcihost_initfn(SysBusDevice *dev)
+static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
=20
@@ -603,8 +603,6 @@ static int bonito_pcihost_initfn(SysBusDevice *dev)
                                      pci_bonito_set_irq, pci_bonito_map_=
irq,
                                      dev, get_system_memory(), get_syste=
m_io(),
                                      0x28, 32, TYPE_PCI_BUS);
-
-    return 0;
 }
=20
 static void bonito_realize(PCIDevice *dev, Error **errp)
@@ -684,7 +682,6 @@ PCIBus *bonito_init(qemu_irq *pic)
     pcihost->pic =3D pic;
     qdev_init_nofail(dev);
=20
-    /* set the pcihost pointer before bonito_initfn is called */
     d =3D pci_create(phb->bus, PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
     s =3D PCI_BONITO(d);
     s->pcihost =3D pcihost;
@@ -726,9 +723,9 @@ static const TypeInfo bonito_info =3D {
=20
 static void bonito_pcihost_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    k->init =3D bonito_pcihost_initfn;
+    dc->realize =3D bonito_pcihost_realize;
 }
=20
 static const TypeInfo bonito_pcihost_info =3D {
--=20
2.18.0.rc1.1.g3f1ff2140
