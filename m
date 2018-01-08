Received: from eggs.gnu.org ([2001:4830:134:3::10]:51457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSg-0006zY-ES
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSf-0002Yn-NB
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:54 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSf-0002Yc-Id
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:53 -0500
Received: by mail-qt0-x243.google.com with SMTP id w10so12061456qtb.10
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:53 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:42 -0300
Message-Id: <20180108024558.17983-14-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/29] piix4: convert reset function to QOM
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
 hw/isa/piix4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 7b231b704b..314f7f7359 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -39,10 +39,10 @@ typedef struct PIIX4State {
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
@@ -97,7 +97,6 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
     piix4_dev = pci_dev;
-    qemu_register_reset(piix4_reset, s);
 }
 
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
@@ -118,6 +117,7 @@ static void piix4_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82371AB_0;
     k->class_id = PCI_CLASS_BRIDGE_ISA;
+    dc->reset = piix4_reset;
     dc->desc = "ISA bridge";
     dc->vmsd = &vmstate_piix4;
     /*
-- 
2.15.1
