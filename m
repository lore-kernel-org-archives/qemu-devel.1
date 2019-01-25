Received: from eggs.gnu.org ([209.51.188.92]:59815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9cp-0005H9-9r
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9co-0006ee-3V
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gn9cm-0006aZ-SZ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:57 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 Jan 2019 17:06:46 -0500
Message-Id: <20190125220648.28164-7-jsnow@redhat.com>
In-Reply-To: <20190125220648.28164-1-jsnow@redhat.com>
References: <20190125220648.28164-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] ide/via: Remove vt82c686b_init_ports()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>

From: BALATON Zoltan <balaton@eik.bme.hu>

This function is only called once from vt82c686b_ide_realize() and its
content is simple enough to not need a separate function but be
included in realize directly (as done in other IDE models except PIIX
currently).

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 47d854e0fa41dad6861107eac61327c247965566.1548160772.git.balaton@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/via.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 987d99c5ec..46cac7b8d6 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -32,6 +32,15 @@
 #include "hw/ide/pci.h"
 #include "trace.h"
 
+static const struct {
+    int iobase;
+    int iobase2;
+    int isairq;
+} port_info[] = {
+    {0x1f0, 0x3f6, 14},
+    {0x170, 0x376, 15},
+};
+
 static uint64_t bmdma_read(void *opaque, hwaddr addr,
                            unsigned size)
 {
@@ -143,34 +152,12 @@ static void via_reset(void *opaque)
     pci_set_long(pci_conf + 0xc0, 0x00020001);
 }
 
-static void vt82c686b_init_ports(PCIIDEState *d) {
-    static const struct {
-        int iobase;
-        int iobase2;
-        int isairq;
-    } port_info[] = {
-        {0x1f0, 0x3f6, 14},
-        {0x170, 0x376, 15},
-    };
-    int i;
-
-    for (i = 0; i < 2; i++) {
-        ide_bus_new(&d->bus[i], sizeof(d->bus[i]), DEVICE(d), i, 2);
-        ide_init_ioport(&d->bus[i], NULL, port_info[i].iobase,
-                        port_info[i].iobase2);
-        ide_init2(&d->bus[i], isa_get_irq(NULL, port_info[i].isairq));
-
-        bmdma_init(&d->bus[i], &d->bmdma[i], d);
-        d->bmdma[i].bus = &d->bus[i];
-        ide_register_restart_cb(&d->bus[i]);
-    }
-}
-
 /* via ide func */
 static void vt82c686b_ide_realize(PCIDevice *dev, Error **errp)
 {
     PCIIDEState *d = PCI_IDE(dev);
     uint8_t *pci_conf = dev->config;
+    int i;
 
     pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy ATA mode */
     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
@@ -181,7 +168,16 @@ static void vt82c686b_ide_realize(PCIDevice *dev, Error **errp)
 
     vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
 
-    vt82c686b_init_ports(d);
+    for (i = 0; i < 2; i++) {
+        ide_bus_new(&d->bus[i], sizeof(d->bus[i]), DEVICE(d), i, 2);
+        ide_init_ioport(&d->bus[i], NULL, port_info[i].iobase,
+                        port_info[i].iobase2);
+        ide_init2(&d->bus[i], isa_get_irq(NULL, port_info[i].isairq));
+
+        bmdma_init(&d->bus[i], &d->bmdma[i], d);
+        d->bmdma[i].bus = &d->bus[i];
+        ide_register_restart_cb(&d->bus[i]);
+    }
 }
 
 static void vt82c686b_ide_exitfn(PCIDevice *dev)
-- 
2.17.2
