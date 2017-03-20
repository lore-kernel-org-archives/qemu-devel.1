Received: from eggs.gnu.org ([2001:4830:134:3::10]:58323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwv-0005IQ-50
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwt-0004z6-Cf
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwt-0004uJ-1n
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:23 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:49 +0800
Message-Id: <20170320001249.25521-11-haozhong.zhang@intel.com>
In-Reply-To: <20170320001249.25521-1-haozhong.zhang@intel.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 10/10] qapi: extend
 'query-memory-devices' to list devices of specified type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Add an optional argument 'devtype' to 'query-memory-devices', which
is either 'dimm' or 'nvdimm'. If 'devtype' is missed or 'dimm', all
memory devices will be listed. If 'devtype' is 'nvdimm', only nvdimm
devices will be listed.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
---
 hmp.c                    |  3 +-
 hw/mem/nvdimm.c          | 38 ++++++++++++++++++++++++++
 hw/mem/pc-dimm.c         | 71 ++++++++++++++++++++++++++++--------------------
 include/hw/mem/nvdimm.h  |  2 ++
 include/hw/mem/pc-dimm.h |  1 +
 qapi-schema.json         | 48 +++++++++++++++++++++++++++++---
 qmp.c                    | 13 +++++++--
 7 files changed, 140 insertions(+), 36 deletions(-)

diff --git a/hmp.c b/hmp.c
index 261843f7a2..35ad8c9716 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2144,7 +2144,8 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
-    MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
+    MemoryDeviceInfoList *info_list =
+        qmp_query_memory_devices(true, MEMORY_DEVICE_TYPE_DIMM, &err);
     MemoryDeviceInfoList *info;
     MemoryDeviceInfo *value;
     PCDIMMDeviceInfo *di;
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 0d3e17e94c..811efda869 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -178,3 +178,41 @@ static void nvdimm_register_types(void)
 }
 
 type_init(nvdimm_register_types)
+
+static int qmp_nvdimm_device_info(Object *obj, NVDIMMDeviceInfo *di)
+{
+    if (!object_dynamic_cast(obj, TYPE_NVDIMM)) {
+        return 1;
+    }
+
+    if (qmp_pc_dimm_device_info(obj, (PCDIMMDeviceInfo *)di)) {
+        return 1;
+    }
+
+    di->label_size = object_property_get_int(obj, "label-size", NULL);
+
+    return 0;
+}
+
+int qmp_nvdimm_device_list(Object *obj, void *opaque)
+{
+    MemoryDeviceInfoList ***prev = opaque;
+    NVDIMMDeviceInfo *di = g_new0(NVDIMMDeviceInfo, 1);
+
+    if (qmp_nvdimm_device_info(obj, di)) {
+        g_free(di);
+    } else {
+        MemoryDeviceInfoList *elem = g_new0(MemoryDeviceInfoList, 1);
+        MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
+
+        info->type = MEMORY_DEVICE_TYPE_NVDIMM;
+        info->u.nvdimm.data = di;
+        elem->value = info;
+        elem->next = NULL;
+        **prev = elem;
+        *prev = &elem->next;
+    }
+
+    object_child_foreach(obj, qmp_nvdimm_device_list, opaque);
+    return 0;
+}
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 69c5784252..40a9c31cc5 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -161,39 +161,52 @@ uint64_t pc_existing_dimms_capacity(Error **errp)
     return cap.size;
 }
 
+int qmp_pc_dimm_device_info(Object *obj, PCDIMMDeviceInfo *di)
+{
+    DeviceState *dev;
+    DeviceClass *dc;
+    PCDIMMDevice *dimm;
+
+    if (!object_dynamic_cast(obj, TYPE_PC_DIMM)) {
+        return 1;
+    }
+
+    dev = DEVICE(obj);
+    dc = DEVICE_GET_CLASS(obj);
+    dimm = PC_DIMM(obj);
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
+    di->size = object_property_get_int(OBJECT(dimm), PC_DIMM_SIZE_PROP, NULL);
+    di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
+
+    return 0;
+}
+
 int qmp_pc_dimm_device_list(Object *obj, void *opaque)
 {
     MemoryDeviceInfoList ***prev = opaque;
+    PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
 
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
-            di->size = object_property_get_int(OBJECT(dimm), PC_DIMM_SIZE_PROP,
-                                               NULL);
-            di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
-
-            info->u.dimm.data = di;
-            elem->value = info;
-            elem->next = NULL;
-            **prev = elem;
-            *prev = &elem->next;
-        }
+    if (qmp_pc_dimm_device_info(obj, di)) {
+        g_free(di);
+    } else {
+        MemoryDeviceInfoList *elem = g_new0(MemoryDeviceInfoList, 1);
+        MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
+
+        info->type = MEMORY_DEVICE_TYPE_DIMM;
+        info->u.dimm.data = di;
+        elem->value = info;
+        elem->next = NULL;
+        **prev = elem;
+        *prev = &elem->next;
     }
 
     object_child_foreach(obj, qmp_pc_dimm_device_list, opaque);
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 03e1ff9558..89c79564c8 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -132,4 +132,6 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        uint32_t ram_slots);
 void nvdimm_plug(AcpiNVDIMMState *state);
 void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
