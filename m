Received: from eggs.gnu.org ([2001:4830:134:3::10]:52971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMX-0001uW-Ka
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMV-00036e-I3
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:09 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:24227)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMU-0002qw-Re
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:07 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:16 +0800
Message-Id: <20181119120820.29878-19-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 18/22] timer/puv3_ost: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, gxt@mprc.pku.edu.cn, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
puv3_ost_class_init().

Cc: gxt@mprc.pku.edu.cn

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/timer/puv3_ost.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 0b3d717e60..853b96dbde 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -113,7 +113,7 @@ static void puv3_ost_tick(void *opaque)
     }
 }
 
-static int puv3_ost_init(SysBusDevice *dev)
+static void puv3_ost_realize(DeviceState *dev, Error **errp)
 {
     PUV3OSTState *s = PUV3_OST(dev);
 
@@ -122,7 +122,7 @@ static int puv3_ost_init(SysBusDevice *dev)
     s->reg_OSMR0 = 0;
     s->reg_OSCR = 0;
 
-    sysbus_init_irq(dev, &s->irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 
     s->bh = qemu_bh_new(puv3_ost_tick, s);
     s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
@@ -130,16 +130,14 @@ static int puv3_ost_init(SysBusDevice *dev)
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_ost_ops, s, "puv3_ost",
             PUV3_REGS_OFFSET);
-    sysbus_init_mmio(dev, &s->iomem);
-
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
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
2.17.1
