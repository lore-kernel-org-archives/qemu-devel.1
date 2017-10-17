Received: from eggs.gnu.org ([2001:4830:134:3::10]:34027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FW5-0006to-Qv
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FW4-0004hl-B3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:13:53 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Oct 2017 21:11:59 -0300
Message-Id: <20171017001209.32276-30-f4bug@amsat.org>
In-Reply-To: <20171017001209.32276-1-f4bug@amsat.org>
References: <20171017001209.32276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 29/39] hw/timer/i8254: rename pit_init() ->
 i8254_pit_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

and remove the old i386/pc dependency

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
---
 include/hw/timer/i8254.h          | 5 +++--
 include/hw/timer/i8254_internal.h | 2 +-
 hw/alpha/dp264.c                  | 2 +-
 hw/i386/pc.c                      | 2 +-
 hw/isa/i82378.c                   | 2 +-
 hw/mips/mips_fulong2e.c           | 2 +-
 hw/mips/mips_jazz.c               | 2 +-
 hw/mips/mips_malta.c              | 2 +-
 hw/mips/mips_r4k.c                | 2 +-
 hw/timer/i8254.c                  | 1 -
 hw/timer/i8254_common.c           | 1 -
 11 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 5adae9fa44..5b12eb918e 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -26,6 +26,7 @@
 #define HW_I8254_H
 
 #include "hw/hw.h"
+#include "hw/qdev.h"
 #include "hw/isa/isa.h"
 
 #define PIT_FREQ 1193182
@@ -48,8 +49,8 @@ typedef struct PITChannelInfo {
 #define TYPE_I8254 "isa-pit"
 #define TYPE_KVM_I8254 "kvm-pit"
 
-static inline ISADevice *pit_init(ISABus *bus, int base, int isa_irq,
-                                  qemu_irq alt_irq)
+static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_irq,
+                                        qemu_irq alt_irq)
 {
     DeviceState *dev;
     ISADevice *d;
diff --git a/include/hw/timer/i8254_internal.h b/include/hw/timer/i8254_internal.h
index dc09cc0467..c37a438f82 100644
--- a/include/hw/timer/i8254_internal.h
+++ b/include/hw/timer/i8254_internal.h
@@ -26,8 +26,8 @@
 #define QEMU_I8254_INTERNAL_H
 
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
+#include "qemu/timer.h"
 
 typedef struct PITChannelState {
     int count; /* can be 65536 */
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 1b121306c2..1bd5243648 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -81,7 +81,7 @@ static void clipper_init(MachineState *machine)
     /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
     rtc_init(isa_bus, 1900, rtc_irq);
 
-    pit_init(isa_bus, 0x40, 0, NULL);
+    i8254_pit_init(isa_bus, 0x40, 0, NULL);
     isa_create_simple(isa_bus, "i8042");
 
     /* VGA setup.  Don't bother loading the bios.  */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05985d4927..b565c6086c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1551,7 +1551,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
         if (kvm_pit_in_kernel()) {
             pit = kvm_pit_init(isa_bus, 0x40);
         } else {
-            pit = pit_init(isa_bus, 0x40, pit_isa_irq, pit_alt_irq);
+            pit = i8254_pit_init(isa_bus, 0x40, pit_isa_irq, pit_alt_irq);
         }
         if (hpet) {
             /* connect PIT to output control line of the HPET */
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index d20ea4c2ee..a9c15f858d 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -97,7 +97,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     isa_bus_irqs(isabus, s->i8259);
 
     /* 1 82C54 (pit) */
-    isa = pit_init(isabus, 0x40, 0, NULL);
+    isa = i8254_pit_init(isabus, 0x40, 0, NULL);
 
     /* speaker */
     pcspk_init(isabus, isa);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 75318680e1..22e6c05fb5 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -363,7 +363,7 @@ static void mips_fulong2e_init(MachineState *machine)
     smbus_eeprom_init(smbus, 1, eeprom_spd, sizeof(eeprom_spd));
 
     /* init other devices */
-    pit = pit_init(isa_bus, 0x40, 0, NULL);
+    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     DMA_init(isa_bus, 0);
 
     /* Super I/O */
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 7e6626dc88..5f37852499 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -222,7 +222,7 @@ static void mips_jazz_init(MachineState *machine,
     i8259 = i8259_init(isa_bus, env->irq[4]);
     isa_bus_irqs(isa_bus, i8259);
     DMA_init(isa_bus, 0);
-    pit = pit_init(isa_bus, 0x40, 0, NULL);
+    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     pcspk_init(isa_bus, pit);
 
     /* Video card */
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2adb9bcf89..de547d732f 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1217,7 +1217,7 @@ void mips_malta_init(MachineState *machine)
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
-    pit = pit_init(isa_bus, 0x40, 0, NULL);
+    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     DMA_init(isa_bus, 0);
 
     /* Super I/O */
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 1272d4ef9d..48fad52540 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -280,7 +280,7 @@ void mips_r4k_init(MachineState *machine)
 
     rtc_init(isa_bus, 2000, NULL);
 
-    pit = pit_init(isa_bus, 0x40, 0, NULL);
+    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
 
     serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
 
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 5e61ad50a8..dbc4a0baec 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -23,7 +23,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index b623c96198..6190b6fc5d 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -24,7 +24,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
-- 
2.15.0.rc0
