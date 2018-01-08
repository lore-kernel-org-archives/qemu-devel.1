Received: from eggs.gnu.org ([2001:4830:134:3::10]:51421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSd-0006yC-Al
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSc-0002XM-Jr
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:51 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:40334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSc-0002XF-FQ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:50 -0500
Received: by mail-qk0-x243.google.com with SMTP id d18so2145448qke.7
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:41 -0300
Message-Id: <20180108024558.17983-13-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/29] piix4: rename some variables in realize
 function
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

PIIX4 structure is now 's'
PCI device is now 'pci_dev'
DeviceState is now 'dev'

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 6b8bc3faf0..7b231b704b 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -87,16 +87,17 @@ static const VMStateDescription vmstate_piix4 = {
     }
 };
 
-static void piix4_realize(PCIDevice *dev, Error **errp)
+static void piix4_realize(PCIDevice *pci_dev, Error **errp)
 {
-    PIIX4State *d = PIIX4_PCI_DEVICE(dev);
+    DeviceState *dev = DEVICE(pci_dev);
+    PIIX4State *s = DO_UPCAST(PIIX4State, dev, pci_dev);
 
-    if (!isa_bus_new(DEVICE(d), pci_address_space(dev),
-                     pci_address_space_io(dev), errp)) {
+    if (!isa_bus_new(dev, pci_address_space(pci_dev),
+                     pci_address_space_io(pci_dev), errp)) {
         return;
     }
-    piix4_dev = &d->dev;
-    qemu_register_reset(piix4_reset, d);
+    piix4_dev = pci_dev;
+    qemu_register_reset(piix4_reset, s);
 }
 
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
-- 
2.15.1
