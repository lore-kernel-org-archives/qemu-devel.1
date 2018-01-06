Received: from eggs.gnu.org ([2001:4830:134:3::10]:41211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXqap-0000f6-Fz
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 10:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXqao-0001MX-OY
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 10:41:07 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:42502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eXqao-0001K1-9h
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 10:41:06 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat,  6 Jan 2018 16:37:28 +0100
Message-Id: <20180106153730.30313-15-hpoussin@reactos.org>
In-Reply-To: <20180106153730.30313-1-hpoussin@reactos.org>
References: <20180106153730.30313-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 14/16] piix4: convert reset function to QOM
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index b313e4fe73..159a27d2d9 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -56,10 +56,10 @@ typedef struct PIIX4State {
 #define PIIX4_PCI_DEVICE(obj) \
     OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
 
-static void piix4_reset(void *opaque)
+static void piix4_reset(DeviceState *dev)
 {
-    PIIX4State *d = opaque;
-    uint8_t *pci_conf = d->dev.config;
+    PIIX4State *s = PIIX4_PCI_DEVICE(dev);
+    uint8_t *pci_conf = s->dev.config;
 
     pci_conf[0x04] = 0x07; // master, memory and I/O
     pci_conf[0x05] = 0x00;
@@ -234,7 +234,6 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
     isa_init_irq(ISA_DEVICE(&s->rtc), &s->rtc.irq, RTC_ISA_IRQ);
 
     piix4_dev = pci_dev;
-    qemu_register_reset(piix4_reset, s);
 }
 
 static void piix4_init(Object *obj)
@@ -268,6 +267,7 @@ static void piix4_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82371AB_0;
     k->class_id = PCI_CLASS_BRIDGE_ISA;
+    dc->reset = piix4_reset;
     dc->desc = "ISA bridge";
     dc->vmsd = &vmstate_piix4;
     /*
-- 
2.11.0
