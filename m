Received: from eggs.gnu.org ([2001:4830:134:3::10]:38886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEYC-0008Ds-DP
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEYB-0008D6-H0
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:05:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:03:48 -0300
Message-Id: <20181018200422.4358-12-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/45] hw/mips/gt64xxx_pci: Convert
 gt64120_reset() function into Device reset method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Convert the gt64120_reset() function into a proper Device reset method.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20181002212522.23303-8-f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/mips/gt64xxx_pci.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 24ad0ad024..dcd1a66329 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -992,9 +992,9 @@ static void gt64120_pci_set_irq(void *opaque, int irq=
_num, int level)
 }
=20
=20
-static void gt64120_reset(void *opaque)
+static void gt64120_reset(DeviceState *dev)
 {
-    GT64120State *s =3D opaque;
+    GT64120State *s =3D GT64120_PCI_HOST_BRIDGE(dev);
=20
     /* FIXME: Malta specific hw assumptions ahead */
=20
@@ -1184,16 +1184,6 @@ PCIBus *gt64120_register(qemu_irq *pic)
     return phb->bus;
 }
=20
-static int gt64120_init(SysBusDevice *dev)
-{
-    GT64120State *s;
-
-    s =3D GT64120_PCI_HOST_BRIDGE(dev);
-
-    qemu_register_reset(gt64120_reset, s);
-    return 0;
-}
-
 static void gt64120_pci_realize(PCIDevice *d, Error **errp)
 {
     /* FIXME: Malta specific hw assumptions ahead */
@@ -1241,9 +1231,8 @@ static const TypeInfo gt64120_pci_info =3D {
 static void gt64120_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *sdc =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    sdc->init =3D gt64120_init;
+    dc->reset =3D gt64120_reset;
     dc->vmsd =3D &vmstate_gt64120;
 }
=20
--=20
2.18.0.rc1.1.g3f1ff2140
