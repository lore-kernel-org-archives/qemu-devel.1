Received: from eggs.gnu.org ([2001:4830:134:3::10]:50371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUb-0000p5-DA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUa-0003lr-6M
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:50:01 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  3 May 2018 17:49:34 +0200
Message-Id: <20180503154936.18946-7-david@redhat.com>
In-Reply-To: <20180503154936.18946-1-david@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/8] machine: introduce
 enforce_memory_device_align() and add it for pc
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

For compat handling, we'll have to ask the machine class if a certain
memory device has alignment requirements when assigning resource to
a memory device. This will only be required for PC for now, PPC is fine
(and will be handled via the alignment of the memory region).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c        | 15 +++++++++++++++
 include/hw/boards.h |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ffcd7b85d9..9405e28cfa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2332,6 +2332,20 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static void pc_machine_enforce_memory_device_align(const MachineClass *mc,
+                                                   const MemoryDeviceState *md,
+                                                   uint64_t *align)
+{
+    const PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
+
+    if (object_dynamic_cast(OBJECT(md), TYPE_PC_DIMM)) {
+        /* compat handling: force to TARGET_PAGE_SIZE */
+        if (!pcmc->enforce_aligned_dimm) {
+            *align = TARGET_PAGE_SIZE;
+        }
+    }
+}
+
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2371,6 +2385,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = pc_machine_device_unplug_cb;
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+    mc->enforce_memory_device_align = pc_machine_enforce_memory_device_align;
 
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ff5142d7c2..db66f2e2d9 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -9,6 +9,7 @@
 #include "qom/object.h"
 #include "qom/cpu.h"
 #include "hw/resource-handler.h"
+#include "hw/mem/memory-device.h"
 
 /**
  * memory_region_allocate_system_memory - Allocate a board's main memory
@@ -163,6 +164,10 @@ typedef struct {
  *    should instead use "unimplemented-device" for all memory ranges where
  *    the guest will attempt to probe for a device that QEMU doesn't
  *    implement and a stub device is required.
+ * @enforce_memory_device_align:
+ *    For some memory devices (e.g. DIMMs), alignment has to be enforced for
+ *    compat handling by the machine. This function will only modify the
+ *    asignment if it needs to be enforced.
  */
 struct MachineClass {
     /*< private >*/
@@ -221,6 +226,9 @@ struct MachineClass {
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
+    void (*enforce_memory_device_align)(const MachineClass *mc,
+                                        const MemoryDeviceState *md,
+                                        uint64_t *align);
 };
 
 /**
-- 
2.14.3
