Received: from eggs.gnu.org ([2001:4830:134:3::10]:41136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXqai-0000YR-0E
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 10:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXqah-0001Al-Aq
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 10:41:00 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:42461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eXqah-00019X-4E
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 10:40:59 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat,  6 Jan 2018 16:37:24 +0100
Message-Id: <20180106153730.30313-11-hpoussin@reactos.org>
In-Reply-To: <20180106153730.30313-1-hpoussin@reactos.org>
References: <20180106153730.30313-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 10/16] piix4: add a i8042 keyboard/mouse
 controller as specified in datasheet
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

Remove i8042 instanciated in malta board, to not have it twice.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c       | 3 +++
 hw/mips/mips_malta.c | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 3f59750e5a..1aab78cdd2 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -169,6 +169,9 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
     /* DMA */
     DMA_init(isa_bus, 0);
 
+    /* Super I/O */
+    isa_create_simple(isa_bus, "i8042");
+
     piix4_dev = pci_dev;
     qemu_register_reset(piix4_reset, s);
 }
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index afe13c684f..7498fad006 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1204,8 +1204,6 @@ void mips_malta_init(MachineState *machine)
     g_free(smbus_eeprom_buf);
 
     /* Super I/O */
-    isa_create_simple(isa_bus, "i8042");
-
     mc146818_rtc_init(isa_bus, 2000, NULL);
     serial_hds_isa_init(isa_bus, 0, 2);
     parallel_hds_isa_init(isa_bus, 1);
-- 
2.11.0
