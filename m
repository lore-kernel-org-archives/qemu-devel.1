Received: from eggs.gnu.org ([2001:4830:134:3::10]:38515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGj-0006Au-Od
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGh-0002Uh-4D
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:29 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:21653)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGg-0002Qh-8x
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:26 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 30 Nov 2018 17:38:47 +0800
Message-Id: <20181130093852.20739-17-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 16/21] timer/etraxfs_timer: Convert sysbus
 init function to realize function
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/timer/etraxfs_timer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index d13bc30b2d..2280914b1d 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -315,9 +315,10 @@ static void etraxfs_timer_reset(void *opaque)
     qemu_irq_lower(t->irq);
 }
 
-static int etraxfs_timer_init(SysBusDevice *dev)
+static void etraxfs_timer_realize(DeviceState *dev, Error **errp)
 {
     ETRAXTimerState *t = ETRAX_TIMER(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     t->bh_t0 = qemu_bh_new(timer0_hit, t);
     t->bh_t1 = qemu_bh_new(timer1_hit, t);
@@ -326,21 +327,20 @@ static int etraxfs_timer_init(SysBusDevice *dev)
     t->ptimer_t1 = ptimer_init(t->bh_t1, PTIMER_POLICY_DEFAULT);
     t->ptimer_wd = ptimer_init(t->bh_wd, PTIMER_POLICY_DEFAULT);
 
-    sysbus_init_irq(dev, &t->irq);
-    sysbus_init_irq(dev, &t->nmi);
+    sysbus_init_irq(sbd, &t->irq);
+    sysbus_init_irq(sbd, &t->nmi);
 
     memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
                           "etraxfs-timer", 0x5c);
-    sysbus_init_mmio(dev, &t->mmio);
+    sysbus_init_mmio(sbd, &t->mmio);
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
