Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC3C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D5520674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWuTG5O6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D5520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42895 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELaK-0001Kq-QF
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELZ2-0007tm-Qk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELZ1-0000lx-MJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELZ1-0000jc-Hk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UZ8FByt5+RSoyescxnZG3nj5fi4dBjqEbnSTh+hW7o=;
 b=VWuTG5O6nMPbnT1qkjhrJ/WGFmPUUmGcP7HdPwNffRvntwWV9BoWcoza7OV0bxdzjerQOL
 BK9GB02Zq9UL4KvxhgMwposT8RI2VjB0O7taAE3ZDwaqahkf/OH0Z+4MQA0y2zvcphyoKi
 mfsqf16co4Quh+RNa7TspxiEtAIXlH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-TTW-PHrVNSi5H3Cc5zY4ag-1; Tue, 17 Mar 2020 19:23:57 -0400
X-MC-Unique: TTW-PHrVNSi5H3Cc5zY4ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9E0918A6EC1;
 Tue, 17 Mar 2020 23:23:54 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 612C660BE0;
 Tue, 17 Mar 2020 23:23:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/20] dp264: use pci_create_simple() to initialise the cmd646
 device
Date: Tue, 17 Mar 2020 19:23:12 -0400
Message-Id: <20200317232329.22362-4-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Remove the call to pci_cmd646_ide_init() since global device init functions
are deprecated in preference of using qdev directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200307091313.24190-2-mark.cave-ayland@ilande.co.uk
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/alpha/dp264.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index e5350a287f..27595767e5 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -16,6 +16,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/ide.h"
+#include "hw/ide/pci.h"
 #include "hw/timer/i8254.h"
 #include "hw/isa/superio.h"
 #include "hw/dma/i8257.h"
@@ -101,9 +102,12 @@ static void clipper_init(MachineState *machine)
     /* IDE disk setup.  */
     {
         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+        PCIDevice *pci_dev;
+
         ide_drive_get(hd, ARRAY_SIZE(hd));
=20
-        pci_cmd646_ide_init(pci_bus, hd, 0);
+        pci_dev =3D pci_create_simple(pci_bus, -1, "cmd646-ide");
+        pci_ide_create_devs(pci_dev, hd);
     }
=20
     /* Load PALcode.  Given that this is not "real" cpu palcode,
--=20
2.21.1


