Received: from eggs.gnu.org ([2001:4830:134:3::10]:46645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHDTr-0000ma-JX
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHDTo-0006c8-4l
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:45:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 29 Oct 2018 19:45:19 +0000
Message-Id: <20181029194519.15628-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] microbit: do not rely on -kernel option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jusual@mail.ru, Joel Stanley <joel@jms.id.au>, jim@groklearning.com, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Microbit programs are typically in Intel HEX (.hex) format.  The generic
loader supports .hex files but it doesn't work as expected:

  $ qemu-system-arm -M microbit -device loader,file=microbit.hex
  Guest image must be specified (using -kernel)

This error comes from armv7m_load_kernel().  Don't try to use it.

Note that we need to register the reset handler that
armv7m_load_kernel() used to register for us.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/arm/microbit.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index e7d74116a5..c4263c05c0 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -13,6 +13,7 @@
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
+#include "qemu/error-report.h"
 
 #include "hw/arm/nrf51_soc.h"
 
@@ -27,6 +28,13 @@ typedef struct {
 #define MICROBIT_MACHINE(obj) \
     OBJECT_CHECK(MicrobitMachineState, obj, TYPE_MICROBIT_MACHINE)
 
+static void microbit_cpu_reset(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    cpu_reset(CPU(cpu));
+}
+
 static void microbit_init(MachineState *machine)
 {
     MicrobitMachineState *s = MICROBIT_MACHINE(machine);
@@ -39,8 +47,12 @@ static void microbit_init(MachineState *machine)
                              &error_fatal);
     object_property_set_bool(soc, true, "realized", &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       NRF51_SOC(soc)->flash_size);
+    if (machine->kernel_filename) {
+        error_report("-device loader,file=<filename> must be used instead of -kernel");
+        exit(1);
+    }
+
+    qemu_register_reset(microbit_cpu_reset, ARM_CPU(first_cpu));
 }
 
 static void microbit_machine_class_init(ObjectClass *oc, void *data)
-- 
2.17.2
