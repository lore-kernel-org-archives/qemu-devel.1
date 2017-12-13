Received: from eggs.gnu.org ([2001:4830:134:3::10]:39559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDuP-0004d2-7H
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDuN-0007Rz-3G
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:41 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:36 -0300
Message-Id: <20171213204436.5379-12-f4bug@amsat.org>
In-Reply-To: <20171213204436.5379-1-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/11] hw/arm/xilinx_zynq: use
 sdbus_create_slave() to name the different SD busses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Using the "bus-name" property we can now address any bus.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xilinx_zynq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 1836a4ed45..9275ae6daf 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -167,6 +167,7 @@ static void zynq_init(MachineState *machine)
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
     DeviceState *dev, *carddev;
     SysBusDevice *busdev;
+    SDBus *sdbus;
     DriveInfo *di;
     BlockBackend *blk;
     qemu_irq pic[64];
@@ -248,24 +249,28 @@ static void zynq_init(MachineState *machine)
     gem_init(&nd_table[1], 0xE000C000, pic[77-IRQ_OFFSET]);
 
     dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
+    qdev_prop_set_string(dev, "sd-bus-name", "sd.0");
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0100000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[56-IRQ_OFFSET]);
 
     di = drive_get_next(IF_SD);
     blk = di ? blk_by_legacy_dinfo(di) : NULL;
-    carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
+    sdbus = (SDBus *)qdev_get_child_bus(dev, "sd.0");
+    carddev = sdbus_create_slave_no_init(sdbus, TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
     object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
 
     dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
+    qdev_prop_set_string(dev, "sd-bus-name", "sd.1");
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0101000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[79-IRQ_OFFSET]);
 
     di = drive_get_next(IF_SD);
     blk = di ? blk_by_legacy_dinfo(di) : NULL;
-    carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
+    sdbus = (SDBus *)qdev_get_child_bus(dev, "sd.1");
+    carddev = sdbus_create_slave_no_init(sdbus, TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
     object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
 
-- 
2.15.1
