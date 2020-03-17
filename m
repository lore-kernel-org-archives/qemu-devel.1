Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE2AC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F2920714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfJduzrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F2920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELhF-00058n-Ro
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELZe-0000oz-0i
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELZc-0005PC-Qk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELZc-0005MW-NJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hav4nkUHBnBpOmQjjncPxXw7xtu0T2JmJhQ14ZDoJo8=;
 b=VfJduzrN4iWZ5SjDqn6MGzIaq1accctDVBvNQziimq+Wgzv2o5PxLS5d+xZgyf9fy7/EYn
 Lg7fcMlN9HcENoFi7yr/fySsZqK1BCI/9ITtKRfFbBuTwONZo2ieM7un7z94isQOv+WQCZ
 YlePh6SrQGZ68Nl19yUNnUR2zy5+dk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-zALfh3zzPPCyxJofTIVa5w-1; Tue, 17 Mar 2020 19:24:32 -0400
X-MC-Unique: zALfh3zzPPCyxJofTIVa5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC621005514;
 Tue, 17 Mar 2020 23:24:29 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96D7960BE0;
 Tue, 17 Mar 2020 23:24:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/20] via-ide: initialise IDE controller in legacy mode
Date: Tue, 17 Mar 2020 19:23:18 -0400
Message-Id: <20200317232329.22362-10-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

According to both the VT82C686B and VT8231 datasheets the VIA Southbridge I=
DE
controller is initialised in legacy mode.

This allows Linux to correctly determine that legacy rather than PCI IRQ ro=
uting
should be used since the boot console text in the fulong2e test image chang=
es from:

scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/100 cmd 0xffffffffbfd04050 ctl 0xffffffffbfd04062 \
  bmdma 0xffffffffbfd04040 irq 14
ata2: PATA max UDMA/100 cmd 0xffffffffbfd04058 ctl 0xffffffffbfd04066 \
  bmdma 0xffffffffbfd04048 irq 14

to:

scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/100 cmd 0xffffffffbfd001f0 ctl 0xffffffffbfd003f6 \
  bmdma 0xffffffffbfd04040 irq 14
ata2: PATA max UDMA/100 cmd 0xffffffffbfd00170 ctl 0xffffffffbfd00376 \
  bmdma 0xffffffffbfd04048 irq 15

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 20200313082444.2439-6-mark.cave-ayland@ilande.co.uk
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 8363bd4802..c8835de01b 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -167,7 +167,7 @@ static void via_ide_realize(PCIDevice *dev, Error **err=
p)
     uint8_t *pci_conf =3D dev->config;
     int i;
=20
-    pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode =
*/
+    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
     dev->wmask[PCI_INTERRUPT_LINE] =3D 0;
=20
--=20
2.21.1


