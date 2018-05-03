Received: from eggs.gnu.org ([2001:4830:134:3::10]:50508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUk-0000y3-60
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUg-0003pU-RM
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:50:10 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  3 May 2018 17:49:36 +0200
Message-Id: <20180503154936.18946-9-david@redhat.com>
In-Reply-To: <20180503154936.18946-1-david@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 8/8] memory-device: factor out (un)assign
 into default resource handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

This moves the remaining bits into the default resource handler. The
pc-dimm remainings are limited to slot and migration handling.

Compatibility to old machines on x86 should be guaranteed by using the
newly introduced machine class function for enforcing alignment of
DIMMs.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/machine.c              | 20 +++++++++++++++++
 hw/i386/pc.c                   | 16 +-------------
 hw/mem/memory-device.c         | 50 +++++++++++++++++++++++++++++++++++-------
 hw/mem/pc-dimm.c               | 31 +-------------------------
 hw/mem/trace-events            |  4 +++-
 hw/ppc/spapr.c                 |  5 ++---
 include/hw/mem/memory-device.h |  9 +++-----
 include/hw/mem/pc-dimm.h       |  3 +--
 8 files changed, 73 insertions(+), 65 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index e763501c66..7fc1a6bc5e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -549,11 +549,31 @@ out:
 static void machine_resource_handler_assign(ResourceHandler *rh,
                                             DeviceState *dev, Error **errp)
 {
+    MachineState *ms = MACHINE(rh);
+    Error *local_err = NULL;
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        MemoryDeviceState *md = MEMORY_DEVICE(dev);
+
+        memory_device_assign(ms, md, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+out:
+    error_propagate(errp, local_err);
 }
 
 static void machine_resource_handler_unassign(ResourceHandler *rh,
                                               DeviceState *dev)
 {
+    MachineState *ms = MACHINE(rh);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        MemoryDeviceState *md = MEMORY_DEVICE(dev);
+
+        memory_device_unassign(ms, md);
+    }
 }
 
 static void machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9405e28cfa..385f18bb53 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1681,22 +1681,8 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr;
-    uint64_t align = TARGET_PAGE_SIZE;
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
-        align = memory_region_get_alignment(mr);
-    }
-
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
      * but pcms->acpi_dev is still created. Check !acpi_enabled in
@@ -1714,7 +1700,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_plug(dev, MACHINE(pcms), align, &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(pcms), &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index aa04e0c962..f7f19f6ed2 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -17,6 +17,8 @@
 #include "qemu/range.h"
 #include "hw/virtio/vhost.h"
 #include "sysemu/kvm.h"
+#include "trace.h"
+
 
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
 {
@@ -68,9 +70,10 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
     return 0;
 }
 
-uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
-                                     uint64_t align, uint64_t size,
-                                     Error **errp)
+static uint64_t memory_device_get_free_addr(MachineState *ms,
+                                            const uint64_t *hint,
+                                            uint64_t align, uint64_t size,
+                                            Error **errp)
 {
     uint64_t address_space_start, address_space_end;
     uint64_t used_region_size = 0;
@@ -237,22 +240,53 @@ void memory_device_pre_assign(MachineState *ms,
     }
 }
 
-void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
-                               uint64_t addr)
+void memory_device_assign(MachineState *ms, MemoryDeviceState *md,
+                          Error **errp)
 {
-    /* we expect a previous call to memory_device_get_free_addr() */
+    const MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    const uint64_t size = mdc->get_region_size(md);
+    MemoryRegion *mr = mdc->get_memory_region(md);
+    uint64_t addr = mdc->get_addr(md);
+    uint64_t align = memory_region_get_alignment(mr);
+
+    /* we expect a previous call to memory_device_pre_assign */
     g_assert(ms->device_memory);
 
+    /* our device might have stronger alignment requirements */
+    if (mdc->get_align) {
+        align = MAX(align, mdc->get_align(md));
+    }
+
+    /* for compat handling, some alignment has to be enforced for DIMMs */
+    if (mc->enforce_memory_device_align) {
+        /* align unchanged if nothing is to be enforced */
+        mc->enforce_memory_device_align(mc, md, &align);
+    }
+
+    addr = memory_device_get_free_addr(ms, !addr ? NULL : &addr, align,
+                                       size, errp);
+    if (*errp) {
+        return;
+    }
+    trace_memory_device_assign_address(addr);
+    mdc->set_addr(md, addr);
+
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
 }
 
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr)
+void memory_device_unassign(MachineState *ms, MemoryDeviceState *md)
 {
-    /* we expect a previous call to memory_device_get_free_addr() */
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    MemoryRegion *mr = mdc->get_memory_region(md);
+
+    /* we expect a previous call to memory_device_pre_assign */
     g_assert(ms->device_memory);
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
+    trace_memory_device_unassign_address(mdc->get_addr(md));
+    mdc->set_addr(md, 0);
 }
 
 static const TypeInfo memory_device_info = {
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 7ab9e77747..9c5eb1fb16 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -32,39 +32,13 @@ typedef struct pc_dimms_capacity {
      Error    **errp;
 } pc_dimms_capacity;
 
-void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
-                         uint64_t align, Error **errp)
+void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine, Error **errp)
 {
     int slot;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
     Error *local_err = NULL;
-    MemoryRegion *mr;
-    uint64_t addr;
-
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    addr = object_property_get_uint(OBJECT(dimm),
-                                    PC_DIMM_ADDR_PROP, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    addr = memory_device_get_free_addr(machine, !addr ? NULL : &addr, align,
-                                       memory_region_size(mr), &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    trace_mhp_pc_dimm_assigned_address(addr);
 
     slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP, &local_err);
     if (local_err) {
@@ -82,7 +56,6 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
     }
     trace_mhp_pc_dimm_assigned_slot(slot);
 
-    memory_device_plug_region(machine, mr, addr);
     vmstate_register_ram(vmstate_mr, dev);
 
 out:
@@ -94,9 +67,7 @@ void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine)
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
 
-    memory_device_unplug_region(machine, mr);
     vmstate_unregister_ram(vmstate_mr, dev);
 }
 
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index e150dcc497..930b6aa6ea 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -2,4 +2,6 @@
 
 # hw/mem/pc-dimm.c
 mhp_pc_dimm_assigned_slot(int slot) "%d"
-mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
+# hw/mem/memory-device.c
+memory_device_assign_address(uint64_t addr) "0x%"PRIx64
+memory_device_unassign_address(uint64_t addr) "0x%"PRIx64
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 428f6c79c5..818e7232d8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3162,16 +3162,15 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr;
-    uint64_t align, size, addr;
+    uint64_t size, addr;
 
     mr = ddc->get_memory_region(dimm, &local_err);
     if (local_err) {
         goto out;
     }
-    align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_memory_plug(dev, MACHINE(ms), align, &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(ms), &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index edbd964ac7..6cedbaf747 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -49,11 +49,8 @@ MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
 void memory_device_pre_assign(MachineState *ms,
                               const MemoryDeviceState *md, Error **errp);
-uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
-                                     uint64_t align, uint64_t size,
-                                     Error **errp);
-void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
-                               uint64_t addr);
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
+void memory_device_assign(MachineState *ms, MemoryDeviceState *md,
+                          Error **errp);
+void memory_device_unassign(MachineState *ms, MemoryDeviceState *md);
 
 #endif
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 627c8601d9..006c80fb2e 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -78,7 +78,6 @@ typedef struct PCDIMMDeviceClass {
 
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
-void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
-                         uint64_t align, Error **errp);
+void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine, Error **errp);
 void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine);
 #endif
-- 
2.14.3
