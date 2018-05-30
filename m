Received: from eggs.gnu.org ([2001:4830:134:3::10]:46118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9w-0004Ui-BK
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9v-0008Tj-Bf
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOA9v-0008TP-4D
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:18 -0300
Message-Id: <20180530230528.30166-3-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/12] numa: postpone options post-processing
 till machine_run_board_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

in preparation for numa options to being handled via QMP before
machine_run_board_init(), move final numa configuration checks
and processing to machine_run_board_init() so it could take into
account both CLI (via parse_numa_opts()) and QMP input

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1525423069-61903-2-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h |  1 +
 hw/core/machine.c     |  5 +++--
 numa.c                | 13 ++++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index d99e5474b4..21713b7e2f 100644
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
index 2040177664..617e5f8d75 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -737,7 +737,7 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     return g_string_free(s, false);
 }
 
-static void machine_numa_finish_init(MachineState *machine)
+static void machine_numa_finish_cpu_init(MachineState *machine)
 {
     int i;
     bool default_mapping;
@@ -792,7 +792,8 @@ void machine_run_board_init(MachineState *machine)
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
     if (nb_numa_nodes) {
-        machine_numa_finish_init(machine);
+        numa_complete_configuration(machine);
+        machine_numa_finish_cpu_init(machine);
     }
 
     /* If the machine supports the valid_cpu_types check and the user
diff --git a/numa.c b/numa.c
index efc78b2f17..ad1d7934f2 100644
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
2.17.1
