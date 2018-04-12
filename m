Received: from eggs.gnu.org ([2001:4830:134:3::10]:37318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f6dLQ-0008NY-Ed
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f6dLN-0007fW-Ti
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:37:00 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 Apr 2018 16:36:35 +0200
Message-Id: <20180412143635.19949-4-david@redhat.com>
In-Reply-To: <20180412143635.19949-1-david@redhat.com>
References: <20180412143635.19949-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] pc-dimm: factor out address space logic
 into MemoryDevice code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, David Hildenbrand <david@redhat.com>

To be able to reuse MemoryDevice logic from other devices besides
pc-dimm, factor the relevant stuff out into the MemoryDevice code.

As we don't care about slots for memory devices that are not pc-dimm,
don't factor that part out.

Most of this patch just moves checks and logic around. While at it, make
the code properly detect certain error conditions better (e.g. fragmented
memory).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c                   |  12 +--
 hw/mem/memory-device.c         | 162 ++++++++++++++++++++++++++++++++++++
 hw/mem/pc-dimm.c               | 185 +++--------------------------------------
 hw/ppc/spapr.c                 |   9 +-
 include/hw/mem/memory-device.h |   4 +
 include/hw/mem/pc-dimm.h       |  14 +---
 6 files changed, 185 insertions(+), 201 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fa8862af33..1c25546a0c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1711,7 +1711,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_plug(dev, &pcms->hotplug_memory, mr, align, &local_err);
