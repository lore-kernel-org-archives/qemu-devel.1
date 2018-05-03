Received: from eggs.gnu.org ([2001:4830:134:3::10]:50419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUd-0000s1-MK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUc-0003nK-Kw
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:50:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  3 May 2018 17:49:35 +0200
Message-Id: <20180503154936.18946-8-david@redhat.com>
In-Reply-To: <20180503154936.18946-1-david@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 7/8] memory-device: factor out pre-assign
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

Let's move all pre-assign checks we can do without the device being
realized into the default resource handler.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/machine.c              | 17 ++++++++++
 hw/mem/memory-device.c         | 72 +++++++++++++++++++-----------------------
 include/hw/mem/memory-device.h |  2 ++
 3 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a41068410c..e763501c66 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "sysemu/qtest.h"
+#include "hw/mem/memory-device.h"
 
 static char *machine_get_accel(Object *obj, Error **errp)
 {
@@ -520,6 +521,9 @@ void machine_set_cpu_numa_node(MachineState *machine,
 static ResourceHandler *machine_get_resource_handler(MachineState *machine,
                                                      const DeviceState *dev)
 {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        return RESOURCE_HANDLER(machine);
+    }
     return NULL;
 }
 
@@ -527,6 +531,19 @@ static void machine_resource_handler_pre_assign(ResourceHandler *rh,
                                                 const DeviceState *dev,
                                                 Error **errp)
 {
+    MachineState *ms = MACHINE(rh);
+    Error *local_err = NULL;
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        const MemoryDeviceState *md = MEMORY_DEVICE(dev);
+
+        memory_device_pre_assign(ms, md, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+out:
+    error_propagate(errp, local_err);
 }
 
 static void machine_resource_handler_assign(ResourceHandler *rh,
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 3e04f3954e..aa04e0c962 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -68,59 +68,27 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
     return 0;
 }
 
-static void memory_device_check_addable(MachineState *ms, uint64_t size,
-                                        Error **errp)
-{
-    uint64_t used_region_size = 0;
-
-    /* we will need a new memory slot for kvm and vhost */
-    if (kvm_enabled() && !kvm_has_free_slot(ms)) {
-        error_setg(errp, "hypervisor has no free memory slots left");
-        return;
-    }
-    if (!vhost_has_free_slot()) {
-        error_setg(errp, "a used vhost backend has no free memory slots left");
-        return;
-    }
-
-    /* will we exceed the total amount of memory specified */
-    memory_device_used_region_size(OBJECT(ms), &used_region_size);
-    if (used_region_size + size > ms->maxram_size - ms->ram_size) {
-        error_setg(errp, "not enough space, currently 0x%" PRIx64
-                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
-                   used_region_size, ms->maxram_size - ms->ram_size);
-        return;
-    }
-
-}
-
 uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
                                      uint64_t align, uint64_t size,
                                      Error **errp)
 {
     uint64_t address_space_start, address_space_end;
+    uint64_t used_region_size = 0;
     GSList *list = NULL, *item;
     uint64_t new_addr = 0;
 
-    if (!ms->device_memory) {
-        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
-                         "supported by the machine");
-        return 0;
-    }
-
-    if (!memory_region_size(&ms->device_memory->mr)) {
-        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
-                         "enabled, please specify the maxmem option");
-        return 0;
-    }
     address_space_start = ms->device_memory->base;
     address_space_end = address_space_start +
                         memory_region_size(&ms->device_memory->mr);
     g_assert(QEMU_ALIGN_UP(address_space_start, align) == address_space_start);
     g_assert(address_space_end >= address_space_start);
 
-    memory_device_check_addable(ms, size, errp);
-    if (*errp) {
+    /* will we exceed the total amount of memory specified */
+    memory_device_used_region_size(OBJECT(ms), &used_region_size);
+    if (used_region_size + size > ms->maxram_size - ms->ram_size) {
+        error_setg(errp, "not enough space, currently 0x%" PRIx64
+                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
+                   used_region_size, ms->maxram_size - ms->ram_size);
         return 0;
     }
 
@@ -243,6 +211,32 @@ uint64_t get_plugged_memory_size(void)
     return size;
 }
 
+void memory_device_pre_assign(MachineState *ms,
+                              const MemoryDeviceState *md, Error **errp)
+{
+    if (!ms->device_memory) {
+        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
+                         "supported by the machine");
+        return;
+    }
+
+    if (!memory_region_size(&ms->device_memory->mr)) {
+        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
+                         "enabled, please specify the maxmem option");
+        return;
+    }
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
+}
+
 void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
                                uint64_t addr)
 {
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index e10f2e854a..edbd964ac7 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -47,6 +47,8 @@ typedef struct MemoryDeviceClass {
 
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
+void memory_device_pre_assign(MachineState *ms,
+                              const MemoryDeviceState *md, Error **errp);
 uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
                                      uint64_t align, uint64_t size,
                                      Error **errp);
-- 
2.14.3
