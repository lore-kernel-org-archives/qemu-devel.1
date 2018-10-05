Received: from eggs.gnu.org ([2001:4830:134:3::10]:47342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRg-0001nM-FI
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MJ9-0006ax-3c
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:22:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:17 +0200
Message-Id: <20181005092024.14344-10-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 09/16] memory-device: add and use
 memory_device_get_region_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Auger Eric <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>

We will factor out get_memory_region() from pc-dimm to memory device code
soon. Once that is done, get_region_size() can be implemented
generically and essentially be replaced by
memory_device_get_region_size (and work only on get_memory_region()).

We have some users of get_memory_region() (spapr and pc-dimm code) that are
only interested in the size. So let's rework them to use
memory_device_get_region_size() first, then we can factor out
get_memory_region() and eventually remove get_region_size() without
touching the same code multiple times.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 13 ++++++++++---
 hw/mem/pc-dimm.c               | 10 ++++------
 hw/ppc/spapr.c                 | 21 +++++++--------------
 include/hw/mem/memory-device.h |  2 ++
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index c1e1b81cf2..425830c65c 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -57,10 +57,9 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
     if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
         const DeviceState *dev = DEVICE(obj);
         const MemoryDeviceState *md = MEMORY_DEVICE(obj);
-        const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
         if (dev->realized) {
-            *size += mdc->get_region_size(md, &error_abort);
+            *size += memory_device_get_region_size(md, &error_abort);
         }
     }
 
@@ -167,7 +166,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
         uint64_t md_size, md_addr;
 
         md_addr = mdc->get_addr(md);
-        md_size = mdc->get_region_size(md, &error_abort);
+        md_size = memory_device_get_region_size(md, &error_abort);
 
         if (ranges_overlap(md_addr, md_size, new_addr, size)) {
             if (hint) {
@@ -266,6 +265,14 @@ void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr)
     memory_region_del_subregion(&ms->device_memory->mr, mr);
 }
 
+uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
+                                       Error **errp)
+{
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+
+    return mdc->get_region_size(md, errp);
+}
+
 static const TypeInfo memory_device_info = {
     .name          = TYPE_MEMORY_DEVICE,
     .parent        = TYPE_INTERFACE,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 130f78d0de..3e43ec8742 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -161,16 +161,14 @@ static Property pc_dimm_properties[] = {
 static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
+    Error *local_err = NULL;
     uint64_t value;
-    MemoryRegion *mr;
-    PCDIMMDevice *dimm = PC_DIMM(obj);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
 
-    mr = ddc->get_memory_region(dimm, errp);
-    if (!mr) {
+    value = memory_device_get_region_size(MEMORY_DEVICE(obj), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
-    value = memory_region_size(mr);
 
     visit_type_uint64(v, name, &value, errp);
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c078347b66..c08130facb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3128,12 +3128,10 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     Error *local_err = NULL;
     sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     uint64_t size, addr;
     uint32_t node;
 
-    size = memory_region_size(mr);
+    size = memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abort);
 
     pc_dimm_plug(dimm, MACHINE(ms), &local_err);
     if (local_err) {
@@ -3169,9 +3167,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     Error *local_err = NULL;
-    MemoryRegion *mr;
     uint64_t size;
     Object *memdev;
     hwaddr pagesize;
@@ -3181,11 +3177,11 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    mr = ddc->get_memory_region(dimm, errp);
-    if (!mr) {
+    size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
-    size = memory_region_size(mr);
 
     if (size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Hotplugged memory size must be a multiple of "
@@ -3257,9 +3253,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
                                                         PCDIMMDevice *dimm)
 {
     sPAPRDRConnector *drc;
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
-    uint64_t size = memory_region_size(mr);
+    uint64_t size = memory_device_get_region_size(MEMORY_DEVICE(dimm),
+                                                  &error_abort);
     uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
     uint32_t avail_lmbs = 0;
     uint64_t addr_start, addr;
@@ -3325,14 +3320,12 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     Error *local_err = NULL;
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     uint32_t nr_lmbs;
     uint64_t size, addr_start, addr;
     int i;
     sPAPRDRConnector *drc;
 
-    size = memory_region_size(mr);
+    size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &error_abort);
     nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
 
     addr_start = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 0474a3dd11..898df3057d 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -83,5 +83,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
 void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
                                uint64_t addr);
 void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
+uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
+                                       Error **errp);
 
 #endif
-- 
2.17.1
