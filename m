Received: from eggs.gnu.org ([2001:4830:134:3::10]:50604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1d4PxA-0002Ax-Kd
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1d4Px5-0003iE-M9
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:50:16 -0400
Received: from m12-12.163.com ([220.181.12.12]:42590)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1d4Px4-0003dH-U6
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:50:11 -0400
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 29 Apr 2017 18:49:33 +0800
Message-Id: <20170429104937.31341-6-zxq_yx_007@163.com>
In-Reply-To: <20170429104937.31341-1-zxq_yx_007@163.com>
References: <20170429104937.31341-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH v2 5/9] hw/timer: QOM'ify m48txx_sysbus (pass 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, david@gibson.dropbear.id.au, pbonzini@redhat.com, atar4qemu@gmail.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com

* split the old SysBus init function into an instance_init
  and a Device realize function
* use DeviceClass::realize instead of SysBusDeviceClass::init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/timer/m48t59.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 474981a6ac..eff259ef96 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -644,30 +644,31 @@ void m48t59_realize_common(M48t59State *s, Error **errp)
     vmstate_register(NULL, -1, &vmstate_m48t59, s);
 }
 
-static int m48t59_init1(SysBusDevice *dev)
+static void m48t59_init1(Object *obj)
 {
-    M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_GET_CLASS(dev);
-    M48txxSysBusState *d = M48TXX_SYS_BUS(dev);
-    Object *o = OBJECT(dev);
+    M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_GET_CLASS(obj);
+    M48txxSysBusState *d = M48TXX_SYS_BUS(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     M48t59State *s = &d->state;
-    Error *err = NULL;
 
     s->model = u->info.model;
     s->size = u->info.size;
     sysbus_init_irq(dev, &s->IRQ);
 
-    memory_region_init_io(&s->iomem, o, &nvram_ops, s, "m48t59.nvram",
+    memory_region_init_io(&s->iomem, obj, &nvram_ops, s, "m48t59.nvram",
                           s->size);
-    memory_region_init_io(&d->io, o, &m48t59_io_ops, s, "m48t59", 4);
-    sysbus_init_mmio(dev, &s->iomem);
-    sysbus_init_mmio(dev, &d->io);
-    m48t59_realize_common(s, &err);
-    if (err != NULL) {
-        error_free(err);
-        return -1;
-    }
+    memory_region_init_io(&d->io, obj, &m48t59_io_ops, s, "m48t59", 4);
+}
+
+static void m48t59_realize(DeviceState *dev, Error **errp)
+{
+    M48txxSysBusState *d = M48TXX_SYS_BUS(dev);
+    M48t59State *s = &d->state;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    return 0;
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_mmio(sbd, &d->io);
+    m48t59_realize_common(s, errp);
 }
 
 static uint32_t m48txx_sysbus_read(Nvram *obj, uint32_t addr)
@@ -696,10 +697,9 @@ static Property m48t59_sysbus_properties[] = {
 static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
     NvramClass *nc = NVRAM_CLASS(klass);
 
-    k->init = m48t59_init1;
+    dc->realize = m48t59_realize;
     dc->reset = m48t59_reset_sysbus;
     dc->props = m48t59_sysbus_properties;
     nc->read = m48txx_sysbus_read;
@@ -725,6 +725,7 @@ static const TypeInfo m48txx_sysbus_type_info = {
     .name = TYPE_M48TXX_SYS_BUS,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(M48txxSysBusState),
+    .instance_init = m48t59_init1,
     .abstract = true,
     .class_init = m48txx_sysbus_class_init,
     .interfaces = (InterfaceInfo[]) {
-- 
2.11.0