+    pc_dimm_memory_plug(dev, align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1761,17 +1761,9 @@ static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
                            DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
 
-    mr = ddc->get_memory_region(dimm, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
     hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
     hhc->unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
 
@@ -1779,7 +1771,7 @@ static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_unplug(dev, &pcms->hotplug_memory, mr);
+    pc_dimm_memory_unplug(dev);
     object_unparent(OBJECT(dev));
 
  out:
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 0e0d6b539a..611c3252f0 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -15,6 +15,8 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "qemu/range.h"
+#include "hw/virtio/vhost.h"
+#include "sysemu/kvm.h"
 
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
 {
@@ -105,6 +107,166 @@ uint64_t get_plugged_memory_size(void)
     return size;
 }
 
+static int memory_device_used_region_size_internal(Object *obj, void *opaque)
+{
+    uint64_t *size = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
+        DeviceState *dev = DEVICE(obj);
+        MemoryDeviceState *md = MEMORY_DEVICE(obj);
+        MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
+
+        if (dev->realized) {
+            *size += mdc->get_region_size(md, &error_abort);
+        }
+    }
+
+    object_child_foreach(obj, memory_device_used_region_size_internal, opaque);
+    return 0;
+}
+
+static uint64_t memory_device_used_region_size(void)
+{
+    uint64_t size = 0;
+
+    memory_device_used_region_size_internal(qdev_get_machine(), &size);
+
+    return size;
+}
+
+uint64_t memory_device_get_free_addr(uint64_t *hint, uint64_t align,
+                                     uint64_t size, Error **errp)
+{
+    const uint64_t used_region_size = memory_device_used_region_size();
+    uint64_t address_space_start, address_space_end;
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    MemoryHotplugState *hpms;
+    GSList *list = NULL, *item;
+    uint64_t new_addr = 0;
+
+    if (!mc->get_memory_hotplug_state) {
+        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
+                         "supported by the machine");
+        return 0;
+    }
+
+    hpms = mc->get_memory_hotplug_state(machine);
+    if (!hpms || !memory_region_size(&hpms->mr)) {
+        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
+                         "enabled, please specify the maxmem option");
+        return 0;
+    }
+    address_space_start = hpms->base;
+    address_space_end = address_space_start + memory_region_size(&hpms->mr);
+    g_assert(address_space_end >= address_space_start);
+
+    if (used_region_size + size > machine->maxram_size - machine->ram_size) {
+        error_setg(errp, "not enough space, currently 0x%" PRIx64
+                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
+                   used_region_size, machine->maxram_size - machine->ram_size);
+        return 0;
+    }
+
+    if (hint && QEMU_ALIGN_UP(*hint, align) != *hint) {
+        error_setg(errp, "address must be aligned to 0x%" PRIx64 " bytes",
+                   align);
+        return 0;
+    }
+
+    if (QEMU_ALIGN_UP(size, align) != size) {
+        error_setg(errp, "backend memory size must be multiple of 0x%"
+                   PRIx64, align);
+        return 0;
+    }
+
+    if (hint) {
+        new_addr = *hint;
+        if (new_addr < address_space_start) {
+            error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
+                       "] at 0x%" PRIx64, new_addr, size, address_space_start);
+            return 0;
+        } else if ((new_addr + size) > address_space_end) {
+            error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
+                       "] beyond 0x%" PRIx64, new_addr, size,
+                       address_space_end);
+            return 0;
+        }
+    } else {
+        new_addr = address_space_start;
+    }
+
+    /* find address range that will fit new memory device */
+    object_child_foreach(qdev_get_machine(), memory_device_built_list, &list);
+    for (item = list; item; item = g_slist_next(item)) {
+        MemoryDeviceState *md = item->data;
+        MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(OBJECT(md));
+        uint64_t md_size, md_addr;
+
+        md_addr = mdc->get_addr(md);
+        md_size = mdc->get_region_size(md, errp);
+        if (*errp) {
+            goto out;
+        }
+
+        if (ranges_overlap(md_addr, md_size, new_addr, size)) {
+            if (hint) {
+                DeviceState *d = DEVICE(md);
+                error_setg(errp, "address range conflicts with '%s'", d->id);
+                goto out;
+            }
+            new_addr = QEMU_ALIGN_UP(md_addr + md_size, align);
+        }
+    }
+
+    if (new_addr + size > address_space_end) {
+        error_setg(errp, "could not find position in guest address space for "
+                   "memory device - memory fragmented due to alignments");
+        goto out;
+    }
+out:
+    g_slist_free(list);
+    return new_addr;
+}
+
+void memory_device_plug_region(MemoryRegion *mr, uint64_t addr, Error **errp)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    MemoryHotplugState *hpms;
+
+    /* we expect a previous call to memory_device_get_free_addr() */
+    g_assert(mc->get_memory_hotplug_state);
+    hpms = mc->get_memory_hotplug_state(machine);
+    g_assert(hpms);
+
+    /* we will need a new memory slot for kvm and vhost */
+    if (kvm_enabled() && !kvm_has_free_slot(machine)) {
+        error_setg(errp, "hypervisor has no free memory slots left");
+        return;
+    }
+    if (!vhost_has_free_slot()) {
+        error_setg(errp, "a used vhost backend has no free memory slots left");
+        return;
+    }
+
+    memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
+}
+
+void memory_device_unplug_region(MemoryRegion *mr)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    MemoryHotplugState *hpms;
+
+    /* we expect a previous call to memory_device_get_free_addr() */
+    g_assert(mc->get_memory_hotplug_state);
+    hpms = mc->get_memory_hotplug_state(machine);
+    g_assert(hpms);
+
+    memory_region_del_subregion(&hpms->mr, mr);
+}
+
 static const TypeInfo memory_device_info = {
     .name          = TYPE_MEMORY_DEVICE,
     .parent        = TYPE_INTERFACE,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 1dbf699e02..cf23ab5d76 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -25,19 +25,10 @@
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qapi/visitor.h"
-#include "qemu/range.h"
 #include "sysemu/numa.h"
-#include "sysemu/kvm.h"
 #include "trace.h"
-#include "hw/virtio/vhost.h"
 
-typedef struct pc_dimms_capacity {
-     uint64_t size;
-     Error    **errp;
-} pc_dimms_capacity;
-
-void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
-                         MemoryRegion *mr, uint64_t align, Error **errp)
+void pc_dimm_memory_plug(DeviceState *dev, uint64_t align, Error **errp)
 {
     int slot;
     MachineState *machine = MACHINE(qdev_get_machine());
@@ -45,37 +36,26 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
     Error *local_err = NULL;
-    uint64_t existing_dimms_capacity = 0;
+    MemoryRegion *mr;
     uint64_t addr;
 
-    addr = object_property_get_uint(OBJECT(dimm),
-                                    PC_DIMM_ADDR_PROP, &local_err);
+    mr = ddc->get_memory_region(dimm, &local_err);
     if (local_err) {
         goto out;
     }
 
-    addr = pc_dimm_get_free_addr(hpms->base,
-                                 memory_region_size(&hpms->mr),
-                                 !addr ? NULL : &addr, align,
-                                 memory_region_size(mr), &local_err);
+    addr = object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
         goto out;
     }
 
