Received: from eggs.gnu.org ([2001:4830:134:3::10]:51585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSx-0007JD-Un
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSx-0002qc-4W
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:11 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:45642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSx-0002q4-0B
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:11 -0500
Received: by mail-qk0-x244.google.com with SMTP id o126so12537278qke.12
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:47 -0300
Message-Id: <20180108024558.17983-19-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 18/29] piix4: add a i8257 dma controller as
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

Remove i8257 instanciated in malta board, to not have it twice.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
[PMD: rebased]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/isa/piix4.c       | 4 ++++
 hw/mips/mips_malta.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index b0f6a0a342..56a1c7d429 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "hw/southbridge/i82371_piix.h"
+#include "hw/dma/i8257.h"
 #include "hw/sysbus.h"
 
 PCIDevice *piix4_dev;
@@ -163,6 +164,9 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
     /* initialize ISA irqs */
     isa_bus_irqs(isa_bus, s->isa);
 
+    /* DMA */
+    i8257_dma_init(isa_bus, 0);
+
     piix4_dev = pci_dev;
 }
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index d31e144b70..db5a8b1811 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -28,7 +28,6 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/superio.h"
-#include "hw/dma/i8257.h"
 #include "hw/char/serial.h"
 #include "net/net.h"
 #include "hw/boards.h"
@@ -1208,7 +1207,6 @@ void mips_malta_init(MachineState *machine)
     smbus = piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    i8257_dma_init(isa_bus, 0);
     mc146818_rtc_init(isa_bus, 2000, NULL);
 
     /* generate SPD EEPROM data */
-- 
2.15.1
