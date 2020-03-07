Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ED0C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 09:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0A2206D5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 09:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0A2206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAVXq-0004L2-IM
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 04:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAVWV-0002UN-Io
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 04:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAVWU-0003SJ-J9
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 04:13:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:37970
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAVWU-0003RU-DT
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 04:13:30 -0500
Received: from host86-162-6-80.range86-162.btcentralplus.com ([86.162.6.80]
 helo=kentang.home) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAVWk-0006ZF-EU; Sat, 07 Mar 2020 09:13:51 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	rth@twiddle.net,
	jsnow@redhat.com
Date: Sat,  7 Mar 2020 09:13:12 +0000
Message-Id: <20200307091313.24190-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200307091313.24190-1-mark.cave-ayland@ilande.co.uk>
References: <20200307091313.24190-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.162.6.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 1/2] dp264: use pci_create_simple() to initialise the
 cmd646 device
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the call to pci_cmd646_ide_init() since global device init functions
are deprecated in preference of using qdev directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/alpha/dp264.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index d28f57199f..f24b34b62e 100644
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
@@ -100,9 +101,12 @@ static void clipper_init(MachineState *machine)
     /* IDE disk setup.  */
     {
         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+        PCIDevice *pci_dev;
+
         ide_drive_get(hd, ARRAY_SIZE(hd));
 
-        pci_cmd646_ide_init(pci_bus, hd, 0);
+        pci_dev = pci_create_simple(pci_bus, -1, "cmd646-ide");
+        pci_ide_create_devs(pci_dev, hd);
     }
 
     /* Load PALcode.  Given that this is not "real" cpu palcode,
-- 
2.20.1


