Received: from eggs.gnu.org ([2001:4830:134:3::10]:44898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgOw-0007zc-5b
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgOs-00020W-4M
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:10 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:35 +0100
Message-Id: <1490189568-167621-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 10/23] numa: mirror cpu to node
 mapping in MachineState::possible_cpus
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

Introduce machine_set_cpu_numa_node() helper that stores
node mapping for CPU in MachineState::possible_cpus.
CPU and node it belongs to is specified by 'props' argument.

Patch doesn't remove old way of storing mapping in
numa_info[X].node_cpu as removing it at the same time
makes patch rather big. Instead it just mirrors mapping
in possible_cpus and follow up per target patches will
switch to possible_cpus and numa_info[X].node_cpu will
be removed once there isn't any users left.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h |  2 ++
 hw/core/machine.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 numa.c              |  8 +++++++
 3 files changed, 78 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 1dd0fde..40f30f1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -42,6 +42,8 @@ bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
 void machine_register_compat_props(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
+void machine_set_cpu_numa_node(MachineState *machine,
+                               CpuInstanceProperties *props, Error **errp);
 
 /**
  * CPUArchId:
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0d92672..6ff0b45 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -388,6 +388,74 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
     return head;
 }
 
+void machine_set_cpu_numa_node(MachineState *machine,
+                               CpuInstanceProperties *props, Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    bool match = false;
+    int i;
+
+    if (!mc->possible_cpu_arch_ids) {
+        error_setg(errp, "mapping of CPUs to NUMA node is not supported");
+        return;
+    }
+
+    /* force board to initialize possible_cpus if it hasn't been done yet */
+    mc->possible_cpu_arch_ids(machine);
+
+    for (i = 0; i < machine->possible_cpus->len; i++) {
+        CPUArchId *slot = &machine->possible_cpus->cpus[i];
+
+        /* reject unsupported by board properties */
+        if (props->has_thread_id && !slot->props.has_thread_id) {
+            error_setg(errp, "thread-id is not supported");
+            return;
+        }
+
+        if (props->has_core_id && !slot->props.has_core_id) {
+            error_setg(errp, "core-id is not supported");
+            return;
+        }
+
+        if (props->has_socket_id && !slot->props.has_socket_id) {
+            error_setg(errp, "socket-id is not supported");
+            return;
+        }
+
+        /* skip slots with explicit mismatch */
+        if (props->has_thread_id && props->thread_id != slot->props.thread_id) {
+                continue;
+        }
+
+        if (props->has_core_id && props->core_id != slot->props.core_id) {
+                continue;
+        }
+
+        if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
+                continue;
+        }
+
+        /* reject assignment if slot is already assigned, for compatibility
+         * of legacy cpu_index mapping with SPAPR core based mapping do not
+         * error out if cpu thread and matched core have the same node-id */
+        if (slot->props.has_node_id &&
+            slot->props.node_id != props->node_id) {
+            error_setg(errp, "CPU is already assigned to node-id: %" PRId64,
+                       slot->props.node_id);
+            return;
+        }
+
+        /* assign slot to node as it's matched '-numa cpu' key */
+        match = true;
+        slot->props.node_id = props->node_id;
+        slot->props.has_node_id = props->has_node_id;
+    }
+
+    if (!match) {
+        error_setg(errp, "no match found");
+    }
+}
+
 static void machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/numa.c b/numa.c
index 24c596d..44057f1 100644
--- a/numa.c
+++ b/numa.c
@@ -169,6 +169,7 @@ static void numa_node_parse(MachineState *ms, NumaNodeOptions *node,
         exit(1);
     }
     for (cpus = node->cpus; cpus; cpus = cpus->next) {
+        CpuInstanceProperties props;
         if (cpus->value >= max_cpus) {
             error_setg(errp,
                        "CPU index (%" PRIu16 ")"
@@ -177,6 +178,10 @@ static void numa_node_parse(MachineState *ms, NumaNodeOptions *node,
             return;
         }
         bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
+        props = mc->cpu_index_to_instance_props(ms, cpus->value);
+        props.node_id = nodenr;
+        props.has_node_id = true;
+        machine_set_cpu_numa_node(ms, &props, &error_fatal);
     }
 
     if (node->has_mem && node->has_memdev) {
@@ -393,9 +398,12 @@ void parse_numa_opts(MachineState *ms)
         if (i == nb_numa_nodes) {
             for (i = 0; i < max_cpus; i++) {
                 CpuInstanceProperties props;
+                /* fetch default mapping from board and enable it */
                 props = mc->cpu_index_to_instance_props(ms, i);
+                props.has_node_id = true;
 
                 set_bit(i, numa_info[props.node_id].node_cpu);
+                machine_set_cpu_numa_node(ms, &props, &error_fatal);
             }
         }
 
-- 
2.7.4