-    existing_dimms_capacity = pc_existing_dimms_capacity(&local_err);
+    addr = memory_device_get_free_addr(!addr ? NULL : &addr, align,
+                                       memory_region_size(mr), &local_err);
     if (local_err) {
         goto out;
     }
 
-    if (existing_dimms_capacity + memory_region_size(mr) >
-        machine->maxram_size - machine->ram_size) {
-        error_setg(&local_err, "not enough space, currently 0x%" PRIx64
-                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
-                   existing_dimms_capacity,
-                   machine->maxram_size - machine->ram_size);
-        goto out;
-    }
-
     object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
         goto out;
@@ -98,67 +78,27 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
     }
     trace_mhp_pc_dimm_assigned_slot(slot);
 
-    if (kvm_enabled() && !kvm_has_free_slot(machine)) {
-        error_setg(&local_err, "hypervisor has no free memory slots left");
-        goto out;
-    }
-
-    if (!vhost_has_free_slot()) {
-        error_setg(&local_err, "a used vhost backend has no free"
-                               " memory slots left");
+    memory_device_plug_region(mr, addr, &local_err);
+    if (local_err) {
         goto out;
     }
-
-    memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
     vmstate_register_ram(vmstate_mr, dev);
 
 out:
     error_propagate(errp, local_err);
 }
 
-void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
-                           MemoryRegion *mr)
+void pc_dimm_memory_unplug(DeviceState *dev)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
 
-    memory_region_del_subregion(&hpms->mr, mr);
+    memory_device_unplug_region(mr);
     vmstate_unregister_ram(vmstate_mr, dev);
 }
 
-static int pc_existing_dimms_capacity_internal(Object *obj, void *opaque)
-{
-    pc_dimms_capacity *cap = opaque;
-    uint64_t *size = &cap->size;
-
-    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
-        DeviceState *dev = DEVICE(obj);
-
-        if (dev->realized) {
-            (*size) += object_property_get_uint(obj, PC_DIMM_SIZE_PROP,
-                cap->errp);
-        }
-
-        if (cap->errp && *cap->errp) {
-            return 1;
-        }
-    }
-    object_child_foreach(obj, pc_existing_dimms_capacity_internal, opaque);
-    return 0;
-}
-
-uint64_t pc_existing_dimms_capacity(Error **errp)
-{
-    pc_dimms_capacity cap;
-
-    cap.size = 0;
-    cap.errp = errp;
-
-    pc_existing_dimms_capacity_internal(qdev_get_machine(), &cap);
-    return cap.size;
-}
-
 static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
 {
     unsigned long *bitmap = opaque;
@@ -205,107 +145,6 @@ out:
     return slot;
 }
 
