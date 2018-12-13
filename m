Received: from eggs.gnu.org ([2001:4830:134:3::10]:35902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOG-0004B5-G7
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOF-0007Ie-QD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:04 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOF-00071P-JN
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:03 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO4-0007I4-KE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:52 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:20 +0000
Message-Id: <20181213145445.17935-13-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/37] intc/puv3_intc: Convert sysbus init
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
puv3_intc_class_init().

Cc: gxt@mprc.pku.edu.cn

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-11-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/puv3_intc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index ef8488aacc4..69ddc8c19ab 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -101,10 +101,10 @@ static const MemoryRegionOps puv3_intc_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int puv3_intc_init(SysBusDevice *sbd)
+static void puv3_intc_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
     PUV3INTCState *s = PUV3_INTC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     qdev_init_gpio_in(dev, puv3_intc_handler, PUV3_IRQS_NR);
     sysbus_init_irq(sbd, &s->parent_irq);
@@ -115,15 +115,12 @@ static int puv3_intc_init(SysBusDevice *sbd)
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_intc_ops, s, "puv3_intc",
                           PUV3_REGS_OFFSET);
     sysbus_init_mmio(sbd, &s->iomem);
-
-    return 0;
 }
 
 static void puv3_intc_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
-
-    sdc->init = puv3_intc_init;
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = puv3_intc_realize;
 }
 
 static const TypeInfo puv3_intc_info = {
-- 
2.19.2
