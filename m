Received: from eggs.gnu.org ([2001:4830:134:3::10]:36662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPU-0005Or-FM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPT-0000in-K5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSPT-0007J5-9b
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:19 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO6-0007Iq-AW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:54 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:23 +0000
Message-Id: <20181213145445.17935-16-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/37] puv3_pm.c: Convert sysbus init function
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

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
puv3_pm_class_init().

Cc: gxt@mprc.pku.edu.cn

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-14-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/puv3_pm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
index 577cebaac78..afe191fbe1f 100644
--- a/hw/misc/puv3_pm.c
+++ b/hw/misc/puv3_pm.c
@@ -119,7 +119,7 @@ static const MemoryRegionOps puv3_pm_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int puv3_pm_init(SysBusDevice *dev)
+static void puv3_pm_realize(DeviceState *dev, Error **errp)
 {
     PUV3PMState *s = PUV3_PM(dev);
 
@@ -127,16 +127,14 @@ static int puv3_pm_init(SysBusDevice *dev)
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_pm_ops, s, "puv3_pm",
             PUV3_REGS_OFFSET);
-    sysbus_init_mmio(dev, &s->iomem);
-
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
 static void puv3_pm_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = puv3_pm_init;
+    dc->realize = puv3_pm_realize;
 }
 
 static const TypeInfo puv3_pm_info = {
-- 
2.19.2
