Received: from eggs.gnu.org ([2001:4830:134:3::10]:51805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTT-0007kl-TE
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTT-0003N9-4T
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:43 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTT-0003Lf-0F
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:43 -0500
Received: by mail-qk0-x242.google.com with SMTP id w184so4360291qka.2
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:56 -0300
Message-Id: <20180108024558.17983-28-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 27/29] piix3: convert reset function to QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/southbridge/piix.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/southbridge/piix.c b/hw/southbridge/piix.c
index df08d94a59..2d429d6b29 100644
--- a/hw/southbridge/piix.c
+++ b/hw/southbridge/piix.c
@@ -203,10 +203,10 @@ static void piix3_write_config_xen(PCIDevice *dev,
     piix3_write_config(dev, address, val, len);
 }
 
-static void piix3_reset(void *opaque)
+static void piix3_reset(DeviceState *dev)
 {
-    PIIX3State *d = opaque;
-    uint8_t *pci_conf = d->dev.config;
+    PIIX3State *s = PIIX3_PCI_DEVICE(dev);
+    uint8_t *pci_conf = s->dev.config;
 
     pci_conf[0x04] = 0x07; /* master, memory and I/O */
     pci_conf[0x05] = 0x00;
@@ -240,8 +240,8 @@ static void piix3_reset(void *opaque)
     pci_conf[0xac] = 0x00;
     pci_conf[0xae] = 0x00;
 
-    d->pic_levels = 0;
-    d->rcr = 0;
+    s->pic_levels = 0;
+    s->rcr = 0;
 }
 
 static int piix3_post_load(void *opaque, int version_id)
@@ -352,8 +352,6 @@ static void piix3_realize(PCIDevice *dev, Error **errp)
                           "piix3-reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev), RCR_IOPORT,
                                         &d->rcr_mem, 1);
-
-    qemu_register_reset(piix3_reset, d);
 }
 
 static void pci_piix3_class_init(ObjectClass *klass, void *data)
@@ -364,6 +362,7 @@ static void pci_piix3_class_init(ObjectClass *klass, void *data)
     dc->desc        = "ISA bridge";
     dc->vmsd        = &vmstate_piix3;
     dc->hotpluggable   = false;
+    dc->reset       = piix3_reset;
     k->realize      = piix3_realize;
     k->vendor_id    = PCI_VENDOR_ID_INTEL;
     /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
-- 
2.15.1
