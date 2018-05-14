Received: from eggs.gnu.org ([2001:4830:134:3::10]:59123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAI0-00049E-U0
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAHu-00056x-PF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:08 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 May 2018 12:00:17 +0200
Message-Id: <20180514100023.12542-13-david@redhat.com>
In-Reply-To: <20180514100023.12542-1-david@redhat.com>
References: <20180514100023.12542-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/18] memory-device: factor out pre-plug
 into hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>

Let's move all pre-plug checks we can do without the device being
realized into the applicable hotplug handler for pc and spapr.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c                   | 11 +++++++
 hw/mem/memory-device.c         | 72 +++++++++++++++++++-----------------------
 hw/ppc/spapr.c                 | 11 +++++++
 include/hw/mem/memory-device.h |  2 ++
 4 files changed, 57 insertions(+), 39 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8bc41ef24b..61f1537e14 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2010,6 +2010,16 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
 {
     Error *local_err = NULL;
 
+    /* first stage hotplug handler */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        memory_device_pre_plug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev),
+                               &local_err);
+    }
+
+    if (local_err) {
+        goto out;
+    }
+
     /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_pre_plug(hotplug_dev, dev, &local_err);
@@ -2017,6 +2027,7 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         hotplug_handler_pre_plug(dev->parent_bus->hotplug_handler, dev,
                                  &local_err);
     }
+out:
     error_propagate(errp, local_err);
 }
 
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 361d38bfc5..d22c91993f 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -68,58 +68,26 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
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
 
@@ -242,6 +210,32 @@ uint64_t get_plugged_memory_size(void)
     return size;
 }
 
+void memory_device_pre_plug(MachineState *ms, const MemoryDeviceState *md,
+                            Error **errp)
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
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 13d153b5a6..562712def2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3676,6 +3676,16 @@ static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
 {
     Error *local_err = NULL;
 
+    /* first stage hotplug handler */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        memory_device_pre_plug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev),
+                               &local_err);
+    }
+
+    if (local_err) {
+        goto out;
+    }
+
     /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         spapr_memory_pre_plug(hotplug_dev, dev, &local_err);
@@ -3685,6 +3695,7 @@ static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
         hotplug_handler_pre_plug(dev->parent_bus->hotplug_handler, dev,
                                  &local_err);
     }
+out:
     error_propagate(errp, local_err);
 }
 
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 62d906be50..3a4e9edc92 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -51,6 +51,8 @@ typedef struct MemoryDeviceClass {
 
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
+void memory_device_pre_plug(MachineState *ms, const MemoryDeviceState *md,
+                            Error **errp);
 uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
                                      uint64_t align, uint64_t size,
                                      Error **errp);
-- 
2.14.3
