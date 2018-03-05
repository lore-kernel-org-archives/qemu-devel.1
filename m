Received: from eggs.gnu.org ([2001:4830:134:3::10]:49635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWl-0004jI-9b
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWk-0001pS-8R
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:11 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWj-0001oN-Vk
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:10 -0500
Received: by mail-wm0-x241.google.com with SMTP id t6so18389535wmt.5
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 13:20:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 18:19:25 -0300
Message-Id: <20180305211928.466-20-f4bug@amsat.org>
In-Reply-To: <20180305211928.466-1-f4bug@amsat.org>
References: <20180305211928.466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 19/22] hw/isa/superio: Add the SMC
 FDC37C669 Super I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/superio.h   |   1 +
 hw/isa/smc37c669-superio.c | 115 +++++++++++++++++++++++++++++++++++++++++++++
 hw/isa/Makefile.objs       |   2 +-
 3 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 hw/isa/smc37c669-superio.c

diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index b47aac3cf8..f9ba29aa30 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -55,5 +55,6 @@ typedef struct ISASuperIOClass {
 } ISASuperIOClass;
 
 #define TYPE_FDC37M81X_SUPERIO  "fdc37m81x-superio"
+#define TYPE_SMC37C669_SUPERIO  "smc37c669-superio"
 
 #endif /* HW_ISA_SUPERIO_H */
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
-- 
2.16.2
