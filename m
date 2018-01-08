Received: from eggs.gnu.org ([2001:4830:134:3::10]:51215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNS8-0006YA-JV
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNS5-0002GN-GT
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:20 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNS5-0002FZ-Ay
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:17 -0500
Received: by mail-qt0-x241.google.com with SMTP id 33so12078096qtv.1
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:32 -0300
Message-Id: <20180108024558.17983-4-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/29] hw/isa: extract parallel-isa specific
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/parallel.h | 14 ++++++++++++++
 include/hw/i386/pc.h       |  8 --------
 hw/char/parallel-isa.c     | 29 +++++++++++++++++++++++++++++
 hw/char/parallel.c         |  2 +-
 hw/i386/pc.c               |  1 +
 hw/isa/isa-bus.c           | 26 --------------------------
 hw/mips/mips_fulong2e.c    |  1 +
 hw/mips/mips_jazz.c        |  1 +
 hw/mips/mips_malta.c       |  1 +
 hw/sparc64/sun4u.c         |  1 +
 MAINTAINERS                |  3 ++-
 hw/char/Makefile.objs      |  1 +
 12 files changed, 52 insertions(+), 36 deletions(-)
 create mode 100644 include/hw/char/parallel.h
 create mode 100644 hw/char/parallel-isa.c

diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
new file mode 100644
index 0000000000..d6dd62fb9f
--- /dev/null
+++ b/include/hw/char/parallel.h
@@ -0,0 +1,14 @@
+#ifndef HW_PARALLEL_H
+#define HW_PARALLEL_H
+
+#include "exec/memory.h"
+#include "hw/isa/isa.h"
+#include "chardev/char.h"
+
+void parallel_hds_isa_init(ISABus *bus, int n);
+
+bool parallel_mm_init(MemoryRegion *address_space,
+                      hwaddr base, int it_shift, qemu_irq irq,
+                      Chardev *chr);
+
+#endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 780fa049d7..87a377011b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -151,14 +151,6 @@ struct PCMachineClass {
 #define PC_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(PCMachineClass, (klass), TYPE_PC_MACHINE)
 
-/* parallel.c */
-
-void parallel_hds_isa_init(ISABus *bus, int n);
-
-bool parallel_mm_init(MemoryRegion *address_space,
-                      hwaddr base, int it_shift, qemu_irq irq,
-                      Chardev *chr);
-
 /* i8259.c */
 
 extern DeviceState *isa_pic;
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
new file mode 100644
index 0000000000..906a55a07d
--- /dev/null
+++ b/hw/char/parallel-isa.c
@@ -0,0 +1,29 @@
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+#include "hw/isa/isa.h"
+#include "hw/char/parallel.h"
+
+static void parallel_init(ISABus *bus, int index, Chardev *chr)
+{
+    DeviceState *dev;
+    ISADevice *isadev;
+
+    isadev = isa_create(bus, "isa-parallel");
+    dev = DEVICE(isadev);
+    qdev_prop_set_uint32(dev, "index", index);
+    qdev_prop_set_chr(dev, "chardev", chr);
+    qdev_init_nofail(dev);
+}
+
+void parallel_hds_isa_init(ISABus *bus, int n)
+{
+    int i;
+
+    assert(n <= MAX_PARALLEL_PORTS);
+
+    for (i = 0; i < n; i++) {
+        if (parallel_hds[i]) {
+            parallel_init(bus, i, parallel_hds[i]);
+        }
+    }
+}
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index f79dc76543..1542d62201 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -28,7 +28,7 @@
 #include "chardev/char-parallel.h"
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
-#include "hw/i386/pc.h"
+#include "hw/char/parallel.h"
 #include "sysemu/sysemu.h"
 
 //#define DEBUG_PARALLEL
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3fcf318a95..6d3b2a8d1c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
+#include "hw/char/parallel.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/topology.h"
 #include "sysemu/cpus.h"
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 348e0eab9d..0f732b5b58 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -23,7 +23,6 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "hw/isa/isa.h"
-#include "hw/i386/pc.h"
 
 static ISABus *isabus;
 
@@ -287,28 +286,3 @@ MemoryRegion *isa_address_space_io(ISADevice *dev)
 }
 
 type_init(isabus_register_types)
-
-static void parallel_init(ISABus *bus, int index, Chardev *chr)
-{
-    DeviceState *dev;
-    ISADevice *isadev;
-
-    isadev = isa_create(bus, "isa-parallel");
-    dev = DEVICE(isadev);
-    qdev_prop_set_uint32(dev, "index", index);
-    qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
-}
-
-void parallel_hds_isa_init(ISABus *bus, int n)
-{
-    int i;
-
-    assert(n <= MAX_PARALLEL_PORTS);
-
-    for (i = 0; i < n; i++) {
-        if (parallel_hds[i]) {
-            parallel_init(bus, i, parallel_hds[i]);
-        }
-    }
-}
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 725e25a134..d3c3a6ab61 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -23,6 +23,7 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
+#include "hw/char/parallel.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
 #include "hw/boards.h"
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 0d2c0683ba..afb33beffd 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -28,6 +28,7 @@
 #include "hw/mips/cpudevs.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
+#include "hw/char/parallel.h"
 #include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 37f19428d6..95d22288f4 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
+#include "hw/char/parallel.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
 #include "hw/boards.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 1672f256e7..8bbc210fc8 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -31,6 +31,7 @@
 #include "hw/pci-host/apb.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
+#include "hw/char/parallel.h"
 #include "hw/timer/m48t59.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 73a5555735..f11c0386e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -867,7 +867,7 @@ M: Michael S. Tsirkin <mst@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
 F: hw/char/debugcon.c
-F: hw/char/parallel.c
+F: hw/char/parallel*
 F: hw/char/serial*
 F: hw/dma/i8257*
 F: hw/i2c/pm_smbus.c
@@ -882,6 +882,7 @@ F: hw/timer/i8254*
 F: hw/timer/mc146818rtc*
 F: hw/watchdog/wdt_ib700.c
 F: include/hw/display/vga.h
+F: include/hw/char/parallel.h
 F: include/hw/i2c/pm_smbus.h
 F: include/hw/isa/i8257.h
 F: include/hw/timer/hpet.h
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 1bcd37e98d..1b979100b7 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -1,6 +1,7 @@
 common-obj-$(CONFIG_IPACK) += ipoctal232.o
 common-obj-$(CONFIG_ESCC) += escc.o
 common-obj-$(CONFIG_PARALLEL) += parallel.o
+common-obj-$(CONFIG_PARALLEL) += parallel-isa.o
 common-obj-$(CONFIG_PL011) += pl011.o
 common-obj-$(CONFIG_SERIAL) += serial.o
 common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
-- 
2.15.1
