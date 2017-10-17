Received: from eggs.gnu.org ([2001:4830:134:3::10]:41690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e4aSU-0003yo-Hm
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e4aSR-0000iU-Ek
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:35:34 -0400
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com
	([104.47.32.62]:57760
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e4aSR-0000hT-7Y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:35:31 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 17 Oct 2017 15:31:19 -0700
Message-ID: <7d590a446dfe29a1815c3cad2a93f7d6b0d8a214.1508279421.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1508279421.git.alistair.francis@xilinx.com>
References: <cover.1508279421.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/5] xlnx-zcu102: Specify the valid CPUs
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

List all possible valid CPU options.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

An implementation for single CPU machines is still being discussed. A
solution proposed by Eduardo is this:

1) Change the default on TYPE_MACHINE to:
     mc->valid_cpu_types = { TYPE_CPU, NULL };

   This will keep the existing behavior for all boards.

2) mc->valid_cpu_types=NULL be interpreted as "no CPU model
   except the default is accepted" or "-cpu is not accepted" in
   machine_run_board_init() (I prefer the former, but both
   options would be correct)

3) Boards like xlnx_zynqmp could then just do this:

   static void xxx_class_init(...) {
       mc->default_cpu_type = MY_CPU_TYPE;
       /* Reason: XXX_init() is hardcoded to MY_CPU_TYPE */
       mc->valid_cpu_types = NULL;
   }

V3:
 - Make variable static
V2:
 - Don't use the users -cpu
 - Fixup allignment

 hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 519a16ed98..d5a5425356 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -160,6 +160,11 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
     arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
 }
 
+static const char *xlnx_zynqmp_valid_cpus[] = {
+                                            ARM_CPU_TYPE_NAME("cortex-a53"),
+                                            NULL
+                                              };
+
 static void xlnx_ep108_init(MachineState *machine)
 {
     XlnxZCU102 *s = EP108_MACHINE(machine);
@@ -185,6 +190,12 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
+     * users a sane error if they specify a different CPU, but we never
+     * use their CPU choice.
+     */
+    mc->valid_cpu_types = xlnx_zynqmp_valid_cpus;
 }
 
 static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
@@ -240,6 +251,12 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
+     * users a sane error if they specify a different CPU, but we never
+     * use their CPU choice.
+     */
+    mc->valid_cpu_types = xlnx_zynqmp_valid_cpus;
 }
 
 static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
-- 
2.11.0
