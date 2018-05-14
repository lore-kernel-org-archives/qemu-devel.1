Received: from eggs.gnu.org ([2001:4830:134:3::10]:59088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAHy-00048d-Pg
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAHx-000585-Hu
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 May 2018 12:00:18 +0200
Message-Id: <20180514100023.12542-14-david@redhat.com>
In-Reply-To: <20180514100023.12542-1-david@redhat.com>
References: <20180514100023.12542-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/18] memory-device: factor out unplug into
 hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>

Let's move the unplug logic into the applicable hotplug handler for pc and
spapr.

We'll move the plug logic next, then this will look more symmetrical in
the hotplug handlers.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c                   | 17 ++++++++++++++++-
 hw/mem/memory-device.c         | 14 ++++++++++++--
 hw/mem/pc-dimm.c               |  2 --
 hw/mem/trace-events            |  2 ++
 hw/ppc/spapr.c                 | 16 +++++++++++++++-
 include/hw/mem/memory-device.h |  2 +-
 6 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 61f1537e14..426fb534c2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2044,6 +2044,12 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
         hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
     }
+
+    if (local_err) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+            memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
+        }
+    }
     error_propagate(errp, local_err);
 }
 
@@ -2080,7 +2086,16 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
         error_setg(&local_err, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
     }
-    error_propagate(errp, local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* first stage hotplug handler */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
+    }
 }
 
 static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index d22c91993f..8f10d613ea 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -17,6 +17,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/vhost.h"
 #include "sysemu/kvm.h"
+#include "trace.h"
 
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
 {
@@ -246,12 +247,21 @@ void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
                                 addr - ms->device_memory->base, mr);
 }
 
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr)
+void memory_device_unplug(MachineState *ms, MemoryDeviceState *md)
 {
-    /* we expect a previous call to memory_device_get_free_addr() */
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    MemoryRegion *mr = mdc->get_memory_region(md);
+
+    /* we expect a previous call to memory_device_pre_plug */
     g_assert(ms->device_memory);
 
+    if (!memory_region_is_mapped(mr)) {
+        return;
+    }
+
     memory_region_del_subregion(&ms->device_memory->mr, mr);
+    trace_memory_device_unassign_address(mdc->get_addr(md));
+    mdc->set_addr(md, 0);
 }
 
 static const TypeInfo memory_device_info = {
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 5e2e3263ab..d487bb513b 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -94,9 +94,7 @@ void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine)
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
 
-    memory_device_unplug_region(machine, mr);
     vmstate_unregister_ram(vmstate_mr, dev);
 }
 
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index e150dcc497..a661ee49a3 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -3,3 +3,5 @@
 # hw/mem/pc-dimm.c
 mhp_pc_dimm_assigned_slot(int slot) "%d"
 mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
+# hw/mem/memory-device.c
+memory_device_unassign_address(uint64_t addr) "0x%"PRIx64
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 562712def2..abdd38a6b5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3621,6 +3621,11 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
         hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
     }
 out:
+    if (local_err) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+            memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
+        }
+    }
     error_propagate(errp, local_err);
 }
 
@@ -3638,7 +3643,16 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
         hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
                                &local_err);
     }
-    error_propagate(errp, local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* first stage hotplug handler */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
+    }
 }
 
 static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 3a4e9edc92..b8365959e7 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -58,6 +58,6 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
                                      Error **errp);
 void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
                                uint64_t addr);
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
+void memory_device_unplug(MachineState *ms, MemoryDeviceState *md);
 
 #endif
-- 
2.14.3
