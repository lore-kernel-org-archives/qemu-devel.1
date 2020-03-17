Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34946C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F129020714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8PlMbFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F129020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELiZ-0007Cn-2a
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELaE-0001j3-87
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELaC-0008P9-Ca
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELaC-0008Hj-8h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQM0UB9If7Xg4g9za/6nNer7pYMGCLAddpBFGqJQ8wM=;
 b=Z8PlMbFEg7HqiBtgmYjXC4tVaJ+sHjq4AvNxL8g7X9b1ryj7SwdnagAVeJHFXxJfF0ub8C
 qPiQgf1udnUoPy4qHss55444Dz+B5uaSCk/L+XpJIazZlEg79oUyuBhnUcqI6LvWmlCYrq
 pQAZvRIiwaMsLeXXNAKo07GJt7WjcFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-wER0LIegMkKk25wdS13xjA-1; Tue, 17 Mar 2020 19:25:08 -0400
X-MC-Unique: wER0LIegMkKk25wdS13xjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47AD81005516;
 Tue, 17 Mar 2020 23:25:06 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC21C60BE0;
 Tue, 17 Mar 2020 23:24:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/20] hw/isa/piix4.c: Introduce variable to store devfn
Date: Tue, 17 Mar 2020 19:23:23 -0400
Message-Id: <20200317232329.22362-15-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

From: BALATON Zoltan <balaton@eik.bme.hu>

To avoid any problem with reassigning pci variable store devfn in a
variable instead of acessing it from the PCIDevice.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 1020e0bfcfc6e364f967ccb2a9a3778ac174ccbe.1584457537.git.balaton=
@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/isa/piix4.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 7edec5e149..2cbdcd7700 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -247,9 +247,10 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus **is=
a_bus,
     DriveInfo **hd;
     PCIDevice *pci;
     DeviceState *dev;
+    int devfn =3D PCI_DEVFN(10, 0);
=20
-    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
-                                          true, TYPE_PIIX4_PCI_DEVICE);
+    pci =3D pci_create_simple_multifunction(pci_bus, devfn,  true,
+                                          TYPE_PIIX4_PCI_DEVICE);
     dev =3D DEVICE(pci);
     if (isa_bus) {
         *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
@@ -257,11 +258,12 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus **i=
sa_bus,
=20
     hd =3D g_new(DriveInfo *, ide_drives);
     ide_drive_get(hd, ide_drives);
-    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
+    pci_piix4_ide_init(pci_bus, hd, devfn + 1);
     g_free(hd);
-    pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
+
+    pci_create_simple(pci_bus, devfn + 2, "piix4-usb-uhci");
     if (smbus) {
-        *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
+        *smbus =3D piix4_pm_init(pci_bus, devfn + 3, 0x1100,
                                isa_get_irq(NULL, 9), NULL, 0, NULL);
    }
=20
--=20
2.21.1


