Received: from eggs.gnu.org ([2001:4830:134:3::10]:49316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWQ-0004Ks-A8
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWP-0001YO-7u
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:19:50 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWP-0001XN-1c
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:19:49 -0500
Received: by mail-wr0-x242.google.com with SMTP id v111so18788059wrb.3
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 13:19:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 18:19:13 -0300
Message-Id: <20180305211928.466-8-f4bug@amsat.org>
In-Reply-To: <20180305211928.466-1-f4bug@amsat.org>
References: <20180305211928.466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 07/22] hw/isa/superio: Add a Super I/O
 template based on the PC87312 device
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
 include/hw/isa/superio.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 hw/isa/isa-superio.c     | 27 +++++++++++++++++++++++++++
 hw/isa/Makefile.objs     |  1 +
 3 files changed, 72 insertions(+)
 create mode 100644 include/hw/isa/superio.h
 create mode 100644 hw/isa/isa-superio.c

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
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
new file mode 100644
index 0000000000..7777f8b9f0
--- /dev/null
+++ b/hw/isa/isa-superio.c
@@ -0,0 +1,27 @@
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
+};
+
+static void isa_superio_register_types(void)
+{
+    type_register_static(&isa_superio_type_info);
+}
+
+type_init(isa_superio_register_types)
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
-- 
2.16.2
