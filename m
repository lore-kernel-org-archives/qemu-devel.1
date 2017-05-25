Received: from eggs.gnu.org ([2001:4830:134:3::10]:57405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoS-0006Yn-VK
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoR-0007Wo-Ku
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:27 +1000
Message-Id: <20170525035132.24268-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/18] spapr: add pre_plug function for memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

This allows to manage errors before the memory
has started to be hotplugged. We already have
the function for the CPU cores.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
[dwg: Fixed a couple of style nits]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bcb0e18..3760d37 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2578,20 +2578,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -2612,6 +2598,29 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                  Error **errp)
+{
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    uint64_t size = memory_region_size(mr);
+    char *mem_dev;
+
+    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+        error_setg(errp, "Hotplugged memory size must be a multiple of "
+                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
+        return;
+    }
+
+    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
+    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
+        error_setg(errp, "Memory backend has bad page size. "
+                   "Use 'memory-backend-file' with correct mem-path.");
+        return;
+    }
+}
+
 typedef struct sPAPRDIMMState {
     uint32_t nr_lmbs;
 } sPAPRDIMMState;
@@ -3006,7 +3015,9 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
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
