Received: from eggs.gnu.org ([2001:4830:134:3::10]:44044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQK8M-0002Pc-4c
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 16:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQK8L-0006Wb-B8
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 16:36:38 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:40130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eQK8L-0006V6-4o
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 16:36:37 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 16 Dec 2017 22:29:57 +0100
Message-Id: <20171216213004.30393-9-hpoussin@reactos.org>
In-Reply-To: <20171216213004.30393-1-hpoussin@reactos.org>
References: <20171216213004.30393-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/15] piix4: add a i8257 dma controller as
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

Remove i8257 instanciated in malta board, to not have it twice.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c       | 3 +++
 hw/mips/mips_malta.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index eb2f730fff..66fdfe25e2 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -158,6 +158,9 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
     /* initialize ISA irqs */
     isa_bus_irqs(isa_bus, s->isa);
 
+    /* DMA */
+    DMA_init(isa_bus, 0);
+
     piix4_dev = pci;
     qemu_register_reset(piix4_reset, s);
 }
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index a1397c3304..8b2a574673 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1205,7 +1205,6 @@ void mips_malta_init(MachineState *machine)
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
     pit = pit_init(isa_bus, 0x40, 0, NULL);
-    DMA_init(isa_bus, 0);
 
     /* Super I/O */
     isa_create_simple(isa_bus, "i8042");
-- 
2.11.0
