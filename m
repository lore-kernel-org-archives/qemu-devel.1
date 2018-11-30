Received: from eggs.gnu.org ([2001:4830:134:3::10]:38537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGj-0006B6-QT
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGh-0002VH-Kz
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:29 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:45951)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGg-0002SJ-L5
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:27 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 30 Nov 2018 17:38:49 +0800
Message-Id: <20181130093852.20739-19-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 18/21] timer/puv3_ost: Convert sysbus init
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/timer/puv3_ost.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 0b3d717e60..3be58c7fdd 100644
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
2.17.1
