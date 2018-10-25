Received: from eggs.gnu.org ([2001:4830:134:3::10]:58019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfni-00032c-Cy
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfng-0000B9-QQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:35:50 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:38 -0300
Message-Id: <20181025133301.16578-21-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 20/43] pc-dimm: pass PCDIMMDevice to
 pc_dimm_.*plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

We're plugging/unplugging a PCDIMMDevice, so directly pass this type
instead of a more generic DeviceState.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181005092024.14344-5-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/pc-dimm.h |  6 +++---
 hw/i386/pc.c             |  6 +++---
 hw/mem/pc-dimm.c         | 24 +++++++++++-------------
 hw/ppc/spapr.c           |  8 ++++----
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index b382eb4303..99cbd54de7 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -79,8 +79,8 @@ typedef struct PCDIMMDeviceClass {
                                                Error **errp);
 } PCDIMMDeviceClass;
 
-void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
+void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp);
-void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp);
-void pc_dimm_unplug(DeviceState *dev, MachineState *machine);
+void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp);
+void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine);
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index eab8572f2a..f095725dba 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1704,7 +1704,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev),
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
 }
 
@@ -1716,7 +1716,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    pc_dimm_plug(dev, MACHINE(pcms), &local_err);
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
     if (local_err) {
         goto out;
     }
@@ -1776,7 +1776,7 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_unplug(dev, MACHINE(pcms));
+    pc_dimm_unplug(PC_DIMM(dev), MACHINE(pcms));
     object_unparent(OBJECT(dev));
 
  out:
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index fb6bcaedc4..f46fb7ada2 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -29,24 +29,24 @@
 
 static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
-void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
+void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp)
 {
-    PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     Error *local_err = NULL;
     MemoryRegion *mr;
     uint64_t addr, align;
     int slot;
 
-    slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
+    slot = object_property_get_int(OBJECT(dimm), PC_DIMM_SLOT_PROP,
                                    &error_abort);
     slot = pc_dimm_get_free_slot(slot == PC_DIMM_UNASSIGNED_SLOT ? NULL : &slot,
                                  machine->ram_slots, &local_err);
     if (local_err) {
         goto out;
     }
-    object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &error_abort);
+    object_property_set_int(OBJECT(dimm), slot, PC_DIMM_SLOT_PROP,
+                            &error_abort);
     trace_mhp_pc_dimm_assigned_slot(slot);
 
     mr = ddc->get_memory_region(dimm, &local_err);
@@ -55,7 +55,7 @@ void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
     }
 
     align = legacy_align ? *legacy_align : memory_region_get_alignment(mr);
-    addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
+    addr = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
                                     &error_abort);
     addr = memory_device_get_free_addr(machine, !addr ? NULL : &addr, align,
                                        memory_region_size(mr), &local_err);
@@ -63,38 +63,36 @@ void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
         goto out;
     }
     trace_mhp_pc_dimm_assigned_address(addr);
-    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP,
+    object_property_set_uint(OBJECT(dimm), addr, PC_DIMM_ADDR_PROP,
                              &error_abort);
 out:
     error_propagate(errp, local_err);
 }
 
-void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp)
+void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
 {
-    PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     uint64_t addr;
 
-    addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
+    addr = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
                                     &error_abort);
 
     memory_device_plug_region(machine, mr, addr);
-    vmstate_register_ram(vmstate_mr, dev);
+    vmstate_register_ram(vmstate_mr, DEVICE(dimm));
 }
 
-void pc_dimm_unplug(DeviceState *dev, MachineState *machine)
+void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine)
 {
-    PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
 
     memory_device_unplug_region(machine, mr);
-    vmstate_unregister_ram(vmstate_mr, dev);
+    vmstate_unregister_ram(vmstate_mr, DEVICE(dimm));
 }
 
 static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 98868d893a..c078347b66 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3135,7 +3135,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     size = memory_region_size(mr);
 
-    pc_dimm_plug(dev, MACHINE(ms), &local_err);
+    pc_dimm_plug(dimm, MACHINE(ms), &local_err);
     if (local_err) {
         goto out;
     }
@@ -3158,7 +3158,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     return;
 
 out_unplug:
-    pc_dimm_unplug(dev, MACHINE(ms));
+    pc_dimm_unplug(dimm, MACHINE(ms));
 out:
     error_propagate(errp, local_err);
 }
@@ -3202,7 +3202,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), NULL, errp);
 }
 
 struct sPAPRDIMMState {
@@ -3314,7 +3314,7 @@ static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
-    pc_dimm_unplug(dev, MACHINE(hotplug_dev));
+    pc_dimm_unplug(PC_DIMM(dev), MACHINE(hotplug_dev));
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
-- 
2.18.0.rc1.1.g3f1ff2140
