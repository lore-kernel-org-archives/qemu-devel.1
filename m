Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC2C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DB721D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DB721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDVb3-0005w4-ND
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDVWt-0002r2-3p
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDVWn-0004Uy-V4
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:17:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5765)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iDVWn-0004UM-QH; Thu, 26 Sep 2019 11:17:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B06988E582;
 Thu, 26 Sep 2019 15:17:56 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 015B05D6A7;
 Thu, 26 Sep 2019 15:17:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/11] hw/acpi/piix4: Convert reset handler to DeviceReset
Date: Thu, 26 Sep 2019 17:17:23 +0200
Message-Id: <20190926151733.25349-2-philmd@redhat.com>
In-Reply-To: <20190926151733.25349-1-philmd@redhat.com>
References: <20190926151733.25349-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 26 Sep 2019 15:17:56 +0000 (UTC)
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
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the reset handler into a proper Device reset method.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/piix4.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 5742c3df87..4e079b39bd 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -27,7 +27,6 @@
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/acpi/acpi.h"
-#include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
@@ -344,9 +343,9 @@ static const VMStateDescription vmstate_acpi =3D {
     }
 };
=20
-static void piix4_reset(void *opaque)
+static void piix4_pm_reset(DeviceState *dev)
 {
-    PIIX4PMState *s =3D opaque;
+    PIIX4PMState *s =3D PIIX4_PM(dev);
     PCIDevice *d =3D PCI_DEVICE(s);
     uint8_t *pci_conf =3D d->config;
=20
@@ -542,7 +541,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error **=
errp)
=20
     s->machine_ready.notify =3D piix4_pm_machine_ready;
     qemu_add_machine_init_done_notifier(&s->machine_ready);
-    qemu_register_reset(piix4_reset, s);
=20
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
@@ -692,6 +690,7 @@ static void piix4_pm_class_init(ObjectClass *klass, v=
oid *data)
     k->device_id =3D PCI_DEVICE_ID_INTEL_82371AB_3;
     k->revision =3D 0x03;
     k->class_id =3D PCI_CLASS_BRIDGE_OTHER;
+    dc->reset =3D piix4_pm_reset;
     dc->desc =3D "PM";
     dc->vmsd =3D &vmstate_acpi;
     dc->props =3D piix4_pm_properties;
--=20
2.20.1


