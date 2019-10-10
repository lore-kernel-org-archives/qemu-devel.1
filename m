Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F2C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB2120650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB2120650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYPW-0007Vh-AD
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIYJG-0000iM-Hn
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIYJF-0002HZ-FD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:16:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iIYJ9-0002Dh-Il; Thu, 10 Oct 2019 09:16:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE3773084249;
 Thu, 10 Oct 2019 13:16:42 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.241])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B76B7600C4;
 Thu, 10 Oct 2019 13:16:34 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] hw/ide/sii3112: Convert reset handler to DeviceReset
Date: Thu, 10 Oct 2019 15:15:23 +0200
Message-Id: <20191010131527.32513-5-philmd@redhat.com>
In-Reply-To: <20191010131527.32513-1-philmd@redhat.com>
References: <20191010131527.32513-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 10 Oct 2019 13:16:42 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SiI3112A SATA controller is a PCI device, it will be reset
when the PCI bus it stands on is reset.

Convert its reset handler into a proper Device reset method.

Reviewed-by: Li Qiang <liq3ea@gmail.com>
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
2.21.0


