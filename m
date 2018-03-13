Received: from eggs.gnu.org ([2001:4830:134:3::10]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsi8-0005p8-It
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsi6-0003Qt-Dg
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:00 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsi6-0003Pe-4O
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:58 -0400
Received: by mail-wm0-x241.google.com with SMTP id x7so878106wmc.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:38 +0100
Message-Id: <20180313224719.4954-29-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/69] hw/dma/i8257: Rename DMA_init() to
 i8257_dma_init()
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

- Move the header from hw/isa/ to hw/dma/
- Remove the old i386/pc dependency
- use a bool type for the high_page_enable argument

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-3-f4bug@amsat.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                     | 2 +-
 hw/dma/i82374.c                 | 3 ++-
 hw/dma/i8257.c                  | 4 ++--
 hw/i386/pc.c                    | 3 ++-
 hw/mips/mips_fulong2e.c         | 3 ++-
 hw/mips/mips_jazz.c             | 3 ++-
 hw/mips/mips_malta.c            | 3 ++-
 hw/sparc/sun4m.c                | 4 ----
 hw/sparc64/sun4u.c              | 4 ----
 include/hw/{isa => dma}/i8257.h | 6 ++++++
 include/hw/isa/isa.h            | 2 --
 11 files changed, 19 insertions(+), 18 deletions(-)
 rename include/hw/{isa => dma}/i8257.h (86%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02ac81432f..319ac9f929 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -940,8 +940,8 @@ F: hw/timer/mc146818rtc*
 F: hw/watchdog/wdt_ib700.c
 F: include/hw/display/vga.h
 F: include/hw/char/parallel.h
+F: include/hw/dma/i8257.h
 F: include/hw/i2c/pm_smbus.h
-F: include/hw/isa/i8257.h
 F: include/hw/timer/hpet.h
 F: include/hw/timer/i8254*
 F: include/hw/timer/mc146818rtc*
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 6c0f975df0..83c87d92e0 100644
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
+    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), true);
     memset(s->commands, 0, sizeof(s->commands));
 }
 
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index bd23e893bf..52675e97c9 100644
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
+void i8257_dma_init(ISABus *bus, bool high_page_enable)
 {
     ISADevice *isa1, *isa2;
     DeviceState *d;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8fa51d8eba..a6ceea9c64 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -41,6 +41,7 @@
 #include "elf.h"
 #include "multiboot.h"
 #include "hw/timer/mc146818rtc.h"
+#include "hw/dma/i8257.h"
 #include "hw/timer/i8254.h"
 #include "hw/audio/pcspk.h"
 #include "hw/pci/msi.h"
@@ -1607,7 +1608,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
     port92_init(port92, a20_line[1]);
     g_free(a20_line);
 
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
 
     for(i = 0; i < MAX_FD; i++) {
         fd[i] = drive_get(IF_FLOPPY, 0, i);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index a8e8c23733..1e43768589 100644
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
@@ -359,7 +360,7 @@ static void mips_fulong2e_init(MachineState *machine)
 
     /* init other devices */
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
 
     /* Super I/O */
     isa_create_simple(isa_bus, "i8042");
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index c87a122ddf..8b6f03a889 100644
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
@@ -220,7 +221,7 @@ static void mips_jazz_init(MachineState *machine,
     /* ISA devices */
     i8259 = i8259_init(isa_bus, env->irq[4]);
     isa_bus_irqs(isa_bus, i8259);
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     pcspk_init(isa_bus, pit);
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index c74882c7e9..9cb86c432e 100644
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
@@ -1209,7 +1210,7 @@ void mips_malta_init(MachineState *machine)
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
 
     /* Super I/O */
     isa_create_simple(isa_bus, "i8042");
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 2b8af2c884..6471aca25d 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -98,10 +98,6 @@ struct sun4m_hwdef {
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
index ceb1ba7eaf..0ca0243821 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -90,10 +90,6 @@ typedef struct EbusState {
 #define TYPE_EBUS "ebus"
 #define EBUS(obj) OBJECT_CHECK(EbusState, (obj), TYPE_EBUS)
 
-void DMA_init(ISABus *bus, int high_page_enable)
-{
-}
-
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
 {
diff --git a/include/hw/isa/i8257.h b/include/hw/dma/i8257.h
similarity index 86%
rename from include/hw/isa/i8257.h
rename to include/hw/dma/i8257.h
index 88a2766a3f..2cab50bb6c 100644
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
 
+void i8257_dma_init(ISABus *bus, bool high_page_enable);
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
-- 
2.14.3
