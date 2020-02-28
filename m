Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FC3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32DE2468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1xz/9od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32DE2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ijU-0000Cd-SQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifR-00081S-6a
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifO-00021I-TN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifO-00020j-Mq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:10 -0500
Received: by mail-wm1-x342.google.com with SMTP id q9so3813156wmj.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nzBxpGRVoOvsVOJMyP7MLneRWhuVzeygLumjQm/0mJM=;
 b=M1xz/9odEHOQ0pmoGoBARbK67tiajNoZgo7Do6G4jCZBxG+o4/yauILySdCBb/7DjV
 ZrqGu5Yrg+eF24+SFAEeM4Ne/DuIsychEyl5iqJSO9kRAjGOORqTtC7LOZ1SYaRFEZrA
 t2A85dfftF9CLfB8vYvHLoBsnRZ8x7FomSRnc1aD9lbaIiQLdpQDbuXNPCy82AeJ7MwI
 /dnwb9TN7DzlCrPM6dzXoHJpivky4SN26sZskRlru+MzuJfdE8MEsbMdYo54VUfOBvKa
 QmHtOnlgL68W/WJGGyKiXEZHYt8ZhNxvNEo02VUQNGCZRTj4d9UQjhDQSht5e+u10zvt
 L7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nzBxpGRVoOvsVOJMyP7MLneRWhuVzeygLumjQm/0mJM=;
 b=NdhE/Muo6RPvS02rnTJ72LFqmO2weS1+0fh2pEGTpMVaLlXd9TycDfJGkddY6TmEH+
 oG9Q7vo1EcrBW5bE9CKI1gzogRvoKwfH4m/JUmx1ZqxJcaluWS0sQefdlERjbtLkN6z9
 NHrGT3dgERfM6Q6NNNtKklSSGhFJ17R/w2FBhaIzR53yBjwctTWO1lyQ6mKU6bbEMOjD
 0uHFGSsRfXR7hPBskD1SJkWCta87RY/RIgeneqBr/5Ql+TqHr0Hg/TvIDpgmvhaaMzGl
 OiHP/r+t+Gu6aHLvuo7gLgYdH8mFhyudWlWM7WsJ8rUblSrnXo2mRQs5o1sLHhYGt8aq
 ihBQ==
X-Gm-Message-State: APjAAAWPYflbPe4hvbSI/Tl5I4JJVhDV7a5uOELGJVdEa+9n9/4fGo/T
 uiPriMwvbQirEY+u561deWDFMgFyJGhUJQ==
X-Google-Smtp-Source: APXvYqxKRzWILLJBqyaGyirS6WISdqfbggTVeWHI4NrMdd59N9hhSKzU9cWWE0QH/WhxVq95mEHaeQ==
X-Received: by 2002:a1c:984a:: with SMTP id a71mr5800072wme.185.1582907949447; 
 Fri, 28 Feb 2020 08:39:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/33] hw/arm/xilinx_zynq: Fix USB port instantiation
Date: Fri, 28 Feb 2020 16:38:30 +0000
Message-Id: <20200228163840.23585-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: Guenter Roeck <linux@roeck-us.net>

USB ports on Xilinx Zync must be instantiated as TYPE_CHIPIDEA to work.
Linux expects and checks various chipidea registers, which do not exist
with the basic ehci emulation. This patch series fixes the problem.

Without this patch, USB ports fail to instantiate under Linux.

ci_hdrc ci_hdrc.0: doesn't support host
ci_hdrc ci_hdrc.0: no supported roles

With this patch, USB ports are instantiated, and it is possible
to boot from USB drive.

ci_hdrc ci_hdrc.0: EHCI Host Controller
ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
usb 1-1: new full-speed USB device number 2 using ci_hdrc
usb 1-1: not running at top speed; connect to a high speed hub
usb 1-1: config 1 interface 0 altsetting 0 endpoint 0x81 has invalid maxpacket 512, setting to 64
usb 1-1: config 1 interface 0 altsetting 0 endpoint 0x2 has invalid maxpacket 512, setting to 64
usb-storage 1-1:1.0: USB Mass Storage device detected
scsi host0: usb-storage 1-1:1.0

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200215122354.13706-2-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3d439a45d57..571cdcd599e 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -29,6 +29,7 @@
 #include "hw/loader.h"
 #include "hw/misc/zynq-xadc.h"
 #include "hw/ssi/ssi.h"
+#include "hw/usb/chipidea.h"
 #include "qemu/error-report.h"
 #include "hw/sd/sdhci.h"
 #include "hw/char/cadence_uart.h"
@@ -225,8 +226,8 @@ static void zynq_init(MachineState *machine)
     zynq_init_spi_flashes(0xE0007000, pic[81-IRQ_OFFSET], false);
     zynq_init_spi_flashes(0xE000D000, pic[51-IRQ_OFFSET], true);
 
-    sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSET]);
-    sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSET]);
+    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - IRQ_OFFSET]);
+    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - IRQ_OFFSET]);
 
     cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
     cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
-- 
2.20.1


