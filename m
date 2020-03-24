Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46341C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F1320775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wq2pjnIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F1320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpg5-0005Yi-7h
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 15:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jGpeW-0003t2-Vq
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jGpeV-0003Fr-Pu
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:55:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57881)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jGpeV-0003FI-Lw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585079755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQFNGKhJkuckNqnn3T7IwEfqRFWlsvZN8tLTUAXGp1c=;
 b=Wq2pjnIJDYk8uYwte49ts0HzGM3p8FoUYzcIw7JX7gIN2uWIbJtUDlvBZ18IC6o3H7RyMw
 8K0A1vHbH0gwOSB79MpWOcgkndwG//0DO9kPLRoxMriWn7XWhs5cLfPSyBXC5RxGY/sd9z
 4sLXDIVDLki4VJfUL1Rnix89qi9V9LQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-mjm4_rAfNomkjpyuPJG-zQ-1; Tue, 24 Mar 2020 15:55:51 -0400
X-MC-Unique: mjm4_rAfNomkjpyuPJG-zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEBB9801F77;
 Tue, 24 Mar 2020 19:55:48 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 183B91E6;
 Tue, 24 Mar 2020 19:55:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 2/2] hw/ide/sii3112: Use qdev gpio rather than
 qemu_allocate_irqs()
Date: Tue, 24 Mar 2020 15:55:23 -0400
Message-Id: <20200324195523.19779-3-jsnow@redhat.com>
In-Reply-To: <20200324195523.19779-1-jsnow@redhat.com>
References: <20200324195523.19779-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out (CID 1421984) that we are leaking the
memory returned by qemu_allocate_irqs(). We can avoid this
leak by switching to using qdev_init_gpio_in(); the base
class finalize will free the irqs that this allocates under
the hood.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 20200323151715.29454-1-peter.maydell@linaro.org
[Maintainer edit: replace `DEVICE(dev)` by `ds` --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/sii3112.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 06605d7af2..d69079c3d9 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -251,8 +251,8 @@ static void sii3112_pci_realize(PCIDevice *dev, Error *=
*errp)
 {
     SiI3112PCIState *d =3D SII3112_PCI(dev);
     PCIIDEState *s =3D PCI_IDE(dev);
+    DeviceState *ds =3D DEVICE(dev);
     MemoryRegion *mr;
-    qemu_irq *irq;
     int i;
=20
     pci_config_set_interrupt_pin(dev->config, 1);
@@ -280,10 +280,10 @@ static void sii3112_pci_realize(PCIDevice *dev, Error=
 **errp)
     memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0, 1=
6);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
=20
-    irq =3D qemu_allocate_irqs(sii3112_set_irq, d, 2);
+    qdev_init_gpio_in(ds, sii3112_set_irq, 2);
     for (i =3D 0; i < 2; i++) {
-        ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
-        ide_init2(&s->bus[i], irq[i]);
+        ide_bus_new(&s->bus[i], sizeof(s->bus[i]), ds, i, 1);
+        ide_init2(&s->bus[i], qdev_get_gpio_in(ds, i));
=20
         bmdma_init(&s->bus[i], &s->bmdma[i], s);
         s->bmdma[i].bus =3D &s->bus[i];
--=20
2.21.1


