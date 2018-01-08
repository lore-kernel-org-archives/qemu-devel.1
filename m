Received: from eggs.gnu.org ([2001:4830:134:3::10]:51647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNT4-0007O7-Br
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNT3-00030b-GM
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:18 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:43136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNT3-000305-C4
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:17 -0500
Received: by mail-qt0-x244.google.com with SMTP id w10so12062126qtb.10
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:49 -0300
Message-Id: <20180108024558.17983-21-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 20/29] piix4: add a speaker as specified in
 datasheet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Hervé Poussineau <hpoussin@reactos.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 04b13f97c6..c78516e595 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -31,6 +31,7 @@
 #include "hw/southbridge/i82371_piix.h"
 #include "hw/dma/i8257.h"
 #include "hw/sysbus.h"
+#include "hw/audio/pcspk.h"
 #include "hw/timer/i8254.h"
 
 PCIDevice *piix4_dev;
@@ -142,6 +143,7 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
     DeviceState *dev = DEVICE(pci_dev);
     PIIX4State *s = DO_UPCAST(PIIX4State, dev, pci_dev);
     ISABus *isa_bus;
+    ISADevice *pit;
     qemu_irq *i8259_out_irq;
 
     isa_bus = isa_bus_new(dev, pci_address_space(pci_dev),
@@ -166,7 +168,10 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
     isa_bus_irqs(isa_bus, s->isa);
 
     /* initialize pit */
-    i8254_pit_init(isa_bus, 0x40, 0, NULL);
+    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
+
+    /* speaker */
+    pcspk_init(isa_bus, pit);
 
     /* DMA */
     i8257_dma_init(isa_bus, 0);
-- 
2.15.1
