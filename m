Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0992BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89FC2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89FC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGOBl-0001Jt-VB
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jGOAj-0007yi-VO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jGOAi-0005mC-Mn
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:35:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:10310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jGOAe-0005lP-R1; Mon, 23 Mar 2020 10:35:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 05C06747E06;
 Mon, 23 Mar 2020 15:35:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DB3B4747E04; Mon, 23 Mar 2020 15:35:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ide/sii3112: Avoid leaking irqs array
Date: Mon, 23 Mar 2020 15:32:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Message-Id: <20200323143514.DB3B4747E04@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity CID 1421984 reports a leak in allocated irqs, this patch
attempts to plug that.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/sii3112.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 06605d7af2..c886916873 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -31,6 +31,7 @@ typedef struct SiI3112Regs {
 typedef struct SiI3112PCIState {
     PCIIDEState i;
     MemoryRegion mmio;
+    qemu_irq *irqs;
     SiI3112Regs regs[2];
 } SiI3112PCIState;
=20
@@ -252,7 +253,6 @@ static void sii3112_pci_realize(PCIDevice *dev, Error=
 **errp)
     SiI3112PCIState *d =3D SII3112_PCI(dev);
     PCIIDEState *s =3D PCI_IDE(dev);
     MemoryRegion *mr;
-    qemu_irq *irq;
     int i;
=20
     pci_config_set_interrupt_pin(dev->config, 1);
@@ -280,10 +280,10 @@ static void sii3112_pci_realize(PCIDevice *dev, Err=
or **errp)
     memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0,=
 16);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
=20
-    irq =3D qemu_allocate_irqs(sii3112_set_irq, d, 2);
+    d->irqs =3D qemu_allocate_irqs(sii3112_set_irq, d, 2);
     for (i =3D 0; i < 2; i++) {
         ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
-        ide_init2(&s->bus[i], irq[i]);
+        ide_init2(&s->bus[i], d->irqs[i]);
=20
         bmdma_init(&s->bus[i], &s->bmdma[i], s);
         s->bmdma[i].bus =3D &s->bus[i];
@@ -291,6 +291,13 @@ static void sii3112_pci_realize(PCIDevice *dev, Erro=
r **errp)
     }
 }
=20
+static void sii3112_unrealize(DeviceState *dev, Error **errp)
+{
+    SiI3112PCIState *d =3D SII3112_PCI(dev);
+
+    qemu_free_irqs(d->irqs, 2);
+}
+
 static void sii3112_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -301,6 +308,7 @@ static void sii3112_pci_class_init(ObjectClass *klass=
, void *data)
     pd->class_id =3D PCI_CLASS_STORAGE_RAID;
     pd->revision =3D 1;
     pd->realize =3D sii3112_pci_realize;
+    dc->unrealize =3D sii3112_unrealize;
     dc->reset =3D sii3112_reset;
     dc->desc =3D "SiI3112A SATA controller";
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
--=20
2.21.1


