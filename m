Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E93AC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202B120714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/8+W8ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202B120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHvUi-00018S-9F
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 16:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jHvOC-0002TB-4C
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 16:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jHvOA-0003GT-Vw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 16:15:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jHvOA-0003Fa-Rg
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 16:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585340134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlEC6r3nGGTqkFYTMWughwRPS15kMqFsrxaGydRPwtM=;
 b=g/8+W8kuiGw9PeTTqfzJjLfcgkGIacQWx40LFqP7O4zDkyMZsdQI0pxkQyhX4+1OrdzCnM
 d6Py5y5fiL9N/g/G0zOF5JOqnGnLvXyDW6E/VfDZkocT/PRnQBivKk3XvjA0TyPw0vPOrA
 F7LHupWd4XKfxGVDqvurxO026xrtNZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-wAfPHWDINoaLzZj_G7dV9A-1; Fri, 27 Mar 2020 16:15:32 -0400
X-MC-Unique: wAfPHWDINoaLzZj_G7dV9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D414100551A;
 Fri, 27 Mar 2020 20:15:30 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A07C819C7F;
 Fri, 27 Mar 2020 20:15:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 5/5] cmd646-ide: use qdev gpio rather than qemu_allocate_irqs()
Date: Fri, 27 Mar 2020 16:15:01 -0400
Message-Id: <20200327201501.1417-6-jsnow@redhat.com>
In-Reply-To: <20200327201501.1417-1-jsnow@redhat.com>
References: <20200327201501.1417-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This prevents the memory from qemu_allocate_irqs() from being leaked which
can in some cases be spotted by Coverity (CID 1421984).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-id: 20200324210519.2974-4-mark.cave-ayland@ilande.co.uk
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/cmd646.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 699f25824d..c254631485 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -249,8 +249,8 @@ static void cmd646_pci_config_write(PCIDevice *d, uint3=
2_t addr, uint32_t val,
 static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
 {
     PCIIDEState *d =3D PCI_IDE(dev);
+    DeviceState *ds =3D DEVICE(dev);
     uint8_t *pci_conf =3D dev->config;
-    qemu_irq *irq;
     int i;
=20
     pci_conf[PCI_CLASS_PROG] =3D 0x8f;
@@ -291,16 +291,15 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Er=
ror **errp)
     /* TODO: RST# value should be 0 */
     pci_conf[PCI_INTERRUPT_PIN] =3D 0x01; // interrupt on pin 1
=20
-    irq =3D qemu_allocate_irqs(cmd646_set_irq, d, 2);
+    qdev_init_gpio_in(ds, cmd646_set_irq, 2);
     for (i =3D 0; i < 2; i++) {
-        ide_bus_new(&d->bus[i], sizeof(d->bus[i]), DEVICE(dev), i, 2);
-        ide_init2(&d->bus[i], irq[i]);
+        ide_bus_new(&d->bus[i], sizeof(d->bus[i]), ds, i, 2);
+        ide_init2(&d->bus[i], qdev_get_gpio_in(ds, i));
=20
         bmdma_init(&d->bus[i], &d->bmdma[i], d);
         d->bmdma[i].bus =3D &d->bus[i];
         ide_register_restart_cb(&d->bus[i]);
     }
-    g_free(irq);
 }
=20
 static void pci_cmd646_ide_exitfn(PCIDevice *dev)
--=20
2.21.1


