Received: from eggs.gnu.org ([2001:4830:134:3::10]:45271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dD7pW-0003lZ-5j
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dD7pS-0006AL-P9
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:18:22 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 23 May 2017 13:18:09 +0200
Message-Id: <20170523111812.13469-2-lvivier@redhat.com>
In-Reply-To: <20170523111812.13469-1-lvivier@redhat.com>
References: <20170523111812.13469-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] spapr: add pre_plug function for memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

This allows to manage errors before the memory
has started to be hotplugged. We already have
the function for the CPU cores.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0980d73..0e8d8d1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2569,20 +2569,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     uint64_t align = memory_region_get_alignment(mr);
     uint64_t size = memory_region_size(mr);
     uint64_t addr;
-    char *mem_dev;
-
-    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
-        error_setg(&local_err, "Hotplugged memory size must be a multiple of "
-                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE/M_BYTE);
-        goto out;
-    }
-
-    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
-    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
-        error_setg(&local_err, "Memory backend has bad page size. "
-                   "Use 'memory-backend-file' with correct mem-path.");
-        goto out;
-    }
 
     pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_err);
     if (local_err) {
@@ -2603,6 +2589,33 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                Error **errp)
+{
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    uint64_t size = memory_region_size(mr);
+    Error *local_err = NULL;
+    char *mem_dev;
+
+    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+        error_setg(&local_err, "Hotplugged memory size must be a multiple of "
+                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
+        goto out;
+    }
+
+    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
+    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
+        error_setg(&local_err, "Memory backend has bad page size. "
+                   "Use 'memory-backend-file' with correct mem-path.");
+        goto out;
+    }
+
+out:
+    error_propagate(errp, local_err);
+}
+
 typedef struct sPAPRDIMMState {
     uint32_t nr_lmbs;
 } sPAPRDIMMState;
@@ -2990,7 +3003,9 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        spapr_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_pre_plug(hotplug_dev, dev, errp);
     }
 }
-- 
2.9.4
