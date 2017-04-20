Received: from eggs.gnu.org ([2001:4830:134:3::10]:43779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F94-0008R2-1y
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F91-00088X-Qi
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F91-00084S-GP
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8u-0006vf-7z
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:56 +0100
Message-Id: <1492706470-10921-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/24] hw/arm: Qomify pxa2xx.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Suramya Shah <shah.suramya@gmail.com>

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
Message-id: 20170415180316.2694-1-shah.suramya@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index cfee392..eea551d 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -755,19 +755,18 @@ static void pxa2xx_ssp_reset(DeviceState *d)
     s->rx_start = s->rx_level = 0;
 }
 
-static int pxa2xx_ssp_init(SysBusDevice *sbd)
+static void pxa2xx_ssp_init(Object *obj)
 {
-    DeviceState *dev = DEVICE(sbd);
-    PXA2xxSSPState *s = PXA2XX_SSP(dev);
-
+    DeviceState *dev = DEVICE(obj);
+    PXA2xxSSPState *s = PXA2XX_SSP(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     sysbus_init_irq(sbd, &s->irq);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &pxa2xx_ssp_ops, s,
+    memory_region_init_io(&s->iomem, obj, &pxa2xx_ssp_ops, s,
                           "pxa2xx-ssp", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
 
     s->bus = ssi_create_bus(dev, "ssi");
-    return 0;
 }
 
 /* Real-Time Clock */
@@ -2321,10 +2320,8 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
 
 static void pxa2xx_ssp_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = pxa2xx_ssp_init;
     dc->reset = pxa2xx_ssp_reset;
     dc->vmsd = &vmstate_pxa2xx_ssp;
 }
@@ -2333,6 +2330,7 @@ static const TypeInfo pxa2xx_ssp_info = {
     .name          = TYPE_PXA2XX_SSP,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PXA2xxSSPState),
+    .instance_init = pxa2xx_ssp_init,
     .class_init    = pxa2xx_ssp_class_init,
 };
 
-- 
2.7.4
