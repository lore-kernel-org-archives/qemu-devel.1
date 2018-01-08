Received: from eggs.gnu.org ([2001:4830:134:3::10]:51474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSj-00072r-MI
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSi-0002cc-RW
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:57 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:39182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSi-0002c5-MZ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:56 -0500
Received: by mail-qk0-x243.google.com with SMTP id r8so8244073qke.6
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:43 -0300
Message-Id: <20180108024558.17983-15-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/29] piix4: add Reset Control Register
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

The RCR I/O port (0xcf9) is used to generate a hard reset or a soft reset.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 314f7f7359..13f4eaa2dd 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -2,6 +2,7 @@
  * QEMU PIIX4 PCI Bridge Emulation
  *
  * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2018 Hervé Poussineau
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
@@ -87,6 +92,34 @@ static const VMStateDescription vmstate_piix4 = {
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
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
 static void piix4_realize(PCIDevice *pci_dev, Error **errp)
 {
     DeviceState *dev = DEVICE(pci_dev);
@@ -96,6 +129,12 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
                      pci_address_space_io(pci_dev), errp)) {
         return;
     }
+
+    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
+                          "reset-control", 1);
+    memory_region_add_subregion_overlap(pci_address_space_io(pci_dev), 0xcf9,
+                                        &s->rcr_mem, 1);
+
     piix4_dev = pci_dev;
 }
 
-- 
2.15.1
