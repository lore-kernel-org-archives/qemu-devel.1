Received: from eggs.gnu.org ([2001:4830:134:3::10]:49079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dpO0q-0007TC-HO
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dpO0l-0000OG-Ha
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:16:12 -0400
Received: from mail-by2nam01on0071.outbound.protection.outlook.com
	([104.47.34.71]:28224
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dpO0l-0000Nf-6i
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:16:07 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 5 Sep 2017 17:12:01 -0700
Message-ID: <b2bfe1ee20bd9764572015df0d167d3015036ef0.1504656490.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1504656490.git.alistair.francis@xilinx.com>
References: <cover.1504656490.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 1/2] machine: Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/core/machine.c   | 27 +++++++++++++++++++++++++++
 include/hw/boards.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 41b53a17ad..de0f127d27 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -758,6 +758,33 @@ void machine_run_board_init(MachineState *machine)
         machine_numa_finish_init(machine);
     }
     machine_class->init(machine);
+
+    if (machine_class->valid_cpu_types && machine->cpu_model) {
+        const char *temp;
+        int i, len = machine_class->valid_cpu_types->len;
+
+        for (i = 0; i < len; i++) {
+            temp = g_array_index(machine_class->valid_cpu_types, char *, i);
+            if (!strcmp(machine->cpu_model, temp)) {
+                /* The user specificed CPU is in the valid field, we are
+                 * good to go.
+                 */
+                g_array_free(machine_class->valid_cpu_types, true);
+                return;
+            }
+        }
+        /* The user specified CPU must not be a valid CPU, print a sane error */
+        temp = g_array_index(machine_class->valid_cpu_types, char *, 0);
+        error_report("Invalid CPU: %s", machine->cpu_model);
+        error_printf("The valid options are: %s", temp);
+        for (i = 1; i < len; i++) {
+            temp = g_array_index(machine_class->valid_cpu_types, char *, i);
+            error_printf(", %s", temp);
+        }
+        error_printf("\n");
+        g_array_free(machine_class->valid_cpu_types, true);
+        exit(1);
+    }
 }
 
 static void machine_class_finalize(ObjectClass *klass, void *data)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3363dd19fd..78678f84a9 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -172,6 +172,7 @@ struct MachineClass {
     int minimum_page_bits;
     bool has_hotpluggable_cpus;
     int numa_mem_align_shift;
+    GArray *valid_cpu_types;
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
 
-- 
2.11.0
