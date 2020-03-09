Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF32BC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2CE20866
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2CE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBORv-00074G-07
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jBONn-0007FE-DM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jBONm-0000r5-3w
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:48:11 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:20820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jBONh-0000jp-Ux; Mon, 09 Mar 2020 15:48:06 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9E870747DFA;
 Mon,  9 Mar 2020 20:48:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7821D747DFE; Mon,  9 Mar 2020 20:48:02 +0100 (CET)
Message-Id: <48e77c282cdc70914122f771497242e1c6e77760.1583781493.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1583781493.git.balaton@eik.bme.hu>
References: <cover.1583781493.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 1/3] ide: Make room for flags in PCIIDEState and add one
 for legacy IRQ routing
Date: Mon, 09 Mar 2020 20:18:13 +0100
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

We'll need a flag for implementing some device specific behaviour in
via-ide but we already have a currently CMD646 specific field that can
be repurposed for this and leave room for furhter flags if needed in
the future. This patch changes the "secondary" field to "flags" and
define the flags for CMD646 and via-ide and change CMD646 and its
users accordingly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/alpha/dp264.c     |  2 +-
 hw/ide/cmd646.c      | 12 ++++++------
 hw/sparc64/sun4u.c   |  9 ++-------
 include/hw/ide.h     |  4 ++--
 include/hw/ide/pci.h |  7 ++++++-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index e5350a287f..f104e5dfa4 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -103,7 +103,7 @@ static void clipper_init(MachineState *machine)
         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
         ide_drive_get(hd, ARRAY_SIZE(hd));
 
-        pci_cmd646_ide_init(pci_bus, hd, 0);
+        pci_cmd646_ide_init(pci_bus, hd, -1, false);
     }
 
     /* Load PALcode.  Given that this is not "real" cpu palcode,
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 335c060673..0be650791f 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -256,7 +256,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
     pci_conf[PCI_CLASS_PROG] = 0x8f;
 
     pci_conf[CNTRL] = CNTRL_EN_CH0; // enable IDE0
-    if (d->secondary) {
+    if (d->flags & BIT(PCI_IDE_SECONDARY)) {
         /* XXX: if not enabled, really disable the seconday IDE controller */
         pci_conf[CNTRL] |= CNTRL_EN_CH1; /* enable IDE1 */
     }
@@ -317,20 +317,20 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
     }
 }
 
-void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
-                         int secondary_ide_enabled)
+void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
+                         bool secondary_ide_enabled)
 {
     PCIDevice *dev;
 
-    dev = pci_create(bus, -1, "cmd646-ide");
-    qdev_prop_set_uint32(&dev->qdev, "secondary", secondary_ide_enabled);
+    dev = pci_create(bus, devfn, "cmd646-ide");
+    qdev_prop_set_bit(&dev->qdev, "secondary", secondary_ide_enabled);
     qdev_init_nofail(&dev->qdev);
 
     pci_ide_create_devs(dev, hd_table);
 }
 
 static Property cmd646_ide_properties[] = {
-    DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
+    DEFINE_PROP_BIT("secondary", PCIIDEState, flags, PCI_IDE_SECONDARY, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d33e84f831..fbe6790847 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -50,8 +50,7 @@
 #include "hw/sparc/sparc64.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
-#include "hw/ide.h"
-#include "hw/ide/pci.h"
+#include "hw/ide/internal.h"
 #include "hw/loader.h"
 #include "hw/fw-path-provider.h"
 #include "elf.h"
@@ -664,11 +663,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     }
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
-
-    pci_dev = pci_create(pci_busA, PCI_DEVFN(3, 0), "cmd646-ide");
-    qdev_prop_set_uint32(&pci_dev->qdev, "secondary", 1);
-    qdev_init_nofail(&pci_dev->qdev);
-    pci_ide_create_devs(pci_dev, hd);
+    pci_cmd646_ide_init(pci_busA, hd, PCI_DEVFN(3, 0), true);
 
     /* Map NVRAM into I/O (ebus) space */
     nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
diff --git a/include/hw/ide.h b/include/hw/ide.h
index 28d8a06439..d88c5ee695 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -12,8 +12,8 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
                         DriveInfo *hd0, DriveInfo *hd1);
 
 /* ide-pci.c */
-void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
-                         int secondary_ide_enabled);
+void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
+                         bool secondary_ide_enabled);
 PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index a9f2c33e68..21075edf16 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -40,6 +40,11 @@ typedef struct BMDMAState {
 #define TYPE_PCI_IDE "pci-ide"
 #define PCI_IDE(obj) OBJECT_CHECK(PCIIDEState, (obj), TYPE_PCI_IDE)
 
+enum {
+    PCI_IDE_SECONDARY, /* used only for cmd646 */
+    PCI_IDE_LEGACY_IRQ
+};
+
 typedef struct PCIIDEState {
     /*< private >*/
     PCIDevice parent_obj;
@@ -47,7 +52,7 @@ typedef struct PCIIDEState {
 
     IDEBus bus[2];
     BMDMAState bmdma[2];
-    uint32_t secondary; /* used only for cmd646 */
+    uint32_t flags;
     MemoryRegion bmdma_bar;
     MemoryRegion cmd_bar[2];
     MemoryRegion data_bar[2];
-- 
2.21.1


