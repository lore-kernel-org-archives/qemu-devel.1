Received: from eggs.gnu.org ([2001:4830:134:3::10]:45120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkrHK-0006Br-GX
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkrHJ-00086l-DK
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:35:02 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed,  1 Aug 2018 15:34:41 +0200
Message-Id: <20180801133444.11269-2-david@redhat.com>
In-Reply-To: <20180801133444.11269-1-david@redhat.com>
References: <20180801133444.11269-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/4] pc-dimm: assign and verify the "slot"
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

We can assign and verify the slot before realizing and trying to plug.
reading/writing the slot property should never fail, so let's reduce
error handling a bit by using &error_abort.

To do this during pre_plug, add and use (x86, ppc) pc_dimm_pre_plug().

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c             |  2 ++
 hw/mem/pc-dimm.c         | 35 ++++++++++++++++++-----------------
 hw/ppc/spapr.c           |  9 ++++++++-
 include/hw/mem/pc-dimm.h |  1 +
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 83a444472b..96be77f0dd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1696,6 +1696,8 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
         return;
     }
+
+    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
 }
 
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 65843bc52a..e56c4daef2 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -29,10 +29,27 @@
 
 static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
+void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp)
+{
+    Error *local_err = NULL;
+    int slot;
+
+    slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
+                                   &error_abort);
+    slot = pc_dimm_get_free_slot(slot == PC_DIMM_UNASSIGNED_SLOT ? NULL : &slot,
+                                 machine->ram_slots, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &error_abort);
+    trace_mhp_pc_dimm_assigned_slot(slot);
+out:
+    error_propagate(errp, local_err);
+}
+
 void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
                   Error **errp)
 {
-    int slot;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
@@ -59,22 +76,6 @@ void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
     }
     trace_mhp_pc_dimm_assigned_address(addr);
 
-    slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    slot = pc_dimm_get_free_slot(slot == PC_DIMM_UNASSIGNED_SLOT ? NULL : &slot,
-                                 machine->ram_slots, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    trace_mhp_pc_dimm_assigned_slot(slot);
-
     memory_device_plug_region(machine, mr, addr);
     vmstate_register_ram(vmstate_mr, dev);
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 421b2dd09b..4b33e9a08e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3191,6 +3191,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    Error *local_err = NULL;
     MemoryRegion *mr;
     uint64_t size;
     Object *memdev;
@@ -3216,7 +3217,13 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     memdev = object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,
                                       &error_abort);
     pagesize = host_memory_backend_pagesize(MEMORY_BACKEND(memdev));
-    spapr_check_pagesize(spapr, pagesize, errp);
+    spapr_check_pagesize(spapr, pagesize, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
 }
 
 struct sPAPRDIMMState {
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 26ebb7d5e9..7b120416d1 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -79,6 +79,7 @@ typedef struct PCDIMMDeviceClass {
                                                Error **errp);
 } PCDIMMDeviceClass;
 
+void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp);
 void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
                   Error **errp);
 void pc_dimm_unplug(DeviceState *dev, MachineState *machine);
-- 
2.17.1