+
+int qmp_nvdimm_device_list(Object *obj, void *opaque);
 #endif
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 1e483f2670..5f74febeaa 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -93,6 +93,7 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
 
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
+int qmp_pc_dimm_device_info(Object *obj, PCDIMMDeviceInfo *di);
 int qmp_pc_dimm_device_list(Object *obj, void *opaque);
 uint64_t pc_existing_dimms_capacity(Error **errp);
 void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
diff --git a/qapi-schema.json b/qapi-schema.json
index 32b4a4b782..5280de2405 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5811,24 +5811,62 @@
 }
 
 ##
+# @NVDIMMDeviceInfo:
+#
+# NVDIMMDevice state information
+#
+# @label-size: size the label storage area
+#
+# Since 2.9
+##
+{ 'struct': 'NVDIMMDeviceInfo',
+  'base': 'PCDIMMDeviceInfo',
+  'data': { 'label-size': 'int' }
+}
+
+##
 # @MemoryDeviceInfo:
 #
 # Union containing information about a memory device
 #
+# - @dimm: since 2.1
+# - @nvdimm: since 2.9
+#
 # Since: 2.1
 ##
-{ 'union': 'MemoryDeviceInfo', 'data': {'dimm': 'PCDIMMDeviceInfo'} }
+{ 'union': 'MemoryDeviceInfo',
+  'data': {'dimm': 'PCDIMMDeviceInfo', 'nvdimm': 'NVDIMMDeviceInfo'}
+}
+
+##
+# @MemoryDeviceType:
+#
+# Type of memory devices.
+#
+# @dimm: pc-dimm memory device
+#
+# @nvdimm: nvdimm memory device
+#
+# Since 2.9
+##
+{ 'enum': 'MemoryDeviceType', 'data': [ 'dimm', 'nvdimm' ] }
 
 ##
 # @query-memory-devices:
 #
-# Lists available memory devices and their state
+# Lists available memory devices and their state. If the optional argument
+# @devtype is present, only memory devices of the specified type are included.
+#
+# @devtype: specify the type of memory devices to be listed. If 'dimm' is
+#           specified, all pc-dimm devices (including nvdimm devices which is
+#           a subtype of pc-dimm) will be listed. If 'nvdimm' is specified,
+#           only nvdimm devices will be listed. (Since 2.9)
 #
 # Since: 2.1
 #
 # Example:
 #
-# -> { "execute": "query-memory-devices" }
+# -> { "execute": "query-memory-devices", "arguments": { "devtype": "dimm" } }
 # <- { "return": [ { "data":
 #                       { "addr": 5368709120,
 #                         "hotpluggable": true,
@@ -5842,7 +5880,9 @@
 #                  } ] }
 #
 ##
-{ 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
+{ 'command': 'query-memory-devices',
+  'data': { '*devtype': 'MemoryDeviceType' },
+  'returns': ['MemoryDeviceInfo'] }
 
 ##
 # @ACPISlotType:
diff --git a/qmp.c b/qmp.c
index fa82b598c6..179a10bced 100644
--- a/qmp.c
+++ b/qmp.c
@@ -36,6 +36,7 @@
 #include "hw/boards.h"
 #include "qom/object_interfaces.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "hw/acpi/acpi_dev_interface.h"
 
 NameInfo *qmp_query_name(Error **errp)
@@ -689,12 +690,20 @@ void qmp_object_del(const char *id, Error **errp)
     user_creatable_del(id, errp);
 }
 
-MemoryDeviceInfoList *qmp_query_memory_devices(Error **errp)
+MemoryDeviceInfoList *qmp_query_memory_devices(bool has_devtype,
+                                               MemoryDeviceType devtype,
+                                               Error **errp)
 {
     MemoryDeviceInfoList *head = NULL;
     MemoryDeviceInfoList **prev = &head;
 
-    qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
+    if (!has_devtype || devtype == MEMORY_DEVICE_TYPE_DIMM) {
+        qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
+    } else if (devtype == MEMORY_DEVICE_TYPE_NVDIMM) {
+        qmp_nvdimm_device_list(qdev_get_machine(), &prev);
+    } else {
+        error_setg(errp, "unrecognized memory device type %d", devtype);
+    }
 
     return head;
 }
-- 
2.12.0
