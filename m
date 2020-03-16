Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5232C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFEC2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFEC2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsKL-0004zL-AT
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jDpyH-0006dj-JA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jDpyF-00011y-Nz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:39:57 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:33301)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jDpy8-0000Bq-Ms; Mon, 16 Mar 2020 09:39:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BFF4E747DF5;
 Mon, 16 Mar 2020 14:39:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8D9D17461AE; Mon, 16 Mar 2020 14:39:46 +0100 (CET)
In-Reply-To: <cover.1584134074.git.balaton@eik.bme.hu>
References: <cover.1584134074.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] hw/ide: Do ide_drive_get() within pci_ide_create_devs()
Date: Mon, 16 Mar 2020 14:35:15 +0100
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Message-Id: <20200316133946.8D9D17461AE@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pci_ide_create_devs() function takes a hd_table parameter but all
callers just pass what ide_drive_get() returns so we can do it locally
simplifying callers and removing hd_table parameter.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: Alternative version that applies without [PATCH 4/8] hw/ide: Move
    MAX_IDE_BUS define to one header

 hw/alpha/dp264.c              | 13 +++----------
 hw/i386/pc_piix.c             |  9 +++++----
 hw/ide/pci.c                  |  4 +++-
 hw/isa/piix4.c                | 10 ++--------
 hw/mips/mips_fulong2e.c       |  4 +---
 hw/mips/mips_malta.c          |  2 +-
 hw/sparc64/sun4u.c            |  6 +-----
 include/hw/ide/pci.h          |  2 +-
 include/hw/southbridge/piix.h |  3 +--
 9 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 27595767e5..f7751b18f6 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -15,7 +15,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/ide.h"
 #include "hw/ide/pci.h"
 #include "hw/timer/i8254.h"
 #include "hw/isa/superio.h"
@@ -58,6 +57,7 @@ static void clipper_init(MachineState *machine)
     const char *initrd_filename = machine->initrd_filename;
     AlphaCPU *cpus[4];
     PCIBus *pci_bus;
+    PCIDevice *pci_dev;
     ISABus *isa_bus;
     qemu_irq rtc_irq;
     long size, i;
@@ -100,15 +100,8 @@ static void clipper_init(MachineState *machine)
     isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
 
     /* IDE disk setup.  */
-    {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        PCIDevice *pci_dev;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-
-        pci_dev = pci_create_simple(pci_bus, -1, "cmd646-ide");
-        pci_ide_create_devs(pci_dev, hd);
-    }
+    pci_dev = pci_create_simple(pci_bus, -1, "cmd646-ide");
+    pci_ide_create_devs(pci_dev);
 
     /* Load PALcode.  Given that this is not "real" cpu palcode,
        but one explicitly written for the emulation, we might as
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c399398739..9216596ec6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -86,7 +86,6 @@ static void pc_init1(MachineState *machine,
     int piix3_devfn = -1;
     qemu_irq smi_irq;
     GSIState *gsi_state;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     BusState *idebus[MAX_IDE_BUS];
     ISADevice *rtc_state;
     MemoryRegion *ram_memory;
@@ -240,20 +239,22 @@ static void pc_init1(MachineState *machine,
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
 
-    ide_drive_get(hd, ARRAY_SIZE(hd));
     if (pcmc->pci_enabled) {
         PCIDevice *dev;
 
         dev = pci_create_simple(pci_bus, piix3_devfn + 1,
                                 xen_enabled() ? "piix3-ide-xen" : "piix3-ide");
-        pci_ide_create_devs(dev, hd);
+        pci_ide_create_devs(dev);
         idebus[0] = qdev_get_child_bus(&dev->qdev, "ide.0");
         idebus[1] = qdev_get_child_bus(&dev->qdev, "ide.1");
         pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
     }
 #ifdef CONFIG_IDE_ISA
-else {
+    else {
+        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
         int i;
+
+        ide_drive_get(hd, ARRAY_SIZE(hd));
         for (i = 0; i < MAX_IDE_BUS; i++) {
             ISADevice *dev;
             char busname[] = "ide.0";
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index e0c84392e2..97347f07f1 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -477,13 +477,15 @@ const VMStateDescription vmstate_ide_pci = {
 };
 
 /* hd_table must contain 4 block drivers */
