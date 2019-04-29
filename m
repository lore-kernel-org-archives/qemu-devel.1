Received: from eggs.gnu.org ([209.51.188.92]:52815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyvE-00076O-Im
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyvD-0005n7-A4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:48 -0400
Received: from mail-oln040092255063.outbound.protection.outlook.com
	([40.92.255.63]:54848
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hKyvC-0005lA-Tz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:47 -0400
From: Alistair Francis <alistair@alistair23.me>
Date: Mon, 29 Apr 2019 05:33:38 +0000
Message-ID: <PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1556515687.git.alistair@alistair23.me>
In-Reply-To: <cover.1556515687.git.alistair@alistair23.me>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 MAINTAINERS                     |  6 +++
 default-configs/arm-softmmu.mak |  1 +
 hw/arm/Kconfig                  |  3 ++
 hw/arm/Makefile.objs            |  1 +
 hw/arm/netduinoplus2.c          | 77 +++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+)
 create mode 100644 hw/arm/netduinoplus2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c9772735cf..9b0af5a0b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -817,6 +817,12 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/netduino2.c
=20
+Netduino Plus 2
+M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: hw/arm/netduinoplus2.c
+
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index e079f10624..1e2c82f201 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -46,6 +46,7 @@ CONFIG_A15MPCORE=3Dy
=20
 CONFIG_ARM_V7M=3Dy
 CONFIG_NETDUINO2=3Dy
+CONFIG_NETDUINOPLUS2=3Dy
=20
 CONFIG_ARM_GIC=3Dy
 CONFIG_ARM_TIMER=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3a98bce15a..13fc779308 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -26,6 +26,9 @@ config MUSICPAL
 config NETDUINO2
     bool
=20
+config NETDUINOPLUS2
+    bool
+
 config NSERIES
     bool
=20
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 36c3ff54c3..1f216f4d93 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -8,6 +8,7 @@ obj-$(CONFIG_INTEGRATOR) +=3D integratorcp.o
 obj-$(CONFIG_MAINSTONE) +=3D mainstone.o
 obj-$(CONFIG_MUSICPAL) +=3D musicpal.o
 obj-$(CONFIG_NETDUINO2) +=3D netduino2.o
+obj-$(CONFIG_NETDUINOPLUS2) +=3D netduinoplus2.o
 obj-$(CONFIG_NSERIES) +=3D nseries.o
 obj-$(CONFIG_OMAP) +=3D omap_sx1.o palm.o
 obj-$(CONFIG_PXA2XX) +=3D gumstix.o spitz.o tosa.o z2.o
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
new file mode 100644
index 0000000000..1f585cf09f
--- /dev/null
+++ b/hw/arm/netduinoplus2.c
@@ -0,0 +1,77 @@
+/*
+ * Netduino Plus 2 Machine Model
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "qemu/error-report.h"
+#include "hw/arm/stm32f405_soc.h"
+#include "hw/arm/arm.h"
+
+typedef struct ARMV7MResetArgs {
+    ARMCPU *cpu;
+    uint32_t reset_sp;
+    uint32_t reset_pc;
+} ARMV7MResetArgs;
+
+static void armv7m_reset(void *opaque)
+{
+    ARMV7MResetArgs *args =3D opaque;
+
+    cpu_reset(CPU(args->cpu));
+
+    args->cpu->env.regs[13] =3D args->reset_sp & 0xFFFFFFFC;
+    args->cpu->env.thumb =3D args->reset_pc & 1;
+    args->cpu->env.regs[15] =3D args->reset_pc & ~1;
+}
+
+static void netduinoplus2_init(MachineState *machine)
+{
+    DeviceState *dev;
+    ARMV7MResetArgs reset_args;
+    uint64_t entry;
+
+    dev =3D qdev_create(NULL, TYPE_STM32F405_SOC);
+    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+                       FLASH_SIZE, &entry);
+
+    reset_args =3D (ARMV7MResetArgs) {
+        .cpu =3D ARM_CPU(first_cpu),
+        .reset_pc =3D entry,
+        .reset_sp =3D (SRAM_BASE_ADDRESS + (SRAM_SIZE * 2) / 3),
+    };
+    qemu_register_reset(armv7m_reset,
+                        g_memdup(&reset_args, sizeof(reset_args)));
+}
+
+static void netduinoplus2_machine_init(MachineClass *mc)
+{
+    mc->desc =3D "Netduino Plus 2 Machine";
+    mc->init =3D netduinoplus2_init;
+}
+
+DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
--=20
2.21.0
