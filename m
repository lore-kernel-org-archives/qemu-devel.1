Received: from eggs.gnu.org ([2001:4830:134:3::10]:50785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7m8-0006Wg-Lg
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7m7-000835-Gp
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7m7-00082o-Aw
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:23 -0400
Date: Tue, 20 Mar 2018 05:17:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-18-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 17/50] qmp: distinguish PC-DIMM and NVDIMM in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Haozhong Zhang <haozhong.zhang@intel.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Haozhong Zhang <haozhong.zhang@intel.com>

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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/misc.json   |  6 +++++-
 hmp.c            | 14 +++++++++++---
 hw/mem/pc-dimm.c | 10 +++++++++-
 numa.c           | 19 +++++++++++++------
 4 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index bcd5d10..6bf082f 100644
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
diff --git a/hmp.c b/hmp.c
index ba9e299..a277517 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2423,7 +2423,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
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
@@ -2436,9 +2447,6 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
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
index 4d050fe..51350d9 100644
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
index 9442704..1116c90 100644
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
-- 
MST
