Received: from eggs.gnu.org ([2001:4830:134:3::10]:58602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurFm-0004DF-5j
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurFl-00025h-1Q
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:52978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eurFk-00023F-N1
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:28 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Sun, 11 Mar 2018 11:02:12 +0800
Message-Id: <20180311030215.11488-3-haozhong.zhang@intel.com>
In-Reply-To: <20180311030215.11488-1-haozhong.zhang@intel.com>
References: <20180311030215.11488-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v6 2/5] qmp: distinguish PC-DIMM and NVDIMM in
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

A new field 'nvdimm' is added to the union type MemoryDeviceInfo for
such purpose. Its type is currently PCDIMMDeviceInfo and will be
updated when necessary in the future.

It also fixes "info memory-devices"/query-memory-devices which
currently show nvdimm devices as dimm devices since
object_dynamic_cast(obj, TYPE_PC_DIMM) happily cast nvdimm to
TYPE_PC_DIMM which it's been inherited from.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hmp.c            | 14 +++++++++++---
 hw/mem/pc-dimm.c | 10 +++++++++-
 numa.c           | 19 +++++++++++++------
 qapi/misc.json   |  6 +++++-
 4 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/hmp.c b/hmp.c
index 016cb5c4f1..011a7c6f35 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2421,7 +2421,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
             switch (value->type) {
             case MEMORY_DEVICE_INFO_KIND_DIMM:
                 di = value->u.dimm.data;
+                break;
+
+            case MEMORY_DEVICE_INFO_KIND_NVDIMM:
+                di = value->u.nvdimm.data;
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
@@ -2434,9 +2445,6 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
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
index 4d050fe2cd..51350d9c2d 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qapi/visitor.h"
@@ -250,6 +251,7 @@ MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
         MemoryDeviceInfoList *elem = g_new0(MemoryDeviceInfoList, 1);
         MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
         PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
+        bool is_nvdimm = object_dynamic_cast(obj, TYPE_NVDIMM);
         DeviceClass *dc = DEVICE_GET_CLASS(obj);
         DeviceState *dev = DEVICE(obj);
 
@@ -265,7 +267,13 @@ MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
         di->size = object_property_get_uint(obj, PC_DIMM_SIZE_PROP, NULL);
         di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
 
-        info->u.dimm.data = di;
+        if (!is_nvdimm) {
+            info->u.dimm.data = di;
+            info->type = MEMORY_DEVICE_INFO_KIND_DIMM;
+        } else {
+            info->u.nvdimm.data = di;
+            info->type = MEMORY_DEVICE_INFO_KIND_NVDIMM;
+        }
         elem->value = info;
         elem->next = NULL;
         if (prev) {
diff --git a/numa.c b/numa.c
index 94427046ec..1116c90af9 100644
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
+                pcdimm_info = value->u.nvdimm.data;
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
diff --git a/qapi/misc.json b/qapi/misc.json
index bcd5d10778..6bf082f612 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2852,7 +2852,11 @@
 #
 # Since: 2.1
 ##
-{ 'union': 'MemoryDeviceInfo', 'data': {'dimm': 'PCDIMMDeviceInfo'} }
+{ 'union': 'MemoryDeviceInfo',
+  'data': { 'dimm': 'PCDIMMDeviceInfo',
+            'nvdimm': 'PCDIMMDeviceInfo'
+          }
+}
 
 ##
 # @query-memory-devices:
-- 
2.14.1
