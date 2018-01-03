Received: from eggs.gnu.org ([2001:4830:134:3::10]:33899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsT-0003LL-5U
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsQ-0007S2-6s
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:01 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:34:04 -0300
Message-Id: <20180103183418.23730-12-f4bug@amsat.org>
In-Reply-To: <20180103183418.23730-1-f4bug@amsat.org>
References: <20180103183418.23730-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 11/25] hw/arm/xilinx_zynq: implement SDHCI
 Spec v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xilinx_zynq.c | 64 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 1836a4ed45..9a106db7b7 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -165,10 +165,8 @@ static void zynq_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ext_ram = g_new(MemoryRegion, 1);
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
-    DeviceState *dev, *carddev;
+    DeviceState *dev;
     SysBusDevice *busdev;
-    DriveInfo *di;
-    BlockBackend *blk;
     qemu_irq pic[64];
     int n;
 
@@ -247,27 +245,45 @@ static void zynq_init(MachineState *machine)
     gem_init(&nd_table[0], 0xE000B000, pic[54-IRQ_OFFSET]);
     gem_init(&nd_table[1], 0xE000C000, pic[77-IRQ_OFFSET]);
 
-    dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0100000);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[56-IRQ_OFFSET]);
-
-    di = drive_get_next(IF_SD);
-    blk = di ? blk_by_legacy_dinfo(di) : NULL;
-    carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
-    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-    object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
-
-    dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0101000);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[79-IRQ_OFFSET]);
-
-    di = drive_get_next(IF_SD);
-    blk = di ? blk_by_legacy_dinfo(di) : NULL;
-    carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
-    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
-    object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
+    for (n = 0; n < 2; n++) {
+        int hci_irq = n ? 79 : 56;
+        hwaddr hci_addr = n ? 0xE0101000 : 0xE0100000;
+        DriveInfo *di;
+        BlockBackend *blk;
+        DeviceState *carddev;
+
+        /* Compatible with:
+         * - SD Host Controller Specification Version 2.0 Part A2
+         * - SDIO Specification Version 2.0
+         * - MMC Specification Version 3.31
+         *
+         * - SDMA (single operation DMA)
+         * - ADMA1 (4 KB boundary limited DMA)
+         * - ADMA2
+         *
+         * - up to seven functions in SD1, SD4, but does not support SPI mode
+         * - SD high-speed (SDHS) card
+         * - SD High Capacity (SDHC) card
+         *
+         * - Low-speed, 1 KHz to 400 KHz
+         * - Full-speed, 1 MHz to 50 MHz (25 MB/sec)
+         */
+        dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
+        qdev_prop_set_uint8(dev, "sd-spec-version", 2);
+        qdev_prop_set_bit(dev, "adma1", true);
+        qdev_prop_set_bit(dev, "high-speed", true);
+        qdev_prop_set_uint16(dev, "max-block-length", 1024);
+        qdev_init_nofail(dev);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, hci_addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[hci_irq - IRQ_OFFSET]);
+
+        di = drive_get_next(IF_SD);
+        blk = di ? blk_by_legacy_dinfo(di) : NULL;
+        carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
+        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+        object_property_set_bool(OBJECT(carddev), true, "realized",
+                                 &error_fatal);
+    }
 
     dev = qdev_create(NULL, TYPE_ZYNQ_XADC);
     qdev_init_nofail(dev);
-- 
2.15.1
