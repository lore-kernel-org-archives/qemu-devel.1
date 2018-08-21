Received: from eggs.gnu.org ([2001:4830:134:3::10]:56612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMw-0004F3-ES
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMt-0000RW-Tt
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:14 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:39 +1000
Message-Id: <20180821043343.7514-23-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/26] 40p: don't use legacy fw_cfg_init_mem()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Instead initialise the device via qdev to allow us to set device properti=
es
directly as required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 83083e4f1b..47146ba12a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -618,7 +618,7 @@ static void ibm_40p_init(MachineState *machine)
     uint16_t cmos_checksum;
     PowerPCCPU *cpu;
     DeviceState *dev;
-    SysBusDevice *pcihost;
+    SysBusDevice *pcihost, *s;
     Nvram *m48t59 =3D NULL;
     PCIBus *pci_bus;
     ISABus *isa_bus;
@@ -711,7 +711,16 @@ static void ibm_40p_init(MachineState *machine)
     }
=20
     /* Prepare firmware configuration for OpenBIOS */
-    fw_cfg =3D fw_cfg_init_mem(CFG_ADDR, CFG_ADDR + 2);
+    dev =3D qdev_create(NULL, TYPE_FW_CFG_MEM);
+    fw_cfg =3D FW_CFG(dev);
+    qdev_prop_set_uint32(dev, "data_width", 1);
+    qdev_prop_set_bit(dev, "dma_enabled", false);
+    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
+                              OBJECT(fw_cfg), NULL);
+    qdev_init_nofail(dev);
+    s =3D SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(s, 0, CFG_ADDR);
+    sysbus_mmio_map(s, 1, CFG_ADDR + 2);
=20
     if (machine->kernel_filename) {
         /* load kernel */
--=20
2.17.1
