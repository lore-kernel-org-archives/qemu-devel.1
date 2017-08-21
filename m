Received: from eggs.gnu.org ([2001:4830:134:3::10]:56173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djgLw-0002mu-2a
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 02:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djgLs-0000U5-VP
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 02:38:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 21 Aug 2017 08:30:29 +0200
Message-Id: <1503297029-28436-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/ppc/spapr: Fix segfault when
 instantiating a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
machine without specifying its 'memdev' property. This happens because
pc_dimm_get_memory_region() does not check whether the 'memdev' property
has properly been set by the user. Looking closer at this function, it's
also obvious that it is using &error_abort to call another function - and
this is bad in a function that is used in the hot-plugging calling chain
since this can also cause QEMU to exit unexpectedly.

So let's fix these issues in a proper way now: Add a "Error **errp"
parameter to pc_dimm_get_memory_region() which we use in case the 'memdev'
property has not been set by the user, and which we can use instead of
the &error_abort, and change the callers of get_memory_region() to make
use of this "errp" parameter for proper error checking.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc.c             | 14 ++++++++++++--
 hw/mem/nvdimm.c          |  2 +-
 hw/mem/pc-dimm.c         | 14 +++++++++++---
 hw/ppc/spapr.c           | 42 ++++++++++++++++++++++++++++++------------
 include/hw/mem/pc-dimm.h |  2 +-
 5 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5943539..2108104 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1691,10 +1691,15 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    MemoryRegion *mr;
     uint64_t align = TARGET_PAGE_SIZE;
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
     if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
         align = memory_region_get_alignment(mr);
     }
@@ -1758,10 +1763,15 @@ static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    MemoryRegion *mr;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
 
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
     hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
     hhc->unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
 
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index db896b0..952fce5 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -71,7 +71,7 @@ static void nvdimm_init(Object *obj)
                         NULL, NULL);
 }
 
-static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
+static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
 {
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index ea67b46..bdf6649 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -363,7 +363,10 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
     PCDIMMDevice *dimm = PC_DIMM(obj);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
 
-    mr = ddc->get_memory_region(dimm);
+    mr = ddc->get_memory_region(dimm, errp);
+    if (!mr) {
+        return;
+    }
     value = memory_region_size(mr);
 
     visit_type_uint64(v, name, &value, errp);
@@ -411,9 +414,14 @@ static void pc_dimm_unrealize(DeviceState *dev, Error **errp)
     host_memory_backend_set_mapped(dimm->hostmem, false);
 }
 
-static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm)
+static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
 {
-    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
+    if (!dimm->hostmem) {
+        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set");
+        return NULL;
+    }
+
+    return host_memory_backend_get_memory(dimm->hostmem, errp);
 }
 
 static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f7a1972..cec441c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2772,10 +2772,15 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm);
-    uint64_t align = memory_region_get_alignment(mr);
-    uint64_t size = memory_region_size(mr);
-    uint64_t addr;
+    MemoryRegion *mr;
+    uint64_t align, size, addr;
+
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    align = memory_region_get_alignment(mr);
+    size = memory_region_size(mr);
 
     pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_err);
     if (local_err) {
@@ -2808,10 +2813,16 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm);
-    uint64_t size = memory_region_size(mr);
+    MemoryRegion *mr;
+    uint64_t size;
     char *mem_dev;
 
+    mr = ddc->get_memory_region(dimm, errp);
+    if (!mr) {
+        return;
+    }
+    size = memory_region_size(mr);
+
     if (size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Hotplugged memory size must be a multiple of "
                       "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
@@ -2882,7 +2893,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
 {
     sPAPRDRConnector *drc;
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     uint64_t size = memory_region_size(mr);
     uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
     uint32_t avail_lmbs = 0;
@@ -2912,7 +2923,7 @@ void spapr_lmb_release(DeviceState *dev)
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     /* This information will get lost if a migration occurs
@@ -2945,12 +2956,19 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm);
-    uint64_t size = memory_region_size(mr);
-    uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
-    uint64_t addr_start, addr;
+    MemoryRegion *mr;
+    uint32_t nr_lmbs;
+    uint64_t size, addr_start, addr;
     int i;
     sPAPRDRConnector *drc;
+
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    size = memory_region_size(mr);
+    nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
+
     addr_start = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
                                          &local_err);
     if (local_err) {
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 1e483f2..6f8c3eb 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -71,7 +71,7 @@ typedef struct PCDIMMDeviceClass {
 
     /* public */
     void (*realize)(PCDIMMDevice *dimm, Error **errp);
-    MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm);
+    MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm, Error **errp);
     MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
 } PCDIMMDeviceClass;
 
-- 
1.8.3.1
