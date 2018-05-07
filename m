Received: from eggs.gnu.org ([2001:4830:134:3::10]:38541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjY8-0006WL-NN
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjY5-0007fJ-J8
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjY5-0007eK-BV
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:08 -0300
Message-Id: <20180507170315.11497-6-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/12] pc-dimm: factor out address search into
 MemoryDevice code
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

This mainly moves code, but does a handfull of optimizations:
- We pass the machine instead of the address space properties
- We check the hinted address directly and handle fragmented memory
  better
- We make the search independent of pc-dimm

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-6-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/memory-device.h |   3 ++
 include/hw/mem/pc-dimm.h       |   5 --
 hw/mem/memory-device.c         |  86 ++++++++++++++++++++++++++++++++
 hw/mem/pc-dimm.c               | 109 +----------------------------------------
 4 files changed, 91 insertions(+), 112 deletions(-)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 31f64cbab2..3427c7d424 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -41,5 +41,8 @@ typedef struct MemoryDeviceClass {
 
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
+uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
+                                     uint64_t align, uint64_t size,
+                                     Error **errp);
 
 #endif
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index aa5930fbb6..e37fb5d5db 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -76,11 +76,6 @@ typedef struct PCDIMMDeviceClass {
     MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
 } PCDIMMDeviceClass;
 
-uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
-                               uint64_t address_space_size,
-                               uint64_t *hint, uint64_t align, uint64_t size,
-                               Error **errp);
-
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
 uint64_t pc_existing_dimms_capacity(Error **errp);
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 6cbdaf99f3..a2cb85462f 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -48,6 +48,92 @@ static int memory_device_build_list(Object *obj, void *opaque)
     return 0;
 }
 
+uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
+                                     uint64_t align, uint64_t size,
+                                     Error **errp)
+{
+    uint64_t address_space_start, address_space_end;
+    GSList *list = NULL, *item;
+    uint64_t new_addr = 0;
+
+    if (!ms->device_memory) {
+        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
+                         "supported by the machine");
+        return 0;
+    }
+
+    if (!memory_region_size(&ms->device_memory->mr)) {
+        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
+                         "enabled, please specify the maxmem option");
+        return 0;
+    }
+    address_space_start = ms->device_memory->base;
+    address_space_end = address_space_start +
+                        memory_region_size(&ms->device_memory->mr);
+    g_assert(QEMU_ALIGN_UP(address_space_start, align) == address_space_start);
+    g_assert(address_space_end >= address_space_start);
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
+    object_child_foreach(OBJECT(ms), memory_device_build_list, &list);
+    for (item = list; item; item = g_slist_next(item)) {
+        const MemoryDeviceState *md = item->data;
+        const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(OBJECT(md));
+        uint64_t md_size, md_addr;
+
+        md_addr = mdc->get_addr(md);
+        md_size = mdc->get_region_size(md);
+        if (*errp) {
+            goto out;
+        }
+
+        if (ranges_overlap(md_addr, md_size, new_addr, size)) {
+            if (hint) {
+                const DeviceState *d = DEVICE(md);
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
 MemoryDeviceInfoList *qmp_memory_device_list(void)
 {
     GSList *devices = NULL, *item;
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 37b8be80a1..9b70174fd9 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -23,9 +23,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
-#include "qemu/config-file.h"
 #include "qapi/visitor.h"
-#include "qemu/range.h"
 #include "sysemu/numa.h"
 #include "sysemu/kvm.h"
 #include "trace.h"
@@ -60,10 +58,8 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
         goto out;
     }
 
-    addr = pc_dimm_get_free_addr(hpms->base,
-                                 memory_region_size(&hpms->mr),
-                                 !addr ? NULL : &addr, align,
-                                 memory_region_size(mr), &local_err);
+    addr = memory_device_get_free_addr(machine, !addr ? NULL : &addr, align,
+                                       memory_region_size(mr), &local_err);
     if (local_err) {
         goto out;
     }
@@ -211,107 +207,6 @@ out:
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
-- 
2.14.3
