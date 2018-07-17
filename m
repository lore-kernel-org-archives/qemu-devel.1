Received: from eggs.gnu.org ([2001:4830:134:3::10]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffRKb-00054r-Tt
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffRKX-0001g1-1g
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:52:01 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 17 Jul 2018 16:51:54 +0200
Message-Id: <1531839114-13671-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] hw/misc/macio: Fix device introspection
 problems in macio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

Valgrind reports an error when introspecting the macio devices, e.g.:

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'macio-newworld'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q ppc64-softmmu/qemu-system-ppc64 -M none,accel=qtest -qmp stdio
[...]
==30768== Invalid read of size 8
==30768==    at 0x5BC1EA: qdev_print (qdev-monitor.c:686)
==30768==    by 0x5BC1EA: qbus_print (qdev-monitor.c:719)
==30768==    by 0x43E458: handle_hmp_command (monitor.c:3446)
[...]

Use the new function sysbus_init_child_obj() to initialize the objects
here, to get the reference counting of the objects right, so that they
are cleaned up correctly when the parent gets removed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/macio/cuda.c  |  5 ++---
 hw/misc/macio/macio.c | 24 ++++++++----------------
 hw/misc/macio/pmu.c   |  5 ++---
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 9651ed9..c4f7a2f 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -554,9 +554,8 @@ static void cuda_init(Object *obj)
     CUDAState *s = CUDA(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    object_initialize(&s->mos6522_cuda, sizeof(s->mos6522_cuda),
-                      TYPE_MOS6522_CUDA);
-    qdev_set_parent_bus(DEVICE(&s->mos6522_cuda), sysbus_get_default());
+    sysbus_init_child_obj(obj, "mos6522-cuda", &s->mos6522_cuda,
+                          sizeof(s->mos6522_cuda), TYPE_MOS6522_CUDA);
 
     memory_region_init_io(&s->mem, obj, &mos6522_cuda_ops, s, "cuda", 0x2000);
     sysbus_init_mmio(sbd, &s->mem);
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index d135e3b..52aa377 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -209,14 +209,11 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
 static void macio_init_ide(MacIOState *s, MACIOIDEState *ide, size_t ide_size,
                            int index)
 {
-    gchar *name;
+    gchar *name = g_strdup_printf("ide[%i]", index);
 
-    object_initialize(ide, ide_size, TYPE_MACIO_IDE);
-    qdev_set_parent_bus(DEVICE(ide), sysbus_get_default());
+    sysbus_init_child_obj(OBJECT(s), name, ide, ide_size, TYPE_MACIO_IDE);
     memory_region_add_subregion(&s->bar, 0x1f000 + ((index + 1) * 0x1000),
                                 &ide->mem);
-    name = g_strdup_printf("ide[%i]", index);
-    object_property_add_child(OBJECT(s), name, OBJECT(ide), NULL);
     g_free(name);
 }
 
@@ -232,9 +229,7 @@ static void macio_oldworld_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0, NULL);
 
-    object_initialize(&s->cuda, sizeof(s->cuda), TYPE_CUDA);
-    qdev_set_parent_bus(DEVICE(&s->cuda), sysbus_get_default());
-    object_property_add_child(obj, "cuda", OBJECT(&s->cuda), NULL);
+    sysbus_init_child_obj(obj, "cuda", &s->cuda, sizeof(s->cuda), TYPE_CUDA);
 
     object_initialize(&os->nvram, sizeof(os->nvram), TYPE_MACIO_NVRAM);
     dev = DEVICE(&os->nvram);
@@ -390,8 +385,8 @@ static void macio_newworld_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0, NULL);
 
-    object_initialize(&ns->gpio, sizeof(ns->gpio), TYPE_MACIO_GPIO);
-    qdev_set_parent_bus(DEVICE(&ns->gpio), sysbus_get_default());
+    sysbus_init_child_obj(obj, "gpio", &ns->gpio, sizeof(ns->gpio),
+                          TYPE_MACIO_GPIO);
 
     for (i = 0; i < 2; i++) {
         macio_init_ide(s, &ns->ide[i], sizeof(ns->ide[i]), i);
@@ -404,13 +399,10 @@ static void macio_instance_init(Object *obj)
 
     memory_region_init(&s->bar, obj, "macio", 0x80000);
 
-    object_initialize(&s->dbdma, sizeof(s->dbdma), TYPE_MAC_DBDMA);
-    qdev_set_parent_bus(DEVICE(&s->dbdma), sysbus_get_default());
-    object_property_add_child(obj, "dbdma", OBJECT(&s->dbdma), NULL);
+    sysbus_init_child_obj(obj, "dbdma", &s->dbdma, sizeof(s->dbdma),
+                          TYPE_MAC_DBDMA);
 
-    object_initialize(&s->escc, sizeof(s->escc), TYPE_ESCC);
-    qdev_set_parent_bus(DEVICE(&s->escc), sysbus_get_default());
-    object_property_add_child(obj, "escc", OBJECT(&s->escc), NULL);
+    sysbus_init_child_obj(obj, "escc", &s->escc, sizeof(s->escc), TYPE_ESCC);
 }
 
 static const VMStateDescription vmstate_macio_oldworld = {
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index e246b0f..d25344f 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -770,9 +770,8 @@ static void pmu_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0, NULL);
 
-    object_initialize(&s->mos6522_pmu, sizeof(s->mos6522_pmu),
-                      TYPE_MOS6522_PMU);
-    qdev_set_parent_bus(DEVICE(&s->mos6522_pmu), sysbus_get_default());
+    sysbus_init_child_obj(obj, "mos6522-pmu", &s->mos6522_pmu,
+                          sizeof(s->mos6522_pmu), TYPE_MOS6522_PMU);
 
     memory_region_init_io(&s->mem, obj, &mos6522_pmu_ops, s, "via-pmu",
                           0x2000);
-- 
1.8.3.1
