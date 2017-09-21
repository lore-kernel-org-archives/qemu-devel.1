Received: from eggs.gnu.org ([2001:4830:134:3::10]:45882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dvBAD-0004mM-Qv
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dvBA9-00026i-Oh
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:45:49 -0400
Received: from mail-sn1nam02on0045.outbound.protection.outlook.com
	([104.47.36.45]:5872
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dvBA9-00025f-GT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:45:45 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 21 Sep 2017 16:41:50 -0700
Message-ID: <d2e446ccb46d71bed3191fc97fe1aa6c884ea4ba.1506037164.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506037164.git.alistair.francis@xilinx.com>
References: <cover.1506037164.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 1/2] machine: Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

RFC v2:
 - Rebase on Igor's cpu_type work
 - Use object_class_dynamic_cast()
 - Use a NULL terminated cahr** list
 - Do the check before the machine_class init() is called


 hw/core/machine.c   | 35 +++++++++++++++++++++++++++++++++++
 include/hw/boards.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 80647edc2a..abebfabdb8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -758,6 +758,41 @@ void machine_run_board_init(MachineState *machine)
     if (nb_numa_nodes) {
         machine_numa_finish_init(machine);
     }
+
+    if (machine_class->valid_cpu_types && machine->cpu_type) {
+        int i;
+
+        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
+            ObjectClass *class = object_class_by_name(machine->cpu_type);
+
+            if (!class) {
+                break;
+            }
+
+            if (object_class_dynamic_cast(class,
+                                          machine_class->valid_cpu_types[i])) {
+                /* The user specificed CPU is in the valid field, we are
+                 * good to go.
+                 */
+                goto done;
+            }
+        }
+
+        /* The user specified CPU must not be a valid CPU, print a sane
+         * error
+         */
+        error_report("Invalid CPU: %s", machine->cpu_type);
+        error_printf("The valid options are: %s",
+                     machine_class->valid_cpu_types[0]);
+        for (i = 1; machine_class->valid_cpu_types[i]; i++) {
+            error_printf(", %s", machine_class->valid_cpu_types[i]);
+        }
+        error_printf("\n");
+
+        exit(1);
+    }
+
+done:
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
