Received: from eggs.gnu.org ([2001:4830:134:3::10]:39240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg6-0000Cy-MB
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg5-0006GS-Uu
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:30 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:38287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eUvg5-0006BG-OH
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:29 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Fri, 29 Dec 2017 15:29:15 +0100
Message-Id: <20171229142922.31701-10-hpoussin@reactos.org>
In-Reply-To: <20171229142922.31701-1-hpoussin@reactos.org>
References: <20171229142922.31701-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 09/16] piix4: add a i8254 pit controller as
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

Remove i8254 instanciated in malta board, to not have it twice.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c       | 4 ++++
 hw/mips/mips_malta.c | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 66fdfe25e2..1fd9f4f330 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
+#include "hw/timer/i8254.h"
 
 PCIDevice *piix4_dev;
 
@@ -158,6 +159,9 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
     /* initialize ISA irqs */
     isa_bus_irqs(isa_bus, s->isa);
 
+    /* initialize pit */
+    i8254_pit_init(isa_bus, 0x40, 0, NULL);
+
     /* DMA */
     DMA_init(isa_bus, 0);
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 647688c58a..afe13c684f 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -99,8 +99,6 @@ typedef struct {
     qemu_irq i8259[16];
 } MaltaState;
 
-static ISADevice *pit;
-
 static struct _loaderparams {
     int ram_size, ram_low_size;
     const char *kernel_filename;
@@ -1204,7 +1202,6 @@ void mips_malta_init(MachineState *machine)
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
-    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
 
     /* Super I/O */
     isa_create_simple(isa_bus, "i8042");
-- 
2.11.0
