Received: from eggs.gnu.org ([2001:4830:134:3::10]:38542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjY8-0006WO-NZ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjY7-0007gg-Fe
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjY7-0007gH-76
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:09 -0300
Message-Id: <20180507170315.11497-7-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 06/12] pc-dimm: factor out capacity and slot
 checks into MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Move the checks into memory_device_get_free_addr(). This will check
before doing any calculations if we have KVM/vhost slots left and if
the total region size would be exceeded.

Of course, while at it, make it independent of pc-dimm code.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-7-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/pc-dimm.h |  1 -
 hw/mem/memory-device.c   | 51 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/pc-dimm.c         | 60 ------------------------------------------------
 3 files changed, 51 insertions(+), 61 deletions(-)

diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index e37fb5d5db..627c8601d9 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -78,7 +78,6 @@ typedef struct PCDIMMDeviceClass {
 
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
-uint64_t pc_existing_dimms_capacity(Error **errp);
 void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
                          uint64_t align, Error **errp);
 void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine);
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index a2cb85462f..8535ddcb14 100644
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
@@ -48,6 +50,50 @@ static int memory_device_build_list(Object *obj, void *opaque)
     return 0;
 }
 
+static int memory_device_used_region_size(Object *obj, void *opaque)
+{
+    uint64_t *size = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
+        const DeviceState *dev = DEVICE(obj);
+        const MemoryDeviceState *md = MEMORY_DEVICE(obj);
+        const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
+
+        if (dev->realized) {
+            *size += mdc->get_region_size(md);
+        }
+    }
+
+    object_child_foreach(obj, memory_device_used_region_size, opaque);
+    return 0;
+}
+
+static void memory_device_check_addable(MachineState *ms, uint64_t size,
+                                        Error **errp)
+{
+    uint64_t used_region_size = 0;
+
+    /* we will need a new memory slot for kvm and vhost */
+    if (kvm_enabled() && !kvm_has_free_slot(ms)) {
+        error_setg(errp, "hypervisor has no free memory slots left");
+        return;
+    }
+    if (!vhost_has_free_slot()) {
+        error_setg(errp, "a used vhost backend has no free memory slots left");
+        return;
+    }
+
+    /* will we exceed the total amount of memory specified */
+    memory_device_used_region_size(OBJECT(ms), &used_region_size);
+    if (used_region_size + size > ms->maxram_size - ms->ram_size) {
+        error_setg(errp, "not enough space, currently 0x%" PRIx64
+                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
+                   used_region_size, ms->maxram_size - ms->ram_size);
+        return;
+    }
+
+}
+
 uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
                                      uint64_t align, uint64_t size,
                                      Error **errp)
@@ -73,6 +119,11 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
     g_assert(QEMU_ALIGN_UP(address_space_start, align) == address_space_start);
     g_assert(address_space_end >= address_space_start);
 
+    memory_device_check_addable(ms, size, errp);
+    if (*errp) {
+        return 0;
+    }
+
     if (hint && QEMU_ALIGN_UP(*hint, align) != *hint) {
         error_setg(errp, "address must be aligned to 0x%" PRIx64 " bytes",
                    align);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9b70174fd9..8aa2d36ce9 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -25,9 +25,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "sysemu/numa.h"
-#include "sysemu/kvm.h"
 #include "trace.h"
-#include "hw/virtio/vhost.h"
 
 typedef struct pc_dimms_capacity {
      uint64_t size;
@@ -43,7 +41,6 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
     Error *local_err = NULL;
-    uint64_t existing_dimms_capacity = 0;
     MemoryRegion *mr;
     uint64_t addr;
 
@@ -64,20 +61,6 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
         goto out;
     }
 
-    existing_dimms_capacity = pc_existing_dimms_capacity(&local_err);
-    if (local_err) {
-        goto out;
-    }
-
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
@@ -100,17 +83,6 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
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
-        goto out;
-    }
-
     memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
     vmstate_register_ram(vmstate_mr, dev);
 
@@ -129,38 +101,6 @@ void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine)
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
-- 
2.14.3
