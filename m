Received: from eggs.gnu.org ([2001:4830:134:3::10]:58470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiW-0006BW-9e
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiV-0003zn-1x
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:24 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiU-0003yj-Nk
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:22 -0400
Received: by mail-wr0-x243.google.com with SMTP id o8so2598942wra.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:58 +0100
Message-Id: <20180313224719.4954-49-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 48/69] hw/isa/superio: Add the SMC FDC37C669
 Super I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-23-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                |   1 +
 hw/isa/Makefile.objs       |   2 +-
 hw/isa/smc37c669-superio.c | 115 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/isa/superio.h   |   1 +
 4 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 hw/isa/smc37c669-superio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b17324107f..216d01efd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -416,6 +416,7 @@ Alpha Machines
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: hw/alpha/
+F: hw/isa/smc37c669-superio.c
 
 ARM Machines
 ------------
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index cac655ba58..83e06f6c04 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -1,5 +1,5 @@
 common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
-common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
+common-obj-$(CONFIG_ISA_BUS) += isa-superio.o smc37c669-superio.o
 common-obj-$(CONFIG_APM) += apm.o
 common-obj-$(CONFIG_I82378) += i82378.o
 common-obj-$(CONFIG_PC87312) += pc87312.o
diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
new file mode 100644
index 0000000000..aa233c6967
--- /dev/null
+++ b/hw/isa/smc37c669-superio.c
@@ -0,0 +1,115 @@
+/*
+ * SMC FDC37C669 Super I/O controller
+ *
+ * Copyright (c) 2018 Philippe Mathieu-Daudé
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/isa/superio.h"
+
+/* UARTs (compatible with NS16450 or PC16550) */
+
+static bool is_serial_enabled(ISASuperIODevice *sio, uint8_t index)
+{
+    return index < 2;
+}
+
+static uint16_t get_serial_iobase(ISASuperIODevice *sio, uint8_t index)
+{
+    return index ? 0x2f8 : 0x3f8;
+}
+
+static unsigned int get_serial_irq(ISASuperIODevice *sio, uint8_t index)
+{
+    return index ? 3 : 4;
+}
+
+/* Parallel port */
+
+static bool is_parallel_enabled(ISASuperIODevice *sio, uint8_t index)
+{
+    return index < 1;
+}
+
+static uint16_t get_parallel_iobase(ISASuperIODevice *sio, uint8_t index)
+{
+    return 0x3bc;
+}
+
+static unsigned int get_parallel_irq(ISASuperIODevice *sio, uint8_t index)
+{
+    return 7;
+}
+
+static unsigned int get_parallel_dma(ISASuperIODevice *sio, uint8_t index)
+{
+    return 3;
+}
+
+/* Diskette controller (Software compatible with the Intel PC8477) */
+
+static bool is_fdc_enabled(ISASuperIODevice *sio, uint8_t index)
+{
+    return index < 1;
+}
+
+static uint16_t get_fdc_iobase(ISASuperIODevice *sio, uint8_t index)
+{
+    return 0x3f0;
+}
+
+static unsigned int get_fdc_irq(ISASuperIODevice *sio, uint8_t index)
+{
+    return 6;
+}
+
+static unsigned int get_fdc_dma(ISASuperIODevice *sio, uint8_t index)
+{
+    return 2;
+}
+
+static void smc37c669_class_init(ObjectClass *klass, void *data)
+{
+    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
+
+    sc->parallel = (ISASuperIOFuncs){
+        .count = 1,
+        .is_enabled = is_parallel_enabled,
+        .get_iobase = get_parallel_iobase,
+        .get_irq    = get_parallel_irq,
+        .get_dma    = get_parallel_dma,
+    };
+    sc->serial = (ISASuperIOFuncs){
+        .count = 2,
+        .is_enabled = is_serial_enabled,
+        .get_iobase = get_serial_iobase,
+        .get_irq    = get_serial_irq,
+    };
+    sc->floppy = (ISASuperIOFuncs){
+        .count = 1,
+        .is_enabled = is_fdc_enabled,
+        .get_iobase = get_fdc_iobase,
+        .get_irq    = get_fdc_irq,
+        .get_dma    = get_fdc_dma,
+    };
+    sc->ide.count = 0;
+}
+
+static const TypeInfo smc37c669_type_info = {
+    .name          = TYPE_SMC37C669_SUPERIO,
+    .parent        = TYPE_ISA_SUPERIO,
+    .instance_size = sizeof(ISASuperIODevice),
+    .class_size    = sizeof(ISASuperIOClass),
+    .class_init    = smc37c669_class_init,
+};
+
+static void smc37c669_register_types(void)
+{
+    type_register_static(&smc37c669_type_info);
+}
+
+type_init(smc37c669_register_types)
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index b47aac3cf8..f9ba29aa30 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -55,5 +55,6 @@ typedef struct ISASuperIOClass {
 } ISASuperIOClass;
 
 #define TYPE_FDC37M81X_SUPERIO  "fdc37m81x-superio"
+#define TYPE_SMC37C669_SUPERIO  "smc37c669-superio"
 
 #endif /* HW_ISA_SUPERIO_H */
-- 
2.14.3
