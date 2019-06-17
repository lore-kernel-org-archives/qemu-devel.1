Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFCCC31E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8955520833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfhuD0Pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8955520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctVB-0002W9-Ri
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46675)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiK-0003Zw-Fl
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiI-000851-Sj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiI-00084S-Jz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so10192048wrw.13
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ayi0GkBgLKY3AdrRPsXWIx7VD1COuTHMv3O+HeMPbB0=;
 b=WfhuD0PzKdy+iiteBQFDe2da6G+5lxjDaa9BE4Mz8P6fZBfIum8Px3CFAS83lyP8u/
 msLLlrVIqJkqN+gbHtcszpBGuwx/0qzYMS9phVHJA4UKZs9Zw7rZCUSNDfYXppYLo0TM
 TwGA2PkMVJ8ugMibl9JMjwjVke9xjrj/VutHeRDZ5KHwK3O4OKO5JxqyA7YrmmiE6lGI
 xukuH19e2vb1dZ1YqdRJ9w9citZaniyh0yvVQHimJnibiWdUPMjBKphAELkuBPLSRYFO
 eQ7NZ6iOeQKamw7EhT+KjLLfGRynjMq4J5+6blS8c72P+Ce51pl3WacNE3h9B6PSsKCM
 xCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ayi0GkBgLKY3AdrRPsXWIx7VD1COuTHMv3O+HeMPbB0=;
 b=NWrQmth9IfZhCo6snDtMA3/G+58N/7n2ateuBz5qMufbLOjTKqujxm81VHtDd29M8g
 1H0nEqOw9LsOUmZ4IYqAQOVwV7q9gpXSYU7f7Eag5YLCxwSgowHnJvgCYm9B93RBz15b
 0NBI4nlTvI5/sJJZZ4prS6UMjXH7a3nr4m20d4mgwch0+jgGtzc1LJpcWlrLWVXtIsSf
 W1XGx/5fnQU6Jz2N73l+QGwVMTnxS15jo6H+sA2X+48y3t6WlnLnzOTzFbWwtWYlOofs
 0/iQw8V+TWr/+/SxrSnbcDj0nm2ECTuxPvXQvv5ZBZQJEMdh4K+z2Xh0Z41uQNPX+DS/
 S37g==
X-Gm-Message-State: APjAAAWyVVNMHf36wWrIe7uRO+mJGRr7JaE7WpGewj+gH8fZiUIFuHcx
 zdu3VvuG5MKKWa3pn3CstFqlVWR3OgFs7w==
X-Google-Smtp-Source: APXvYqyX5cK0m8KxamQYgJcBlGWQI49b9fOYO3fbsPrXiJGLJ4cIBKUH0HwVsnWjcYFT7V5V7RgtTw==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr1996411wrs.183.1560782065136; 
 Mon, 17 Jun 2019 07:34:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:58 +0100
Message-Id: <20190617143412.5734-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 10/24] hw/intc/arm_gicv3:
 GICD_TYPER.SecurityExtn is RAZ if GICD_CTLR.DS == 1
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

The GICv3 specification says that the GICD_TYPER.SecurityExtn bit
is RAZ if GICD_CTLR.DS is 1. We were incorrectly making it RAZ
if the security extension is unsupported. "Security extension
unsupported" always implies GICD_CTLR.DS == 1, but the guest can
also set DS on a GIC which does support the security extension.
Fix the condition to correctly check the GICD_CTLR.DS bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190524124248.28394-3-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_dist.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index e6fe4905fd3..b65f56f9035 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -378,8 +378,14 @@ static MemTxResult gicd_readl(GICv3State *s, hwaddr offset,
          * ITLinesNumber == (num external irqs / 32) - 1
          */
         int itlinesnumber = ((s->num_irq - GIC_INTERNAL) / 32) - 1;
+        /*
+         * SecurityExtn must be RAZ if GICD_CTLR.DS == 1, and
+         * "security extensions not supported" always implies DS == 1,
+         * so we only need to check the DS bit.
+         */
+        bool sec_extn = !(s->gicd_ctlr & GICD_CTLR_DS);
 
-        *data = (1 << 25) | (1 << 24) | (s->security_extn << 10) |
+        *data = (1 << 25) | (1 << 24) | (sec_extn << 10) |
             (0xf << 19) | itlinesnumber;
         return MEMTX_OK;
     }
-- 
2.20.1


