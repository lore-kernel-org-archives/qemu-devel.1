Received: from eggs.gnu.org ([2001:4830:134:3::10]:53214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N2-0004jR-Dw
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N1-00026N-Cv
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:03:00 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:58850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eQ8N1-00025U-6Y
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:59 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 16 Dec 2017 10:02:26 +0100
Message-Id: <20171216090228.28505-14-hpoussin@reactos.org>
In-Reply-To: <20171216090228.28505-1-hpoussin@reactos.org>
References: <20171216090228.28505-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/15] piix4: add a speaker as specified in
 datasheet
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

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 82890f0712..7358d7f5db 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -30,6 +30,7 @@
 #include "hw/isa/isa.h"
 #include "hw/char/isa.h"
 #include "hw/sysbus.h"
+#include "hw/audio/pcspk.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
@@ -144,6 +145,7 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
     DeviceState *dev = DEVICE(pci);
     PIIX4State *s = DO_UPCAST(PIIX4State, dev, pci);
     ISABus *isa_bus;
+    ISADevice *pit;
     qemu_irq *i8259_out_irq;
     int i;
     Error *err = NULL;
@@ -170,7 +172,10 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
     isa_bus_irqs(isa_bus, s->isa);
 
     /* initialize pit */
-    pit_init(isa_bus, 0x40, 0, NULL);
+    pit = pit_init(isa_bus, 0x40, 0, NULL);
+
+    /* speaker */
+    pcspk_init(isa_bus, pit);
 
     /* DMA */
     DMA_init(isa_bus, 0);
-- 
2.11.0
