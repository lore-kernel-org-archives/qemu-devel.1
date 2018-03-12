Received: from eggs.gnu.org ([2001:4830:134:3::10]:48197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFk-0007BC-Rh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFi-00055b-GV
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1evNFi-00054W-BA
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:34 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 12 Mar 2018 14:11:07 +0100
Message-Id: <1520860275-101576-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/9] numa: postpone options post-processing
 till machine_run_board_init()
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
v2:
  - remove duplicate qemu_opts_foreach() in numa_complete_configuration()
    that was causing non explicitly IDed node "-numa node" parsed twice.
---
 include/sysemu/numa.h |  1 +
 hw/core/machine.c     |  5 +++--
 numa.c                | 13 ++++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index d99e547..21713b7 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -23,6 +23,7 @@ struct NumaNodeMem {
 
 extern NodeInfo numa_info[MAX_NODES];
 void parse_numa_opts(MachineState *ms);
+void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
 extern QemuOptsList qemu_numa_opts;
 void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5e2bbcd..e1d9482 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -715,7 +715,7 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     return g_string_free(s, false);
 }
 
-static void machine_numa_finish_init(MachineState *machine)
+static void machine_numa_finish_cpu_init(MachineState *machine)
 {
     int i;
     bool default_mapping;
@@ -770,7 +770,8 @@ void machine_run_board_init(MachineState *machine)
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
     if (nb_numa_nodes) {
-        machine_numa_finish_init(machine);
+        numa_complete_configuration(machine);
+        machine_numa_finish_cpu_init(machine);
     }
 
     /* If the machine supports the valid_cpu_types check and the user
diff --git a/numa.c b/numa.c
index 398e2c9..126c649 100644
--- a/numa.c
+++ b/numa.c
@@ -338,15 +338,11 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
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
     /*
      * If memory hotplug is enabled (slots > 0) but without '-numa'
      * options explicitly on CLI, guestes will break.
@@ -433,6 +429,13 @@ void parse_numa_opts(MachineState *ms)
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
