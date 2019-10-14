Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A6C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244B720854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUaB6jCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244B720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3ep-0003g4-2m
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2r4-0005j7-8z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2r2-0008N2-Cy
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2r2-0008Ly-3E
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id b24so17302664wmj.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=C6hx9VEDPUQFFEw9ZY8vKZMPEGQy47fWl3oWJsaPD+Q=;
 b=DUaB6jCJeW3ao7ijQf5WSwKmMZoUDYF7Sr+aD1vbhd7NqhfKgZG6pdQln7yRn/A1/B
 DBY4aZrdh1a8D6e/qXTQJjIUKpzjCGc1U6GKbxUbiYQx21qzFIJ7kr9Pr+dma75B0cSg
 jLDs/vwCoA0ZTgiQWfbF0iCoIXaCnO5g4jF1zZVPup1q9M2U2WRpw+0sljGQQAAfDfXj
 PSUlaBri5noXlkKKzO9jiei9I36hfDLlwkJQ874veiePppBH7xBLF4h6oLN7DrJ6Xcqk
 bbBNJbTC3/WmulxQusCeTZ/uy4/fkIjR7KZ6ZkUGsiNASpeXOVym9DAhSBoo+scC5I82
 41Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C6hx9VEDPUQFFEw9ZY8vKZMPEGQy47fWl3oWJsaPD+Q=;
 b=QZxelIxhw1G/Uz4NmJkkUvtujhNGEfuJpXreAVISK7oShnDGe+Ke0pn0RU6ydLAfKK
 Pd/eoIpu86Z1SMErl+2qp+bEZifM53sUW/2NbRd0nM01C83etIRtkdp7uE0CGMRk/s4L
 IBY3ZxiCoiiilCOx+XsQcSrshXz+eZV5eJtfqBX7Ru2yEtU+Vu1e/mLd8cH96IwFqOik
 7GpMNnIWvUJrI2nPY16fbXylLd+Q+gaN7Eot4sp16jgs85V4dv8B2h/Az9DJ26T0ZdT5
 9vjyPUNCGrdaOPCg9YqDDM4cdfc+gxC3qS5K4UlRmk/sekSSlaLXtns5zthFg8K3zaI6
 nOAg==
X-Gm-Message-State: APjAAAUgsrIsQnZqSKJcE7TJsnjJShUY9HQ/oJjdNz7LaMyDjR1PczO/
 521fLmuGS2mvmU0JR0TanbRHHiVWPH28pQ==
X-Google-Smtp-Source: APXvYqx5m6tg6Crn3bUh1GP0Lrq6ZZSXH4QB4kjZAKOkLUa8ToMhh2eoscmx7TMA2D2QYQ2hPmPVGw==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr15238503wmj.85.1571069150558; 
 Mon, 14 Oct 2019 09:05:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/68] hw/misc/bcm2835_mbox: Add trace events
Date: Mon, 14 Oct 2019 17:04:04 +0100
Message-Id: <20191014160404.19553-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add trace events for read/write accesses and IRQ.

Properties are structures used for the ARM particular MBOX.
Since one call in bcm2835_property.c concerns the mbox block,
name this trace event in the same bcm2835_mbox* namespace.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190926173428.10713-8-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_mbox.c     | 5 +++++
 hw/misc/bcm2835_property.c | 2 ++
 hw/misc/trace-events       | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 77285624c9f..77d2d80706c 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -15,6 +15,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 #define MAIL0_PEEK   0x90
 #define MAIL0_SENDER 0x94
@@ -123,6 +124,7 @@ static void bcm2835_mbox_update(BCM2835MboxState *s)
             set = true;
         }
     }
+    trace_bcm2835_mbox_irq(set);
     qemu_set_irq(s->arm_irq, set);
 }
 
@@ -178,8 +180,10 @@ static uint64_t bcm2835_mbox_read(void *opaque, hwaddr offset, unsigned size)
     default:
         qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx"\n",
                       __func__, offset);
+        trace_bcm2835_mbox_read(size, offset, res);
         return 0;
     }
+    trace_bcm2835_mbox_read(size, offset, res);
 
     bcm2835_mbox_update(s);
 
@@ -195,6 +199,7 @@ static void bcm2835_mbox_write(void *opaque, hwaddr offset,
 
     offset &= 0xff;
 
+    trace_bcm2835_mbox_write(size, offset, value);
     switch (offset) {
     case MAIL0_SENDER:
         break;
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 43a5465c5dc..0eea2e20f79 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -13,6 +13,7 @@
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
@@ -283,6 +284,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         }
 
+        trace_bcm2835_mbox_property(tag, bufsize, resplen);
         if (tag == 0) {
             break;
         }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 74276225f81..1deb1d08c19 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -143,3 +143,9 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU wri
 
 # aspeed_xdma.c
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
+
+# bcm2835_mbox.c
+bcm2835_mbox_write(unsigned int size, uint64_t addr, uint64_t value) "mbox write sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
+bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "mbox read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
+bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
+bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
-- 
2.20.1


