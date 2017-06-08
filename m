Received: from eggs.gnu.org ([2001:4830:134:3::10]:47286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2VU-0005h3-Cw
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2VP-0001JP-W2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:08 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ2VP-0001JD-MP
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:03 -0400
Received: by mail-wm0-x242.google.com with SMTP id 70so8660955wme.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 11:50:03 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 21:49:38 +0300
Message-Id: <20170608184944.19406-4-mrolnik@gmail.com>
In-Reply-To: <20170608184944.19406-1-mrolnik@gmail.com>
References: <20170608184944.19406-1-mrolnik@gmail.com>
Subject: [Qemu-devel] [PATCH RFC v19 03/13] target-avr: adding a sample AVR
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anichang@protonmail.ch, Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <1471522070-77598-4-git-send-email-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 MAINTAINERS          |   1 +
 hw/avr/Makefile.objs |  21 ++++++++++
 hw/avr/sample.c      | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 hw/avr/sample.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dc37be323e..313b42642a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -129,6 +129,7 @@ AVR
 M: Michael Rolnik <mrolnik@gmail.com>
 S: Maintained
 F: target-avr/
+F: hw/avr/
 
 CRIS
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
new file mode 100644
index 0000000000..8f537c9870
--- /dev/null
+++ b/hw/avr/Makefile.objs
@@ -0,0 +1,21 @@
+#
+#  QEMU AVR CPU
+#
+#  Copyright (c) 2016 Michael Rolnik
+#
+#  This library is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU Lesser General Public
+#  License as published by the Free Software Foundation; either
+#  version 2.1 of the License, or (at your option) any later version.
+#
+#  This library is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  Lesser General Public License for more details.
+#
+#  You should have received a copy of the GNU Lesser General Public
+#  License along with this library; if not, see
+#  <http://www.gnu.org/licenses/lgpl-2.1.html>
+#
+
+obj-y += sample.o
diff --git a/hw/avr/sample.c b/hw/avr/sample.c
new file mode 100644
index 0000000000..7b03130680
--- /dev/null
+++ b/hw/avr/sample.c
@@ -0,0 +1,108 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+/*
+ *  NOTE:
+ *      This is not a real AVR board !!! This is an example !!!
+ *
+ *        This example can be used to build a real AVR board.
+ *
+ *      This example board loads provided binary file into flash memory and
+ *      executes it from 0x00000000 address in the code memory space.
+ *
+ *      Currently used for AVR CPU validation
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
+#include "ui/console.h"
+#include "hw/boards.h"
+#include "hw/devices.h"
+#include "hw/loader.h"
+#include "qemu/error-report.h"
+#include "exec/address-spaces.h"
+#include "include/hw/sysbus.h"
+
+#define VIRT_BASE_FLASH 0x00000000
+#define VIRT_BASE_ISRAM 0x00000100
+#define VIRT_BASE_EXMEM 0x00001100
+#define VIRT_BASE_EEPROM 0x00000000
+
+#define SIZE_FLASH 0x00020000
+#define SIZE_ISRAM 0x00001000
+#define SIZE_EXMEM 0x00010000
+#define SIZE_EEPROM 0x00001000
+#define SIZE_IOREG SIZE_REGS
+
+#define PHYS_BASE_FLASH (PHYS_BASE_CODE)
+
+#define PHYS_BASE_ISRAM (PHYS_BASE_DATA)
+#define PHYS_BASE_EXMEM (PHYS_BASE_ISRAM + SIZE_ISRAM)
+#define PHYS_BASE_EEPROM (PHYS_BASE_EXMEM + SIZE_EXMEM)
+
+#define PHYS_BASE_IOREG (PHYS_BASE_REGS + 0x20)
+
+static void sample_init(MachineState *machine)
+{
+    MemoryRegion *address_space_mem;
+    MemoryRegion *ram;
+    MemoryRegion *flash;
+    unsigned ram_size = SIZE_ISRAM + SIZE_EXMEM;
+    AVRCPU *cpu_avr ATTRIBUTE_UNUSED;
+    const char *firmware = NULL;
+    const char *filename;
+
+    address_space_mem = get_system_memory();
+    ram = g_new(MemoryRegion, 1);
+    flash = g_new(MemoryRegion, 1);
+
+    cpu_avr = cpu_avr_init("avr5");
+
+    memory_region_allocate_system_memory(ram, NULL, "avr.ram", ram_size);
+    memory_region_add_subregion(address_space_mem, PHYS_BASE_ISRAM, ram);
+
+    memory_region_init_rom(flash, NULL, "avr.flash", SIZE_FLASH, &error_fatal);
+    memory_region_add_subregion(address_space_mem, PHYS_BASE_FLASH, flash);
+    vmstate_register_ram_global(flash);
+
+    if (machine->firmware) {
+        firmware = machine->firmware;
+    }
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
+    if (filename) {
+        load_image_targphys(filename, PHYS_BASE_FLASH, SIZE_FLASH);
+    }
+}
+
+static void sample_machine_init(MachineClass *mc)
+{
+    mc->desc = "AVR sample/example board";
+    mc->init = sample_init;
+    mc->is_default = 1;
+}
+
+DEFINE_MACHINE("sample", sample_machine_init)
-- 
2.11.0 (Apple Git-81)
