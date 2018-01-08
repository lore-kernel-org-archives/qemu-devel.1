Received: from eggs.gnu.org ([2001:4830:134:3::10]:51619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNT1-0007L4-HL
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNT0-0002w1-L7
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:15 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNT0-0002vK-GN
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:14 -0500
Received: by mail-qk0-x241.google.com with SMTP id d202so12534550qkc.9
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:48 -0300
Message-Id: <20180108024558.17983-20-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/29] piix4: add a i8254 pit controller as
 specified in datasheet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Yongbok Kim <yongbok.kim@mips.com>

From: Hervé Poussineau <hpoussin@reactos.org>

Remove i8254 instanciated in malta board, to not have it twice.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
[PMD: rebased]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/isa/piix4.c       | 4 ++++
 hw/mips/mips_malta.c | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 56a1c7d429..04b13f97c6 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -31,6 +31,7 @@
 #include "hw/southbridge/i82371_piix.h"
 #include "hw/dma/i8257.h"
 #include "hw/sysbus.h"
+#include "hw/timer/i8254.h"
 
 PCIDevice *piix4_dev;
 
@@ -164,6 +165,9 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
     /* initialize ISA irqs */
     isa_bus_irqs(isa_bus, s->isa);
 
+    /* initialize pit */
+    i8254_pit_init(isa_bus, 0x40, 0, NULL);
+
     /* DMA */
     i8257_dma_init(isa_bus, 0);
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index db5a8b1811..84b4d5c423 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -44,7 +44,6 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/timer/mc146818rtc.h"
-#include "hw/timer/i8254.h"
 #include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"             /* SysBusDevice */
@@ -98,8 +97,6 @@ typedef struct {
     qemu_irq i8259[16];
 } MaltaState;
 
-static ISADevice *pit;
-
 static struct _loaderparams {
     int ram_size, ram_low_size;
     const char *kernel_filename;
@@ -1206,7 +1203,6 @@ void mips_malta_init(MachineState *machine)
     pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
     smbus = piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
-    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     mc146818_rtc_init(isa_bus, 2000, NULL);
 
     /* generate SPD EEPROM data */
-- 
2.15.1
