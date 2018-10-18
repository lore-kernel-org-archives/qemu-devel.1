Received: from eggs.gnu.org ([2001:4830:134:3::10]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEbQ-0003Ay-1s
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEbP-0003QF-1g
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:04:10 -0300
Message-Id: <20181018200422.4358-34-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 33/45] memory-device: trace when
 pre_plugging/plugging/unplugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's trace the address and the id of a memory device when
pre_plugging/plugging/unplugging succeeded.

Trace it when pre_plugging as well as when plugging, so we really know
when a specific address is actually used.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181005092024.14344-17-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/mem/memory-device.c | 8 ++++++++
 hw/mem/pc-dimm.c       | 8 --------
 hw/mem/trace-events    | 5 ++++-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 30585d6148..7de1ccd497 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -17,6 +17,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/vhost.h"
 #include "sysemu/kvm.h"
+#include "trace.h"
 
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
 {
@@ -269,6 +270,10 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
         goto out;
     }
     mdc->set_addr(md, addr, &local_err);
+    if (!local_err) {
+        trace_memory_device_pre_plug(DEVICE(md)->id ? DEVICE(md)->id : "",
+                                     addr);
+    }
 out:
     error_propagate(errp, local_err);
 }
@@ -288,6 +293,7 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
 
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
+    trace_memory_device_plug(DEVICE(md)->id ? DEVICE(md)->id : "", addr);
 }
 
 void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
@@ -303,6 +309,8 @@ void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
     g_assert(ms->device_memory);
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
+    trace_memory_device_unplug(DEVICE(md)->id ? DEVICE(md)->id : "",
+                               mdc->get_addr(md));
 }
 
 uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 6c854139a7..0c9b9e8292 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -33,7 +33,6 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp)
 {
     Error *local_err = NULL;
-    uint64_t addr;
     int slot;
 
     slot = object_property_get_int(OBJECT(dimm), PC_DIMM_SLOT_PROP,
@@ -49,13 +48,6 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
 
     memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, legacy_align,
                            &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    addr = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
-                                    &error_abort);
-    trace_mhp_pc_dimm_assigned_address(addr);
 out:
     error_propagate(errp, local_err);
 }
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index e150dcc497..0f2f278ff2 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -2,4 +2,7 @@
 
 # hw/mem/pc-dimm.c
 mhp_pc_dimm_assigned_slot(int slot) "%d"
-mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
+# hw/mem/memory-device.c
+memory_device_pre_plug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
+memory_device_plug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
+memory_device_unplug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
-- 
2.18.0.rc1.1.g3f1ff2140
