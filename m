Received: from eggs.gnu.org ([2001:4830:134:3::10]:33683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN1B-0000Av-5H
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN18-0003IS-QY
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:13 -0500
Received: from m12-14.163.com ([220.181.12.14]:60844)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Ep-CK
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:10 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sun,  5 Feb 2017 21:37:25 +0800
Message-Id: <20170205133727.23424-8-zxq_yx_007@163.com>
In-Reply-To: <20170205133727.23424-1-zxq_yx_007@163.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [RESEND PATCH 7/9] hw/timer: QOM'ify slavio_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

rename slavio_timer_init1 to slavio_timer_init and assign
it to slavio_timer_info.instance_init, then we drop the
SysBusDeviceClass::init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/timer/slavio_timer.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index bfee1f3027..a8cc9c0148 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -373,9 +373,10 @@ static void slavio_timer_reset(DeviceState *d)
     s->cputimer_mode = 0;
 }
 
-static int slavio_timer_init1(SysBusDevice *dev)
+static void slavio_timer_init(Object *obj)
 {
-    SLAVIO_TIMERState *s = SLAVIO_TIMER(dev);
+    SLAVIO_TIMERState *s = SLAVIO_TIMER(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     QEMUBH *bh;
     unsigned int i;
     TimerContext *tc;
@@ -394,14 +395,12 @@ static int slavio_timer_init1(SysBusDevice *dev)
 
         size = i == 0 ? SYS_TIMER_SIZE : CPU_TIMER_SIZE;
         snprintf(timer_name, sizeof(timer_name), "timer-%i", i);
-        memory_region_init_io(&tc->iomem, OBJECT(s), &slavio_timer_mem_ops, tc,
+        memory_region_init_io(&tc->iomem, obj, &slavio_timer_mem_ops, tc,
                               timer_name, size);
         sysbus_init_mmio(dev, &tc->iomem);
 
         sysbus_init_irq(dev, &s->cputimer[i].irq);
     }
-
-    return 0;
 }
 
 static Property slavio_timer_properties[] = {
@@ -412,9 +411,7 @@ static Property slavio_timer_properties[] = {
 static void slavio_timer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = slavio_timer_init1;
     dc->reset = slavio_timer_reset;
     dc->vmsd = &vmstate_slavio_timer;
     dc->props = slavio_timer_properties;
@@ -424,6 +421,7 @@ static const TypeInfo slavio_timer_info = {
     .name          = TYPE_SLAVIO_TIMER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SLAVIO_TIMERState),
+    .instance_init = slavio_timer_init,
     .class_init    = slavio_timer_class_init,
 };
 
-- 
2.11.0
