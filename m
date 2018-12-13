Received: from eggs.gnu.org ([2001:4830:134:3::10]:35801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO5-0003zb-5B
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO3-00073L-L0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:52 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO3-00071P-C3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:51 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO2-0007Gu-9J
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:50 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:16 +0000
Message-Id: <20181213145445.17935-9-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/37] dma/puv3_dma: Convert sysbus init
 function to realize function
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
puv3_dma_class_init().

Cc: gxt@mprc.pku.edu.cn

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-7-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/puv3_dma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
index b97a6c1767c..c89eade0292 100644
--- a/hw/dma/puv3_dma.c
+++ b/hw/dma/puv3_dma.c
@@ -76,7 +76,7 @@ static const MemoryRegionOps puv3_dma_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int puv3_dma_init(SysBusDevice *dev)
+static void puv3_dma_realize(DeviceState *dev, Error **errp)
 {
     PUV3DMAState *s = PUV3_DMA(dev);
     int i;
@@ -87,16 +87,14 @@ static int puv3_dma_init(SysBusDevice *dev)
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_dma_ops, s, "puv3_dma",
             PUV3_REGS_OFFSET);
-    sysbus_init_mmio(dev, &s->iomem);
-
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
 static void puv3_dma_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = puv3_dma_init;
+    dc->realize = puv3_dma_realize;
 }
 
 static const TypeInfo puv3_dma_info = {
-- 
2.19.2
