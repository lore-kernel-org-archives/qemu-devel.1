Received: from eggs.gnu.org ([2001:4830:134:3::10]:42027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ5M-0005OB-ME
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ5K-0003eE-VF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:40:02 -0300
Message-Id: <20170922154014.29350-23-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 22/34] hw/input/i8042: extract API from
 hw/i386/pc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

- include vmmouse
- add entries in MAINTAINERS (pckbd.c, i8042.h)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i386/pc.h     | 11 -----------
 include/hw/input/i8042.h | 30 ++++++++++++++++++++++++++++++
 hw/alpha/dp264.c         |  3 ++-
 hw/i386/pc.c             |  5 +++--
 hw/input/pckbd.c         |  2 +-
 hw/input/vmmouse.c       |  3 +--
 hw/mips/mips_fulong2e.c  |  3 ++-
 hw/mips/mips_jazz.c      |  1 +
 hw/mips/mips_malta.c     |  3 ++-
 hw/mips/mips_r4k.c       |  3 ++-
 hw/misc/vmport.c         |  1 +
 hw/ppc/prep.c            |  5 +++--
 hw/sparc64/sun4u.c       |  3 ++-
 hw/unicore32/puv3.c      |  1 +
 MAINTAINERS              |  4 +++-
 15 files changed, 54 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/input/i8042.h

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 25ba378bd8..6a2e947332 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -193,17 +193,6 @@ static inline void vmport_init(ISABus *bus)
 }
 
 void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
-void vmmouse_get_data(uint32_t *data);
-void vmmouse_set_data(const uint32_t *data);
-
-/* pckbd.c */
-#define I8042_A20_LINE "a20"
-
-void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
-                   MemoryRegion *region, ram_addr_t size,
-                   hwaddr mask);
-void i8042_isa_mouse_fake_event(void *opaque);
-void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
 
 /* pc.c */
 extern int fd_bootchk;
diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
new file mode 100644
index 0000000000..836417304b
--- /dev/null
+++ b/include/hw/input/i8042.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU PS/2 Controller
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef HW_INPUT_I8042_H
+#define HW_INPUT_I8042_H
+
+#include "hw/hw.h"
+#include "hw/isa/isa.h"
+
+#define TYPE_I8042 "i8042"
+
+#define I8042_A20_LINE "a20"
+
+void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
+                   MemoryRegion *region, ram_addr_t size,
+                   hwaddr mask);
+void i8042_isa_mouse_fake_event(void *opaque);
+void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
+
+#define TYPE_VMMOUSE "vmmouse"
+
+void vmmouse_get_data(uint32_t *data);
+void vmmouse_set_data(const uint32_t *data);
+
+#endif /* HW_INPUT_I8042_H */
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 1bd5243648..2253990654 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -19,6 +19,7 @@
 #include "hw/timer/mc146818rtc.h"
 #include "hw/ide.h"
 #include "hw/timer/i8254.h"
+#include "hw/input/i8042.h"
 #include "hw/char/serial.h"
 #include "qemu/cutils.h"
 
@@ -82,7 +83,7 @@ static void clipper_init(MachineState *machine)
     rtc_init(isa_bus, 1900, rtc_irq);
 
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    isa_create_simple(isa_bus, "i8042");
+    isa_create_simple(isa_bus, TYPE_I8042);
 
     /* VGA setup.  Don't bother loading the bios.  */
     pci_vga_init(pci_bus);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5cb0ae67cd..3aa10c780b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -40,6 +40,7 @@
 #include "multiboot.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/timer/i8254.h"
+#include "hw/input/i8042.h"
 #include "hw/audio/pcspk.h"
 #include "hw/pci/msi.h"
 #include "hw/sysbus.h"
@@ -1564,11 +1565,11 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
-    i8042 = isa_create_simple(isa_bus, "i8042");
+    i8042 = isa_create_simple(isa_bus, TYPE_I8042);
     i8042_setup_a20_line(i8042, a20_line[0]);
     if (!no_vmport) {
         vmport_init(isa_bus);
-        vmmouse = isa_try_create(isa_bus, "vmmouse");
+        vmmouse = isa_try_create(isa_bus, TYPE_VMMOUSE);
     } else {
         vmmouse = NULL;
     }
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index c479f827b6..f17f18e51b 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -26,6 +26,7 @@
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
 #include "hw/input/ps2.h"
+#include "hw/input/i8042.h"
 #include "sysemu/sysemu.h"
 
 /* debug PC keyboard */
@@ -480,7 +481,6 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
     qemu_register_reset(kbd_reset, s);
 }
 
