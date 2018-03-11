Received: from eggs.gnu.org ([2001:4830:134:3::10]:58574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurFj-0004CK-Up
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurFh-00024g-N5
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:28 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Sun, 11 Mar 2018 11:02:11 +0800
Message-Id: <20180311030215.11488-2-haozhong.zhang@intel.com>
In-Reply-To: <20180311030215.11488-1-haozhong.zhang@intel.com>
References: <20180311030215.11488-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v6 1/5] pc-dimm: make qmp_pc_dimm_device_list()
 sort devices by address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org

Make qmp_pc_dimm_device_list() return sorted by start address
list of devices so that it could be reused in places that
would need sorted list*. Reuse existing pc_dimm_built_list()
to get sorted list.

While at it hide recursive callbacks from callers, so that:

  qmp_pc_dimm_device_list(qdev_get_machine(), &list);

could be replaced with simpler:

  list = qmp_pc_dimm_device_list();

* follow up patch will use it in build_srat()

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au> for ppc part
Reviewed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/mem/pc-dimm.c         | 83 +++++++++++++++++++++++++-----------------------
 hw/ppc/spapr.c           |  3 +-
 include/hw/mem/pc-dimm.h |  2 +-
 numa.c                   |  4 +--
 qmp.c                    |  7 +---
 stubs/qmp_pc_dimm.c      |  4 +--
 6 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 6e74b61cb6..4d050fe2cd 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -162,45 +162,6 @@ uint64_t get_plugged_memory_size(void)
     return pc_existing_dimms_capacity(&error_abort);
 }
 
-int qmp_pc_dimm_device_list(Object *obj, void *opaque)
-{
-    MemoryDeviceInfoList ***prev = opaque;
-
-    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
-        DeviceState *dev = DEVICE(obj);
-
-        if (dev->realized) {
-            MemoryDeviceInfoList *elem = g_new0(MemoryDeviceInfoList, 1);
-            MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
-            PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
-            DeviceClass *dc = DEVICE_GET_CLASS(obj);
-            PCDIMMDevice *dimm = PC_DIMM(obj);
-
-            if (dev->id) {
-                di->has_id = true;
-                di->id = g_strdup(dev->id);
-            }
-            di->hotplugged = dev->hotplugged;
-            di->hotpluggable = dc->hotpluggable;
-            di->addr = dimm->addr;
-            di->slot = dimm->slot;
-            di->node = dimm->node;
-            di->size = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
-                                                NULL);
-            di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
-
-            info->u.dimm.data = di;
-            elem->value = info;
-            elem->next = NULL;
-            **prev = elem;
-            *prev = &elem->next;
-        }
-    }
-
-    object_child_foreach(obj, qmp_pc_dimm_device_list, opaque);
-    return 0;
-}
-
 static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
 {
     unsigned long *bitmap = opaque;
@@ -276,6 +237,50 @@ static int pc_dimm_built_list(Object *obj, void *opaque)
     return 0;
 }
 
+MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
+{
+    GSList *dimms = NULL, *item;
+    MemoryDeviceInfoList *list = NULL, *prev = NULL;
+
+    object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &dimms);
+
+    for (item = dimms; item; item = g_slist_next(item)) {
+        PCDIMMDevice *dimm = PC_DIMM(item->data);
+        Object *obj = OBJECT(dimm);
+        MemoryDeviceInfoList *elem = g_new0(MemoryDeviceInfoList, 1);
+        MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
+        PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
+        DeviceClass *dc = DEVICE_GET_CLASS(obj);
+        DeviceState *dev = DEVICE(obj);
+
+        if (dev->id) {
+            di->has_id = true;
+            di->id = g_strdup(dev->id);
+        }
+        di->hotplugged = dev->hotplugged;
+        di->hotpluggable = dc->hotpluggable;
+        di->addr = dimm->addr;
+        di->slot = dimm->slot;
+        di->node = dimm->node;
+        di->size = object_property_get_uint(obj, PC_DIMM_SIZE_PROP, NULL);
+        di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
+
+        info->u.dimm.data = di;
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
+    g_slist_free(dimms);
+
+    return list;
+}
+
 uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
                                uint64_t address_space_size,
                                uint64_t *hint, uint64_t align, uint64_t size,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7e1c858566..44a0670d11 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -722,8 +722,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
     }
 
     if (hotplug_lmb_start) {
-        MemoryDeviceInfoList **prev = &dimms;
-        qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
+        dimms = qmp_pc_dimm_device_list();
     }
 
     /* ibm,dynamic-memory */
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index d83b957829..1fc479281c 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -93,7 +93,7 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
 
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
-int qmp_pc_dimm_device_list(Object *obj, void *opaque);
+MemoryDeviceInfoList *qmp_pc_dimm_device_list(void);
 uint64_t pc_existing_dimms_capacity(Error **errp);
 uint64_t get_plugged_memory_size(void);
 void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
diff --git a/numa.c b/numa.c
index 398e2c9a85..94427046ec 100644
--- a/numa.c
+++ b/numa.c
@@ -520,12 +520,10 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 
 static void numa_stat_memory_devices(NumaNodeMem node_mem[])
 {
-    MemoryDeviceInfoList *info_list = NULL;
-    MemoryDeviceInfoList **prev = &info_list;
+    MemoryDeviceInfoList *info_list = qmp_pc_dimm_device_list();
     MemoryDeviceInfoList *info;
     PCDIMMDeviceInfo     *pcdimm_info;
 
-    qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
     for (info = info_list; info; info = info->next) {
         MemoryDeviceInfo *value = info->value;
 
diff --git a/qmp.c b/qmp.c
index 8c7d1cc479..4b2517d8b5 100644
--- a/qmp.c
+++ b/qmp.c
@@ -731,12 +731,7 @@ void qmp_object_del(const char *id, Error **errp)
 
 MemoryDeviceInfoList *qmp_query_memory_devices(Error **errp)
 {
-    MemoryDeviceInfoList *head = NULL;
-    MemoryDeviceInfoList **prev = &head;
-
-    qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
-
-    return head;
+    return qmp_pc_dimm_device_list();
 }
 
 ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
diff --git a/stubs/qmp_pc_dimm.c b/stubs/qmp_pc_dimm.c
index 9ddc4f619a..b6b2cca89e 100644
--- a/stubs/qmp_pc_dimm.c
+++ b/stubs/qmp_pc_dimm.c
@@ -2,9 +2,9 @@
 #include "qom/object.h"
 #include "hw/mem/pc-dimm.h"
 
-int qmp_pc_dimm_device_list(Object *obj, void *opaque)
+MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
 {
-   return 0;
+   return NULL;
 }
 
 uint64_t get_plugged_memory_size(void)
-- 
2.14.1
