Received: from eggs.gnu.org ([2001:4830:134:3::10]:49043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLlE-0002Am-Ax
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLlC-00008H-Jf
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:23 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Jun 2018 14:16:55 +0200
Message-Id: <20180611121655.19616-12-david@redhat.com>
In-Reply-To: <20180611121655.19616-1-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 11/11] pc-dimm: assign and verify the "slot"
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
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

We can assign and verify the slot before realizing and trying to plug.
reading/writing the slot property should never change, so let's reduce
error handling a bit by using &error_abort.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 995ce22d8d..88423f95a3 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -30,12 +30,25 @@
 void pc_dimm_memory_pre_plug(DeviceState *dev, MachineState *machine,
                              Error **errp)
 {
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
 }
 
 void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
                          uint64_t align, Error **errp)
 {
-    int slot;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
@@ -61,22 +74,6 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
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
 
-- 
2.17.1
