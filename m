Received: from eggs.gnu.org ([2001:4830:134:3::10]:54775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K5-0001QG-J1
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K2-0000KH-Dw
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:01 -0500
Received: from m12-14.163.com ([220.181.12.14]:45577)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K1-0000Jw-QN
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:58 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:43 +0800
Message-Id: <20161231011847.4153-2-zxq_yx_007@163.com>
In-Reply-To: <20161231011847.4153-1-zxq_yx_007@163.com>
References: <20161231011847.4153-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 1/5] hw/misc: QOM'ify milkymist-hpdmc.c
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
 hw/misc/milkymist-hpdmc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index e6140eec6b..c0fdd2cb2e 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -129,15 +129,14 @@ static void milkymist_hpdmc_reset(DeviceState *d)
                          | IODELAY_PLL2_LOCKED;
 }
 
-static int milkymist_hpdmc_init(SysBusDevice *dev)
+static void milkymist_hpdmc_init(Object *obj)
 {
-    MilkymistHpdmcState *s = MILKYMIST_HPDMC(dev);
+    MilkymistHpdmcState *s = MILKYMIST_HPDMC(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_io(&s->regs_region, OBJECT(dev), &hpdmc_mmio_ops, s,
+    memory_region_init_io(&s->regs_region, obj, &hpdmc_mmio_ops, s,
             "milkymist-hpdmc", R_MAX * 4);
     sysbus_init_mmio(dev, &s->regs_region);
-
-    return 0;
 }
 
 static const VMStateDescription vmstate_milkymist_hpdmc = {
@@ -153,9 +152,7 @@ static const VMStateDescription vmstate_milkymist_hpdmc = {
 static void milkymist_hpdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_hpdmc_init;
     dc->reset = milkymist_hpdmc_reset;
     dc->vmsd = &vmstate_milkymist_hpdmc;
 }
@@ -164,6 +161,7 @@ static const TypeInfo milkymist_hpdmc_info = {
     .name          = TYPE_MILKYMIST_HPDMC,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MilkymistHpdmcState),
+    .instance_init = milkymist_hpdmc_init,
     .class_init    = milkymist_hpdmc_class_init,
 };
 
-- 
2.11.0