-#define TYPE_I8042 "i8042"
 #define I8042(obj) OBJECT_CHECK(ISAKBDState, (obj), TYPE_I8042)
 
 typedef struct ISAKBDState {
diff --git a/hw/input/vmmouse.c b/hw/input/vmmouse.c
index b6d22086f4..c48c07c564 100644
--- a/hw/input/vmmouse.c
+++ b/hw/input/vmmouse.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "ui/console.h"
-#include "hw/input/ps2.h"
+#include "hw/input/i8042.h"
 #include "hw/i386/pc.h"
 #include "hw/qdev.h"
 
@@ -52,7 +52,6 @@
 #define DPRINTF(fmt, ...) do { } while (0)
 #endif
 
-#define TYPE_VMMOUSE "vmmouse"
 #define VMMOUSE(obj) OBJECT_CHECK(VMMouseState, (obj), TYPE_VMMOUSE)
 
 typedef struct VMMouseState
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 22e6c05fb5..a35745a407 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -42,6 +42,7 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/timer/i8254.h"
+#include "hw/input/i8042.h"
 #include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
@@ -367,7 +368,7 @@ static void mips_fulong2e_init(MachineState *machine)
     DMA_init(isa_bus, 0);
 
     /* Super I/O */
-    isa_create_simple(isa_bus, "i8042");
+    isa_create_simple(isa_bus, TYPE_I8042);
 
     rtc_init(isa_bus, 2000, NULL);
 
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 25f0294236..1bbef7eeb5 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -41,6 +41,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/display/vga.h"
 #include "hw/audio/pcspk.h"
+#include "hw/input/i8042.h"
 #include "sysemu/block-backend.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index de547d732f..45c7f589aa 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -45,6 +45,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/timer/mc146818rtc.h"
+#include "hw/input/i8042.h"
 #include "hw/timer/i8254.h"
 #include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
@@ -1221,7 +1222,7 @@ void mips_malta_init(MachineState *machine)
     DMA_init(isa_bus, 0);
 
     /* Super I/O */
-    isa_create_simple(isa_bus, "i8042");
+    isa_create_simple(isa_bus, TYPE_I8042);
 
     rtc_init(isa_bus, 2000, NULL);
     serial_hds_isa_init(isa_bus, 0, 2);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 48fad52540..946097a31f 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -27,6 +27,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/timer/mc146818rtc.h"
+#include "hw/input/i8042.h"
 #include "hw/timer/i8254.h"
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
@@ -295,7 +296,7 @@ void mips_r4k_init(MachineState *machine)
                      hd[MAX_IDE_DEVS * i],
 		     hd[MAX_IDE_DEVS * i + 1]);
 
-    isa_create_simple(isa_bus, "i8042");
+    isa_create_simple(isa_bus, TYPE_I8042);
 }
 
 static void mips_machine_init(MachineClass *mc)
diff --git a/hw/misc/vmport.c b/hw/misc/vmport.c
index 165500223f..bc078eb20a 100644
--- a/hw/misc/vmport.c
+++ b/hw/misc/vmport.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
+#include "hw/input/i8042.h"
 #include "sysemu/hw_accel.h"
 #include "hw/qdev.h"
 
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 94138a4e8c..16f4537093 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -41,6 +41,7 @@
 #include "hw/ide.h"
 #include "hw/loader.h"
 #include "hw/timer/mc146818rtc.h"
+#include "hw/input/i8042.h"
 #include "hw/isa/pc87312.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/arch_init.h"
@@ -643,7 +644,7 @@ static void ppc_prep_init(MachineState *machine)
                      hd[2 * i],
 		     hd[2 * i + 1]);
     }
-    isa_create_simple(isa_bus, "i8042");
+    isa_create_simple(isa_bus, TYPE_I8042);
 
     cpu = POWERPC_CPU(first_cpu);
     sysctrl->reset_irq = cpu->env.irq_inputs[PPC6xx_INPUT_HRESET];
@@ -775,7 +776,7 @@ static void ibm_40p_init(MachineState *machine)
 
     /* add some more devices */
     if (defaults_enabled()) {
-        isa_create_simple(isa_bus, "i8042");
+        isa_create_simple(isa_bus, TYPE_I8042);
         m48t59 = NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
 
         dev = DEVICE(isa_create(isa_bus, "cs4231a"));
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index c3280aaf38..973daed977 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -31,6 +31,7 @@
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
 #include "hw/timer/m48t59.h"
+#include "hw/input/i8042.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
 #include "qemu/timer.h"
@@ -488,7 +489,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
     pci_cmd646_ide_init(pci_bus, hd, 1);
 
-    isa_create_simple(isa_bus, "i8042");
+    isa_create_simple(isa_bus, TYPE_I8042);
 
     /* Floppy */
     for(i = 0; i < MAX_FD; i++) {
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 6849bac59c..cf79c89f12 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -19,6 +19,7 @@
 
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
+#include "hw/input/i8042.h"
 
 #define KERNEL_LOAD_ADDR        0x03000000
 #define KERNEL_MAX_SIZE         0x00800000 /* Just a guess */
diff --git a/MAINTAINERS b/MAINTAINERS
index f7d377ead9..cc1f8bb66b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -834,12 +834,13 @@ F: hw/misc/sga.c
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
-S: Support
+S: Supported
 F: hw/char/debugcon.c
 F: hw/char/parallel.c
 F: hw/char/serial*
 F: hw/dma/i8257*
 F: hw/i2c/pm_smbus.c
+F: hw/input/pckbd.c
 F: hw/intc/apic*
 F: hw/intc/ioapic*
 F: hw/intc/i8259*
@@ -849,6 +850,7 @@ F: hw/timer/hpet*
 F: hw/timer/i8254*
 F: hw/timer/mc146818rtc*
 F: include/hw/i2c/pm_smbus.h
+F: include/hw/input/i8042.h
 F: include/hw/timer/hpet.h
 F: include/hw/timer/i8254*
 F: include/hw/timer/mc146818rtc*
-- 
2.14.1
