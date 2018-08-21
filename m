Received: from eggs.gnu.org ([2001:4830:134:3::10]:33955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4v-0002Pl-PX
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0007Bs-4P
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:23 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:53041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4j-00070n-IN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:17 -0400
Received: by mail-wm0-x22e.google.com with SMTP id y139-v6so855125wmc.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:33 +0200
Message-Id: <1534870966-9287-62-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 61/74] pc-dimm: assign and verify the "addr"
 property during pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

We can assign and verify the address before realizing and trying to plug.
reading/writing the address property should never fail for DIMMs, so let's
reduce error handling a bit by using &error_abort. Getting access to the
memory region now might however fail. So forward errors from
get_memory_region() properly.

As all memory devices should use the alignment of the underlying memory
region for guest physical address asignment, do detection of the
alignment in pc_dimm_pre_plug(), but allow pc.c to overwrite the
alignment for compatibility handling.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180801133444.11269-5-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c             | 16 +++++-----------
 hw/mem/pc-dimm.c         | 50 +++++++++++++++++++++++++-----------------------
 hw/ppc/spapr.c           |  7 +++----
 include/hw/mem/pc-dimm.h |  6 +++---
 4 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b31610c..0314845 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1679,7 +1679,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
     const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
+    const uint64_t legacy_align = TARGET_PAGE_SIZE;
 
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
@@ -1697,7 +1699,8 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
+    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev),
+                     pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
 }
 
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
@@ -1706,18 +1709,9 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
-    uint64_t align = TARGET_PAGE_SIZE;
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    if (pcmc->enforce_aligned_dimm) {
-        align = memory_region_get_alignment(mr);
-    }
-
-    pc_dimm_plug(dev, MACHINE(pcms), align, &local_err);
+    pc_dimm_plug(dev, MACHINE(pcms), &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index e56c4da..fb6bcae 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -29,9 +29,14 @@
 
 static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
-void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp)
+void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
+                      const uint64_t *legacy_align, Error **errp)
 {
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     Error *local_err = NULL;
+    MemoryRegion *mr;
+    uint64_t addr, align;
     int slot;
 
     slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
@@ -43,44 +48,41 @@ void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp)
     }
     object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &error_abort);
     trace_mhp_pc_dimm_assigned_slot(slot);
+
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    align = legacy_align ? *legacy_align : memory_region_get_alignment(mr);
+    addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
+                                    &error_abort);
+    addr = memory_device_get_free_addr(machine, !addr ? NULL : &addr, align,
+                                       memory_region_size(mr), &local_err);
+    if (local_err) {
+        goto out;
+    }
+    trace_mhp_pc_dimm_assigned_address(addr);
+    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP,
+                             &error_abort);
 out:
     error_propagate(errp, local_err);
 }
 
-void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
-                  Error **errp)
+void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
-    Error *local_err = NULL;
     uint64_t addr;
 
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
+    addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
+                                    &error_abort);
 
     memory_device_plug_region(machine, mr, addr);
     vmstate_register_ram(vmstate_mr, dev);
-
-out:
-    error_propagate(errp, local_err);
 }
 
 void pc_dimm_unplug(DeviceState *dev, MachineState *machine)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 96468dc..a70704a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3164,13 +3164,12 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
-    uint64_t align, size, addr;
+    uint64_t size, addr;
     uint32_t node;
 
-    align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_plug(dev, MACHINE(ms), align, &local_err);
+    pc_dimm_plug(dev, MACHINE(ms), &local_err);
     if (local_err) {
         goto out;
     }
@@ -3237,7 +3236,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
+    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), NULL, errp);
 }
 
 struct sPAPRDIMMState {
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 7b12041..b382eb4 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -79,8 +79,8 @@ typedef struct PCDIMMDeviceClass {
                                                Error **errp);
 } PCDIMMDeviceClass;
 
-void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp);
-void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
-                  Error **errp);
+void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
+                      const uint64_t *legacy_align, Error **errp);
+void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp);
 void pc_dimm_unplug(DeviceState *dev, MachineState *machine);
 #endif
-- 
1.8.3.1
