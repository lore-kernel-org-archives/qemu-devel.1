Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD36FC10F28
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 02:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E1220665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 02:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E1220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB7p2-0000Rh-Po
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 22:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jB7nq-0006ym-Sd
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 22:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jB7np-0004MM-Bf
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 22:05:58 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:15514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jB7nl-0004Ho-PX; Sun, 08 Mar 2020 22:05:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2A9B3747D5D;
 Mon,  9 Mar 2020 01:49:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 899757475F6; Mon,  9 Mar 2020 01:49:28 +0100 (CET)
Message-Id: <2acb7e522055bb9ac45586c1792edc7615ef3ae6.1583714522.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1583714522.git.balaton@eik.bme.hu>
References: <cover.1583714522.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 2/2] via-ide: Also emulate non 100% native mode
Date: Mon, 09 Mar 2020 01:42:02 +0100
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some machines operate in "non 100% native mode" where interrupts are
fixed at legacy IDE interrupts and some guests expect this behaviour
without checking based on knowledge about hardware. Even Linux has
arch specific workarounds for this that are activated on such boards
so this needs to be emulated as well.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()

 hw/ide/via.c            | 57 +++++++++++++++++++++++++++++++++++------
 hw/mips/mips_fulong2e.c |  2 +-
 include/hw/ide.h        |  3 ++-
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 096de8dba0..44ecc2af29 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -1,9 +1,10 @@
 /*
- * QEMU IDE Emulation: PCI VIA82C686B support.
+ * QEMU VIA southbridge IDE emulation (VT82C686B, VT8231)
  *
  * Copyright (c) 2003 Fabrice Bellard
  * Copyright (c) 2006 Openedhand Ltd.
  * Copyright (c) 2010 Huacai Chen <zltjiangshi@gmail.com>
+ * Copyright (c) 2019-2020 BALATON Zoltan
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -25,6 +26,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -111,14 +114,40 @@ static void via_ide_set_irq(void *opaque, int n, int level)
     } else {
         d->config[0x70 + n * 8] &= ~0x80;
     }
-
     level = (d->config[0x70] & 0x80) || (d->config[0x78] & 0x80);
-    n = pci_get_byte(d->config + PCI_INTERRUPT_LINE);
-    if (n) {
-        qemu_set_irq(isa_get_irq(NULL, n), level);
+
+    /*
+     * Some machines operate in "non 100% native mode" where PCI_INTERRUPT_LINE
+     * is not used but IDE always uses ISA IRQ 14 and 15 even in native mode.
+     * Some guest drivers expect this, often without checking.
+     */
+    if (!(pci_get_byte(d->config + PCI_CLASS_PROG) & (n ? 4 : 1)) ||
+        PCI_IDE(d)->flags & BIT(PCI_IDE_LEGACY_IRQ)) {
+        qemu_set_irq(isa_get_irq(NULL, (n ? 15 : 14)), level);
+    } else {
+        qemu_set_irq(isa_get_irq(NULL, 14), level);
     }
 }
 
+static uint32_t via_ide_config_read(PCIDevice *d, uint32_t address, int len)
+{
+    /*
+     * The pegasos2 firmware writes to PCI_INTERRUPT_LINE but on real
+     * hardware it's fixed at 14 and won't change. Some guests also expect
+     * legacy interrupts, without reading PCI_INTERRUPT_LINE but Linux
+     * depends on this to read 14. We set it to 14 in the reset method and
+     * also set the wmask to 0 to emulate this but that turns out to be not
+     * enough. QEMU resets the PCI bus after this device and
+     * pci_do_device_reset() called from pci_device_reset() will zero
+     * PCI_INTERRUPT_LINE so this config_read function is to counter that and
+     * restore the correct value, otherwise this should not be needed.
+     */
+    if (range_covers_byte(address, len, PCI_INTERRUPT_LINE)) {
+        pci_set_byte(d->config + PCI_INTERRUPT_LINE, 14);
+    }
+    return pci_default_read_config(d, address, len);
+}
+
 static void via_ide_reset(DeviceState *dev)
 {
     PCIIDEState *d = PCI_IDE(dev);
@@ -169,7 +198,8 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
 
     pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode */
     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
-    dev->wmask[PCI_INTERRUPT_LINE] = 0xf;
+    dev->wmask[PCI_CLASS_PROG] = 5;
+    dev->wmask[PCI_INTERRUPT_LINE] = 0;
 
     memory_region_init_io(&d->data_bar[0], OBJECT(d), &pci_ide_data_le_ops,
                           &d->bus[0], "via-ide0-data", 8);
@@ -213,14 +243,23 @@ static void via_ide_exitfn(PCIDevice *dev)
     }
 }
 
-void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
+void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
+                  bool legacy_irq)
 {
     PCIDevice *dev;
 
-    dev = pci_create_simple(bus, devfn, "via-ide");
+    dev = pci_create(bus, devfn, "via-ide");
+    qdev_prop_set_bit(&dev->qdev, "legacy-irq", legacy_irq);
+    qdev_init_nofail(&dev->qdev);
     pci_ide_create_devs(dev, hd_table);
 }
 
+static Property via_ide_properties[] = {
+    DEFINE_PROP_BIT("legacy-irq", PCIIDEState, flags, PCI_IDE_LEGACY_IRQ,
+                    false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void via_ide_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -229,10 +268,12 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
     dc->reset = via_ide_reset;
     k->realize = via_ide_realize;
     k->exit = via_ide_exitfn;
+    k->config_read = via_ide_config_read;
     k->vendor_id = PCI_VENDOR_ID_VIA;
     k->device_id = PCI_DEVICE_ID_VIA_IDE;
     k->revision = 0x06;
     k->class_id = PCI_CLASS_STORAGE_IDE;
+    device_class_set_props(dc, via_ide_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 4727b1d3a4..150182c62a 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -257,7 +257,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
-    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
+    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1), false);
 
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
diff --git a/include/hw/ide.h b/include/hw/ide.h
index d88c5ee695..2a7001ccba 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -18,7 +18,8 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
-void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
+void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
+                  bool legacy_irq);
 
 /* ide-mmio.c */
 void mmio_ide_init_drives(DeviceState *dev, DriveInfo *hd0, DriveInfo *hd1);
-- 
2.21.1


