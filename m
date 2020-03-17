Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB726C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842E620714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9vablU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842E620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELki-0002Pd-Ka
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELaH-0001qK-NO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELaG-0000FU-D8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELaG-0000Cj-8r
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iF0+/Pdzy8HgdQpvJErGs69taSaLcsxlEw81wFyJFpQ=;
 b=X9vablU7jG4ESbHMP2PUfssYKmX4P8rw+3isv0ztXpDo3j9ckgpfaKpUDbFYxuv5WBSTpV
 SdCaOFzSRDactdEt5MrNyd8eBmpR9vUSAniaIhxp/IhozSI9MR+5uJ/vQhNXsYJ8qQ70d4
 p2k97ZpTfkXXrPhs93STFujW1wC1TK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-kBAdC_BFOSGOAj8R4QWQcg-1; Tue, 17 Mar 2020 19:25:13 -0400
X-MC-Unique: kBAdC_BFOSGOAj8R4QWQcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2FA9DB60;
 Tue, 17 Mar 2020 23:25:11 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B4A660BE0;
 Tue, 17 Mar 2020 23:25:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/20] hw/ide: Get rid of piix4_init function
Date: Tue, 17 Mar 2020 19:23:24 -0400
Message-Id: <20200317232329.22362-16-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
 Helge Deller <deller@gmx.de>, Markus Armbruster <armbru@redhat.com>,
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

This removes pci_piix4_ide_init() function similar to clean up done to
other ide devices.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: fe46b6536abbae77695f6d1c711a04a3f4b5481d.1584457537.git.balaton=
@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/ide.h |  1 -
 hw/ide/piix.c    | 12 +-----------
 hw/isa/piix4.c   |  4 +++-
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/include/hw/ide.h b/include/hw/ide.h
index 883bbaeb9b..21bd8f23f1 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -12,7 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int ioba=
se2, int isairq,
                         DriveInfo *hd0, DriveInfo *hd1);
=20
 /* ide-pci.c */
-PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn=
);
 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
=20
 /* ide-mmio.c */
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 8bcd6b72c2..3b2de4c312 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -208,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
     }
 }
=20
-/* hd_table must contain 4 block drivers */
-/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
-PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn=
)
-{
-    PCIDevice *dev;
-
-    dev =3D pci_create_simple(bus, devfn, "piix4-ide");
-    pci_ide_create_devs(dev, hd_table);
-    return dev;
-}
-
 /* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
 static void piix3_ide_class_init(ObjectClass *klass, void *data)
 {
@@ -247,6 +236,7 @@ static const TypeInfo piix3_ide_xen_info =3D {
     .class_init    =3D piix3_ide_class_init,
 };
=20
+/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
 static void piix4_ide_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 2cbdcd7700..706eb5be69 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -35,6 +35,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/ide.h"
+#include "hw/ide/pci.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
@@ -256,9 +257,10 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus **is=
a_bus,
         *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
     }
=20
+    pci =3D pci_create_simple(pci_bus, devfn + 1, "piix4-ide");
     hd =3D g_new(DriveInfo *, ide_drives);
     ide_drive_get(hd, ide_drives);
-    pci_piix4_ide_init(pci_bus, hd, devfn + 1);
+    pci_ide_create_devs(pci, hd);
     g_free(hd);
=20
     pci_create_simple(pci_bus, devfn + 2, "piix4-usb-uhci");
--=20
2.21.1


