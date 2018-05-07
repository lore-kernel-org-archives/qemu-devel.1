Received: from eggs.gnu.org ([2001:4830:134:3::10]:38364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjXw-0006L4-5S
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjXn-0007Lp-5F
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjXm-0007LM-Sb
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:04 -0300
Message-Id: <20180507170315.11497-2-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] pc-dimm: factor out MemoryDevice interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

On the qmp level, we already have the concept of memory devices:
    "query-memory-devices"
Right now, we only support NVDIMM and PCDIMM.

We want to map other devices later into the address space of the guest.
Such device could e.g. be virtio devices. These devices will have a
guest memory range assigned but won't be exposed via e.g. ACPI. We want
to make them look like memory device, but not glued to pc-dimm.

Especially, it will not always be possible to have TYPE_PC_DIMM as a parent
class (e.g. virtio devices). Let's use an interface instead. As a first
part, convert handling of
- qmp_pc_dimm_device_list
- get_plugged_memory_size
to our new model. plug/unplug stuff etc. will follow later.

A memory device will have to provide the following functions:
- get_addr(): Necessary, as the property "addr" can e.g. not be used for
              virtio devices (already defined).
- get_plugged_size(): The amount this device offers to the guest as of
                      now.
- get_region_size(): Because this can later on be bigger than the
                     plugged size.
- fill_device_info(): Fill MemoryDeviceInfo, e.g. for qmp.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-2-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/memory-device.h               |  45 ++++++++++
 include/hw/mem/pc-dimm.h                     |   2 -
 hw/i386/acpi-build.c                         |   3 +-
 hw/mem/memory-device.c                       | 120 +++++++++++++++++++++++++++
 hw/mem/pc-dimm.c                             | 120 ++++++++++++++-------------
 hw/ppc/spapr.c                               |   3 +-
 hw/ppc/spapr_hcall.c                         |   1 +
 numa.c                                       |   3 +-
 qmp.c                                        |   4 +-
 stubs/{qmp_pc_dimm.c => qmp_memory_device.c} |   4 +-
 hw/mem/Makefile.objs                         |   1 +
 stubs/Makefile.objs                          |   2 +-
 12 files changed, 242 insertions(+), 66 deletions(-)
 create mode 100644 include/hw/mem/memory-device.h
 create mode 100644 hw/mem/memory-device.c
 rename stubs/{qmp_pc_dimm.c => qmp_memory_device.c} (61%)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
new file mode 100644
index 0000000000..31f64cbab2
--- /dev/null
+++ b/include/hw/mem/memory-device.h
@@ -0,0 +1,45 @@
+/*
+ * Memory Device Interface
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef MEMORY_DEVICE_H
+#define MEMORY_DEVICE_H
+
+#include "qom/object.h"
+#include "hw/qdev.h"
+
+#define TYPE_MEMORY_DEVICE "memory-device"
+
+#define MEMORY_DEVICE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(MemoryDeviceClass, (klass), TYPE_MEMORY_DEVICE)
+#define MEMORY_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MemoryDeviceClass, (obj), TYPE_MEMORY_DEVICE)
+#define MEMORY_DEVICE(obj) \
+     INTERFACE_CHECK(MemoryDeviceState, (obj), TYPE_MEMORY_DEVICE)
+
+typedef struct MemoryDeviceState {
+    Object parent_obj;
+} MemoryDeviceState;
+
+typedef struct MemoryDeviceClass {
+    InterfaceClass parent_class;
+
+    uint64_t (*get_addr)(const MemoryDeviceState *md);
+    uint64_t (*get_plugged_size)(const MemoryDeviceState *md);
+    uint64_t (*get_region_size)(const MemoryDeviceState *md);
+    void (*fill_device_info)(const MemoryDeviceState *md,
+                             MemoryDeviceInfo *info);
+} MemoryDeviceClass;
+
+MemoryDeviceInfoList *qmp_memory_device_list(void);
+uint64_t get_plugged_memory_size(void);
+
+#endif
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 1fc479281c..e88073321f 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -93,9 +93,7 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
 
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
-MemoryDeviceInfoList *qmp_pc_dimm_device_list(void);
 uint64_t pc_existing_dimms_capacity(Error **errp);
-uint64_t get_plugged_memory_size(void);
 void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
                          MemoryRegion *mr, uint64_t align, Error **errp);
 void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index c634dcad1d..624e955e29 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -46,6 +46,7 @@
 #include "hw/acpi/vmgenid.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/timer/mc146818rtc_regs.h"
+#include "hw/mem/memory-device.h"
 #include "sysemu/numa.h"
 
 /* Supported chipsets: */
