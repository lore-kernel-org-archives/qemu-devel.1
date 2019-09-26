Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5632FC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACF0222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACF0222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDViy-0000BK-7P
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDVXN-0003JB-T9
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDVXM-0004ka-T7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:18:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iDVXK-0004j2-2p; Thu, 26 Sep 2019 11:18:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 450BE30A5A54;
 Thu, 26 Sep 2019 15:18:29 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56FA05D6B0;
 Thu, 26 Sep 2019 15:18:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/11] hw/ide/sii3112: Convert reset handler to DeviceReset
Date: Thu, 26 Sep 2019 17:17:27 +0200
Message-Id: <20190926151733.25349-6-philmd@redhat.com>
In-Reply-To: <20190926151733.25349-1-philmd@redhat.com>
References: <20190926151733.25349-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 26 Sep 2019 15:18:29 +0000 (UTC)
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
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the reset handler into a proper Device reset method.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ide/sii3112.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 2181260531..06605d7af2 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include "hw/ide/pci.h"
 #include "qemu/module.h"
-#include "sysemu/reset.h"
 #include "trace.h"
=20
 #define TYPE_SII3112_PCI "sii3112"
@@ -237,9 +236,9 @@ static void sii3112_set_irq(void *opaque, int channel=
, int level)
     sii3112_update_irq(s);
 }
=20
-static void sii3112_reset(void *opaque)
+static void sii3112_reset(DeviceState *dev)
 {
-    SiI3112PCIState *s =3D opaque;
+    SiI3112PCIState *s =3D SII3112_PCI(dev);
     int i;
=20
     for (i =3D 0; i < 2; i++) {
@@ -290,7 +289,6 @@ static void sii3112_pci_realize(PCIDevice *dev, Error=
 **errp)
         s->bmdma[i].bus =3D &s->bus[i];
         ide_register_restart_cb(&s->bus[i]);
     }
-    qemu_register_reset(sii3112_reset, s);
 }
=20
 static void sii3112_pci_class_init(ObjectClass *klass, void *data)
@@ -303,6 +301,7 @@ static void sii3112_pci_class_init(ObjectClass *klass=
, void *data)
     pd->class_id =3D PCI_CLASS_STORAGE_RAID;
     pd->revision =3D 1;
     pd->realize =3D sii3112_pci_realize;
+    dc->reset =3D sii3112_reset;
     dc->desc =3D "SiI3112A SATA controller";
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
--=20
2.20.1


