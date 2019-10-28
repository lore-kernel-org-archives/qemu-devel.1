Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6314CCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359AB214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StMie+Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359AB214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9HT-0006fj-Jv
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iP7zn-0002KF-E4
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iP7zb-0007Z8-By
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21341
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iP7zZ-0007WK-Fy
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572280537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1mnDPhJBEXVD5ywhdmqBZq3BJFN2BPl11JdMUU6s1g=;
 b=StMie+PdK6XF0+PARBp2YMjWEkiba0MffttoVHv6jWG/V5hqkH+7npoMd8FXQvPhMkNXAR
 d+cwr0wjjHc5gVyiCd+X9iQZHhWiQhtZyjbu3C64n1pS0j33wxZsAwEZ9m5bkZoYmSrUAf
 AxovctCoay16nyJve9d4l9zUgGcwlAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-b9hocVO-P5qNwLHRKkn5uw-1; Mon, 28 Oct 2019 12:35:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8159107AD28;
 Mon, 28 Oct 2019 16:35:32 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-87.brq.redhat.com [10.40.204.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F3E26199;
 Mon, 28 Oct 2019 16:35:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/20] piix4: Add an i8254 PIT Controller as specified in
 datasheet
Date: Mon, 28 Oct 2019 17:34:34 +0100
Message-Id: <20191028163447.18541-8-philmd@redhat.com>
In-Reply-To: <20191028163447.18541-1-philmd@redhat.com>
References: <20191028163447.18541-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: b9hocVO-P5qNwLHRKkn5uw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Remove i8254 instanciated in malta board, to not have it twice.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-Id: <20171216090228.28505-10-hpoussin@reactos.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/piix4.c       | 4 ++++
 hw/mips/mips_malta.c | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 9ebe98bdc3..c07a1e14a8 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -30,6 +30,7 @@
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "hw/dma/i8257.h"
+#include "hw/timer/i8254.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
@@ -168,6 +169,9 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     /* initialize ISA irqs */
     isa_bus_irqs(isa_bus, s->isa);
=20
+    /* initialize pit */
+    i8254_pit_init(isa_bus, 0x40, 0, NULL);
+
     /* DMA */
     i8257_dma_init(isa_bus, 0);
=20
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 44e5f8b26b..9af486c77c 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -45,7 +45,6 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/timer/i8254.h"
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"             /* SysBusDevice */
 #include "qemu/host-utils.h"
@@ -99,8 +98,6 @@ typedef struct {
     qemu_irq i8259[ISA_NUM_IRQS];
 } MaltaState;
=20
-static ISADevice *pit;
-
 static struct _loaderparams {
     int ram_size, ram_low_size;
     const char *kernel_filename;
@@ -1428,7 +1425,6 @@ void mips_malta_init(MachineState *machine)
     pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
     smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
-    pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
     mc146818_rtc_init(isa_bus, 2000, NULL);
=20
     /* generate SPD EEPROM data */
--=20
2.21.0


