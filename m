Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSJ-0006gk-G5
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSI-0002MB-IU
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:31 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSI-0002Lz-EU
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:30 -0500
Received: by mail-qt0-x243.google.com with SMTP id g9so12060521qth.9
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:35 -0300
Message-Id: <20180108024558.17983-7-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/29] hw/isa: add a generic isa_superio_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/superio.h | 17 +++++++++++++++++
 hw/isa/isa-superio.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS              |  2 ++
 hw/isa/Makefile.objs     |  1 +
 4 files changed, 65 insertions(+)
 create mode 100644 include/hw/isa/superio.h
 create mode 100644 hw/isa/isa-superio.c

diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
new file mode 100644
index 0000000000..e685b96653
--- /dev/null
+++ b/include/hw/isa/superio.h
@@ -0,0 +1,17 @@
+/*
+ * Generic ISA Super I/O
+ *
+ * Copyright (c) 2018 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef HW_ISA_SUPERIO_H
+#define HW_ISA_SUPERIO_H
+
+#include "hw/isa/isa.h"
+
+ISADevice *isa_superio_init(ISABus *isa_bus, int serial_count,
+                            int parallel_count, int drive_count);
+
+#endif
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
new file mode 100644
index 0000000000..93d8457c6b
--- /dev/null
+++ b/hw/isa/isa-superio.c
@@ -0,0 +1,45 @@
+/*
+ * Generic ISA Super I/O
+ *
+ * Copyright (c) 2018 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/blockdev.h"
+#include "hw/isa/superio.h"
+#include "hw/char/serial.h"
+#include "hw/char/parallel.h"
+#include "hw/block/fdc.h"
+#include "hw/input/i8042.h"
+
+ISADevice *isa_superio_init(ISABus *isa_bus, int serial_count,
+                            int parallel_count, int drive_count)
+{
+    serial_hds_isa_init(isa_bus, 0, serial_count);
+
+    parallel_hds_isa_init(isa_bus, parallel_count);
+
+    if (drive_count) {
+        DriveInfo **fd;
+        int i;
+
+        if (drive_count > MAX_FD) {
+            warn_report("superio: ignoring %d floppy controllers",
+                        drive_count - MAX_FD);
+            drive_count = MAX_FD;
+        }
+        fd = g_new(DriveInfo *, drive_count);
+
+        for (i = 0; i < drive_count; i++) {
+            fd[i] = drive_get(IF_FLOPPY, 0, i);
+        }
+        fdctrl_init_isa(isa_bus, fd);
+
+        g_free(fd); /* FIXME */
+    }
+
+    return isa_create_simple(isa_bus, TYPE_I8042);
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 7f9e98a046..6f867da743 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -875,6 +875,7 @@ F: hw/input/pckbd.c
 F: hw/intc/apic*
 F: hw/intc/ioapic*
 F: hw/intc/i8259*
+F: hw/isa/isa-superio.c
 F: hw/misc/debugexit.c
 F: hw/misc/pc-testdev.c
 F: hw/timer/hpet*
@@ -885,6 +886,7 @@ F: include/hw/display/vga.h
 F: include/hw/char/parallel.h
 F: include/hw/dma/i8257.h
 F: include/hw/i2c/pm_smbus.h
+F: include/hw/isa/superio.h
 F: include/hw/input/i8042.h
 F: include/hw/timer/hpet.h
 F: include/hw/timer/i8254*
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
2.15.1
