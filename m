Received: from eggs.gnu.org ([2001:4830:134:3::10]:36597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPN-0005Hg-2V
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPJ-0000Uh-II
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:11 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSPJ-00071P-80
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO7-0007JW-Ql
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:55 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:26 +0000
Message-Id: <20181213145445.17935-19-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/37] timer/etraxfs_timer: Convert sysbus init
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
etraxfs_timer_class_init().

Cc: edgar.iglesias@gmail.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181130093852.20739-17-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/etraxfs_timer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index d13bc30b2d6..2280914b1d7 100644
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
2.19.2
