Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A65DC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD5D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/p0PXed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD5D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELeO-0000ZY-1M
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELZK-0008RL-FC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELZJ-0002nP-5s
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45277)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELZJ-0002l4-10
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sw7irWBODFAOA5JA5Jo4Sw7IdxZM3hhTMVPInNO4y68=;
 b=N/p0PXedLhImXCsRAoGU8SEHSUWXjN/BC+g2iGe5yweEnL/rqKr70tSIuqw4dcyRNJ1Q/3
 714gOwb6/+nSxnoJIr315QCuyn/XLqE0sibRXTFpCcOVsBzMMnyi/eXzWIKyq9HICOpbQF
 pzqC0Mn1XVT8WQVrcrQINmP1RslF/BY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-Vb1vI6djP46TKt2WcO9yUw-1; Tue, 17 Mar 2020 19:24:15 -0400
X-MC-Unique: Vb1vI6djP46TKt2WcO9yUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D75AC1005514;
 Tue, 17 Mar 2020 23:24:12 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C746C60BE0;
 Tue, 17 Mar 2020 23:24:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/20] ide/via: Get rid of via_ide_init()
Date: Tue, 17 Mar 2020 19:23:15 -0400
Message-Id: <20200317232329.22362-7-jsnow@redhat.com>
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Follow example of CMD646 and remove via_ide_init function and do it
directly in board code instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-id: 20200313082444.2439-3-mark.cave-ayland@ilande.co.uk
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/ide.h        | 1 -
 hw/ide/via.c            | 8 --------
 hw/mips/mips_fulong2e.c | 5 ++++-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/ide.h b/include/hw/ide.h
index 0c7080ed92..dea0ecf5be 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -16,7 +16,6 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo =
**hd_table, int devfn);
 PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn=
);
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn=
);
 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
-void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
=20
 /* ide-mmio.c */
 void mmio_ide_init_drives(DeviceState *dev, DriveInfo *hd0, DriveInfo *hd1=
);
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 84f0efff94..3153be8862 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -211,14 +211,6 @@ static void via_ide_exitfn(PCIDevice *dev)
     }
 }
=20
-void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
-{
-    PCIDevice *dev;
-
-    dev =3D pci_create_simple(bus, devfn, "via-ide");
-    pci_ide_create_devs(dev, hd_table);
-}
-
 static void via_ide_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 4727b1d3a4..639ba2a091 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -37,6 +37,7 @@
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "hw/ide.h"
+#include "hw/ide/pci.h"
 #include "elf.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/rtc/mc146818rtc.h"
@@ -239,6 +240,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus,=
 int slot, qemu_irq intc,
     qemu_irq *i8259;
     ISABus *isa_bus;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    PCIDevice *dev;
=20
     isa_bus =3D vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
     if (!isa_bus) {
@@ -256,8 +258,9 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus,=
 int slot, qemu_irq intc,
     /* Super I/O */
     isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
=20
+    dev =3D pci_create_simple(pci_bus, PCI_DEVFN(slot, 1), "via-ide");
     ide_drive_get(hd, ARRAY_SIZE(hd));
-    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
+    pci_ide_create_devs(dev, hd);
=20
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
--=20
2.21.1


