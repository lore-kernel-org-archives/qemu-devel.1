Received: from eggs.gnu.org ([2001:4830:134:3::10]:38164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVE-0003Bb-Bm
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVB-0008De-IL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:41 +1100
Message-Id: <20170222063348.32176-37-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 36/43] change CPUArchId.cpu type to Object*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

so it could be reused for SPAPR cores as well

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/acpi/cpu.c       | 2 +-
 hw/i386/pc.c        | 8 ++++----
 include/hw/boards.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 6017ca0..8c719d3 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -198,7 +198,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     state->dev_count = id_list->len;
     state->devs = g_new0(typeof(*state->devs), state->dev_count);
     for (i = 0; i < id_list->len; i++) {
-        state->devs[i].cpu =  id_list->cpus[i].cpu;
+        state->devs[i].cpu =  CPU(id_list->cpus[i].cpu);
         state->devs[i].arch_id = id_list->cpus[i].arch_id;
     }
     memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, state,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3475174..138022d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1830,7 +1830,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
     }
 
     found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
-    found_cpu->cpu = CPU(dev);
+    found_cpu->cpu = OBJECT(dev);
 out:
     error_propagate(errp, local_err);
 }
@@ -2288,13 +2288,13 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
 {
     int i;
-    CPUState *cpu;
+    Object *cpu;
     HotpluggableCPUList *head = NULL;
     const char *cpu_type;
 
     cpu = machine->possible_cpus->cpus[0].cpu;
     assert(cpu); /* BSP is always present */
-    cpu_type = object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(cpu)));
+    cpu_type = object_get_typename(cpu);
 
     for (i = 0; i < machine->possible_cpus->len; i++) {
         HotpluggableCPUList *list_item = g_new0(typeof(*list_item), 1);
@@ -2308,7 +2308,7 @@ static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
         cpu = machine->possible_cpus->cpus[i].cpu;
         if (cpu) {
             cpu_item->has_qom_path = true;
-            cpu_item->qom_path = object_get_canonical_path(OBJECT(cpu));
+            cpu_item->qom_path = object_get_canonical_path(cpu);
         }
 
         list_item->value = cpu_item;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 4023b38..60209df 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -51,7 +51,7 @@ void machine_register_compat_props(MachineState *machine);
 typedef struct {
     uint64_t arch_id;
     CpuInstanceProperties props;
-    struct CPUState *cpu;
+    Object *cpu;
 } CPUArchId;
 
 /**
-- 
2.9.3
