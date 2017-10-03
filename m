Received: from eggs.gnu.org ([2001:4830:134:3::10]:49206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dzTV8-0000Hn-VW
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dzTV5-0006OS-P6
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:09:10 -0400
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com
	([104.47.38.52]:56111
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dzTV5-0006OF-IT
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:09:07 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 3 Oct 2017 13:05:09 -0700
Message-ID: <b8474e9d2e0a219d9bac901342f983b13d009301.1507059418.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1507059418.git.alistair.francis@xilinx.com>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/5] machine: Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org

This patch add a MachineClass element that can be set in the machine C
code to specify a list of supported CPU types. If the supported CPU
types are specified the user enter CPU (by -cpu at runtime) is checked
against the supported types and QEMU exits if they aren't supported.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

V1:
 - Use 'type' in the error message
 - Move a uneeded operation out of the for loop
 - Remove the goto
RFC v2:
 - Rebase on Igor's cpu_type work
 - Use object_class_dynamic_cast()
 - Use a NULL terminated cahr** list
 - Do the check before the machine_class init() is called


 hw/core/machine.c   | 35 +++++++++++++++++++++++++++++++++++
 include/hw/boards.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 80647edc2a..3afc6a7b5b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -758,6 +758,41 @@ void machine_run_board_init(MachineState *machine)
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
+        /* machine->cpu_type is supposed to be always a valid QOM type */
+        assert(class);
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
+            /* The user specified CPU must not be a valid CPU */
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
 
-- 
2.11.0
