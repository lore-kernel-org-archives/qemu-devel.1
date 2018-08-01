Received: from eggs.gnu.org ([2001:4830:134:3::10]:45287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkrHZ-0006Np-9l
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkrHX-0008FA-Hq
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:35:17 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed,  1 Aug 2018 15:34:44 +0200
Message-Id: <20180801133444.11269-5-david@redhat.com>
In-Reply-To: <20180801133444.11269-1-david@redhat.com>
References: <20180801133444.11269-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/4] pc-dimm: assign and verify the "addr"
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
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, Eric Auger <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>

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
---
 hw/i386/pc.c             | 16 ++++---------
 hw/mem/pc-dimm.c         | 50 +++++++++++++++++++++-------------------
 hw/ppc/spapr.c           |  7 +++---
 include/hw/mem/pc-dimm.h |  6 ++---
 4 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b31610ca63..03148450c8 100644
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
index e56c4daef2..fb6bcaedc4 100644
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
index 4b33e9a08e..6136ec7986 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3150,13 +3150,12 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -3223,7 +3222,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
+    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), NULL, errp);
 }
 
 struct sPAPRDIMMState {
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 7b120416d1..b382eb4303 100644
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
2.17.1
