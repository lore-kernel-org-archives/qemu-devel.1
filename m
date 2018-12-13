Received: from eggs.gnu.org ([2001:4830:134:3::10]:35708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO2-0003vD-98
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO1-0006zK-4c
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:50 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO0-0006w2-TY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:49 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSNz-0007Fd-Eo
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:47 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:11 +0000
Message-Id: <20181213145445.17935-4-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/37] musicpal: Convert sysbus init function to
 realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
mv88w8618_wlan_class_init().

Cc: jan.kiszka@web.de
Cc: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-2-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musicpal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 726ae29394e..d22532a11c8 100644
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
2.19.2
