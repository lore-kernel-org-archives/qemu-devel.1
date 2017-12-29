Received: from eggs.gnu.org ([2001:4830:134:3::10]:39213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg6-0000Ca-0k
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg5-0006G0-3V
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:30 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:38283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eUvg4-0006AI-UP
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:29 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Fri, 29 Dec 2017 15:29:12 +0100
Message-Id: <20171229142922.31701-7-hpoussin@reactos.org>
In-Reply-To: <20171229142922.31701-1-hpoussin@reactos.org>
References: <20171229142922.31701-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/16] piix4: add Reset Control Register
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

The RCR I/O port (0xcf9) is used to generate a hard reset or a soft reset.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 4f476dc7e6..7c83e7c23d 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -2,6 +2,7 @@
  * QEMU PIIX4 PCI Bridge Emulation
  *
  * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2016 Hervé Poussineau
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -33,6 +34,10 @@ PCIDevice *piix4_dev;
 
 typedef struct PIIX4State {
     PCIDevice dev;
+
+    /* Reset Control Register */
+    MemoryRegion rcr_mem;
+    uint8_t rcr;
 } PIIX4State;
 
 #define TYPE_PIIX4_PCI_DEVICE "PIIX4"
@@ -87,6 +92,30 @@ static const VMStateDescription vmstate_piix4 = {
     }
 };
 
+static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
+                            unsigned int len)
+{
+    PIIX4State *s = opaque;
+
+    if (val & 4) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        return;
+    }
+    s->rcr = val & 2; /* keep System Reset type only */
+}
+
+static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned int len)
+{
+    PIIX4State *s = opaque;
+    return s->rcr;
+}
+
+static const MemoryRegionOps piix4_rcr_ops = {
+    .read = piix4_rcr_read,
+    .write = piix4_rcr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN
+};
+
 static void piix4_realize(PCIDevice *pci, Error **errp)
 {
     DeviceState *dev = DEVICE(pci);
@@ -96,6 +125,12 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
                      pci_address_space_io(pci), errp)) {
         return;
     }
+
+    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
+                          "reset-control", 1);
+    memory_region_add_subregion_overlap(pci_address_space_io(pci), 0xcf9,
+                                        &s->rcr_mem, 1);
+
     piix4_dev = pci;
     qemu_register_reset(piix4_reset, s);
 }
-- 
2.11.0
