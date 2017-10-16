Received: from eggs.gnu.org ([2001:4830:134:3::10]:33982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48An-0004Yc-IR
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48Ak-000710-A1
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e48Ak-00070C-1i
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:22 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 16 Oct 2017 18:22:51 +0200
Message-Id: <1508170976-96869-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 1/6] numa: postpone options post-processing till
 machine_run_board_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

in preparation for numa options to being handled via QMP before
machine_run_board_init(), move final numa configuration checks
and processing to machine_run_board_init() so it could take into
account both CLI (via parse_numa_opts()) and QMP input

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/sysemu/numa.h |  1 +
 hw/core/machine.c     |  5 +++--
 numa.c                | 13 ++++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 5c6df28..c19e456 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -31,6 +31,7 @@ struct NumaNodeMem {
 
 extern NodeInfo numa_info[MAX_NODES];
 void parse_numa_opts(MachineState *ms);
+void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
 extern QemuOptsList qemu_numa_opts;
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 80647ed..f482211 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -701,7 +701,7 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     return g_string_free(s, false);
 }
 
-static void machine_numa_finish_init(MachineState *machine)
+static void machine_numa_finish_cpu_init(MachineState *machine)
 {
     int i;
     bool default_mapping;
@@ -756,7 +756,8 @@ void machine_run_board_init(MachineState *machine)
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
     if (nb_numa_nodes) {
-        machine_numa_finish_init(machine);
+        numa_complete_configuration(machine);
+        machine_numa_finish_cpu_init(machine);
     }
     machine_class->init(machine);
 }
diff --git a/numa.c b/numa.c
index 8d78d95..18af4ff 100644
--- a/numa.c
+++ b/numa.c
@@ -424,15 +424,11 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
     nodes[i].node_mem = size - usedmem;
 }
 
-void parse_numa_opts(MachineState *ms)
+void numa_complete_configuration(MachineState *ms)
 {
     int i;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
-        exit(1);
-    }
-
     assert(max_numa_nodeid <= MAX_NODES);
 
     /* No support for sparse NUMA node IDs yet: */
@@ -508,6 +504,13 @@ void parse_numa_opts(MachineState *ms)
     }
 }
 
+void parse_numa_opts(MachineState *ms)
+{
+    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
+        exit(1);
+    }
+}
+
 void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
 {
     int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
-- 
2.7.4
