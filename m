Received: from eggs.gnu.org ([2001:4830:134:3::10]:38467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjY2-0006Q6-3r
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjY0-0007b7-Ov
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjY0-0007aF-GZ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:07 -0300
Message-Id: <20180507170315.11497-5-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 04/12] pc-dimm: pass in the machine and to the
 MemoryHotplugState
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

We use the machine internally either way, so let's just pass it in then.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-5-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/pc-dimm.h | 4 ++--
 hw/i386/pc.c             | 4 ++--
 hw/mem/pc-dimm.c         | 8 ++++----
 hw/ppc/spapr.c           | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 1d26e13cef..aa5930fbb6 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -84,7 +84,7 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
 uint64_t pc_existing_dimms_capacity(Error **errp);
-void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
+void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
                          uint64_t align, Error **errp);
-void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms);
+void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine);
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e337c6552d..e94e63dc6c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1715,7 +1715,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_plug(dev, MACHINE(pcms)->device_memory, align, &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(pcms), align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1775,7 +1775,7 @@ static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_unplug(dev, MACHINE(pcms)->device_memory);
+    pc_dimm_memory_unplug(dev, MACHINE(pcms));
     object_unparent(OBJECT(dev));
 
  out:
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index aeff369f6f..37b8be80a1 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -36,11 +36,11 @@ typedef struct pc_dimms_capacity {
      Error    **errp;
 } pc_dimms_capacity;
 
-void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
+void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
                          uint64_t align, Error **errp)
 {
     int slot;
-    MachineState *machine = MACHINE(qdev_get_machine());
+    MemoryHotplugState *hpms = machine->device_memory;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
@@ -122,14 +122,14 @@ out:
     error_propagate(errp, local_err);
 }
 
-void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms)
+void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
 
-    memory_region_del_subregion(&hpms->mr, mr);
+    memory_region_del_subregion(&machine->device_memory->mr, mr);
     vmstate_unregister_ram(vmstate_mr, dev);
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d4917e89c6..4576ad63bc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3153,7 +3153,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_memory_plug(dev, MACHINE(ms)->device_memory, align, &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(ms), align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -3174,7 +3174,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     return;
 
 out_unplug:
-    pc_dimm_memory_unplug(dev, MACHINE(ms)->device_memory);
+    pc_dimm_memory_unplug(dev, MACHINE(ms));
 out:
     error_propagate(errp, local_err);
 }
@@ -3311,7 +3311,7 @@ void spapr_lmb_release(DeviceState *dev)
      * Now that all the LMBs have been removed by the guest, call the
      * pc-dimm unplug handler to cleanup up the pc-dimm device.
      */
-    pc_dimm_memory_unplug(dev, MACHINE(spapr)->device_memory);
+    pc_dimm_memory_unplug(dev, MACHINE(spapr));
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
-- 
2.14.3
