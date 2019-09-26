Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66736C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6A221D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6A221D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDVbb-0006qq-PC
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDVXG-00039M-IZ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDVXF-0004fe-F1
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:18:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iDVXD-0004eI-CJ; Thu, 26 Sep 2019 11:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DEF6E315C027;
 Thu, 26 Sep 2019 15:18:20 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72C895D6B0;
 Thu, 26 Sep 2019 15:18:17 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/11] hw/pci-host/piix: Convert reset handler to DeviceReset
Date: Thu, 26 Sep 2019 17:17:26 +0200
Message-Id: <20190926151733.25349-5-philmd@redhat.com>
In-Reply-To: <20190926151733.25349-1-philmd@redhat.com>
References: <20190926151733.25349-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 26 Sep 2019 15:18:20 +0000 (UTC)
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the reset handler into a proper Device reset method.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/piix.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 135c645535..a1cd8b8406 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -36,7 +36,6 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "hw/pci-host/pam.h"
-#include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "hw/i386/ioapic.h"
 #include "qapi/visitor.h"
@@ -562,9 +561,9 @@ static void piix3_write_config_xen(PCIDevice *dev,
     piix3_write_config(dev, address, val, len);
 }
=20
-static void piix3_reset(void *opaque)
+static void piix3_reset(DeviceState *dev)
 {
-    PIIX3State *d =3D opaque;
+    PIIX3State *d =3D PIIX3_PCI_DEVICE(dev);
     uint8_t *pci_conf =3D d->dev.config;
=20
     pci_conf[0x04] =3D 0x07; /* master, memory and I/O */
@@ -711,8 +710,6 @@ static void piix3_realize(PCIDevice *dev, Error **err=
p)
                           "piix3-reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev), RCR_I=
OPORT,
                                         &d->rcr_mem, 1);
-
-    qemu_register_reset(piix3_reset, d);
 }
=20
 static void pci_piix3_class_init(ObjectClass *klass, void *data)
@@ -723,6 +720,7 @@ static void pci_piix3_class_init(ObjectClass *klass, =
void *data)
     dc->desc        =3D "ISA bridge";
     dc->vmsd        =3D &vmstate_piix3;
     dc->hotpluggable   =3D false;
+    dc->reset       =3D piix3_reset;
     k->realize      =3D piix3_realize;
     k->vendor_id    =3D PCI_VENDOR_ID_INTEL;
     /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
--=20
2.20.1


