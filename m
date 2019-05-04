Received: from eggs.gnu.org ([209.51.188.92]:42353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oG-0003rm-3A
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oF-0004ak-3T
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hN1oE-0004a2-U2
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id k16so12176440wrn.5
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 14:03:02 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sat,  4 May 2019 23:02:32 +0200
Message-Id: <1557003754-26473-2-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/3] lsi53c895a: hide 53c895a registers in
 53c810
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, hpoussin@reactos.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

AIX/PReP does access to the aliased IO registers of 53810.
Implement aliasing to make the AIX driver work.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/scsi/lsi53c895a.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index da7239d..6b95699 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2271,6 +2271,9 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     LSIState *s = LSI53C895A(dev);
     DeviceState *d = DEVICE(dev);
     uint8_t *pci_conf;
+    uint64_t mmio_size;
+    MemoryRegion *mr;
+    uint16_t type = PCI_DEVICE_GET_CLASS(dev)->device_id;
 
     pci_conf = dev->config;
 
@@ -2279,13 +2282,21 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     /* Interrupt pin A */
     pci_conf[PCI_INTERRUPT_PIN] = 0x01;
 
-    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
-                          "lsi-mmio", 0x400);
     memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
                           "lsi-ram", 0x2000);
     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
                           "lsi-io", 256);
-
+    if (type == PCI_DEVICE_ID_LSI_53C895A) {
+        mmio_size = 0x400;
+    } else {
+        mr = g_new(MemoryRegion, 1);
+        memory_region_init_alias(mr, OBJECT(d), "lsi-io-alias", &s->io_io,
+                                 0, 0x80);
+        memory_region_add_subregion_overlap(&s->io_io, 0x80, mr, -1);
+        mmio_size = 0x80;
+    }
+    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
+                          "lsi-mmio", mmio_size);
     address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
     qdev_init_gpio_out(d, &s->ext_irq, 1);
 
-- 
2.7.2
