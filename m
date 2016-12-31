Received: from eggs.gnu.org ([2001:4830:134:3::10]:54777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K5-0001QI-JG
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K2-0000KN-Jn
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:01 -0500
Received: from m12-14.163.com ([220.181.12.14]:45591)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K2-0000Jy-0q
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:58 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:44 +0800
Message-Id: <20161231011847.4153-3-zxq_yx_007@163.com>
In-Reply-To: <20161231011847.4153-1-zxq_yx_007@163.com>
References: <20161231011847.4153-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 2/5] hw/misc: QOM'ify milkymist-pfpu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: michael@walle.cc

Drop the old SysBus init function and use instance_init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/misc/milkymist-pfpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 3ca25894f1..b1c57cd7f8 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -497,17 +497,16 @@ static void milkymist_pfpu_reset(DeviceState *d)
     }
 }
 
-static int milkymist_pfpu_init(SysBusDevice *dev)
+static void milkymist_pfpu_init(Object *obj)
 {
-    MilkymistPFPUState *s = MILKYMIST_PFPU(dev);
+    MilkymistPFPUState *s = MILKYMIST_PFPU(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
     sysbus_init_irq(dev, &s->irq);
 
-    memory_region_init_io(&s->regs_region, OBJECT(dev), &pfpu_mmio_ops, s,
+    memory_region_init_io(&s->regs_region, obj, &pfpu_mmio_ops, s,
             "milkymist-pfpu", MICROCODE_END * 4);
     sysbus_init_mmio(dev, &s->regs_region);
-
-    return 0;
 }
 
 static const VMStateDescription vmstate_milkymist_pfpu = {
@@ -527,9 +526,7 @@ static const VMStateDescription vmstate_milkymist_pfpu = {
 static void milkymist_pfpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_pfpu_init;
     dc->reset = milkymist_pfpu_reset;
     dc->vmsd = &vmstate_milkymist_pfpu;
 }
@@ -538,6 +535,7 @@ static const TypeInfo milkymist_pfpu_info = {
     .name          = TYPE_MILKYMIST_PFPU,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MilkymistPFPUState),
+    .instance_init = milkymist_pfpu_init,
     .class_init    = milkymist_pfpu_class_init,
 };
 
-- 
2.11.0
