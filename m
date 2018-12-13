Received: from eggs.gnu.org ([2001:4830:134:3::10]:36574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPJ-0005EW-Bl
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPI-0000Sq-Ey
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:09 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSPI-0006zA-5y
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:08 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO8-0007Jy-Qm
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:56 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:28 +0000
Message-Id: <20181213145445.17935-21-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/37] timer/puv3_ost: Convert sysbus init
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
puv3_ost_class_init().

Cc: gxt@mprc.pku.edu.cn

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-19-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/puv3_ost.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 0b3d717e608..3be58c7fdd7 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -113,16 +113,17 @@ static void puv3_ost_tick(void *opaque)
     }
 }
 
-static int puv3_ost_init(SysBusDevice *dev)
+static void puv3_ost_realize(DeviceState *dev, Error **errp)
 {
     PUV3OSTState *s = PUV3_OST(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     s->reg_OIER = 0;
     s->reg_OSSR = 0;
     s->reg_OSMR0 = 0;
     s->reg_OSCR = 0;
 
-    sysbus_init_irq(dev, &s->irq);
+    sysbus_init_irq(sbd, &s->irq);
 
     s->bh = qemu_bh_new(puv3_ost_tick, s);
     s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
@@ -130,16 +131,14 @@ static int puv3_ost_init(SysBusDevice *dev)
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_ost_ops, s, "puv3_ost",
             PUV3_REGS_OFFSET);
-    sysbus_init_mmio(dev, &s->iomem);
-
-    return 0;
+    sysbus_init_mmio(sbd, &s->iomem);
 }
 
 static void puv3_ost_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = puv3_ost_init;
+    dc->realize = puv3_ost_realize;
 }
 
 static const TypeInfo puv3_ost_info = {
-- 
2.19.2
