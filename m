Received: from eggs.gnu.org ([2001:4830:134:3::10]:45432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPg-0000Da-DZ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPf-0002F8-41
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:56 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:45 +0100
Message-Id: <1490189568-167621-21-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 20/23] numa: use possible_cpus for not
 mapped CPUs check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

and remove corresponding part in numa.c that uses
node_cpu bitmaps.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
It's one more less user of node_cpu bitmpas, following
commit will remove the last user along with
node_cpu itself.
---
 hw/core/machine.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 numa.c            | 10 ----------
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index d284a63..ab51d2c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -19,6 +19,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
+#include "sysemu/numa.h"
 
 static char *machine_get_accel(Object *obj, Error **errp)
 {
@@ -643,9 +644,66 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
 
+static char *cpu_slot_to_string(const CPUArchId *cpu)
+{
+    GString *s = g_string_new(NULL);
+    if (cpu->props.has_socket_id) {
+        g_string_append_printf(s, "socket-id: %"PRId64, cpu->props.socket_id);
+    }
+    if (cpu->props.has_core_id) {
+        if (s->len) {
+            g_string_append_printf(s, ", ");
+        }
+        g_string_append_printf(s, "core-id: %"PRId64, cpu->props.core_id);
+    }
+    if (cpu->props.has_thread_id) {
+        if (s->len) {
+            g_string_append_printf(s, ", ");
+        }
+        g_string_append_printf(s, "thread-id: %"PRId64, cpu->props.thread_id);
+    }
+    return g_string_free(s, false);
+}
+
+static void machine_numa_validate(MachineState *machine)
+{
+    int i;
+    GString *s = g_string_new(NULL);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
+
+    assert(nb_numa_nodes);
+    for (i = 0; i < possible_cpus->len; i++) {
+        const CPUArchId *cpu_slot = &possible_cpus->cpus[i];
+
+        /* at this point numa mappings are initilized by CLI options
+         * or with default mappings so it's sufficient to list
+         * all not yet mapped CPUs here */
+        /* TODO: make it hard error in future */
+        if (!cpu_slot->props.has_node_id) {
+            char *cpu_str = cpu_slot_to_string(cpu_slot);
+            g_string_append_printf(s, "%sCPU %d [%s]", s->len ? ", " : "", i,
+                                   cpu_str);
+            g_free(cpu_str);
+        }
+    }
+    if (s->len) {
+        error_report("warning: CPU(s) not present in any NUMA nodes: %s",
+                     s->str);
+        error_report("warning: All CPU(s) up to maxcpus should be described "
+                     "in NUMA config, ability to start up with partial NUMA "
+                     "mappings is obsoleted and will be removed in future");
+    }
+    g_string_free(s, true);
+}
+
 void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
+
+    if (nb_numa_nodes) {
+        machine_numa_validate(machine);
+    }
     machine_class->init(machine);
 }
 
diff --git a/numa.c b/numa.c
index 8461c96..523558f 100644
--- a/numa.c
+++ b/numa.c
@@ -293,16 +293,6 @@ static void validate_numa_cpus(void)
         bitmap_or(seen_cpus, seen_cpus,
                   numa_info[i].node_cpu, max_cpus);
     }
-
-    if (!bitmap_full(seen_cpus, max_cpus)) {
-        char *msg;
-        bitmap_complement(seen_cpus, seen_cpus, max_cpus);
-        msg = enumerate_cpus(seen_cpus, max_cpus);
-        error_report("warning: CPU(s) not present in any NUMA nodes: %s", msg);
-        error_report("warning: All CPU(s) up to maxcpus should be described "
-                     "in NUMA config");
-        g_free(msg);
-    }
     g_free(seen_cpus);
 }
 
-- 
2.7.4
