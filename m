Received: from eggs.gnu.org ([2001:4830:134:3::10]:41091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehPW9-0005uD-DS
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehPV5-0000Fc-9m
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:47:49 -0500
Received: from mail-sn1nam02on0076.outbound.protection.outlook.com
	([104.47.36.76]:16128
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ehPV4-0000E3-RR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:46:43 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 1 Feb 2018 16:42:05 -0800
Message-ID: <56ba11cee61d769a9a2816fa990d472ab1480906.1517532021.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1517532021.git.alistair.francis@xilinx.com>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 1/6] machine: Convert the valid cpu types to
 use cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org, peter.maydell@linaro.org

As cpu_type is not a user visible string let's convert the
valid_cpu_types to compare against cpu_model instead. This way we have a
user friendly string to report back.

Once we have a cpu_type to cpu_model conversion this patch should be
reverted and we should use cpu_type instead.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/core/machine.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index cdc1163dc6..de5bac1c84 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -776,13 +776,12 @@ void machine_run_board_init(MachineState *machine)
     /* If the machine supports the valid_cpu_types check and the user
      * specified a CPU with -cpu check here that the user CPU is supported.
      */
-    if (machine_class->valid_cpu_types && machine->cpu_type) {
-        ObjectClass *class = object_class_by_name(machine->cpu_type);
+    if (machine_class->valid_cpu_types && machine->cpu_model) {
         int i;
 
         for (i = 0; machine_class->valid_cpu_types[i]; i++) {
-            if (object_class_dynamic_cast(class,
-                                          machine_class->valid_cpu_types[i])) {
+            if (!strcmp(machine->cpu_model,
+                        machine_class->valid_cpu_types[i])) {
                 /* The user specificed CPU is in the valid field, we are
                  * good to go.
                  */
@@ -792,8 +791,8 @@ void machine_run_board_init(MachineState *machine)
 
         if (!machine_class->valid_cpu_types[i]) {
             /* The user specified CPU is not valid */
-            error_report("Invalid CPU type: %s", machine->cpu_type);
-            error_printf("The valid types are: %s",
+            error_report("Invalid CPU model: %s", machine->cpu_model);
+            error_printf("The valid models are: %s",
                          machine_class->valid_cpu_types[0]);
             for (i = 1; machine_class->valid_cpu_types[i]; i++) {
                 error_printf(", %s", machine_class->valid_cpu_types[i]);
-- 
2.14.1
