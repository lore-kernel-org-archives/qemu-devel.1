Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7DAC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F37222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F37222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDVfL-00047R-0K
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDVXU-0003Nj-Lo
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDVXS-0004mo-3t
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iDVXR-0004mJ-VM; Thu, 26 Sep 2019 11:18:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A258488134E;
 Thu, 26 Sep 2019 15:18:36 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B93BE61F24;
 Thu, 26 Sep 2019 15:18:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] hw/isa/vt82c686: Convert reset handler to DeviceReset
Date: Thu, 26 Sep 2019 17:17:29 +0200
Message-Id: <20190926151733.25349-8-philmd@redhat.com>
In-Reply-To: <20190926151733.25349-1-philmd@redhat.com>
References: <20190926151733.25349-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 26 Sep 2019 15:18:36 +0000 (UTC)
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
 hw/isa/vt82c686.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 50bd28fa82..616f67f347 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -23,7 +23,6 @@
 #include "hw/isa/apm.h"
 #include "hw/acpi/acpi.h"
 #include "hw/i2c/pm_smbus.h"
-#include "sysemu/reset.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "exec/address-spaces.h"
@@ -116,11 +115,10 @@ static const MemoryRegionOps superio_ops =3D {
     },
 };
=20
-static void vt82c686b_reset(void * opaque)
+static void vt82c686b_isa_reset(DeviceState *dev)
 {
-    PCIDevice *d =3D opaque;
-    uint8_t *pci_conf =3D d->config;
-    VT82C686BState *vt82c =3D VT82C686B_DEVICE(d);
+    VT82C686BState *vt82c =3D VT82C686B_DEVICE(dev);
+    uint8_t *pci_conf =3D vt82c->dev.config;
=20
     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
     pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO | PCI_COMMAND_ME=
MORY |
@@ -476,8 +474,6 @@ static void vt82c686b_realize(PCIDevice *d, Error **e=
rrp)
      * But we do not emulate a floppy, so just set it here. */
     memory_region_add_subregion(isa_bus->address_space_io, 0x3f0,
                                 &vt82c->superio);
-
-    qemu_register_reset(vt82c686b_reset, d);
 }
=20
 ISABus *vt82c686b_isa_init(PCIBus *bus, int devfn)
@@ -501,6 +497,7 @@ static void via_class_init(ObjectClass *klass, void *=
data)
     k->device_id =3D PCI_DEVICE_ID_VIA_ISA_BRIDGE;
     k->class_id =3D PCI_CLASS_BRIDGE_ISA;
     k->revision =3D 0x40;
+    dc->reset =3D vt82c686b_isa_reset;
     dc->desc =3D "ISA bridge";
     dc->vmsd =3D &vmstate_via;
     /*
--=20
2.20.1


