Received: from eggs.gnu.org ([2001:4830:134:3::10]:35166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wt-0004nC-66
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Ws-00028M-9k
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2Ws-000289-1Z
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:10 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:16 +0200
Message-Id: <20180829153624.12299-13-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/20] memory-device: trace when
 pre_assigning/assigning/unassigning addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

Let's trace the address when pre_pluggin/plugging/unplugging a memory device.

Trace it when pre_plugging as well as when plugging, so we really know
when a specific address is actually used.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 6 ++++++
 hw/mem/pc-dimm.c       | 8 --------
 hw/mem/trace-events    | 5 ++++-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 5f62eb6a94..a31ba73ea7 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -17,6 +17,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/vhost.h"
 #include "sysemu/kvm.h"
+#include "trace.h"
 
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
 {
@@ -274,6 +275,9 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
         goto out;
     }
     mdc->set_addr(md, addr, &local_err);
+    if (!local_err) {
+        trace_memory_device_pre_assign_address(addr);
+    }
 out:
     error_propagate(errp, local_err);
 }
@@ -290,6 +294,7 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
 
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
+    trace_memory_device_assign_address(addr);
 }
 
 void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
@@ -302,6 +307,7 @@ void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
     g_assert(ms->device_memory);
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
+    trace_memory_device_unassign_address(mdc->get_addr(md));
 }
 
 static const TypeInfo memory_device_info = {
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 634335f984..732b3b8a1d 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -33,7 +33,6 @@ void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp)
 {
     Error *local_err = NULL;
-    uint64_t addr;
     int slot;
 
     slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
@@ -48,13 +47,6 @@ void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
 
     memory_device_pre_plug(MEMORY_DEVICE(dev), machine, legacy_align,
                            &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
-                                    &error_abort);
-    trace_mhp_pc_dimm_assigned_address(addr);
 out:
     error_propagate(errp, local_err);
 }
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index e150dcc497..b40482077e 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -2,4 +2,7 @@
 
 # hw/mem/pc-dimm.c
 mhp_pc_dimm_assigned_slot(int slot) "%d"
-mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
+# hw/mem/memory-device.c
+memory_device_pre_assign_address(uint64_t addr) "0x%"PRIx64
+memory_device_assign_address(uint64_t addr) "0x%"PRIx64
+memory_device_unassign_address(uint64_t addr) "0x%"PRIx64
-- 
2.17.1
