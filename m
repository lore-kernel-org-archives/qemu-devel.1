Received: from eggs.gnu.org ([2001:4830:134:3::10]:34511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1dDsvO-0004ET-MR
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1dDsvK-0005QO-9E
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:35:34 -0400
Received: from m12-15.163.com ([220.181.12.15]:35923)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1dDsvJ-0005PW-2p
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:35:30 -0400
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Thu, 25 May 2017 21:34:48 +0800
Message-Id: <20170525133451.22459-6-zxq_yx_007@163.com>
In-Reply-To: <20170525133451.22459-1-zxq_yx_007@163.com>
References: <20170525133451.22459-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 5/8] hw/timer: QOM'ify m48txx_sysbus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au, f4bug@amsat.org

* split the old SysBus init function into an instance_init
  and a Device realize function
* use DeviceClass::realize instead of SysBusDeviceClass::init
* assign DeviceClass::vmsd instead of using vmstate_register function

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/m48t59.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 474981a6ac..3a9f541c9b 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -640,34 +640,33 @@ void m48t59_realize_common(M48t59State *s, Error **errp)
         s->wd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &watchdog_cb, s);
     }
     qemu_get_timedate(&s->alarm, 0);
-
-    vmstate_register(NULL, -1, &vmstate_m48t59, s);
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
@@ -696,12 +695,12 @@ static Property m48t59_sysbus_properties[] = {
 static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
     NvramClass *nc = NVRAM_CLASS(klass);
 
-    k->init = m48t59_init1;
+    dc->realize = m48t59_realize;
     dc->reset = m48t59_reset_sysbus;
     dc->props = m48t59_sysbus_properties;
+    dc->vmsd = &vmstate_m48t59;
     nc->read = m48txx_sysbus_read;
     nc->write = m48txx_sysbus_write;
     nc->toggle_lock = m48txx_sysbus_toggle_lock;
@@ -725,6 +724,7 @@ static const TypeInfo m48txx_sysbus_type_info = {
     .name = TYPE_M48TXX_SYS_BUS,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(M48txxSysBusState),
+    .instance_init = m48t59_init1,
     .abstract = true,
     .class_init = m48txx_sysbus_class_init,
     .interfaces = (InterfaceInfo[]) {
-- 
2.13.0.rc2.115.g10c78a162
