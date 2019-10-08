Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA02C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A54205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A54205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqno-0003Ce-4J
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHqRh-0006Kz-NY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHqRg-0008Vf-KI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:26:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iHqRX-0008RO-Vo; Tue, 08 Oct 2019 10:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2108AC034E71;
 Tue,  8 Oct 2019 14:26:27 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-43.brq.redhat.com [10.40.204.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4427919C69;
 Tue,  8 Oct 2019 14:26:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] hw/isa/piix4: Convert reset handler to DeviceReset
Date: Tue,  8 Oct 2019 16:25:33 +0200
Message-Id: <20191008142539.7793-3-philmd@redhat.com>
In-Reply-To: <20191008142539.7793-1-philmd@redhat.com>
References: <20191008142539.7793-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 08 Oct 2019 14:26:27 +0000 (UTC)
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

The PIIX4/ISA is a PCI device within the PIIX4 chipset, it will be reset
when the PCI bus it stands on is reset.

Convert its reset handler into a proper Device reset method.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/piix4.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 3294056cd5..890d999abf 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -28,7 +28,6 @@
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/reset.h"
=20
 PCIDevice *piix4_dev;
=20
@@ -40,9 +39,9 @@ typedef struct PIIX4State {
 #define PIIX4_PCI_DEVICE(obj) \
     OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
=20
-static void piix4_reset(void *opaque)
+static void piix4_isa_reset(DeviceState *dev)
 {
-    PIIX4State *d =3D opaque;
+    PIIX4State *d =3D PIIX4_PCI_DEVICE(dev);
     uint8_t *pci_conf =3D d->dev.config;
=20
     pci_conf[0x04] =3D 0x07; // master, memory and I/O
@@ -97,7 +96,6 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
         return;
     }
     piix4_dev =3D &d->dev;
-    qemu_register_reset(piix4_reset, d);
 }
=20
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
@@ -118,6 +116,7 @@ static void piix4_class_init(ObjectClass *klass, void=
 *data)
     k->vendor_id =3D PCI_VENDOR_ID_INTEL;
     k->device_id =3D PCI_DEVICE_ID_INTEL_82371AB_0;
     k->class_id =3D PCI_CLASS_BRIDGE_ISA;
+    dc->reset =3D piix4_isa_reset;
     dc->desc =3D "ISA bridge";
     dc->vmsd =3D &vmstate_piix4;
     /*
--=20
2.21.0


