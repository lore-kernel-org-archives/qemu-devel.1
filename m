Received: from eggs.gnu.org ([2001:4830:134:3::10]:46437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUvS4-0006r8-5E
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUvS0-0004lu-7M
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:48:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Jun 2018 16:48:00 +0200
Message-Id: <20180618144800.555-5-david@redhat.com>
In-Reply-To: <20180618144800.555-1-david@redhat.com>
References: <20180618144800.555-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/4] pc-dimm: assign and verify the "addr"
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
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

We can assign and verify the slot before realizing and trying to plug.
reading/writing the address property should never fail, so let's reduce
error handling a bit by using &error_abort. Getting access to the memory
region now might however fail. So forward errors from
get_memory_region() properly.

Keep tracing the assigned address for now in the plug code, as that's the
point we are sure plugging succeeded and the address willa ctually be
used.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9198104d34..42c4d0b750 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -31,7 +31,11 @@ static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
 void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp)
 {
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     Error *local_err = NULL;
+    uint64_t align, addr;
+    MemoryRegion *mr;
     int slot;
 
     slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
@@ -43,6 +47,22 @@ void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp)
     }
     object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &error_abort);
     trace_mhp_pc_dimm_assigned_slot(slot);
+
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    align = memory_device_get_align(machine, mr);
+
+    addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
+                                    &error_abort);
+    addr = memory_device_get_free_addr(machine, !addr ? NULL : &addr, align,
+                                       memory_region_size(mr), &local_err);
+    if (local_err) {
+        goto out;
+    }
+    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP,
+                             &error_abort);
 out:
     error_propagate(errp, local_err);
 }
@@ -54,33 +74,14 @@ void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp)
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
-    const uint64_t align = memory_device_get_align(machine, mr);
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
+    addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
+                                    &error_abort);
     trace_mhp_pc_dimm_assigned_address(addr);
 
     memory_device_plug_region(machine, mr, addr);
     vmstate_register_ram(vmstate_mr, dev);
-
-out:
-    error_propagate(errp, local_err);
 }
 
 void pc_dimm_unplug(DeviceState *dev, MachineState *machine)
-- 
2.17.1
