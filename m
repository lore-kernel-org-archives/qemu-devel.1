Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA23ECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B3D2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B3D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUZb-0001kg-Mu
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKUW7-0005Bl-TC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKUW6-0006iX-U1
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKUW6-0006iN-OO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF4113090FC3;
 Tue, 15 Oct 2019 21:38:05 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E57EB60C5D;
 Tue, 15 Oct 2019 21:38:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
Subject: [PULL 05/18] hw/isa/piix4: Convert reset handler to DeviceReset
Date: Tue, 15 Oct 2019 18:37:32 -0300
Message-Id: <20191015213745.22174-6-ehabkost@redhat.com>
In-Reply-To: <20191015213745.22174-1-ehabkost@redhat.com>
References: <20191015213745.22174-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 15 Oct 2019 21:38:06 +0000 (UTC)
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
Cc: Li Qiang <liq3ea@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The PIIX4/ISA is a PCI device within the PIIX4 chipset, it will be reset
when the PCI bus it stands on is reset.

Convert its reset handler into a proper Device reset method.

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191010131527.32513-3-philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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


