Received: from eggs.gnu.org ([2001:4830:134:3::10]:53176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N1-0004j5-Io
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N0-00025i-Mf
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:59 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:58847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eQ8N0-00024k-CB
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:58 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 16 Dec 2017 10:02:25 +0100
Message-Id: <20171216090228.28505-13-hpoussin@reactos.org>
In-Reply-To: <20171216090228.28505-1-hpoussin@reactos.org>
References: <20171216090228.28505-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/15] piix4: add a mc146818rtc controller as
 specified in datasheet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Remove mc146818rtc instanciated in malta board, to not have it twice.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c       | 12 ++++++++++++
 hw/mips/mips_malta.c |  4 ----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index bc13169a00..82890f0712 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -31,6 +31,7 @@
 #include "hw/char/isa.h"
 #include "hw/sysbus.h"
 #include "hw/timer/i8254.h"
+#include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
 
 PCIDevice *piix4_dev;
@@ -43,6 +44,7 @@ typedef struct PIIX4State {
     FDCtrlISABus floppy;
     ISASerialState serial[2];
     ISAParallelState parallel;
+    RTCState rtc;
 
     /* Reset Control Register */
     MemoryRegion rcr_mem;
@@ -202,6 +204,15 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
         return;
     }
 
+    /* timer */
+    qdev_set_parent_bus(DEVICE(&s->rtc), BUS(isa_bus));
+    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    isa_init_irq(ISA_DEVICE(&s->rtc), &s->rtc.irq, RTC_ISA_IRQ);
+
     piix4_dev = pci;
     qemu_register_reset(piix4_reset, s);
 }
@@ -216,6 +227,7 @@ static void piix4_init(Object *obj)
         object_initialize(&s->serial[i], sizeof(s->serial[i]), TYPE_ISA_SERIAL);
     }
     object_initialize(&s->parallel, sizeof(s->parallel), TYPE_ISA_PARALLEL);
+    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_MC146818_RTC);
 
     object_property_add_alias(obj, "floppy", OBJECT(&s->floppy), "driveA",
                               &error_abort);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index d3db2b503e..c0ee2ad0cd 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -995,7 +995,6 @@ void mips_malta_init(MachineState *machine)
     uint8_t *smbus_eeprom_buf = g_malloc0(smbus_eeprom_size);
     int64_t kernel_entry, bootloader_run_addr;
     PCIBus *pci_bus;
-    ISABus *isa_bus;
     qemu_irq cbus_irq, i8259_irq;
     PCIDevice *pci;
     int piix4_devfn;
@@ -1206,7 +1205,6 @@ void mips_malta_init(MachineState *machine)
     qdev_prop_set_chr(dev, "parallel", parallel_hds[0]);
 
     qdev_init_nofail(dev);
-    isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
     piix4_devfn = pci->devfn;
 
     /* Interrupt controller */
@@ -1222,8 +1220,6 @@ void mips_malta_init(MachineState *machine)
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
 
-    rtc_init(isa_bus, 2000, NULL);
-
     /* Network card */
     network_init(pci_bus);
 
-- 
2.11.0
