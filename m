Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B045C4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4962F2081B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqEIbkAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4962F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nux-0004fN-Nn
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npm-0007dK-G0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npl-0000u5-BU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:06 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8npl-0000sv-5Z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:05 -0400
Received: by mail-wr1-x435.google.com with SMTP id h7so31580588wrw.8
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tBSweGRJqo1QugNMOgMsQvTUwdKJFX5c4+9Ab8DGWNg=;
 b=IqEIbkAmJduDpgu6zcdRZY2Ye0s5mHWAKQtx1Tsixu31bVJygBgUGMlP75rXi83qNY
 O9wFEKWvnMxGA3b0j9+8RAmhCW1mUYpSINdWZJTmNLLD3RCi8K54fl/Ujd1F5RjC7D4x
 VPqz1K0IdFaRYFDqIILGfg5abm6eTS30STD3OcsnfsnDAEseL7hzhHomo3lhCuqp2td4
 jP3L2KOgJjaPYR/EtH/Ue00KO9U95AkLQ3bSSSLx5ZhgFOKz4C0ElthyM3vrNMa0EUp8
 NwfnPPRRRN5sgNoNTY2JGP24UPRlTidYO0ZnAFvZkKjGJLw8rGbSOPbAa/8l4qnaYmMD
 heVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tBSweGRJqo1QugNMOgMsQvTUwdKJFX5c4+9Ab8DGWNg=;
 b=oa4ZONbqqK5HtSVStqtPVKyNmTFVXMst0qvJBbqORh3By6yqhWRxPtwTQsyxKG9pXr
 h2W1k9+EJMAUQWulxTO6piWXjCLeW8aOymuW+ISRm4RfGMNfH6SMrgeqwTgIJznNfBW9
 tC5NqX40JbwVs2ZAMprb7Mk1+LWHLYuMZ2Ye+4YBPW/fjssTbbaFh27CdGoV4CYQHIYq
 QvIrF2pb8DjHooZxufzgDypLtkrXKCtTak5BsSCpALoVfNgm5DrPTrwh9+2hvHnlEpQ5
 xDvO7Aq5D83aR/2cwx0yH7fuLc0uhHioe4E9hxygFjtTVxskcODVbHAUWoWhIfYQCwmR
 D4Nw==
X-Gm-Message-State: APjAAAXpgB8IAvOIqB9StkCsu6F+76UdYjZgBjNl7oatz9Cqcc42WLp5
 xzQ1fM8BPpwZXbXoV0HtqsxWH4W/v/VfsA==
X-Google-Smtp-Source: APXvYqyuE5pwz4zSc7LzKTuFJAK5xayFVdJ7iBfGGEDLqjFq6LAM9vuZO3jA1PApRamnvIckIboSug==
X-Received: by 2002:adf:e947:: with SMTP id m7mr1409792wrn.178.1568389804001; 
 Fri, 13 Sep 2019 08:50:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.50.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:50:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:48 +0100
Message-Id: <20190913154952.27724-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 08/12] aspeed/smc: Calculate checksum on normal
 DMA
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

From: Christian Svensson <bluecmd@google.com>

This patch adds the missing checksum calculation on normal DMA transfer.
According to the datasheet this is how the SMC should behave.

Verified on AST1250 that the hardware matches the behaviour.

Signed-off-by: Christian Svensson <bluecmd@google.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190904070506.1052-9-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 5c3436db5e8..9ffc7e01179 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -989,6 +989,7 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
         s->regs[R_DMA_FLASH_ADDR] += 4;
         s->regs[R_DMA_DRAM_ADDR] += 4;
         s->regs[R_DMA_LEN] -= 4;
+        s->regs[R_DMA_CHECKSUM] += data;
     }
 }
 
-- 
2.20.1


