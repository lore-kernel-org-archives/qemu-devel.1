Received: from eggs.gnu.org ([2001:4830:134:3::10]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7m8-0006Wf-Kw
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7m7-00082j-1B
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:24 -0400
Date: Tue, 20 Mar 2018 05:17:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-17-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 16/50] pc-dimm: make
 qmp_pc_dimm_device_list() sort devices by address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Haozhong Zhang <haozhong.zhang@intel.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson for ppc part <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org

From: Haozhong Zhang <haozhong.zhang@intel.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/mem/pc-dimm.h |  2 +-
 hw/mem/pc-dimm.c         | 83 +++++++++++++++++++++++++-----------------------
 hw/ppc/spapr.c           |  3 +-
 numa.c                   |  4 +--
 qmp.c                    |  7 +---
 stubs/qmp_pc_dimm.c      |  4 +--
 6 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index d83b957..1fc4792 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -93,7 +93,7 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
 
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
-int qmp_pc_dimm_device_list(Object *obj, void *opaque);
+MemoryDeviceInfoList *qmp_pc_dimm_device_list(void);
 uint64_t pc_existing_dimms_capacity(Error **errp);
 uint64_t get_plugged_memory_size(void);
 void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 6e74b61..4d050fe 100644
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
index 7e1c858..44a0670 100644
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
diff --git a/numa.c b/numa.c
index 398e2c9..9442704 100644
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
index 8c7d1cc..4b2517d 100644
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
index 9ddc4f6..b6b2cca 100644
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
MST
