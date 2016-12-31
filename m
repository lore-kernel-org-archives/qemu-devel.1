Received: from eggs.gnu.org ([2001:4830:134:3::10]:54774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K5-0001QF-Ik
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K3-0000L0-7z
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:01 -0500
Received: from m12-14.163.com ([220.181.12.14]:45625)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K2-0000KA-LV
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:59 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:46 +0800
Message-Id: <20161231011847.4153-5-zxq_yx_007@163.com>
In-Reply-To: <20161231011847.4153-1-zxq_yx_007@163.com>
References: <20161231011847.4153-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 4/5] hw/net: QOM'ify milkymist-minimac2.c
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

* Split the old SysBus init into an instance_init and a
  DeviceClass::realize function
* Drop the old SysBus init function and use instance_init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/net/milkymist-minimac2.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index c3a12e1197..81d10d64bb 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -452,21 +452,21 @@ static NetClientInfo net_milkymist_minimac2_info = {
     .receive = minimac2_rx,
 };
 
-static int milkymist_minimac2_init(SysBusDevice *sbd)
+static void milkymist_minimac2_init(Object *obj)
 {
-    DeviceState *dev = DEVICE(sbd);
-    MilkymistMinimac2State *s = MILKYMIST_MINIMAC2(dev);
+    MilkymistMinimac2State *s = MILKYMIST_MINIMAC2(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     size_t buffers_size = TARGET_PAGE_ALIGN(3 * MINIMAC2_BUFFER_SIZE);
 
     sysbus_init_irq(sbd, &s->rx_irq);
     sysbus_init_irq(sbd, &s->tx_irq);
 
-    memory_region_init_io(&s->regs_region, OBJECT(dev), &minimac2_ops, s,
+    memory_region_init_io(&s->regs_region, obj, &minimac2_ops, s,
                           "milkymist-minimac2", R_MAX * 4);
     sysbus_init_mmio(sbd, &s->regs_region);
 
     /* register buffers memory */
-    memory_region_init_ram(&s->buffers, OBJECT(dev), "milkymist-minimac2.buffers",
+    memory_region_init_ram(&s->buffers, obj, "milkymist-minimac2.buffers",
                            buffers_size, &error_fatal);
     vmstate_register_ram_global(&s->buffers);
     s->rx0_buf = memory_region_get_ram_ptr(&s->buffers);
@@ -474,13 +474,16 @@ static int milkymist_minimac2_init(SysBusDevice *sbd)
     s->tx_buf = s->rx1_buf + MINIMAC2_BUFFER_SIZE;
 
     sysbus_init_mmio(sbd, &s->buffers);
+}
+
+static void milkymist_minimac2_realize(DeviceState *dev, Error **errp)
+{
+    MilkymistMinimac2State *s = MILKYMIST_MINIMAC2(dev);
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_milkymist_minimac2_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-
-    return 0;
 }
 
 static const VMStateDescription vmstate_milkymist_minimac2_mdio = {
@@ -521,18 +524,18 @@ static Property milkymist_minimac2_properties[] = {
 static void milkymist_minimac2_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_minimac2_init;
     dc->reset = milkymist_minimac2_reset;
     dc->vmsd = &vmstate_milkymist_minimac2;
     dc->props = milkymist_minimac2_properties;
+    dc->realize = milkymist_minimac2_realize;
 }
 
 static const TypeInfo milkymist_minimac2_info = {
     .name          = TYPE_MILKYMIST_MINIMAC2,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MilkymistMinimac2State),
+    .instance_init = milkymist_minimac2_init,
     .class_init    = milkymist_minimac2_class_init,
 };
 
-- 
2.11.0
