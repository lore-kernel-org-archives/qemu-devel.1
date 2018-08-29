Received: from eggs.gnu.org ([2001:4830:134:3::10]:52307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3wg-00058w-31
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3oY-0004Ko-EE
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:59:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 29 Aug 2018 17:59:06 +0100
Message-Id: <20180829165911.30106-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
References: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/7] macio: add macio bus to help with fw path
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

As the in-built IDE controller is attached to the macio bus then we should also
model this the same in QEMU to aid fw path generation.

Note that all existing macio devices are moved onto the new macio bus so that
the qdev tree accurately reflects the real hardware.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/macio.c         | 37 ++++++++++++++++++++++++++++---------
 include/hw/misc/macio/macio.h | 10 ++++++++++
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 52aa3775f4..229bfddb90 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -90,6 +90,15 @@ static void macio_bar_setup(MacIOState *s)
     macio_escc_legacy_setup(s);
 }
 
+static void macio_init_child_obj(MacIOState *s, const char *childname,
+                                 void *child, size_t childsize,
+                                 const char *childtype)
+{
+    object_initialize_child(OBJECT(s), childname, child, childsize, childtype,
+                            &error_abort, NULL);
+    qdev_set_parent_bus(DEVICE(child), BUS(&s->macio_bus));
+}
+
 static void macio_common_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
@@ -211,7 +220,7 @@ static void macio_init_ide(MacIOState *s, MACIOIDEState *ide, size_t ide_size,
 {
     gchar *name = g_strdup_printf("ide[%i]", index);
 
-    sysbus_init_child_obj(OBJECT(s), name, ide, ide_size, TYPE_MACIO_IDE);
+    macio_init_child_obj(s, name, ide, ide_size, TYPE_MACIO_IDE);
     memory_region_add_subregion(&s->bar, 0x1f000 + ((index + 1) * 0x1000),
                                 &ide->mem);
     g_free(name);
@@ -229,7 +238,7 @@ static void macio_oldworld_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0, NULL);
 
-    sysbus_init_child_obj(obj, "cuda", &s->cuda, sizeof(s->cuda), TYPE_CUDA);
+    macio_init_child_obj(s, "cuda", &s->cuda, sizeof(s->cuda), TYPE_CUDA);
 
     object_initialize(&os->nvram, sizeof(os->nvram), TYPE_MACIO_NVRAM);
     dev = DEVICE(&os->nvram);
@@ -340,7 +349,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         object_property_set_link(OBJECT(&s->pmu), OBJECT(sysbus_dev), "gpio",
                                  &error_abort);
         qdev_prop_set_bit(DEVICE(&s->pmu), "has-adb", ns->has_adb);
-        qdev_set_parent_bus(DEVICE(&s->pmu), sysbus_get_default());
+        qdev_set_parent_bus(DEVICE(&s->pmu), BUS(&s->macio_bus));
         object_property_add_child(OBJECT(s), "pmu", OBJECT(&s->pmu), NULL);
 
         object_property_set_bool(OBJECT(&s->pmu), true, "realized", &err);
@@ -356,7 +365,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
     } else {
         /* CUDA */
         object_initialize(&s->cuda, sizeof(s->cuda), TYPE_CUDA);
-        qdev_set_parent_bus(DEVICE(&s->cuda), sysbus_get_default());
+        qdev_set_parent_bus(DEVICE(&s->cuda), BUS(&s->macio_bus));
         object_property_add_child(OBJECT(s), "cuda", OBJECT(&s->cuda), NULL);
         qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                              s->frequency);
@@ -385,8 +394,8 @@ static void macio_newworld_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0, NULL);
 
-    sysbus_init_child_obj(obj, "gpio", &ns->gpio, sizeof(ns->gpio),
-                          TYPE_MACIO_GPIO);
+    macio_init_child_obj(s, "gpio", &ns->gpio, sizeof(ns->gpio),
+                         TYPE_MACIO_GPIO);
 
     for (i = 0; i < 2; i++) {
         macio_init_ide(s, &ns->ide[i], sizeof(ns->ide[i]), i);
@@ -399,10 +408,13 @@ static void macio_instance_init(Object *obj)
 
     memory_region_init(&s->bar, obj, "macio", 0x80000);
 
-    sysbus_init_child_obj(obj, "dbdma", &s->dbdma, sizeof(s->dbdma),
-                          TYPE_MAC_DBDMA);
+    qbus_create_inplace(&s->macio_bus, sizeof(s->macio_bus), TYPE_MACIO_BUS,
+                        DEVICE(obj), "macio.0");
 
-    sysbus_init_child_obj(obj, "escc", &s->escc, sizeof(s->escc), TYPE_ESCC);
+    macio_init_child_obj(s, "dbdma", &s->dbdma, sizeof(s->dbdma),
+                         TYPE_MAC_DBDMA);
+
+    macio_init_child_obj(s, "escc", &s->escc, sizeof(s->escc), TYPE_ESCC);
 }
 
 static const VMStateDescription vmstate_macio_oldworld = {
@@ -470,6 +482,12 @@ static void macio_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
+static const TypeInfo macio_bus_info = {
+    .name = TYPE_MACIO_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(MacIOBusState),
+};
+
 static const TypeInfo macio_oldworld_type_info = {
     .name          = TYPE_OLDWORLD_MACIO,
     .parent        = TYPE_MACIO,
@@ -501,6 +519,7 @@ static const TypeInfo macio_type_info = {
 
 static void macio_register_types(void)
 {
+    type_register_static(&macio_bus_info);
     type_register_static(&macio_type_info);
     type_register_static(&macio_oldworld_type_info);
     type_register_static(&macio_newworld_type_info);
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 0c3964ec12..3189973ee6 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -34,6 +34,15 @@
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/ppc/openpic.h"
 
+/* MacIO virtual bus */
+#define TYPE_MACIO_BUS "macio-bus"
+#define MACIO_BUS(obj) OBJECT_CHECK(MacIOBusState, (obj), TYPE_MACIO_BUS)
+
+typedef struct MacIOBusState {
+    /*< private >*/
+    BusState parent_obj;
+} MacIOBusState;
+
 /* MacIO IDE */
 #define TYPE_MACIO_IDE "macio-ide"
 #define MACIO_IDE(obj) OBJECT_CHECK(MACIOIDEState, (obj), TYPE_MACIO_IDE)
@@ -68,6 +77,7 @@ typedef struct MacIOState {
     PCIDevice parent;
     /*< public >*/
 
+    MacIOBusState macio_bus;
     MemoryRegion bar;
     CUDAState cuda;
     PMUState pmu;
-- 
2.11.0