@@ -2253,7 +2254,7 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
                                            uint64_t len, int default_node)
 {
-    MemoryDeviceInfoList *info_list = qmp_pc_dimm_device_list();
+    MemoryDeviceInfoList *info_list = qmp_memory_device_list();
     MemoryDeviceInfoList *info;
     MemoryDeviceInfo *mi;
     PCDIMMDeviceInfo *di;
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
new file mode 100644
index 0000000000..6cbdaf99f3
--- /dev/null
+++ b/hw/mem/memory-device.c
@@ -0,0 +1,120 @@
+/*
+ * Memory Device Interface
+ *
+ * Copyright ProfitBricks GmbH 2012
+ * Copyright (C) 2014 Red Hat Inc
+ * Copyright (c) 2018 Red Hat Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/mem/memory-device.h"
+#include "hw/qdev.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "qemu/range.h"
+
+static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
+{
+    const MemoryDeviceState *md_a = MEMORY_DEVICE(a);
+    const MemoryDeviceState *md_b = MEMORY_DEVICE(b);
+    const MemoryDeviceClass *mdc_a = MEMORY_DEVICE_GET_CLASS(a);
+    const MemoryDeviceClass *mdc_b = MEMORY_DEVICE_GET_CLASS(b);
+    const uint64_t addr_a = mdc_a->get_addr(md_a);
+    const uint64_t addr_b = mdc_b->get_addr(md_b);
+
+    if (addr_a > addr_b) {
+        return 1;
+    } else if (addr_a < addr_b) {
+        return -1;
+    }
+    return 0;
+}
+
+static int memory_device_build_list(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
+        DeviceState *dev = DEVICE(obj);
+        if (dev->realized) { /* only realized memory devices matter */
+            *list = g_slist_insert_sorted(*list, dev, memory_device_addr_sort);
+        }
+    }
+
+    object_child_foreach(obj, memory_device_build_list, opaque);
+    return 0;
+}
+
+MemoryDeviceInfoList *qmp_memory_device_list(void)
+{
+    GSList *devices = NULL, *item;
+    MemoryDeviceInfoList *list = NULL, *prev = NULL;
+
+    object_child_foreach(qdev_get_machine(), memory_device_build_list,
+                         &devices);
+
+    for (item = devices; item; item = g_slist_next(item)) {
+        const MemoryDeviceState *md = MEMORY_DEVICE(item->data);
+        const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(item->data);
+        MemoryDeviceInfoList *elem = g_new0(MemoryDeviceInfoList, 1);
+        MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
+
+        mdc->fill_device_info(md, info);
+
+        elem->value = info;
+        elem->next = NULL;
+        if (prev) {
+            prev->next = elem;
+        } else {
+            list = elem;
+        }
+        prev = elem;
+    }
+
+    g_slist_free(devices);
+
+    return list;
+}
+
+static int memory_device_plugged_size(Object *obj, void *opaque)
+{
+    uint64_t *size = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
+        const DeviceState *dev = DEVICE(obj);
+        const MemoryDeviceState *md = MEMORY_DEVICE(obj);
+        const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
+
+        if (dev->realized) {
+            *size += mdc->get_plugged_size(md);
+        }
+    }
+
+    object_child_foreach(obj, memory_device_plugged_size, opaque);
+    return 0;
+}
+
+uint64_t get_plugged_memory_size(void)
+{
+    uint64_t size = 0;
+
+    memory_device_plugged_size(qdev_get_machine(), &size);
+
+    return size;
+}
+
+static const TypeInfo memory_device_info = {
+    .name          = TYPE_MEMORY_DEVICE,
+    .parent        = TYPE_INTERFACE,
+    .class_size = sizeof(MemoryDeviceClass),
+};
+
+static void memory_device_register_types(void)
+{
+    type_register_static(&memory_device_info);
+}
+
+type_init(memory_device_register_types)
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 51350d9c2d..ef330628c1 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/mem/memory-device.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qapi/visitor.h"
@@ -158,11 +159,6 @@ uint64_t pc_existing_dimms_capacity(Error **errp)
     return cap.size;
 }
 
