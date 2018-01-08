Received: from eggs.gnu.org ([2001:4830:134:3::10]:51237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSB-0006aR-G1
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSA-0002Ix-8l
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:23 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:33 -0300
Message-Id: <20180108024558.17983-5-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/29] hw/dma/i8257: rename DMA_init() to
 i8257_dma_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:PReP" <qemu-ppc@nongnu.org>

- move the header from hw/isa/ to hw/dma/
- remove the old i386/pc dependency

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/{isa => dma}/i8257.h | 6 ++++++
 include/hw/isa/isa.h            | 2 --
 hw/dma/i82374.c                 | 3 ++-
 hw/dma/i8257.c                  | 4 ++--
 hw/i386/pc.c                    | 3 ++-
 hw/mips/mips_fulong2e.c         | 3 ++-
 hw/mips/mips_jazz.c             | 3 ++-
 hw/mips/mips_malta.c            | 3 ++-
 hw/sparc/sun4m.c                | 4 ----
 hw/sparc64/sun4u.c              | 4 ----
 MAINTAINERS                     | 2 +-
 11 files changed, 19 insertions(+), 18 deletions(-)
 rename include/hw/{isa => dma}/i8257.h (86%)

diff --git a/include/hw/isa/i8257.h b/include/hw/dma/i8257.h
similarity index 86%
rename from include/hw/isa/i8257.h
rename to include/hw/dma/i8257.h
index 88a2766a3f..0041565177 100644
--- a/include/hw/isa/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -1,6 +1,10 @@
 #ifndef HW_I8257_H
 #define HW_I8257_H
 
+#include "hw/hw.h"
+#include "hw/isa/isa.h"
+#include "exec/ioport.h"
+
 #define TYPE_I8257 "i8257"
 
 typedef struct I8257Regs {
@@ -40,4 +44,6 @@ typedef struct I8257State {
     PortioList portio_pageh;
 } I8257State;
 
+void i8257_dma_init(ISABus *bus, int high_page_enable);
+
 #endif
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 95593408ef..b9dbab24b4 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -151,6 +151,4 @@ static inline ISABus *isa_bus_from_device(ISADevice *d)
     return ISA_BUS(qdev_get_parent_bus(DEVICE(d)));
 }
 
-/* i8257.c */
-void DMA_init(ISABus *bus, int high_page_enable);
 #endif
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 6c0f975df0..0b8a6f4a80 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
+#include "hw/dma/i8257.h"
 
 #define TYPE_I82374 "i82374"
 #define I82374(obj) OBJECT_CHECK(I82374State, (obj), TYPE_I82374)
@@ -123,7 +124,7 @@ static void i82374_realize(DeviceState *dev, Error **errp)
     portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj),
                     s->iobase);
 
-    DMA_init(isa_bus_from_device(ISA_DEVICE(dev)), 1);
+    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), 1);
     memset(s->commands, 0, sizeof(s->commands));
 }
 
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index bd23e893bf..07bfbdb618 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
-#include "hw/isa/i8257.h"
+#include "hw/dma/i8257.h"
 #include "qemu/main-loop.h"
 #include "trace.h"
 
@@ -622,7 +622,7 @@ static void i8257_register_types(void)
 
 type_init(i8257_register_types)
 
-void DMA_init(ISABus *bus, int high_page_enable)
+void i8257_dma_init(ISABus *bus, int high_page_enable)
 {
     ISADevice *isa1, *isa2;
     DeviceState *d;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6d3b2a8d1c..e39af3d48c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -40,6 +40,7 @@
 #include "elf.h"
 #include "multiboot.h"
 #include "hw/timer/mc146818rtc.h"
+#include "hw/dma/i8257.h"
 #include "hw/timer/i8254.h"
 #include "hw/audio/pcspk.h"
 #include "hw/pci/msi.h"
@@ -1605,7 +1606,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
     port92_init(port92, a20_line[1]);
     g_free(a20_line);
 
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
 
     for(i = 0; i < MAX_FD; i++) {
         fd[i] = drive_get(IF_FLOPPY, 0, i);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index d3c3a6ab61..cbe159034d 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/dma/i8257.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/block/fdc.h"
@@ -361,7 +362,7 @@ static void mips_fulong2e_init(MachineState *machine)
 
     /* init other devices */
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
 
     /* Super I/O */
     isa_create_simple(isa_bus, "i8042");
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index afb33beffd..6ed4b83f40 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -27,6 +27,7 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/i386/pc.h"
+#include "hw/dma/i8257.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/isa/isa.h"
@@ -219,7 +220,7 @@ static void mips_jazz_init(MachineState *machine,
     /* ISA devices */
     i8259 = i8259_init(isa_bus, env->irq[4]);
     isa_bus_irqs(isa_bus, i8259);
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     pcspk_init(isa_bus, pit);
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 95d22288f4..0a9e3dedf4 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -27,6 +27,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/dma/i8257.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/block/fdc.h"
@@ -1210,7 +1211,7 @@ void mips_malta_init(MachineState *machine)
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
 
     /* Super I/O */
     isa_create_simple(isa_bus, "i8042");
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index e71648404c..2ed28c4d25 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -99,10 +99,6 @@ struct sun4m_hwdef {
     uint8_t nvram_machine_id;
 };
 
-void DMA_init(ISABus *bus, int high_page_enable)
-{
-}
-
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
 {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 8bbc210fc8..135f8088ca 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -87,10 +87,6 @@ typedef struct EbusState {
     MemoryRegion bar1;
 } EbusState;
 
-void DMA_init(ISABus *bus, int high_page_enable)
-{
-}
-
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
 {
diff --git a/MAINTAINERS b/MAINTAINERS
index f11c0386e9..89810df375 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -883,8 +883,8 @@ F: hw/timer/mc146818rtc*
 F: hw/watchdog/wdt_ib700.c
 F: include/hw/display/vga.h
 F: include/hw/char/parallel.h
+F: include/hw/dma/i8257.h
 F: include/hw/i2c/pm_smbus.h
-F: include/hw/isa/i8257.h
 F: include/hw/timer/hpet.h
 F: include/hw/timer/i8254*
 F: include/hw/timer/mc146818rtc*
-- 
2.15.1
