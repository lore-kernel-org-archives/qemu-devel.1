Received: from eggs.gnu.org ([2001:4830:134:3::10]:35950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7z9-00020e-MM
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7z8-000562-2d
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:21:23 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 May 2018 15:19:49 +0200
Message-Id: <20180511131953.12905-14-david@redhat.com>
In-Reply-To: <20180511131953.12905-1-david@redhat.com>
References: <20180511131953.12905-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/17] memory-device: factor out plug into
 hotplug handler
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

Let's move the plug logic into the applicable hotplug handler for pc and
spapr.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c                   | 35 ++++++++++++++++++++---------------
 hw/mem/memory-device.c         | 40 ++++++++++++++++++++++++++++++++++------
 hw/mem/pc-dimm.c               | 29 +----------------------------
 hw/mem/trace-events            |  2 +-
 hw/ppc/spapr.c                 | 15 ++++++++++++---
 include/hw/mem/memory-device.h |  7 ++-----
 include/hw/mem/pc-dimm.h       |  3 +--
 7 files changed, 71 insertions(+), 60 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b90cbd5495..8bf0de1ef2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1682,22 +1682,8 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
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
@@ -1715,7 +1701,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_plug(dev, MACHINE(pcms), align, &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(pcms), &local_err);
     if (local_err) {
         goto out;
     }
@@ -2036,6 +2022,25 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
 {
     Error *local_err = NULL;
 
+    /* first stage hotplug handler */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(hotplug_dev);
+        uint64_t align = 0;
+
+        /* compat handling: force to TARGET_PAGE_SIZE */
+        if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
+            !pcmc->enforce_aligned_dimm) {
+            align = TARGET_PAGE_SIZE;
+        }
+        memory_device_plug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev),
+                           align ? &align : NULL, &local_err);
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_dimm_plug(hotplug_dev, dev, &local_err);
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 8f10d613ea..04bdb30f22 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -69,9 +69,10 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
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
@@ -237,11 +238,38 @@ void memory_device_pre_plug(MachineState *ms, const MemoryDeviceState *md,
     }
 }
 
-void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
-                               uint64_t addr)
+void memory_device_plug(MachineState *ms, MemoryDeviceState *md,
+                        uint64_t *enforced_align, Error **errp)
 {
-    /* we expect a previous call to memory_device_get_free_addr() */
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    const uint64_t size = mdc->get_region_size(md);
+    MemoryRegion *mr = mdc->get_memory_region(md);
+    uint64_t addr = mdc->get_addr(md);
+    uint64_t align;
+
+    /* we expect a previous call to memory_device_pre_plug */
     g_assert(ms->device_memory);
+    g_assert(mr && !memory_region_is_mapped(mr));
+
+    /* compat handling, some alignment has to be enforced for DIMMs */
+    if (enforced_align) {
+        align = *enforced_align;
+    } else {
+        align = memory_region_get_alignment(mr);
+    }
+
+    /* our device might have stronger alignment requirements */
+    if (mdc->get_align) {
+        align = MAX(align, mdc->get_align(md));
+    }
+
+    addr = memory_device_get_free_addr(ms, !addr ? NULL : &addr, align,
+                                       size, errp);
+    if (*errp) {
+        return;
+    }
+    trace_memory_device_assign_address(addr);
+    mdc->set_addr(md, addr);
 
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index d487bb513b..8b1dcb3260 100644
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
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index a661ee49a3..930b6aa6ea 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -2,6 +2,6 @@
 
 # hw/mem/pc-dimm.c
 mhp_pc_dimm_assigned_slot(int slot) "%d"
-mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
 # hw/mem/memory-device.c
+memory_device_assign_address(uint64_t addr) "0x%"PRIx64
 memory_device_unassign_address(uint64_t addr) "0x%"PRIx64
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4b5e4de7da..6bb677c95d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3144,16 +3144,15 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -3595,6 +3594,16 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     Error *local_err = NULL;
 
+    /* first stage hotplug handler */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        memory_device_plug(ms, MEMORY_DEVICE(dev), NULL, &local_err);
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         int node;
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index b8365959e7..a7408597fd 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -53,11 +53,8 @@ MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
 void memory_device_pre_plug(MachineState *ms, const MemoryDeviceState *md,
                             Error **errp);
-uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
-                                     uint64_t align, uint64_t size,
-                                     Error **errp);
-void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
-                               uint64_t addr);
+void memory_device_plug(MachineState *ms, MemoryDeviceState *md,
+                        uint64_t *enforced_align, Error **errp);
 void memory_device_unplug(MachineState *ms, MemoryDeviceState *md);
 
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
