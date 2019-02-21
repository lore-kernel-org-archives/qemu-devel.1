Received: from eggs.gnu.org ([209.51.188.92]:55147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gwnl8-0004iZ-TK
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gwnl4-00062o-VH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:47:26 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37875 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gwnl3-00061G-3W
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:47:21 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 21 Feb 2019 13:45:58 +0100
Message-Id: <1550753160-15142-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550753160-15142-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550753160-15142-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/8] hw/pci-host/bonito.c: Add PCI mem region
 mapped at the correct address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: BALATON Zoltan <balaton@eik.bme.hu>

Stop using system memory as PCI memory otherwise devices such as VGA
that have regions mapped to PCI memory clash with RAM. Use a separate
memory region for PCI memory and map it to the correct address in
system memory which allows PCI mem regions to show at the correct
address where clients expect them.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/bonito.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 9f33582..dde4437 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -217,6 +217,7 @@ struct BonitoState {
     PCIHostState parent_obj;
     qemu_irq *pic;
     PCIBonitoState *pci_dev;
+    MemoryRegion pci_mem;
 };
=20
 #define TYPE_BONITO_PCI_HOST_BRIDGE "Bonito-pcihost"
@@ -598,11 +599,15 @@ static const VMStateDescription vmstate_bonito =3D =
{
 static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
+    BonitoState *bs =3D BONITO_PCI_HOST_BRIDGE(dev);
=20
+    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIL=
O_SIZE);
     phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
                                      pci_bonito_set_irq, pci_bonito_map_=
irq,
-                                     dev, get_system_memory(), get_syste=
m_io(),
+                                     dev, &bs->pci_mem, get_system_io(),
                                      0x28, 32, TYPE_PCI_BUS);
+    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE,
+                                &bs->pci_mem);
 }
=20
 static void bonito_realize(PCIDevice *dev, Error **errp)
--=20
2.7.4
