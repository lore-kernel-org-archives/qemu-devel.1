Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59580C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D9E20663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5wxTZCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D9E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXCw-0000p7-Eg
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1y-0007oN-5o
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1u-0003kd-8M
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1q-0003AO-Hm
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id f15so5621190wrp.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HOm2CbtgSjlbFOA7w5702X1sF3QJOmfprmZwNYY5LhY=;
 b=Z5wxTZCK1uB1wFDuzBbKJsKri+5wjc6KJiCn3FzzIbOeyB3mj8gmd+dhQ8HSfcJW8D
 U3IlISELC0eX9Z/eq2VyXn3bE0bpoY7Cm9L7JLlSCJgwYX0A7oAxIZ9XGCShopGf9/pg
 UBPFGF95yJo6XonMkc83lDMjWCE2Dg3Bw0tmIyzyKNIBHwUUgg0BKB+RU3d0s0XreWHD
 WQil2znc1wpFp4/94euzQY3GCRShOzav1jdYz+949Xdlx8r/wJEcz+zSYgoQqUKX8hlr
 3Jdao4Fx5kt/8tYyeBA244niOSN5OBinABuxKzmAXRxuRMIEf9gpFKY74NHfzicyfaPh
 ffAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HOm2CbtgSjlbFOA7w5702X1sF3QJOmfprmZwNYY5LhY=;
 b=SOw+1c4eDV4MSDMr/hJz3tGeHTVrzDnAsZhncwEAqtqapAVD2BOHC+nxM4f+ZCPHt0
 jBEuGeZEZkXEM7VDVVMERHji+twxvCil6768ywbAZTP4sqy4M/G2VCCWzJFEn65ztJyD
 Arp2NXLVWFJr9c4YuKE4LT/3XDcGeJOMHsKqsYZl+sv6dyieACyCbrxpjktaCMJX9f9/
 motaX1gpdPzoSut9qQS6Lyv4AJAE4vvqsNCzK8p6kY+MYn3BilELGHXKedbrhrNqsCbd
 3Co9YRuzNDL8Q5Mb4A2b9G6DmCIoiSJiY2VOec6iZf6Dt3QjvtNkkw1zigxtN7nArpte
 I2PQ==
X-Gm-Message-State: APjAAAURbFudR8dvYkPdLaIF4mth7wwNvCWd9vfIF97l7HKHsSWCEwZf
 PoZsafN08P2XPCABcArgO1qatk6v
X-Google-Smtp-Source: APXvYqx+QmtgCy4HL7VJWm1FgASUGcFH/SufN8h6XUcXs5oh0dwXuoXXhrAVGv6IDdUMUd/+0DBgEw==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr35317620wrw.232.1561413668126; 
 Mon, 24 Jun 2019 15:01:08 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.01.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:01:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:54 +0200
Message-Id: <20190624220056.25861-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624220056.25861-1-f4bug@amsat.org>
References: <20190624220056.25861-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 7/9] hw/sparc/sun4m: Mark some devices as
 'unimplemented'
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These devices are not slots on a bus, but real devices that
we do not implement.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc/sun4m.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index cc85598d5b..0df5a8edfc 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -42,6 +42,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
 #include "hw/misc/empty_slot.h"
+#include "hw/misc/unimp.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "trace.h"
@@ -970,7 +971,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     }
 
     if (hwdef->sx_base) {
-        empty_slot_init(hwdef->sx_base, 0x2000);
+        create_unimplemented_device("sx", hwdef->sx_base, 0x2000);
     }
 
     nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
@@ -1033,14 +1034,16 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     if (hwdef->dbri_base) {
         /* ISDN chip with attached CS4215 audio codec */
         /* prom space */
-        empty_slot_init(hwdef->dbri_base+0x1000, 0x30);
+        create_unimplemented_device("SUNW,DBRI.prom",
+                                    hwdef->dbri_base + 0x1000, 0x30);
         /* reg space */
-        empty_slot_init(hwdef->dbri_base+0x10000, 0x100);
+        create_unimplemented_device("SUNW,DBRI",
+                                    hwdef->dbri_base + 0x10000, 0x100);
     }
 
     if (hwdef->bpp_base) {
         /* parallel port */
-        empty_slot_init(hwdef->bpp_base, 0x20);
+        create_unimplemented_device("parallel", hwdef->bpp_base, 0x20);
     }
 
     initrd_size = 0;
-- 
2.19.1


