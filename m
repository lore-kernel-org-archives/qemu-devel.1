Received: from eggs.gnu.org ([2001:4830:134:3::10]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4D8-0007CV-Iz
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4D7-0004Hz-Ag
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:30 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4D7-0004GC-05
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:29 -0500
Received: by mail-wm0-x241.google.com with SMTP id z9so681180wmb.3
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 14:40:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:40 +0100
Message-Id: <20180308223946.26784-20-f4bug@amsat.org>
In-Reply-To: <20180308223946.26784-1-f4bug@amsat.org>
References: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/25] hw/isa/vt82c686: Add the
 TYPE_VT82C686B_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yongbok Kim <yongbok.kim@mips.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/vt82c686.h |  2 ++
 hw/isa/vt82c686.c         | 20 ++++++++++++++++++++
 hw/mips/mips_fulong2e.c   | 15 +++------------
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index db97c8ed7a..c3c2b6e786 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -1,6 +1,8 @@
 #ifndef HW_VT82C686_H
 #define HW_VT82C686_H
 
+#define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
+
 /* vt82c686.c */
 ISABus *vt82c686b_isa_init(PCIBus * bus, int devfn);
 void vt82c686b_ac97_init(PCIBus *bus, int devfn);
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 7eaf3c7e8f..cff1946232 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -17,6 +17,7 @@
 #include "hw/i2c/smbus.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
+#include "hw/isa/superio.h"
 #include "hw/sysbus.h"
 #include "hw/mips/mips.h"
 #include "hw/isa/apm.h"
@@ -519,11 +520,30 @@ static const TypeInfo via_info = {
     },
 };
 
+static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
+{
+    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
+
+    sc->serial.count = 2;
+    sc->parallel.count = 1;
+    sc->ide.count = 0;
+    sc->floppy.count = 1;
+}
+
+static const TypeInfo via_superio_info = {
+    .name          = TYPE_VT82C686B_SUPERIO,
+    .parent        = TYPE_ISA_SUPERIO,
+    .instance_size = sizeof(ISASuperIODevice),
+    .class_size    = sizeof(ISASuperIOClass),
+    .class_init    = vt82c686b_superio_class_init,
+};
+
 static void vt82c686b_register_types(void)
 {
     type_register_static(&via_ac97_info);
     type_register_static(&via_mc97_info);
     type_register_static(&via_pm_info);
+    type_register_static(&via_superio_info);
     type_register_static(&via_info);
 }
 
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 9ebc225d3b..d608f17e1e 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -23,9 +23,7 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/dma/i8257.h"
-#include "hw/char/serial.h"
-#include "hw/char/parallel.h"
-#include "hw/block/fdc.h"
+#include "hw/isa/superio.h"
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/i2c/smbus.h"
@@ -34,7 +32,6 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci/pci.h"
-#include "sysemu/sysemu.h"
 #include "audio/audio.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
@@ -44,8 +41,6 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/timer/i8254.h"
-#include "hw/input/i8042.h"
-#include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
 #include "qemu/error-report.h"
@@ -250,6 +245,8 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     /* init other devices */
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(isa_bus, 0);
+    /* Super I/O */
+    isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
     vt82c686b_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
@@ -262,12 +259,6 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     /* Audio support */
     vt82c686b_ac97_init(pci_bus, PCI_DEVFN(slot, 5));
     vt82c686b_mc97_init(pci_bus, PCI_DEVFN(slot, 6));
-
-    /* Super I/O */
-    isa_create_simple(isa_bus, TYPE_I8042);
-
-    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
-    parallel_hds_isa_init(isa_bus, 1);
 }
 
 /* Network support */
-- 
2.16.2