-uint64_t get_plugged_memory_size(void)
-{
-    return pc_existing_dimms_capacity(&error_abort);
-}
-
 static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
 {
     unsigned long *bitmap = opaque;
@@ -238,57 +234,6 @@ static int pc_dimm_built_list(Object *obj, void *opaque)
     return 0;
 }
 
-MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
-{
-    GSList *dimms = NULL, *item;
-    MemoryDeviceInfoList *list = NULL, *prev = NULL;
-
-    object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &dimms);
-
-    for (item = dimms; item; item = g_slist_next(item)) {
-        PCDIMMDevice *dimm = PC_DIMM(item->data);
-        Object *obj = OBJECT(dimm);
-        MemoryDeviceInfoList *elem = g_new0(MemoryDeviceInfoList, 1);
-        MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
-        PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
-        bool is_nvdimm = object_dynamic_cast(obj, TYPE_NVDIMM);
-        DeviceClass *dc = DEVICE_GET_CLASS(obj);
-        DeviceState *dev = DEVICE(obj);
-
-        if (dev->id) {
-            di->has_id = true;
-            di->id = g_strdup(dev->id);
-        }
-        di->hotplugged = dev->hotplugged;
-        di->hotpluggable = dc->hotpluggable;
-        di->addr = dimm->addr;
-        di->slot = dimm->slot;
-        di->node = dimm->node;
-        di->size = object_property_get_uint(obj, PC_DIMM_SIZE_PROP, NULL);
-        di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
-
-        if (!is_nvdimm) {
-            info->u.dimm.data = di;
-            info->type = MEMORY_DEVICE_INFO_KIND_DIMM;
-        } else {
-            info->u.nvdimm.data = di;
-            info->type = MEMORY_DEVICE_INFO_KIND_NVDIMM;
-        }
-        elem->value = info;
-        elem->next = NULL;
-        if (prev) {
-            prev->next = elem;
-        } else {
-            list = elem;
-        }
-        prev = elem;
-    }
-
-    g_slist_free(dimms);
-
-    return list;
-}
-
 uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
                                uint64_t address_space_size,
                                uint64_t *hint, uint64_t align, uint64_t size,
@@ -445,10 +390,63 @@ static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
     return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
 }
 
+static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
+{
+    const PCDIMMDevice *dimm = PC_DIMM(md);
+
+    return dimm->addr;
+}
+
+static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md)
+{
+    /* dropping const here is fine as we don't touch the memory region */
+    PCDIMMDevice *dimm = PC_DIMM(md);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
+    MemoryRegion *mr;
+
+    mr = ddc->get_memory_region(dimm, &error_abort);
+    if (!mr) {
+        return 0;
+    }
+
+    return memory_region_size(mr);
+}
+
+static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
+                                        MemoryDeviceInfo *info)
+{
+    PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
+    const DeviceClass *dc = DEVICE_GET_CLASS(md);
+    const PCDIMMDevice *dimm = PC_DIMM(md);
+    const DeviceState *dev = DEVICE(md);
+
+    if (dev->id) {
+        di->has_id = true;
+        di->id = g_strdup(dev->id);
+    }
+    di->hotplugged = dev->hotplugged;
+    di->hotpluggable = dc->hotpluggable;
+    di->addr = dimm->addr;
+    di->slot = dimm->slot;
+    di->node = dimm->node;
+    di->size = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
+                                        NULL);
+    di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
+        info->u.nvdimm.data = di;
+        info->type = MEMORY_DEVICE_INFO_KIND_NVDIMM;
+    } else {
+        info->u.dimm.data = di;
+        info->type = MEMORY_DEVICE_INFO_KIND_DIMM;
+    }
+}
+
 static void pc_dimm_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
 
     dc->realize = pc_dimm_realize;
     dc->unrealize = pc_dimm_unrealize;
@@ -457,6 +455,12 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
 
     ddc->get_memory_region = pc_dimm_get_memory_region;
     ddc->get_vmstate_memory_region = pc_dimm_get_vmstate_memory_region;
