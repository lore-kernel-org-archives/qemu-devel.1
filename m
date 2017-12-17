Received: from eggs.gnu.org ([2001:4830:134:3::10]:49105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQoEZ-0003jZ-6K
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQoEU-0003oQ-B7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:45:03 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:28:01 +0300
Message-Id: <1bfaedcf482e324498a80f3544468207f60b48a6.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 56/61] hw/display/vga: extract public API from
 i386/pc to "hw/display/vga.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

and remove the old i386/pc dependency.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS              |  1 +
 hw/display/vga-isa-mm.c  |  3 +--
 hw/display/vga-isa.c     |  2 +-
 hw/display/vga.c         |  2 +-
 hw/mips/mips_jazz.c      |  1 +
 include/hw/display/vga.h | 25 +++++++++++++++++++++++++
 include/hw/i386/pc.h     | 12 ------------
 vl.c                     |  2 +-
 8 files changed, 31 insertions(+), 17 deletions(-)
 create mode 100644 include/hw/display/vga.h

diff --git a/MAINTAINERS b/MAINTAINERS
index acbff2f1bb..8859a50c36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -881,6 +881,7 @@ F: hw/timer/hpet*
 F: hw/timer/i8254*
 F: hw/timer/mc146818rtc*
 F: hw/watchdog/wdt_ib700.c
+F: include/hw/display/vga.h
 F: include/hw/i2c/pm_smbus.h
 F: include/hw/isa/i8257.h
 F: include/hw/timer/hpet.h
diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index 68c4d6e23e..e887b45651 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -23,10 +23,9 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
+#include "hw/display/vga.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
-#include "qemu/timer.h"
=20
 #define VGA_RAM_SIZE (8192 * 1024)
=20
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 26f69fd40a..469834add5 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -25,7 +25,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
+#include "hw/isa/isa.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
 #include "qemu/timer.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 4163b532e0..a0412000a5 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
+#include "hw/display/vga.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
 #include "vga_regs.h"
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 22a3d5169c..0d2c0683ba 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -39,6 +39,7 @@
 #include "hw/loader.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/timer/i8254.h"
+#include "hw/display/vga.h"
 #include "hw/audio/pcspk.h"
 #include "sysemu/block-backend.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/display/vga.h b/include/hw/display/vga.h
new file mode 100644
index 0000000000..0401a3a292
--- /dev/null
+++ b/include/hw/display/vga.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU VGA Emulator.
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef QEMU_HW_DISPLAY_VGA_H
+#define QEMU_HW_DISPLAY_VGA_H
+
+#include "exec/memory.h"
+
+enum vga_retrace_method {
+    VGA_RETRACE_DUMB,
+    VGA_RETRACE_PRECISE
+};
+
+extern enum vga_retrace_method vga_retrace_method;
+
+int isa_vga_mm_init(hwaddr vram_base,
+                    hwaddr ctrl_base, int it_shift,
+                    MemoryRegion *address_space);
+
+#endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 3794473108..1d55ba3322 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -302,18 +302,6 @@ PCIBus *find_i440fx(void);
 extern PCIDevice *piix4_dev;
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
=20
-/* vga.c */
-enum vga_retrace_method {
-    VGA_RETRACE_DUMB,
-    VGA_RETRACE_PRECISE
-};
-
-extern enum vga_retrace_method vga_retrace_method;
-
-int isa_vga_mm_init(hwaddr vram_base,
-                    hwaddr ctrl_base, int it_shift,
-                    MemoryRegion *address_space);
-
 /* ne2000.c */
 static inline bool isa_ne2000_init(ISABus *bus, int base, int irq, NICIn=
fo *nd)
 {
diff --git a/vl.c b/vl.c
index c1ba52306a..e9012bb009 100644
--- a/vl.c
+++ b/vl.c
@@ -57,9 +57,9 @@ int main(int argc, char **argv)
 #include "hw/boards.h"
 #include "sysemu/accel.h"
 #include "hw/usb.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "hw/scsi/scsi.h"
+#include "hw/display/vga.h"
 #include "hw/bt.h"
 #include "sysemu/watchdog.h"
 #include "hw/smbios/smbios.h"
--=20
2.11.0
