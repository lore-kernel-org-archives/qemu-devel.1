Received: from eggs.gnu.org ([2001:4830:134:3::10]:34505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FWo-0007be-Aw
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FWl-0005AD-QR
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:14:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Oct 2017 21:12:09 -0300
Message-Id: <20171017001209.32276-40-f4bug@amsat.org>
In-Reply-To: <20171017001209.32276-1-f4bug@amsat.org>
References: <20171017001209.32276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 39/39] hw/dma/i8257: rename DMA_init() to
 i8257_dma_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

- move the header from hw/isa/ to hw/dma/
- remove the old i386/pc dependency

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/{isa/i8257.h => dma/i8257_dma.h} | 6 ++++++
 include/hw/isa/isa.h                        | 2 --
 hw/dma/i82374.c                             | 3 ++-
 hw/dma/i8257.c                              | 4 ++--
 hw/i386/pc.c                                | 3 ++-
 hw/mips/mips_fulong2e.c                     | 3 ++-
 hw/mips/mips_jazz.c                         | 3 ++-
 hw/mips/mips_malta.c                        | 3 ++-
 hw/sparc/sun4m.c                            | 4 ----
 hw/sparc64/sun4u.c                          | 4 ----
 10 files changed, 18 insertions(+), 17 deletions(-)
 rename include/hw/{isa/i8257.h => dma/i8257_dma.h} (86%)

diff --git a/include/hw/isa/i8257.h b/include/hw/dma/i8257_dma.h
similarity index 86%
rename from include/hw/isa/i8257.h
rename to include/hw/dma/i8257_dma.h
index 88a2766a3f..0041565177 100644
--- a/include/hw/isa/i8257.h
+++ b/include/hw/dma/i8257_dma.h
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
index 280e64f0fa..42b9eef659 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/isa/isa.h"
+#include "hw/dma/i8257_dma.h"
 
 #define TYPE_I82374 "i82374"
 #define I82374(obj) OBJECT_CHECK(I82374State, (obj), TYPE_I82374)
@@ -130,7 +131,7 @@ static void i82374_realize(DeviceState *dev, Error **errp)
     portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj),
                     s->iobase);
 
-    DMA_init(isa_bus, 1);
+    i8257_dma_init(isa_bus, 1);
     memset(s->commands, 0, sizeof(s->commands));
 }
 
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index bd23e893bf..a8f26b003b 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
-#include "hw/isa/i8257.h"
+#include "hw/dma/i8257_dma.h"
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
index a8d20ae89c..bb0c70f606 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -39,6 +39,7 @@
 #include "elf.h"
 #include "multiboot.h"
 #include "hw/timer/mc146818rtc.h"
+#include "hw/dma/i8257_dma.h"
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
 #include "hw/audio/pcspk.h"
@@ -1467,7 +1468,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
         qdev_init_nofail(dev);
     }
 
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
 
     for(i = 0; i < MAX_FD; i++) {
         fd[i] = drive_get(IF_FLOPPY, 0, i);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index bf021ba018..7ebbffa8f2 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/dma/i8257_dma.h"
 #include "hw/char/serial.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
@@ -365,7 +366,7 @@ static void mips_fulong2e_init(MachineState *machine)
 
     /* init other devices */
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
 
     /* Super I/O */
     isa_create_simple(isa_bus, TYPE_I8042);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index f5112fab39..439bbd71fe 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -27,6 +27,7 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/i386/pc.h"
+#include "hw/dma/i8257_dma.h"
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
@@ -223,7 +224,7 @@ static void mips_jazz_init(MachineState *machine,
     /* ISA devices */
     i8259 = i8259_init(isa_bus, env->irq[4]);
     isa_bus_irqs(isa_bus, i8259);
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     pcspk_init(isa_bus, pit);
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 7e8194be17..6945fa47c3 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -27,6 +27,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/dma/i8257_dma.h"
 #include "hw/char/serial.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
@@ -1219,7 +1220,7 @@ void mips_malta_init(MachineState *machine)
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    DMA_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0);
 
     /* Super I/O */
     isa_create_simple(isa_bus, TYPE_I8042);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 93424b186f..f6fda6eb13 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -100,10 +100,6 @@ struct sun4m_hwdef {
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
index 1cd283063e..6b45d487f0 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -86,10 +86,6 @@ typedef struct EbusState {
     MemoryRegion bar1;
 } EbusState;
 
-void DMA_init(ISABus *bus, int high_page_enable)
-{
-}
-
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
 {
-- 
2.15.0.rc0
