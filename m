Received: from eggs.gnu.org ([2001:4830:134:3::10]:38428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjY0-0006OZ-67
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjXz-0007ZT-0e
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjXy-0007Yq-Pb
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:06 -0300
Message-Id: <20180507170315.11497-4-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/12] pc-dimm: no need to pass the memory region
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

We can just query it ourselves. When unplugging, we should always be
able to the region (as it was previously plugged). E.g. PPC already
assumed that and used &error_abort.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-4-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/pc-dimm.h |  5 ++---
 hw/i386/pc.c             | 13 ++-----------
 hw/mem/pc-dimm.c         | 12 +++++++++---
 hw/ppc/spapr.c           |  9 +++------
 4 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 8bda37adab..1d26e13cef 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -85,7 +85,6 @@ int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
 uint64_t pc_existing_dimms_capacity(Error **errp);
 void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
-                         MemoryRegion *mr, uint64_t align, Error **errp);
-void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
-                           MemoryRegion *mr);
+                         uint64_t align, Error **errp);
+void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms);
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0aa7885798..e337c6552d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1715,8 +1715,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_plug(dev, MACHINE(pcms)->device_memory, mr, align,
-                        &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(pcms)->device_memory, align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1766,17 +1765,9 @@ static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
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
 
@@ -1784,7 +1775,7 @@ static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_unplug(dev, MACHINE(pcms)->device_memory, mr);
+    pc_dimm_memory_unplug(dev, MACHINE(pcms)->device_memory);
     object_unparent(OBJECT(dev));
 
  out:
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index ef330628c1..aeff369f6f 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -37,7 +37,7 @@ typedef struct pc_dimms_capacity {
 } pc_dimms_capacity;
 
 void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
-                         MemoryRegion *mr, uint64_t align, Error **errp)
+                         uint64_t align, Error **errp)
 {
     int slot;
     MachineState *machine = MACHINE(qdev_get_machine());
@@ -46,8 +46,14 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
     Error *local_err = NULL;
     uint64_t existing_dimms_capacity = 0;
+    MemoryRegion *mr;
     uint64_t addr;
 
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
     addr = object_property_get_uint(OBJECT(dimm),
                                     PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
@@ -116,12 +122,12 @@ out:
     error_propagate(errp, local_err);
 }
 
-void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
-                           MemoryRegion *mr)
+void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
 
     memory_region_del_subregion(&hpms->mr, mr);
     vmstate_unregister_ram(vmstate_mr, dev);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 30d634a8a3..d4917e89c6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3153,7 +3153,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_memory_plug(dev, MACHINE(ms)->device_memory, mr, align, &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(ms)->device_memory, align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -3174,7 +3174,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     return;
 
 out_unplug:
-    pc_dimm_memory_unplug(dev, MACHINE(ms)->device_memory, mr);
+    pc_dimm_memory_unplug(dev, MACHINE(ms)->device_memory);
 out:
     error_propagate(errp, local_err);
 }
@@ -3292,9 +3292,6 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
 void spapr_lmb_release(DeviceState *dev)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
-    PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     /* This information will get lost if a migration occurs
@@ -3314,7 +3311,7 @@ void spapr_lmb_release(DeviceState *dev)
      * Now that all the LMBs have been removed by the guest, call the
      * pc-dimm unplug handler to cleanup up the pc-dimm device.
      */
-    pc_dimm_memory_unplug(dev, MACHINE(spapr)->device_memory, mr);
+    pc_dimm_memory_unplug(dev, MACHINE(spapr)->device_memory);
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
-- 
2.14.3
