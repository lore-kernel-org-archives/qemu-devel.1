Received: from eggs.gnu.org ([2001:4830:134:3::10]:47826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1esk4B-0004z9-GY
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1esk47-0004lD-JW
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:57:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:22624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1esk46-0004iW-Su
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:57:43 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon,  5 Mar 2018 14:57:07 +0800
Message-Id: <20180305065710.25876-3-haozhong.zhang@intel.com>
In-Reply-To: <20180305065710.25876-1-haozhong.zhang@intel.com>
References: <20180305065710.25876-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/5] qmp: distinguish PC-DIMM and NVDIMM in
 MemoryDeviceInfoList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, dgilbert@redhat.com

It may need to treat PC-DIMM and NVDIMM differently, e.g., when
deciding the necessity of non-volatile flag bit in SRAT memory
affinity structures.

NVDIMMDeviceInfo, which inherits from PCDIMMDeviceInfo, is added to
union type MemoryDeviceInfo to record information of NVDIMM devices.
The NVDIMM-specific data is currently left empty and will be filled
when necessary in the future.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hmp.c            | 14 +++++++++++---
 hw/mem/pc-dimm.c | 20 ++++++++++++++++++--
 numa.c           | 19 +++++++++++++------
 qapi-schema.json | 18 +++++++++++++++++-
 4 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/hmp.c b/hmp.c
index ae86bfbade..3f06407c5e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2413,7 +2413,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
             switch (value->type) {
             case MEMORY_DEVICE_INFO_KIND_DIMM:
                 di = value->u.dimm.data;
+                break;
+
+            case MEMORY_DEVICE_INFO_KIND_NVDIMM:
+                di = qapi_NVDIMMDeviceInfo_base(value->u.nvdimm.data);
+                break;
+
+            default:
+                di = NULL;
+                break;
+            }
 
+            if (di) {
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
                                MemoryDeviceInfoKind_str(value->type),
                                di->id ? di->id : "");
@@ -2426,9 +2437,6 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                                di->hotplugged ? "true" : "false");
                 monitor_printf(mon, "  hotpluggable: %s\n",
                                di->hotpluggable ? "true" : "false");
-                break;
-            default:
-                break;
             }
         }
     }
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 4d050fe2cd..866ecc699a 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qapi/visitor.h"
@@ -249,10 +250,19 @@ MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
         Object *obj = OBJECT(dimm);
         MemoryDeviceInfoList *elem = g_new0(MemoryDeviceInfoList, 1);
         MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
-        PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
+        PCDIMMDeviceInfo *di;
+        NVDIMMDeviceInfo *ndi;
+        bool is_nvdimm = object_dynamic_cast(obj, TYPE_NVDIMM);
         DeviceClass *dc = DEVICE_GET_CLASS(obj);
         DeviceState *dev = DEVICE(obj);
 
+        if (!is_nvdimm) {
+            di = g_new0(PCDIMMDeviceInfo, 1);
+        } else {
+            ndi = g_new0(NVDIMMDeviceInfo, 1);
+            di = qapi_NVDIMMDeviceInfo_base(ndi);
+        }
+
         if (dev->id) {
             di->has_id = true;
             di->id = g_strdup(dev->id);
@@ -265,7 +275,13 @@ MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
         di->size = object_property_get_uint(obj, PC_DIMM_SIZE_PROP, NULL);
         di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
 
-        info->u.dimm.data = di;
+        if (!is_nvdimm) {
+            info->u.dimm.data = di;
+            info->type = MEMORY_DEVICE_INFO_KIND_DIMM;
+        } else {
+            info->u.nvdimm.data = ndi;
+            info->type = MEMORY_DEVICE_INFO_KIND_NVDIMM;
+        }
         elem->value = info;
         elem->next = NULL;
         if (prev) {
diff --git a/numa.c b/numa.c
index c6734ceb8c..23c4371e51 100644
--- a/numa.c
+++ b/numa.c
@@ -529,18 +529,25 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
 
         if (value) {
             switch (value->type) {
-            case MEMORY_DEVICE_INFO_KIND_DIMM: {
+            case MEMORY_DEVICE_INFO_KIND_DIMM:
                 pcdimm_info = value->u.dimm.data;
+                break;
+
+            case MEMORY_DEVICE_INFO_KIND_NVDIMM:
+                pcdimm_info = qapi_NVDIMMDeviceInfo_base(value->u.nvdimm.data);
+                break;
+
+            default:
+                pcdimm_info = NULL;
+                break;
+            }
+
+            if (pcdimm_info) {
                 node_mem[pcdimm_info->node].node_mem += pcdimm_info->size;
                 if (pcdimm_info->hotpluggable && pcdimm_info->hotplugged) {
                     node_mem[pcdimm_info->node].node_plugged_mem +=
                         pcdimm_info->size;
                 }
-                break;
-            }
-
-            default:
-                break;
             }
         }
     }
diff --git a/qapi-schema.json b/qapi-schema.json
index cd98a94388..1c2d281749 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2920,6 +2920,18 @@
           }
 }
 
+##
+# @NVDIMMDeviceInfo:
+#
+# NVDIMMDevice state information
+#
+# Since: 2.12
+##
+{ 'struct': 'NVDIMMDeviceInfo',
+  'base': 'PCDIMMDeviceInfo',
+  'data': {}
+}
+
 ##
 # @MemoryDeviceInfo:
 #
@@ -2927,7 +2939,11 @@
 #
 # Since: 2.1
 ##
-{ 'union': 'MemoryDeviceInfo', 'data': {'dimm': 'PCDIMMDeviceInfo'} }
+{ 'union': 'MemoryDeviceInfo',
+  'data': { 'dimm': 'PCDIMMDeviceInfo',
+            'nvdimm': 'NVDIMMDeviceInfo'
+          }
+}
 
 ##
 # @query-memory-devices:
-- 
2.14.1