+
+    mdc->get_addr = pc_dimm_md_get_addr;
+    /* for a dimm plugged_size == region_size */
+    mdc->get_plugged_size = pc_dimm_md_get_region_size;
+    mdc->get_region_size = pc_dimm_md_get_region_size;
+    mdc->fill_device_info = pc_dimm_md_fill_device_info;
 }
 
 static TypeInfo pc_dimm_info = {
@@ -466,6 +470,10 @@ static TypeInfo pc_dimm_info = {
     .instance_init = pc_dimm_init,
     .class_init    = pc_dimm_class_init,
     .class_size    = sizeof(PCDIMMDeviceClass),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+    },
 };
 
 static void pc_dimm_register_types(void)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 32ab3c43b6..640a66a21a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -74,6 +74,7 @@
 #include "hw/compat.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_cpu_core.h"
+#include "hw/mem/memory-device.h"
 
 #include <libfdt.h>
 
@@ -887,7 +888,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
     }
 
     /* ibm,dynamic-memory or ibm,dynamic-memory-v2 */
-    dimms = qmp_pc_dimm_device_list();
+    dimms = qmp_memory_device_list();
     if (spapr_ovec_test(spapr->ov5_cas, OV5_DRMEM_V2)) {
         ret = spapr_populate_drmem_v2(spapr, fdt, offset, dimms);
     } else {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index ca9702e667..5f6e6249ba 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -14,6 +14,7 @@
 #include "kvm_ppc.h"
 #include "hw/ppc/spapr_ovec.h"
 #include "mmu-book3s-v3.h"
+#include "hw/mem/memory-device.h"
 
 struct LPCRSyncState {
     target_ulong value;
diff --git a/numa.c b/numa.c
index 78a869e598..70b150e73a 100644
--- a/numa.c
+++ b/numa.c
@@ -36,6 +36,7 @@
 #include "hw/boards.h"
 #include "sysemu/hostmem.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/memory-device.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
@@ -521,7 +522,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 
 static void numa_stat_memory_devices(NumaNodeMem node_mem[])
 {
-    MemoryDeviceInfoList *info_list = qmp_pc_dimm_device_list();
+    MemoryDeviceInfoList *info_list = qmp_memory_device_list();
     MemoryDeviceInfoList *info;
     PCDIMMDeviceInfo     *pcdimm_info;
 
diff --git a/qmp.c b/qmp.c
index 9e95b889ff..25fdc9a5b2 100644
--- a/qmp.c
+++ b/qmp.c
@@ -39,7 +39,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "hw/boards.h"
 #include "qom/object_interfaces.h"
-#include "hw/mem/pc-dimm.h"
+#include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi_dev_interface.h"
 
 NameInfo *qmp_query_name(Error **errp)
@@ -731,7 +731,7 @@ void qmp_object_del(const char *id, Error **errp)
 
 MemoryDeviceInfoList *qmp_query_memory_devices(Error **errp)
 {
-    return qmp_pc_dimm_device_list();
+    return qmp_memory_device_list();
 }
 
 ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
diff --git a/stubs/qmp_pc_dimm.c b/stubs/qmp_memory_device.c
similarity index 61%
rename from stubs/qmp_pc_dimm.c
rename to stubs/qmp_memory_device.c
index b6b2cca89e..85ff8f2d7e 100644
--- a/stubs/qmp_pc_dimm.c
+++ b/stubs/qmp_memory_device.c
@@ -1,8 +1,8 @@
 #include "qemu/osdep.h"
 #include "qom/object.h"
-#include "hw/mem/pc-dimm.h"
+#include "hw/mem/memory-device.h"
 
-MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
+MemoryDeviceInfoList *qmp_memory_device_list(void)
 {
    return NULL;
 }
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
index f12f8b97a2..10be4df2a2 100644
--- a/hw/mem/Makefile.objs
+++ b/hw/mem/Makefile.objs
@@ -1,2 +1,3 @@
 common-obj-$(CONFIG_MEM_HOTPLUG) += pc-dimm.o
+common-obj-$(CONFIG_MEM_HOTPLUG) += memory-device.o
 common-obj-$(CONFIG_NVDIMM) += nvdimm.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 2d59d84091..53d3f32cb2 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -34,7 +34,7 @@ stub-obj-y += uuid.o
 stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_WIN32) += fd-register.o
-stub-obj-y += qmp_pc_dimm.o
+stub-obj-y += qmp_memory_device.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
-- 
2.14.3
