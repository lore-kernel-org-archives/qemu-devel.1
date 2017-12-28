Received: from eggs.gnu.org ([2001:4830:134:3::10]:44753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbtz-0006t7-Bj
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbty-0006Z5-5p
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUbtx-0006Xv-P0
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:30 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 28 Dec 2017 18:22:59 +0100
Message-Id: <1514481779-184817-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
References: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 4/4] numa: pc: reset machine if numa config
 has changed in prelaunch time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h |  1 +
 hw/core/machine.c   |  2 +-
 hw/i386/pc.c        |  1 +
 numa.c              | 14 +++++++++++---
 vl.c                |  4 ++++
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 156b16f..9b3ec6a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -62,6 +62,7 @@ MachineClass *find_default_machine(void);
 extern MachineState *current_machine;
 
 void machine_run_board_init(MachineState *machine);
+void machine_numa_finish_init(MachineState *machine);
 bool machine_usb(MachineState *machine);
 bool machine_kernel_irqchip_allowed(MachineState *machine);
 bool machine_kernel_irqchip_required(MachineState *machine);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 212dfec..120b7ca 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -701,7 +701,7 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     return g_string_free(s, false);
 }
 
-static void machine_numa_finish_init(MachineState *machine)
+void machine_numa_finish_init(MachineState *machine)
 {
     int i;
     bool default_mapping;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3fcf318..6c91554 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2244,6 +2244,7 @@ static void pc_machine_reset(void)
     CPUState *cs;
     X86CPU *cpu;
 
+    parse_numa_opts(MACHINE(qdev_get_machine()));
     qemu_devices_reset();
 
     /* Reset APIC after devices have been reset to cancel
diff --git a/numa.c b/numa.c
index fd2bf1c..83eaaea 100644
--- a/numa.c
+++ b/numa.c
@@ -53,7 +53,7 @@ static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
 int nb_numa_nodes;
 bool have_numa_distance;
 NodeInfo numa_info[MAX_NODES];
-
+static bool numa_inited;
 
 static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                             Error **errp)
@@ -173,6 +173,11 @@ void parse_NumaOptions(MachineState *ms, NumaOptions *object, Error **errp)
 {
     Error *err = NULL;
 
+    if (numa_inited && runstate_check(RUN_STATE_PRELAUNCH)) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);
+    }
+    numa_inited = false;
+
     switch (object->type) {
     case NUMA_OPTIONS_TYPE_NODE:
         parse_numa_node(ms, &object->u.node, &err);
@@ -352,9 +357,10 @@ void parse_numa_opts(MachineState *ms)
     int i;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
-        exit(1);
+    if (numa_inited) {
+        return;
     }
+    numa_inited = true;
 
     /*
      * If memory hotplug is enabled (slots > 0) but without '-numa'
@@ -439,6 +445,8 @@ void parse_numa_opts(MachineState *ms)
             /* Validation succeeded, now fill in any missing distances. */
             complete_init_numa_distance();
         }
+
+        machine_numa_finish_init(ms);
     }
 }
 
diff --git a/vl.c b/vl.c
index d3a5c5d..9e00604 100644
--- a/vl.c
+++ b/vl.c
@@ -4690,6 +4690,10 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
+    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa,
+                          current_machine, NULL)) {
+        exit(1);
+    }
     parse_numa_opts(current_machine);
 
     /* parse features once if machine provides default cpu_type */
-- 
2.7.4
