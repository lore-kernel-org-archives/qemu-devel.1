Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E858620873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E858620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBkST-00071X-5Z
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 15:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jBkPq-0003EQ-Dh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jBkPp-0008Cn-Bz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:19:46 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:60290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jBkNw-0002rQ-AY; Tue, 10 Mar 2020 15:19:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 96A84747E06;
 Tue, 10 Mar 2020 20:17:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1442F747DF7; Tue, 10 Mar 2020 20:17:46 +0100 (CET)
Message-Id: <f6656fa8b7a198cbf58b6d8bbb1faaebf1b8a69d.1583867210.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1583867210.git.balaton@eik.bme.hu>
References: <cover.1583867210.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 2/4] ide: Make room for flags in PCIIDEState and add one
 for legacy IRQ routing
Date: Tue, 10 Mar 2020 20:06:50 +0100
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
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
 hw/ide/cmd646.c      | 4 ++--
 hw/sparc64/sun4u.c   | 2 +-
 include/hw/ide/pci.h | 7 ++++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index d953932104..a48141a689 100644
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
@@ -318,7 +318,7 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
 }
 
 static Property cmd646_ide_properties[] = {
-    DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
+    DEFINE_PROP_BIT("secondary", PCIIDEState, flags, PCI_IDE_SECONDARY, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d33e84f831..92c3ebfaa9 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -666,7 +666,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     ide_drive_get(hd, ARRAY_SIZE(hd));
 
     pci_dev = pci_create(pci_busA, PCI_DEVFN(3, 0), "cmd646-ide");
-    qdev_prop_set_uint32(&pci_dev->qdev, "secondary", 1);
+    qdev_prop_set_bit(&pci_dev->qdev, "secondary", true);
     qdev_init_nofail(&pci_dev->qdev);
     pci_ide_create_devs(pci_dev, hd);
 
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


