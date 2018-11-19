Received: from eggs.gnu.org ([2001:4830:134:3::10]:52723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0001mg-5c
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMN-0002wr-Fb
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:00 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:21649)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiML-0002pK-Sp
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:08:59 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:14 +0800
Message-Id: <20181119120820.29878-17-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 16/22] timer/etraxfs_timer: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, edgar.iglesias@gmail.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
etraxfs_timer_class_init().

Cc: edgar.iglesias@gmail.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/timer/etraxfs_timer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index d13bc30b2d..e8c53b836e 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -315,7 +315,7 @@ static void etraxfs_timer_reset(void *opaque)
     qemu_irq_lower(t->irq);
 }
 
-static int etraxfs_timer_init(SysBusDevice *dev)
+static void etraxfs_timer_realize(DeviceState *dev, Error **errp)
 {
     ETRAXTimerState *t = ETRAX_TIMER(dev);
 
@@ -326,21 +326,20 @@ static int etraxfs_timer_init(SysBusDevice *dev)
     t->ptimer_t1 = ptimer_init(t->bh_t1, PTIMER_POLICY_DEFAULT);
     t->ptimer_wd = ptimer_init(t->bh_wd, PTIMER_POLICY_DEFAULT);
 
-    sysbus_init_irq(dev, &t->irq);
-    sysbus_init_irq(dev, &t->nmi);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &t->irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &t->nmi);
 
     memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
                           "etraxfs-timer", 0x5c);
-    sysbus_init_mmio(dev, &t->mmio);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &t->mmio);
     qemu_register_reset(etraxfs_timer_reset, t);
-    return 0;
 }
 
 static void etraxfs_timer_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = etraxfs_timer_init;
+    dc->realize = etraxfs_timer_realize;
 }
 
 static const TypeInfo etraxfs_timer_info = {
-- 
2.17.1
