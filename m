Received: from eggs.gnu.org ([2001:4830:134:3::10]:58771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ7-0004nM-6z
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ4-0005Gd-Do
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:02 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:21651)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ2-00056Y-6l
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:00 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 23 Nov 2018 23:30:31 +0800
Message-Id: <20181123153040.18933-13-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v2 12/21] milkymist-pfpu: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, michael@walle.cc, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
milkymist_pfpu_class_init().

Cc: michael@walle.cc

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/misc/milkymist-pfpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 86f5e383b0..4a03c7ee63 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -497,17 +497,16 @@ static void milkymist_pfpu_reset(DeviceState *d)
     }
 }
 
-static int milkymist_pfpu_init(SysBusDevice *dev)
+static void milkymist_pfpu_realize(DeviceState *dev, Error **errp)
 {
     MilkymistPFPUState *s = MILKYMIST_PFPU(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    sysbus_init_irq(dev, &s->irq);
+    sysbus_init_irq(sbd, &s->irq);
 
     memory_region_init_io(&s->regs_region, OBJECT(dev), &pfpu_mmio_ops, s,
             "milkymist-pfpu", MICROCODE_END * 4);
-    sysbus_init_mmio(dev, &s->regs_region);
-
-    return 0;
+    sysbus_init_mmio(sbd, &s->regs_region);
 }
 
 static const VMStateDescription vmstate_milkymist_pfpu = {
@@ -527,9 +526,8 @@ static const VMStateDescription vmstate_milkymist_pfpu = {
 static void milkymist_pfpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_pfpu_init;
+    dc->realize = milkymist_pfpu_realize;
     dc->reset = milkymist_pfpu_reset;
     dc->vmsd = &vmstate_milkymist_pfpu;
 }
-- 
2.17.1
