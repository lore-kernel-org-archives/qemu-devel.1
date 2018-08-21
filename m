Received: from eggs.gnu.org ([2001:4830:134:3::10]:33972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4y-0002Sd-5K
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0007E9-VJ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4o-0006xI-Fe
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:18 -0400
Received: by mail-wr1-x429.google.com with SMTP id g33-v6so6432166wrd.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:30 +0200
Message-Id: <1534870966-9287-59-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 58/74] pc-dimm: assign and verify the "slot"
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

We can assign and verify the slot before realizing and trying to plug.
reading/writing the slot property should never fail, so let's reduce
error handling a bit by using &error_abort.

To do this during pre_plug, add and use (x86, ppc) pc_dimm_pre_plug().

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180801133444.11269-2-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c             |  2 ++
 hw/mem/pc-dimm.c         | 35 ++++++++++++++++++-----------------
 hw/ppc/spapr.c           |  9 ++++++++-
 include/hw/mem/pc-dimm.h |  1 +
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 83a4444..96be77f 100644
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
index 65843bc..e56c4da 100644
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
index ab9c04e..96468dc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3205,6 +3205,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    Error *local_err = NULL;
     MemoryRegion *mr;
     uint64_t size;
     Object *memdev;
@@ -3230,7 +3231,13 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
index 26ebb7d..7b12041 100644
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
1.8.3.1
