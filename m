Received: from eggs.gnu.org ([2001:4830:134:3::10]:48968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLl8-00026I-AI
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLl3-0008V8-U4
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:18 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Jun 2018 14:16:51 +0200
Message-Id: <20180611121655.19616-8-david@redhat.com>
In-Reply-To: <20180611121655.19616-1-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 07/11] pc-dimm: get_memory_region() can
 never fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

We already verify when realizing that the memdev property has been
set. We have no more accesses to get_memory_region() before the device
is realized.

So this function will never fail. Remove the stale check and the
error variable. Add a comment to the functions stating that they should
never be called on uninitialized devices.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c             |  7 +------
 hw/mem/nvdimm.c          |  2 +-
 hw/mem/pc-dimm.c         | 21 ++++++---------------
 hw/ppc/spapr.c           | 14 +++-----------
 include/hw/mem/pc-dimm.h |  4 +++-
 5 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 85c040482e..017396fe84 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1706,15 +1706,10 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr;
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
     uint64_t align = TARGET_PAGE_SIZE;
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
     if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
         align = memory_region_get_alignment(mr);
     }
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index df9716231f..b2dc2bbb50 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -96,7 +96,7 @@ static void nvdimm_init(Object *obj)
                              nvdimm_get_unarmed, nvdimm_set_unarmed, NULL);
 }
 
-static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
+static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
 {
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 5294734529..7bb6ce509c 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -35,14 +35,9 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
     Error *local_err = NULL;
-    MemoryRegion *mr;
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
     uint64_t addr;
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
     addr = object_property_get_uint(OBJECT(dimm),
                                     PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
@@ -89,7 +84,7 @@ void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine)
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
 
     memory_device_unplug_region(machine, mr);
     vmstate_unregister_ram(vmstate_mr, dev);
@@ -172,7 +167,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    mr = ddc->get_memory_region(dimm, errp);
+    mr = ddc->get_memory_region(dimm);
     if (!mr) {
         return;
     }
@@ -223,13 +218,9 @@ static void pc_dimm_unrealize(DeviceState *dev, Error **errp)
     host_memory_backend_set_mapped(dimm->hostmem, false);
 }
 
-static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
+static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm)
 {
-    if (!dimm->hostmem) {
-        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set");
-        return NULL;
-    }
-
+    g_assert(dimm->hostmem);
     return host_memory_backend_get_memory(dimm->hostmem);
 }
 
@@ -252,7 +243,7 @@ static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md)
     const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
     MemoryRegion *mr;
 
-    mr = ddc->get_memory_region(dimm, &error_abort);
+    mr = ddc->get_memory_region(dimm);
     if (!mr) {
         return 0;
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a5f1bbd58a..214286fd2f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3142,14 +3142,10 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr;
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
     uint64_t align, size, addr;
     uint32_t node;
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
@@ -3263,7 +3259,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
 {
     sPAPRDRConnector *drc;
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
     uint64_t size = memory_region_size(mr);
     uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
     uint32_t avail_lmbs = 0;
@@ -3331,16 +3327,12 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr;
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
     uint32_t nr_lmbs;
     uint64_t size, addr_start, addr;
     int i;
     sPAPRDRConnector *drc;
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
     size = memory_region_size(mr);
     nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
 
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 627c8601d9..f0e6867803 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -72,7 +72,9 @@ typedef struct PCDIMMDeviceClass {
 
     /* public */
     void (*realize)(PCDIMMDevice *dimm, Error **errp);
-    MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm, Error **errp);
+
+    /* functions should not be called before the device was realized */
+    MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm);
     MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
 } PCDIMMDeviceClass;
 
-- 
2.17.1
