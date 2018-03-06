Received: from eggs.gnu.org ([2001:4830:134:3::10]:44313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKW-0005rk-DB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKR-0008Fj-T9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:37:00 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:31:02 +0000
Message-Id: <20180306203103.25563-19-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 18/19] mac_newworld: remove pics IRQ array and
 wire up macio to OpenPIC directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Introduce constants for the pre-defined New World IRQs to help keep things
readable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac.h          |  8 ++++++++
 hw/ppc/mac_newworld.c | 29 +++++++++++++++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 5f5916252a..3819058310 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -47,6 +47,14 @@
 
 #define ESCC_CLOCK 3686400
 
+/* New World IRQs */
+#define NEWWORLD_CUDA_IRQ      0x19
+#define NEWWORLD_ESCCB_IRQ     0x24
+#define NEWWORLD_ESCCA_IRQ     0x25
+#define NEWWORLD_IDE0_IRQ      0xd
+#define NEWWORLD_IDE0_DMA_IRQ  0x2
+#define NEWWORLD_IDE1_IRQ      0xe
+#define NEWWORLD_IDE1_DMA_IRQ  0x3
 
 /* MacIO */
 #define TYPE_MACIO_IDE "macio-ide"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 2fcb101982..3cde507065 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -115,7 +115,7 @@ static void ppc_core99_init(MachineState *machine)
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
     char *filename;
-    qemu_irq *pic, **openpic_irqs;
+    qemu_irq **openpic_irqs;
     int linux_boot, i, j, k;
     MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
     hwaddr kernel_base, initrd_base, cmdline_base = 0;
@@ -292,8 +292,6 @@ static void ppc_core99_init(MachineState *machine)
         }
     }
 
-    pic = g_new0(qemu_irq, 64);
-
     pic_dev = qdev_create(NULL, TYPE_OPENPIC);
     qdev_prop_set_uint32(pic_dev, "model", OPENPIC_MODEL_KEYLARGO);
     qdev_init_nofail(pic_dev);
@@ -305,10 +303,6 @@ static void ppc_core99_init(MachineState *machine)
         }
     }
 
-    for (i = 0; i < 64; i++) {
-        pic[i] = qdev_get_gpio_in(pic_dev, i);
-    }
-
     if (PPC_INPUT(env) == PPC_FLAGS_INPUT_970) {
         /* 970 gets a U3 bus */
         /* Uninorth AGP bus */
@@ -382,13 +376,20 @@ static void ppc_core99_init(MachineState *machine)
     /* MacIO */
     macio = NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO));
     dev = DEVICE(macio);
-    qdev_connect_gpio_out(dev, 0, pic[0x19]); /* CUDA */
-    qdev_connect_gpio_out(dev, 1, pic[0x24]); /* ESCC-B */
-    qdev_connect_gpio_out(dev, 2, pic[0x25]); /* ESCC-A */
-    qdev_connect_gpio_out(dev, 3, pic[0x0d]); /* IDE */
-    qdev_connect_gpio_out(dev, 4, pic[0x02]); /* IDE DMA */
-    qdev_connect_gpio_out(dev, 5, pic[0x0e]); /* IDE */
-    qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE DMA */
+    qdev_connect_gpio_out(dev, 0,
+        qdev_get_gpio_in(pic_dev, NEWWORLD_CUDA_IRQ));
+    qdev_connect_gpio_out(dev, 1,
+        qdev_get_gpio_in(pic_dev, NEWWORLD_ESCCB_IRQ));
+    qdev_connect_gpio_out(dev, 2,
+        qdev_get_gpio_in(pic_dev, NEWWORLD_ESCCA_IRQ));
+    qdev_connect_gpio_out(dev, 3,
+        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_IRQ));
+    qdev_connect_gpio_out(dev, 4,
+        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_DMA_IRQ));
+    qdev_connect_gpio_out(dev, 5,
+        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_IRQ));
+    qdev_connect_gpio_out(dev, 6,
+        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_DMA_IRQ));
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
                              &error_abort);
-- 
2.11.0
