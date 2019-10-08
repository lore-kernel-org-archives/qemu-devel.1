Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B768C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F1E20659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F1E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqb8-0007T9-W3
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHqSI-00074R-3m
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHqSG-0000NV-2I
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:27:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iHqS9-0000LP-Uf; Tue, 08 Oct 2019 10:27:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0630C190C006;
 Tue,  8 Oct 2019 14:27:05 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-43.brq.redhat.com [10.40.204.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7080D19C69;
 Tue,  8 Oct 2019 14:26:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] hw/ide/via82c: Convert reset handler to DeviceReset
Date: Tue,  8 Oct 2019 16:25:36 +0200
Message-Id: <20191008142539.7793-6-philmd@redhat.com>
In-Reply-To: <20191008142539.7793-1-philmd@redhat.com>
References: <20191008142539.7793-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 08 Oct 2019 14:27:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VIA82C686B IDE controller is a PCI device, it will be reset
when the PCI bus it stands on is reset.

Convert its reset handler into a proper Device reset method.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ide/via.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 7087dc676e..053622bd82 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -29,7 +29,6 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
-#include "sysemu/reset.h"
=20
 #include "hw/ide/pci.h"
 #include "trace.h"
@@ -120,10 +119,10 @@ static void via_ide_set_irq(void *opaque, int n, in=
t level)
     }
 }
=20
-static void via_ide_reset(void *opaque)
+static void via_ide_reset(DeviceState *dev)
 {
-    PCIIDEState *d =3D opaque;
-    PCIDevice *pd =3D PCI_DEVICE(d);
+    PCIIDEState *d =3D PCI_IDE(dev);
+    PCIDevice *pd =3D PCI_DEVICE(dev);
     uint8_t *pci_conf =3D pd->config;
     int i;
=20
@@ -172,8 +171,6 @@ static void via_ide_realize(PCIDevice *dev, Error **e=
rrp)
     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
     dev->wmask[PCI_INTERRUPT_LINE] =3D 0xf;
=20
-    qemu_register_reset(via_ide_reset, d);
-
     memory_region_init_io(&d->data_bar[0], OBJECT(d), &pci_ide_data_le_o=
ps,
                           &d->bus[0], "via-ide0-data", 8);
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &d->data_bar[0])=
;
@@ -229,6 +226,7 @@ static void via_ide_class_init(ObjectClass *klass, vo=
id *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
=20
+    dc->reset =3D via_ide_reset;
     k->realize =3D via_ide_realize;
     k->exit =3D via_ide_exitfn;
     k->vendor_id =3D PCI_VENDOR_ID_VIA;
--=20
2.21.0


