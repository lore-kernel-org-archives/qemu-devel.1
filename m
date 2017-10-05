Received: from eggs.gnu.org ([2001:4830:134:3::10]:48765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0Ct0-0001Uy-5Z
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0Csz-00008Z-4o
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0Csy-00007x-Tf
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:36:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  5 Oct 2017 17:36:33 -0300
Message-Id: <20171005203638.19255-5-ehabkost@redhat.com>
In-Reply-To: <20171005203638.19255-1-ehabkost@redhat.com>
References: <20171005203638.19255-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] machine: Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

This patch add a MachineClass element that can be set in the machine C
code to specify a list of supported CPU types. If the supported CPU
types are specified the user enter CPU (by -cpu at runtime) is checked
against the supported types and QEMU exits if they aren't supported.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <b8474e9d2e0a219d9bac901342f983b13d009301.1507059418.git.alistair.francis@xilinx.com>
[ehabkost: removed assert(), rewrote comment]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h |  1 +
 hw/core/machine.c   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 156e0a5701..191a5b3cd8 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -191,6 +191,7 @@ struct MachineClass {
     bool has_hotpluggable_cpus;
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
+    const char **valid_cpu_types;
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 80647edc2a..36c2fb069c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -758,6 +758,38 @@ void machine_run_board_init(MachineState *machine)
     if (nb_numa_nodes) {
         machine_numa_finish_init(machine);
     }
+
+    /* If the machine supports the valid_cpu_types check and the user
+     * specified a CPU with -cpu check here that the user CPU is supported.
+     */
+    if (machine_class->valid_cpu_types && machine->cpu_type) {
+        ObjectClass *class = object_class_by_name(machine->cpu_type);
+        int i;
+
+        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
+            if (object_class_dynamic_cast(class,
+                                          machine_class->valid_cpu_types[i])) {
+                /* The user specificed CPU is in the valid field, we are
+                 * good to go.
+                 */
+                break;
+            }
+        }
+
+        if (!machine_class->valid_cpu_types[i]) {
+            /* The user specified CPU is not valid */
+            error_report("Invalid CPU type: %s", machine->cpu_type);
+            error_printf("The valid types are: %s",
+                         machine_class->valid_cpu_types[0]);
+            for (i = 1; machine_class->valid_cpu_types[i]; i++) {
+                error_printf(", %s", machine_class->valid_cpu_types[i]);
+            }
+            error_printf("\n");
+
+            exit(1);
+        }
+    }
+
     machine_class->init(machine);
 }
 
-- 
2.13.6
