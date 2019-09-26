Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F5C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB05721D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB05721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDVoz-00053K-Tx
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDVXf-0003T6-Pd
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDVXd-0004sP-Ot
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:18:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iDVXd-0004rh-Ha; Thu, 26 Sep 2019 11:18:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 594DB30860D6;
 Thu, 26 Sep 2019 15:18:47 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 909415D6B0;
 Thu, 26 Sep 2019 15:18:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] hw/pci-host/bonito: Convert reset handler to DeviceReset
Date: Thu, 26 Sep 2019 17:17:31 +0200
Message-Id: <20190926151733.25349-10-philmd@redhat.com>
In-Reply-To: <20190926151733.25349-1-philmd@redhat.com>
References: <20190926151733.25349-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 26 Sep 2019 15:18:47 +0000 (UTC)
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
 Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the reset handler into a proper Device reset method.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/bonito.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ceee463a11..aaba96bd13 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -45,7 +45,6 @@
 #include "hw/mips/mips.h"
 #include "hw/pci/pci_host.h"
 #include "migration/vmstate.h"
-#include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
=20
@@ -570,9 +569,9 @@ static int pci_bonito_map_irq(PCIDevice * pci_dev, in=
t irq_num)
     }
 }
=20
-static void bonito_reset(void *opaque)
+static void bonito_reset(DeviceState *dev)
 {
-    PCIBonitoState *s =3D opaque;
+    PCIBonitoState *s =3D PCI_BONITO(dev);
=20
     /* set the default value of north bridge registers */
=20
@@ -671,8 +670,6 @@ static void bonito_realize(PCIDevice *dev, Error **er=
rp)
     pci_set_byte(dev->config + PCI_INTERRUPT_PIN, 0x01);
     pci_set_byte(dev->config + PCI_MIN_GNT, 0x3c);
     pci_set_byte(dev->config + PCI_MAX_LAT, 0x00);
-
-    qemu_register_reset(bonito_reset, s);
 }
=20
 PCIBus *bonito_init(qemu_irq *pic)
@@ -703,6 +700,7 @@ static void bonito_class_init(ObjectClass *klass, voi=
d *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
=20
+    dc->reset =3D bonito_reset;
     k->realize =3D bonito_realize;
     k->vendor_id =3D 0xdf53;
     k->device_id =3D 0x00d5;
--=20
2.20.1


