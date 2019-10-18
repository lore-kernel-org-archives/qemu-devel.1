Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E130DCA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BA1222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BA1222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSjO-0004FO-St
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLScz-0003xf-Sb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLScy-0005yA-H6
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:49:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLScy-0005x2-BU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:49:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 652913001FEB;
 Fri, 18 Oct 2019 13:49:09 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2221360BF1;
 Fri, 18 Oct 2019 13:48:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/20] piix4: Add a i8257 DMA Controller as specified in
 datasheet
Date: Fri, 18 Oct 2019 15:47:40 +0200
Message-Id: <20191018134754.16362-7-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-1-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 18 Oct 2019 13:49:09 +0000 (UTC)
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Remove i8257 instantiated in malta board, to not have it twice.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-Id: <20171216090228.28505-9-hpoussin@reactos.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
[PMD: rebased]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/piix4.c       | 4 ++++
 hw/mips/mips_malta.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index ac9383a658..0b24d8323c 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
+#include "hw/dma/i8257.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
@@ -167,6 +168,9 @@ static void piix4_realize(PCIDevice *dev, Error **err=
p)
     /* initialize ISA irqs */
     isa_bus_irqs(isa_bus, s->isa);
=20
+    /* DMA */
+    i8257_dma_init(isa_bus, 0);
+
     piix4_dev =3D dev;
 }
=20
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e499b7a6bb..df247177ca 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -28,7 +28,6 @@
 #include "cpu.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/superio.h"
-#include "hw/dma/i8257.h"
 #include "hw/char/serial.h"
 #include "net/net.h"
 #include "hw/boards.h"
@@ -1430,7 +1429,6 @@ void mips_malta_init(MachineState *machine)
     smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
     pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    i8257_dma_init(isa_bus, 0);
     mc146818_rtc_init(isa_bus, 2000, NULL);
=20
     /* generate SPD EEPROM data */
--=20
2.21.0


