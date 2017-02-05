Received: from eggs.gnu.org ([2001:4830:134:3::10]:33671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN1B-0000Ao-2j
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003HI-U7
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:13 -0500
Received: from m12-14.163.com ([220.181.12.14]:60846)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Eh-BF
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:09 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sun,  5 Feb 2017 21:37:26 +0800
Message-Id: <20170205133727.23424-9-zxq_yx_007@163.com>
In-Reply-To: <20170205133727.23424-1-zxq_yx_007@163.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [RESEND PATCH 8/9] hw/sparc: QOM'ify sun4m.c
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

Drop the old SysBusDeviceClass::init and use instance_init
or DeviceClass::realize instead

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/sparc/sun4m.c | 54 +++++++++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index f5b6efddf8..352ca0bb4c 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -584,30 +584,23 @@ typedef struct IDRegState {
     MemoryRegion mem;
 } IDRegState;
 
-static int idreg_init1(SysBusDevice *dev)
+static void idreg_init1(Object *obj)
 {
-    IDRegState *s = MACIO_ID_REGISTER(dev);
+    IDRegState *s = MACIO_ID_REGISTER(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->mem, OBJECT(s),
+    memory_region_init_ram(&s->mem, obj,
                            "sun4m.idreg", sizeof(idreg_data), &error_fatal);
     vmstate_register_ram_global(&s->mem);
     memory_region_set_readonly(&s->mem, true);
     sysbus_init_mmio(dev, &s->mem);
-    return 0;
-}
-
-static void idreg_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
-
-    k->init = idreg_init1;
 }
 
 static const TypeInfo idreg_info = {
     .name          = TYPE_MACIO_ID_REGISTER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(IDRegState),
-    .class_init    = idreg_class_init,
+    .instance_init = idreg_init1,
 };
 
 #define TYPE_TCX_AFX "tcx_afx"
@@ -632,28 +625,21 @@ static void afx_init(hwaddr addr)
     sysbus_mmio_map(s, 0, addr);
 }
 
-static int afx_init1(SysBusDevice *dev)
+static void afx_init1(Object *obj)
 {
-    AFXState *s = TCX_AFX(dev);
+    AFXState *s = TCX_AFX(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->mem, OBJECT(s), "sun4m.afx", 4, &error_fatal);
+    memory_region_init_ram(&s->mem, obj, "sun4m.afx", 4, &error_fatal);
     vmstate_register_ram_global(&s->mem);
     sysbus_init_mmio(dev, &s->mem);
-    return 0;
-}
-
-static void afx_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
-
-    k->init = afx_init1;
 }
 
 static const TypeInfo afx_info = {
     .name          = TYPE_TCX_AFX,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AFXState),
-    .class_init    = afx_class_init,
+    .instance_init = afx_init1,
 };
 
 #define TYPE_OPENPROM "openprom"
@@ -706,16 +692,16 @@ static void prom_init(hwaddr addr, const char *bios_name)
     }
 }
 
-static int prom_init1(SysBusDevice *dev)
+static void prom_init1(Object *obj)
 {
-    PROMState *s = OPENPROM(dev);
+    PROMState *s = OPENPROM(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->prom, OBJECT(s), "sun4m.prom", PROM_SIZE_MAX,
+    memory_region_init_ram(&s->prom, obj, "sun4m.prom", PROM_SIZE_MAX,
                            &error_fatal);
     vmstate_register_ram_global(&s->prom);
     memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
-    return 0;
 }
 
 static Property prom_properties[] = {
@@ -725,9 +711,7 @@ static Property prom_properties[] = {
 static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = prom_init1;
     dc->props = prom_properties;
 }
 
@@ -736,6 +720,7 @@ static const TypeInfo prom_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PROMState),
     .class_init    = prom_class_init,
+    .instance_init = prom_init1,
 };
 
 #define TYPE_SUN4M_MEMORY "memory"
@@ -749,14 +734,14 @@ typedef struct RamDevice {
 } RamDevice;
 
 /* System RAM */
-static int ram_init1(SysBusDevice *dev)
+static void ram_realize(DeviceState *dev, Error **errp)
 {
     RamDevice *d = SUN4M_RAM(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     memory_region_allocate_system_memory(&d->ram, OBJECT(d), "sun4m.ram",
                                          d->size);
-    sysbus_init_mmio(dev, &d->ram);
-    return 0;
+    sysbus_init_mmio(sbd, &d->ram);
 }
 
 static void ram_init(hwaddr addr, ram_addr_t RAM_size,
@@ -792,9 +777,8 @@ static Property ram_properties[] = {
 static void ram_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = ram_init1;
+    dc->realize = ram_realize;
     dc->props = ram_properties;
 }
 
-- 
2.11.0
