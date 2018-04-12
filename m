Received: from eggs.gnu.org ([2001:4830:134:3::10]:56860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f6YOZ-0002tz-Ic
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f6YOV-00077k-GR
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:19:54 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 Apr 2018 11:19:35 +0200
Message-Id: <20180412091936.32446-3-david@redhat.com>
In-Reply-To: <20180412091936.32446-1-david@redhat.com>
References: <20180412091936.32446-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/3] machine: make MemoryHotplugState
 accessible via the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Markus Armbruster --cc=qemu-ppc @ nongnu . org" <armbru@redhat.com>, David Hildenbrand <david@redhat.com>

Let's allow to query the MemoryHotplugState from the machine.

This allows us to generically detect if a certain machine has support
for memory devices, and to generically manage it (find free address
range, plug/unplug a memory region).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c             | 12 ++++++++++++
 hw/ppc/spapr.c           | 12 ++++++++++++
 include/hw/boards.h      | 16 ++++++++++++++++
 include/hw/mem/pc-dimm.h | 12 +-----------
 4 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d36bac8c89..fa8862af33 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2337,6 +2337,17 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static MemoryHotplugState *pc_machine_get_memory_hotplug_state(MachineState *ms)
+{
+    PCMachineState *pcms = PC_MACHINE(ms);
+
+    if (!pcms->hotplug_memory.base) {
+        /* hotplug not supported */
+        return NULL;
+    }
+    return &pcms->hotplug_memory;
+}
+
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2376,6 +2387,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = pc_machine_device_unplug_cb;
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+    mc->get_memory_hotplug_state = pc_machine_get_memory_hotplug_state;
 
     object_class_property_add(oc, PC_MACHINE_MEMHP_REGION_SIZE, "int",
         pc_machine_get_hotplug_memory_region_size, NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ea93c5de08..0a6528a421 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3867,6 +3867,17 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
     return NULL;
 }
 
+static MemoryHotplugState *spapr_get_memory_hotplug_state(MachineState *ms)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
+
+    if (!spapr->hotplug_memory.base) {
+        /* hotplug not supported */
+        return NULL;
+    }
+    return &spapr->hotplug_memory;
+}
+
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -3926,6 +3937,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      * in which LMBs are represented and hot-added
      */
     mc->numa_mem_align_shift = 28;
+    mc->get_memory_hotplug_state = spapr_get_memory_hotplug_state;
 
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a609239112..447bdc7219 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -105,6 +105,17 @@ typedef struct {
     CPUArchId cpus[0];
 } CPUArchIdList;
 
+/**
+ * MemoryHotplugState:
+ * @base: address in guest physical address space where hotplug memory
+ * address space begins.
+ * @mr: hotplug memory address space container
+ */
+typedef struct MemoryHotplugState {
+    hwaddr base;
+    MemoryRegion mr;
+} MemoryHotplugState;
+
 /**
  * MachineClass:
  * @max_cpus: maximum number of CPUs supported. Default: 1
@@ -156,6 +167,10 @@ typedef struct {
  *    should instead use "unimplemented-device" for all memory ranges where
  *    the guest will attempt to probe for a device that QEMU doesn't
  *    implement and a stub device is required.
+ * @get_memory_hotplug_state:
+ *    If a machine support memory hotplug, the returned data ontains
+ *    information about the portion of guest physical address space
+ *    where memory devices can be mapped to (e.g. to hotplug a pc-dimm).
  */
 struct MachineClass {
     /*< private >*/
@@ -212,6 +227,7 @@ struct MachineClass {
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
+    MemoryHotplugState *(*get_memory_hotplug_state)(MachineState *ms);
 };
 
 /**
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index e88073321f..8bda37adab 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -19,6 +19,7 @@
 #include "exec/memory.h"
 #include "sysemu/hostmem.h"
 #include "hw/qdev.h"
+#include "hw/boards.h"
 
 #define TYPE_PC_DIMM "pc-dimm"
 #define PC_DIMM(obj) \
@@ -75,17 +76,6 @@ typedef struct PCDIMMDeviceClass {
     MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
 } PCDIMMDeviceClass;
 
-/**
- * MemoryHotplugState:
- * @base: address in guest physical address space where hotplug memory
- * address space begins.
- * @mr: hotplug memory address space container
- */
-typedef struct MemoryHotplugState {
-    hwaddr base;
-    MemoryRegion mr;
-} MemoryHotplugState;
-
 uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
                                uint64_t address_space_size,
                                uint64_t *hint, uint64_t align, uint64_t size,
-- 
2.14.3
