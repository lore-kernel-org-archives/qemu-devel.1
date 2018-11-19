Received: from eggs.gnu.org ([2001:4830:134:3::10]:52702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0001mV-0n
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMM-0002uo-3R
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:00 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:07:59 +0800
Message-Id: <20181119120820.29878-2-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 01/22] musicpal: Convert sysbus init function
 to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, jan.kiszka@web.de, peter.maydell@linaro.org, qemu-arm@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
mv88w8618_wlan_class_init().

Cc: jan.kiszka@web.de
Cc: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/arm/musicpal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9648b3af44..7ffcdbb097 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1147,14 +1147,13 @@ static const MemoryRegionOps mv88w8618_wlan_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int mv88w8618_wlan_init(SysBusDevice *dev)
+static void mv88w8618_wlan_realize(DeviceState *dev, Error **errp)
 {
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
 
     memory_region_init_io(iomem, OBJECT(dev), &mv88w8618_wlan_ops, NULL,
                           "musicpal-wlan", MP_WLAN_SIZE);
-    sysbus_init_mmio(dev, iomem);
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), iomem);
 }
 
 /* GPIO register offsets */
@@ -1720,9 +1719,9 @@ DEFINE_MACHINE("musicpal", musicpal_machine_init)
 
 static void mv88w8618_wlan_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = mv88w8618_wlan_init;
+    dc->realize = mv88w8618_wlan_realize;
 }
 
 static const TypeInfo mv88w8618_wlan_info = {
-- 
2.17.1
