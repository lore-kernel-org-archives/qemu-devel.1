Received: from eggs.gnu.org ([2001:4830:134:3::10]:59118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZa-00011q-Ck
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZX-0001sY-HA
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:48 +1000
Message-Id: <20180427092126.24812-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/49] mac_oldworld: remove pics IRQ array and
 wire up macio to heathrow directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Introduce constants for the pre-defined Old World IRQs to help keep thing=
s
readable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac.h          |  8 ++++++++
 hw/ppc/mac_oldworld.c | 27 ++++++++++++++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 93f25d7acb..c5a33e96cb 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -47,6 +47,14 @@
=20
 #define ESCC_CLOCK 3686400
=20
+/* Old World IRQs */
+#define OLDWORLD_CUDA_IRQ      0x12
+#define OLDWORLD_ESCCB_IRQ     0x10
+#define OLDWORLD_ESCCA_IRQ     0xf
+#define OLDWORLD_IDE0_IRQ      0xd
+#define OLDWORLD_IDE0_DMA_IRQ  0x2
+#define OLDWORLD_IDE1_IRQ      0xe
+#define OLDWORLD_IDE1_DMA_IRQ  0x3
=20
 /* MacIO */
 #define TYPE_MACIO_IDE "macio-ide"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index f9e63b8d83..2bbcefa076 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -87,7 +87,6 @@ static void ppc_heathrow_init(MachineState *machine)
     PowerPCCPU *cpu =3D NULL;
     CPUPPCState *env =3D NULL;
     char *filename;
-    qemu_irq *pic;
     int linux_boot, i;
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *bios =3D g_new(MemoryRegion, 1);
@@ -241,11 +240,6 @@ static void ppc_heathrow_init(MachineState *machine)
         }
     }
=20
-    pic =3D g_new0(qemu_irq, HEATHROW_NUM_IRQS);
-    for (i =3D 0; i < HEATHROW_NUM_IRQS; i++) {
-        pic[i] =3D qdev_get_gpio_in(pic_dev, i);
-    }
-
     /* Timebase Frequency */
     if (kvm_enabled()) {
         tbfreq =3D kvmppc_get_tbfreq();
@@ -287,13 +281,20 @@ static void ppc_heathrow_init(MachineState *machine=
)
     /* MacIO */
     macio =3D OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO=
));
     dev =3D DEVICE(macio);
-    qdev_connect_gpio_out(dev, 0, pic[0x12]); /* CUDA */
-    qdev_connect_gpio_out(dev, 1, pic[0x10]); /* ESCC-B */
-    qdev_connect_gpio_out(dev, 2, pic[0x0F]); /* ESCC-A */
-    qdev_connect_gpio_out(dev, 3, pic[0x0D]); /* IDE-0 */
-    qdev_connect_gpio_out(dev, 4, pic[0x02]); /* IDE-0 DMA */
-    qdev_connect_gpio_out(dev, 5, pic[0x0E]); /* IDE-1 */
-    qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE-1 DMA */
+    qdev_connect_gpio_out(dev, 0,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_CUDA_IRQ));
+    qdev_connect_gpio_out(dev, 1,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_ESCCB_IRQ));
+    qdev_connect_gpio_out(dev, 2,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_ESCCA_IRQ));
+    qdev_connect_gpio_out(dev, 3,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE0_IRQ));
+    qdev_connect_gpio_out(dev, 4,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE0_DMA_IRQ));
+    qdev_connect_gpio_out(dev, 5,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE1_IRQ));
+    qdev_connect_gpio_out(dev, 6,
+        qdev_get_gpio_in(pic_dev, OLDWORLD_IDE1_DMA_IRQ));
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
                              &error_abort);
--=20
2.14.3
