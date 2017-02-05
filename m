Received: from eggs.gnu.org ([2001:4830:134:3::10]:33684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN1B-0000Aw-6D
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003HN-VX
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:13 -0500
Received: from m12-14.163.com ([220.181.12.14]:60845)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Ek-Ax
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:09 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sun,  5 Feb 2017 21:37:27 +0800
Message-Id: <20170205133727.23424-10-zxq_yx_007@163.com>
In-Reply-To: <20170205133727.23424-1-zxq_yx_007@163.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [RESEND PATCH 9/9] hw/sparc64: QOM'ify sun4u.c
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
 hw/sparc64/sun4u.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d1a6bca873..5182be2e1f 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -329,16 +329,16 @@ static void prom_init(hwaddr addr, const char *bios_name)
     }
 }
 
-static int prom_init1(SysBusDevice *dev)
+static void prom_init1(Object *obj)
 {
-    PROMState *s = OPENPROM(dev);
+    PROMState *s = OPENPROM(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->prom, OBJECT(s), "sun4u.prom", PROM_SIZE_MAX,
+    memory_region_init_ram(&s->prom, obj, "sun4u.prom", PROM_SIZE_MAX,
                            &error_fatal);
     vmstate_register_ram_global(&s->prom);
     memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
-    return 0;
 }
 
 static Property prom_properties[] = {
@@ -348,9 +348,7 @@ static Property prom_properties[] = {
 static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = prom_init1;
     dc->props = prom_properties;
 }
 
@@ -359,6 +357,7 @@ static const TypeInfo prom_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PROMState),
     .class_init    = prom_class_init,
+    .instance_init = prom_init1,
 };
 
 
@@ -373,15 +372,15 @@ typedef struct RamDevice {
 } RamDevice;
 
 /* System RAM */
-static int ram_init1(SysBusDevice *dev)
+static void ram_realize(DeviceState *dev, Error **errp)
 {
     RamDevice *d = SUN4U_RAM(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     memory_region_init_ram(&d->ram, OBJECT(d), "sun4u.ram", d->size,
                            &error_fatal);
     vmstate_register_ram_global(&d->ram);
-    sysbus_init_mmio(dev, &d->ram);
-    return 0;
+    sysbus_init_mmio(sbd, &d->ram);
 }
 
 static void ram_init(hwaddr addr, ram_addr_t RAM_size)
@@ -409,9 +408,8 @@ static Property ram_properties[] = {
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
