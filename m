Received: from eggs.gnu.org ([2001:4830:134:3::10]:44107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUyEK-0002RD-S6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUyEJ-0004mF-GI
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:16 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45023
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fUyEJ-0004ga-7p
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:15 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 18 Jun 2018 18:45:37 +0100
Message-Id: <20180618174538.30092-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180618174538.30092-1-mark.cave-ayland@ilande.co.uk>
References: <20180618174538.30092-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 2/3] hw/sparc/sun4m: Fix problems with device
 introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Thomas Huth <thuth@redhat.com>

Several devices of the sun4m machines are using &error_fatal in
their instance_init function and thus can cause QEMU to abort
unexpectedly:

$ echo "{'execute':'qmp_capabilities'}"\
       "{'execute':'device-list-properties',"\
       " 'arguments':{'typename':'openprom'}}" \
       | sparc-softmmu/qemu-system-sparc -M SS-10 -S -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
RAMBlock "sun4m.prom" already registered, abort!
Aborted (core dumped)

$ echo "{'execute':'qmp_capabilities'}"\
       "{'execute':'device-list-properties',"\
       " 'arguments':{'typename':'macio_idreg'}}" \
       | sparc-softmmu/qemu-system-sparc -M SS-10 -S -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
RAMBlock "sun4m.idreg" already registered, abort!
Aborted (core dumped)

$ echo "{'execute':'qmp_capabilities'}"\
       "{'execute':'device-list-properties',"\
       " 'arguments':{'typename':'tcx_afx'}}" \
       | sparc-softmmu/qemu-system-sparc -M SS-5 -S -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
RAMBlock "sun4m.afx" already registered, abort!
Aborted (core dumped)

Fix the issues by converting the instance_init functions into realize()
functions instead, which are allowed to fail (and not called during
device introspection).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/sun4m.c | 67 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0ee779fafe..b984d2da0e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -572,23 +572,36 @@ typedef struct IDRegState {
     MemoryRegion mem;
 } IDRegState;
 
-static void idreg_init1(Object *obj)
+static void idreg_realize(DeviceState *ds, Error **errp)
 {
-    IDRegState *s = MACIO_ID_REGISTER(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+    IDRegState *s = MACIO_ID_REGISTER(ds);
+    SysBusDevice *dev = SYS_BUS_DEVICE(ds);
+    Error *local_err = NULL;
+
+    memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.idreg",
+                                     sizeof(idreg_data), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
-    memory_region_init_ram_nomigrate(&s->mem, obj,
-                           "sun4m.idreg", sizeof(idreg_data), &error_fatal);
     vmstate_register_ram_global(&s->mem);
     memory_region_set_readonly(&s->mem, true);
     sysbus_init_mmio(dev, &s->mem);
 }
 
+static void idreg_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = idreg_realize;
+}
+
 static const TypeInfo idreg_info = {
     .name          = TYPE_MACIO_ID_REGISTER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(IDRegState),
-    .instance_init = idreg_init1,
+    .class_init    = idreg_class_init,
 };
 
 #define TYPE_TCX_AFX "tcx_afx"
@@ -613,21 +626,35 @@ static void afx_init(hwaddr addr)
     sysbus_mmio_map(s, 0, addr);
 }
 
-static void afx_init1(Object *obj)
+static void afx_realize(DeviceState *ds, Error **errp)
 {
-    AFXState *s = TCX_AFX(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+    AFXState *s = TCX_AFX(ds);
+    SysBusDevice *dev = SYS_BUS_DEVICE(ds);
+    Error *local_err = NULL;
+
+    memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.afx", 4,
+                                     &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
-    memory_region_init_ram_nomigrate(&s->mem, obj, "sun4m.afx", 4, &error_fatal);
     vmstate_register_ram_global(&s->mem);
     sysbus_init_mmio(dev, &s->mem);
 }
 
+static void afx_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = afx_realize;
+}
+
 static const TypeInfo afx_info = {
     .name          = TYPE_TCX_AFX,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AFXState),
-    .instance_init = afx_init1,
+    .class_init    = afx_class_init,
 };
 
 #define TYPE_OPENPROM "openprom"
@@ -680,13 +707,19 @@ static void prom_init(hwaddr addr, const char *bios_name)
     }
 }
 
-static void prom_init1(Object *obj)
+static void prom_realize(DeviceState *ds, Error **errp)
 {
-    PROMState *s = OPENPROM(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+    PROMState *s = OPENPROM(ds);
+    SysBusDevice *dev = SYS_BUS_DEVICE(ds);
+    Error *local_err = NULL;
+
+    memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4m.prom",
+                                     PROM_SIZE_MAX, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
-    memory_region_init_ram_nomigrate(&s->prom, obj, "sun4m.prom", PROM_SIZE_MAX,
-                           &error_fatal);
     vmstate_register_ram_global(&s->prom);
     memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
@@ -701,6 +734,7 @@ static void prom_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->props = prom_properties;
+    dc->realize = prom_realize;
 }
 
 static const TypeInfo prom_info = {
@@ -708,7 +742,6 @@ static const TypeInfo prom_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PROMState),
     .class_init    = prom_class_init,
-    .instance_init = prom_init1,
 };
 
 #define TYPE_SUN4M_MEMORY "memory"
-- 
2.11.0
