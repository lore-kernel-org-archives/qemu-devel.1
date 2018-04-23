Received: from eggs.gnu.org ([2001:4830:134:3::10]:49624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAegy-0007VH-3T
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAegx-00086i-1x
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:51:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 23 Apr 2018 18:51:19 +0200
Message-Id: <20180423165126.15441-5-david@redhat.com>
In-Reply-To: <20180423165126.15441-1-david@redhat.com>
References: <20180423165126.15441-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/11] pc-dimm: pass in the machine and to
 the MemoryHotplugState
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

We use the machine internally either way, so let's just pass it in then.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c             | 4 ++--
 hw/mem/pc-dimm.c         | 8 ++++----
 hw/ppc/spapr.c           | 6 +++---
 include/hw/mem/pc-dimm.h | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c14dec492b..4b2ede9029 100644
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
index 8c13d165b4..8ecb716f72 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3044,7 +3044,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_memory_plug(dev, MACHINE(ms)->device_memory, align, &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(ms), align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -3065,7 +3065,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     return;
 
 out_unplug:
-    pc_dimm_memory_unplug(dev, MACHINE(ms)->device_memory);
+    pc_dimm_memory_unplug(dev, MACHINE(ms));
 out:
     error_propagate(errp, local_err);
 }
@@ -3202,7 +3202,7 @@ void spapr_lmb_release(DeviceState *dev)
      * Now that all the LMBs have been removed by the guest, call the
      * pc-dimm unplug handler to cleanup up the pc-dimm device.
      */
-    pc_dimm_memory_unplug(dev, MACHINE(spapr)->device_memory);
+    pc_dimm_memory_unplug(dev, MACHINE(spapr));
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
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
-- 
2.14.3
