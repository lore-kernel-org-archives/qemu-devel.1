Received: from eggs.gnu.org ([2001:4830:134:3::10]:42051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXop0-0000uI-Q7
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXoox-0004ZU-Ll
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:52:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 14 Dec 2018 14:51:52 +0000
Message-Id: <20181214145152.27250-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] microbit: make -kernel optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jusual@mail.ru, Joel Stanley <joel@jms.id.au>, jim@groklearning.com, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

ARMv7M machine types support -kernel for ELF and raw image files.
Microbit programs are typically in Intel HEX (.hex) format.  The generic
loader supports .hex files but it doesn't work as expected:

  $ qemu-system-arm -M microbit -device loader,file=3Dmicrobit.hex
  Guest image must be specified (using -kernel)

This error comes from armv7m_load_kernel() but we don't have -kernel in
this case.

This patch makes -kernel optional since most of the time we'll want to
use -device loader instead.

Note that we need to register the reset handler that
armv7m_load_kernel() used to register for us.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/arm/microbit.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index a734e7f650..638f638792 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -14,6 +14,7 @@
 #include "hw/arm/arm.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
+#include "qemu/error-report.h"
=20
 #include "hw/arm/nrf51_soc.h"
=20
@@ -28,6 +29,13 @@ typedef struct {
 #define MICROBIT_MACHINE(obj) \
     OBJECT_CHECK(MicrobitMachineState, obj, TYPE_MICROBIT_MACHINE)
=20
+static void microbit_cpu_reset(void *opaque)
+{
+    ARMCPU *cpu =3D opaque;
+
+    cpu_reset(CPU(cpu));
+}
+
 static void microbit_init(MachineState *machine)
 {
     MicrobitMachineState *s =3D MICROBIT_MACHINE(machine);
@@ -41,8 +49,13 @@ static void microbit_init(MachineState *machine)
                              &error_fatal);
     object_property_set_bool(soc, true, "realized", &error_fatal);
=20
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       NRF51_SOC(soc)->flash_size);
+    if (machine->kernel_filename) {
+        armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+                           NRF51_SOC(soc)->flash_size);
+    } else {
+        /* armv7m_load_kernel() does this, we need to do it manually her=
e */
+        qemu_register_reset(microbit_cpu_reset, ARM_CPU(first_cpu));
+    }
 }
=20
 static void microbit_machine_class_init(ObjectClass *oc, void *data)
--=20
2.19.2