-static gint pc_dimm_addr_sort(gconstpointer a, gconstpointer b)
-{
-    PCDIMMDevice *x = PC_DIMM(a);
-    PCDIMMDevice *y = PC_DIMM(b);
-    Int128 diff = int128_sub(int128_make64(x->addr), int128_make64(y->addr));
-
-    if (int128_lt(diff, int128_zero())) {
-        return -1;
-    } else if (int128_gt(diff, int128_zero())) {
-        return 1;
-    }
-    return 0;
-}
-
-static int pc_dimm_built_list(Object *obj, void *opaque)
-{
-    GSList **list = opaque;
-
-    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
-        DeviceState *dev = DEVICE(obj);
-        if (dev->realized) { /* only realized DIMMs matter */
-            *list = g_slist_insert_sorted(*list, dev, pc_dimm_addr_sort);
-        }
-    }
-
-    object_child_foreach(obj, pc_dimm_built_list, opaque);
-    return 0;
-}
-
-uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
-                               uint64_t address_space_size,
-                               uint64_t *hint, uint64_t align, uint64_t size,
-                               Error **errp)
-{
-    GSList *list = NULL, *item;
-    uint64_t new_addr, ret = 0;
-    uint64_t address_space_end = address_space_start + address_space_size;
-
-    g_assert(QEMU_ALIGN_UP(address_space_start, align) == address_space_start);
-
-    if (!address_space_size) {
-        error_setg(errp, "memory hotplug is not enabled, "
-                         "please add maxmem option");
-        goto out;
-    }
-
-    if (hint && QEMU_ALIGN_UP(*hint, align) != *hint) {
-        error_setg(errp, "address must be aligned to 0x%" PRIx64 " bytes",
-                   align);
-        goto out;
-    }
-
-    if (QEMU_ALIGN_UP(size, align) != size) {
-        error_setg(errp, "backend memory size must be multiple of 0x%"
-                   PRIx64, align);
-        goto out;
-    }
-
-    assert(address_space_end > address_space_start);
-    object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &list);
-
-    if (hint) {
-        new_addr = *hint;
-    } else {
-        new_addr = address_space_start;
-    }
-
-    /* find address range that will fit new DIMM */
-    for (item = list; item; item = g_slist_next(item)) {
-        PCDIMMDevice *dimm = item->data;
-        uint64_t dimm_size = object_property_get_uint(OBJECT(dimm),
-                                                      PC_DIMM_SIZE_PROP,
-                                                      errp);
-        if (errp && *errp) {
-            goto out;
-        }
-
-        if (ranges_overlap(dimm->addr, dimm_size, new_addr, size)) {
-            if (hint) {
-                DeviceState *d = DEVICE(dimm);
-                error_setg(errp, "address range conflicts with '%s'", d->id);
-                goto out;
-            }
-            new_addr = QEMU_ALIGN_UP(dimm->addr + dimm_size, align);
-        }
-    }
-    ret = new_addr;
-
-    if (new_addr < address_space_start) {
-        error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
-                   "] at 0x%" PRIx64, new_addr, size, address_space_start);
-    } else if ((new_addr + size) > address_space_end) {
-        error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
-                   "] beyond 0x%" PRIx64, new_addr, size, address_space_end);
-    }
-
-out:
-    g_slist_free(list);
-    return ret;
-}
-
 static Property pc_dimm_properties[] = {
     DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),
     DEFINE_PROP_UINT32(PC_DIMM_NODE_PROP, PCDIMMDevice, node, 0),
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7ccdb705b3..7757a49335 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3041,7 +3041,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_err);
+    pc_dimm_memory_plug(dev, align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -3062,7 +3062,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     return;
 
 out_unplug:
-    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
+    pc_dimm_memory_unplug(dev);
 out:
     error_propagate(errp, local_err);
 }
@@ -3180,9 +3180,6 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
 void spapr_lmb_release(DeviceState *dev)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
-    PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     /* This information will get lost if a migration occurs
@@ -3202,7 +3199,7 @@ void spapr_lmb_release(DeviceState *dev)
      * Now that all the LMBs have been removed by the guest, call the
      * pc-dimm unplug handler to cleanup up the pc-dimm device.
      */
-    pc_dimm_memory_unplug(dev, &spapr->hotplug_memory, mr);
+    pc_dimm_memory_unplug(dev);
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 3e498b2e61..722620da24 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -40,5 +40,9 @@ typedef struct MemoryDeviceClass {
 
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
+uint64_t memory_device_get_free_addr(uint64_t *hint, uint64_t align,
+                                     uint64_t size, Error **errp);
+void memory_device_plug_region(MemoryRegion *mr, uint64_t addr, Error **errp);
+void memory_device_unplug_region(MemoryRegion *mr);
 
 #endif
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 8bda37adab..2e7c2abe35 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -19,7 +19,6 @@
 #include "exec/memory.h"
 #include "sysemu/hostmem.h"
 #include "hw/qdev.h"
-#include "hw/boards.h"
 
 #define TYPE_PC_DIMM "pc-dimm"
 #define PC_DIMM(obj) \
@@ -76,16 +75,7 @@ typedef struct PCDIMMDeviceClass {
     MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
 } PCDIMMDeviceClass;
 
-uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
-                               uint64_t address_space_size,
-                               uint64_t *hint, uint64_t align, uint64_t size,
-                               Error **errp);
-
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
-
-uint64_t pc_existing_dimms_capacity(Error **errp);
-void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
-                         MemoryRegion *mr, uint64_t align, Error **errp);
-void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
-                           MemoryRegion *mr);
+void pc_dimm_memory_plug(DeviceState *dev, uint64_t align, Error **errp);
+void pc_dimm_memory_unplug(DeviceState *dev);
 #endif
-- 
2.14.3