-void pci_ide_create_devs(PCIDevice *dev, DriveInfo **hd_table)
+void pci_ide_create_devs(PCIDevice *dev)
 {
     PCIIDEState *d = PCI_IDE(dev);
+    DriveInfo *hd_table[2 * MAX_IDE_DEVS];
     static const int bus[4]  = { 0, 0, 1, 1 };
     static const int unit[4] = { 0, 1, 0, 1 };
     int i;
 
+    ide_drive_get(hd_table, ARRAY_SIZE(hd_table));
     for (i = 0; i < 4; i++) {
         if (hd_table[i]) {
             ide_create_drive(d->bus + bus[i], unit[i], hd_table[i]);
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 0ab4787658..13fa1660c3 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -241,11 +241,8 @@ static void piix4_register_types(void)
 
 type_init(piix4_register_types)
 
-DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
-                          I2CBus **smbus, size_t ide_buses)
+DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus, I2CBus **smbus)
 {
-    size_t ide_drives = ide_buses * MAX_IDE_DEVS;
-    DriveInfo **hd;
     PCIDevice *pci;
     DeviceState *dev;
 
@@ -257,10 +254,7 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
     }
 
     pci = pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
-    hd = g_new(DriveInfo *, ide_drives);
-    ide_drive_get(hd, ide_drives);
-    pci_ide_create_devs(pci, hd);
-    g_free(hd);
+    pci_ide_create_devs(pci);
 
     pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
     if (smbus) {
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 639ba2a091..0f312b5a35 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -239,7 +239,6 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
 {
     qemu_irq *i8259;
     ISABus *isa_bus;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     PCIDevice *dev;
 
     isa_bus = vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
@@ -259,8 +258,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
 
     dev = pci_create_simple(pci_bus, PCI_DEVFN(slot, 1), "via-ide");
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    pci_ide_create_devs(dev, hd);
+    pci_ide_create_devs(dev);
 
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index d380f73d7b..e4c4de1b4e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1403,7 +1403,7 @@ void mips_malta_init(MachineState *machine)
     pci_bus = gt64120_register(s->i8259);
 
     /* Southbridge */
-    dev = piix4_create(pci_bus, &isa_bus, &smbus, MAX_IDE_BUS);
+    dev = piix4_create(pci_bus, &isa_bus, &smbus);
 
     /* Interrupt controller */
     qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d33e84f831..6abfcb30f8 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -50,7 +50,6 @@
 #include "hw/sparc/sparc64.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
-#include "hw/ide.h"
 #include "hw/ide/pci.h"
 #include "hw/loader.h"
 #include "hw/fw-path-provider.h"
@@ -563,7 +562,6 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     PCIBus *pci_bus, *pci_busA, *pci_busB;
     PCIDevice *ebus, *pci_dev;
     SysBusDevice *s;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     DeviceState *iommu, *dev;
     FWCfgState *fw_cfg;
     NICInfo *nd;
@@ -663,12 +661,10 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
         qemu_macaddr_default_if_unset(&macaddr);
     }
 
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-
     pci_dev = pci_create(pci_busA, PCI_DEVFN(3, 0), "cmd646-ide");
     qdev_prop_set_uint32(&pci_dev->qdev, "secondary", 1);
     qdev_init_nofail(&pci_dev->qdev);
-    pci_ide_create_devs(pci_dev, hd);
+    pci_ide_create_devs(pci_dev);
 
     /* Map NVRAM into I/O (ebus) space */
     nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index 98ffa7dfcd..dd504e5a0b 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -63,7 +63,7 @@ static inline IDEState *bmdma_active_if(BMDMAState *bmdma)
 void bmdma_init(IDEBus *bus, BMDMAState *bm, PCIIDEState *d);
 void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
 extern MemoryRegionOps bmdma_addr_ioport_ops;
-void pci_ide_create_devs(PCIDevice *dev, DriveInfo **hd_table);
+void pci_ide_create_devs(PCIDevice *dev);
 
 extern const VMStateDescription vmstate_ide_pci;
 extern const MemoryRegionOps pci_ide_cmd_le_ops;
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 152628c6d9..02bd741209 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -68,7 +68,6 @@ extern PCIDevice *piix4_dev;
 
 PIIX3State *piix3_create(PCIBus *pci_bus, ISABus **isa_bus);
 
-DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
-                          I2CBus **smbus, size_t ide_buses);
+DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus, I2CBus **smbus);
 
 #endif
-- 
2.21.1


