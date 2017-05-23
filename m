Received: from eggs.gnu.org ([2001:4830:134:3::10]:48478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDAxh-0008Jq-8u
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDAxg-0002cT-4z
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:39:01 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 May 2017 16:38:47 +0200
Message-Id: <1495550330-34087-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1495550330-34087-1-git-send-email-imammedo@redhat.com>
References: <1495550330-34087-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] numa: move default mapping init to
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

there is no need use cpu_index_to_instance_props() for setting
default cpu -> node mapping. Generic machine code can do it
without cpu_index by just enabling already preset defaults
in possible_cpus.

PS:
as bonus it makes one less user of cpu_index_to_instance_props()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  - make default_mapping boolean, Eduardo Habkost <ehabkost@redhat.com>
  - redo default mapping detection loop as a combo of
    for/if, Eduardo Habkost <ehabkost@redhat.com>
  - return back lost TODO comment, Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 33 +++++++++++++++++++++++----------
 numa.c            | 26 --------------------------
 2 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index fd6a436..aaf3cff 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -700,26 +700,39 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     return g_string_free(s, false);
 }
 
-static void machine_numa_validate(MachineState *machine)
+static void machine_numa_finish_init(MachineState *machine)
 {
     int i;
+    bool default_mapping;
     GString *s = g_string_new(NULL);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     assert(nb_numa_nodes);
     for (i = 0; i < possible_cpus->len; i++) {
+        if (possible_cpus->cpus[i].props.has_node_id) {
+            break;
+        }
+    }
+    default_mapping = (i == possible_cpus->len);
+
+    for (i = 0; i < possible_cpus->len; i++) {
         const CPUArchId *cpu_slot = &possible_cpus->cpus[i];
 
-        /* at this point numa mappings are initilized by CLI options
-         * or with default mappings so it's sufficient to list
-         * all not yet mapped CPUs here */
-        /* TODO: make it hard error in future */
         if (!cpu_slot->props.has_node_id) {
-            char *cpu_str = cpu_slot_to_string(cpu_slot);
-            g_string_append_printf(s, "%sCPU %d [%s]", s->len ? ", " : "", i,
-                                   cpu_str);
-            g_free(cpu_str);
+            if (default_mapping) {
+                /* fetch default mapping from board and enable it */
+                CpuInstanceProperties props = cpu_slot->props;
+                props.has_node_id = true;
+                machine_set_cpu_numa_node(machine, &props, &error_fatal);
+            } else {
+                /* record slots with not set mapping,
+                 * TODO: make it hard error in future */
+                char *cpu_str = cpu_slot_to_string(cpu_slot);
+                g_string_append_printf(s, "%sCPU %d [%s]",
+                                       s->len ? ", " : "", i, cpu_str);
+                g_free(cpu_str);
+            }
         }
     }
     if (s->len) {
@@ -737,7 +750,7 @@ void machine_run_board_init(MachineState *machine)
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
     if (nb_numa_nodes) {
-        machine_numa_validate(machine);
+        machine_numa_finish_init(machine);
     }
     machine_class->init(machine);
 }
diff --git a/numa.c b/numa.c
index 723f5f8..e30702e 100644
--- a/numa.c
+++ b/numa.c
@@ -427,7 +427,6 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
 void parse_numa_opts(MachineState *ms)
 {
     int i;
-    const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
@@ -485,31 +484,6 @@ void parse_numa_opts(MachineState *ms)
 
         numa_set_mem_ranges();
 
-        /* assign CPUs to nodes using board provided default mapping */
-        if (!mc->cpu_index_to_instance_props || !mc->possible_cpu_arch_ids) {
-            error_report("default CPUs to NUMA node mapping isn't supported");
-            exit(1);
-        }
-
-        possible_cpus = mc->possible_cpu_arch_ids(ms);
-        for (i = 0; i < possible_cpus->len; i++) {
-            if (possible_cpus->cpus[i].props.has_node_id) {
-                break;
-            }
-        }
-
-        /* no CPUs are assigned to NUMA nodes */
-        if (i == possible_cpus->len) {
-            for (i = 0; i < max_cpus; i++) {
-                CpuInstanceProperties props;
-                /* fetch default mapping from board and enable it */
-                props = mc->cpu_index_to_instance_props(ms, i);
-                props.has_node_id = true;
-
-                machine_set_cpu_numa_node(ms, &props, &error_fatal);
-            }
-        }
-
         /* QEMU needs at least all unique node pair distances to build
          * the whole NUMA distance table. QEMU treats the distance table
          * as symmetric by default, i.e. distance A->B == distance B->A.
-- 
2.7.4
