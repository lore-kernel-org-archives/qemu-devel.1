Received: from eggs.gnu.org ([2001:4830:134:3::10]:58225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiE-0005vf-Kc
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiD-0003bN-DS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:06 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiD-0003a4-5v
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:05 -0400
Received: by mail-wm0-x241.google.com with SMTP id u10so668643wmu.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:44 +0100
Message-Id: <20180313224719.4954-35-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 34/69] hw/isa/superio: Add a Super I/O template
 based on the PC87312 device
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
Message-Id: <20180308223946.26784-9-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS              |  2 ++
 hw/isa/Makefile.objs     |  1 +
 hw/isa/isa-superio.c     | 28 ++++++++++++++++++++++++++++
 include/hw/isa/superio.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 hw/isa/isa-superio.c
 create mode 100644 include/hw/isa/superio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ff22ce610..9f7b8e79c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -933,6 +933,7 @@ F: hw/input/pckbd.c
 F: hw/intc/apic*
 F: hw/intc/ioapic*
 F: hw/intc/i8259*
+F: hw/isa/isa-superio.c
 F: hw/misc/debugexit.c
 F: hw/misc/pc-testdev.c
 F: hw/timer/hpet*
@@ -944,6 +945,7 @@ F: include/hw/char/parallel.h
 F: include/hw/dma/i8257.h
 F: include/hw/i2c/pm_smbus.h
 F: include/hw/input/i8042.h
+F: include/hw/isa/superio.h
 F: include/hw/timer/hpet.h
 F: include/hw/timer/i8254*
 F: include/hw/timer/mc146818rtc*
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index fb37c55cf2..cac655ba58 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -1,4 +1,5 @@
 common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
+common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
 common-obj-$(CONFIG_APM) += apm.o
 common-obj-$(CONFIG_I82378) += i82378.o
 common-obj-$(CONFIG_PC87312) += pc87312.o
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
new file mode 100644
index 0000000000..14ec16f831
--- /dev/null
+++ b/hw/isa/isa-superio.c
@@ -0,0 +1,28 @@
+/*
+ * Generic ISA Super I/O
+ *
+ * Copyright (c) 2010-2012 Herve Poussineau
+ * Copyright (c) 2011-2012 Andreas Färber
+ * Copyright (c) 2018 Philippe Mathieu-Daudé
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "hw/isa/superio.h"
+#include "trace.h"
+
+static const TypeInfo isa_superio_type_info = {
+    .name = TYPE_ISA_SUPERIO,
+    .parent = TYPE_ISA_DEVICE,
+    .abstract = true,
+    .class_size = sizeof(ISASuperIOClass),
+};
+
+static void isa_superio_register_types(void)
+{
+    type_register_static(&isa_superio_type_info);
+}
+
+type_init(isa_superio_register_types)
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
new file mode 100644
index 0000000000..cff6ad6c08
--- /dev/null
+++ b/include/hw/isa/superio.h
@@ -0,0 +1,44 @@
+/*
+ * Generic ISA Super I/O
+ *
+ * Copyright (c) 2018 Philippe Mathieu-Daudé
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_ISA_SUPERIO_H
+#define HW_ISA_SUPERIO_H
+
+#include "qemu-common.h"
+#include "sysemu/sysemu.h"
+#include "hw/isa/isa.h"
+
+#define TYPE_ISA_SUPERIO "isa-superio"
+#define ISA_SUPERIO(obj) \
+    OBJECT_CHECK(ISASuperIODevice, (obj), TYPE_ISA_SUPERIO)
+#define ISA_SUPERIO_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(ISASuperIOClass, (obj), TYPE_ISA_SUPERIO)
+#define ISA_SUPERIO_CLASS(klass) \
+    OBJECT_CLASS_CHECK(ISASuperIOClass, (klass), TYPE_ISA_SUPERIO)
+
+typedef struct ISASuperIODevice {
+    ISADevice parent_obj;
+} ISASuperIODevice;
+
+typedef struct ISASuperIOFuncs {
+    size_t count;
+    bool (*is_enabled)(ISASuperIODevice *sio, uint8_t index);
+    uint16_t (*get_iobase)(ISASuperIODevice *sio, uint8_t index);
+    unsigned int (*get_irq)(ISASuperIODevice *sio, uint8_t index);
+    unsigned int (*get_dma)(ISASuperIODevice *sio, uint8_t index);
+} ISASuperIOFuncs;
+
+typedef struct ISASuperIOClass {
+    /*< private >*/
+    ISADeviceClass parent_class;
+    /*< public >*/
+    DeviceRealize parent_realize;
+} ISASuperIOClass;
+
+#endif /* HW_ISA_SUPERIO_H */
-- 
2.14.3
