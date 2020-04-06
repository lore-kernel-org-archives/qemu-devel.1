Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A6FC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B5420678
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3AXRp7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B5420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOlF-0008Hy-2E
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjq-0006lk-UW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjp-0002tV-TZ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjp-0002rp-Ne
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id t203so5520035wmt.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5Mxtsabkw4+l/WTVOoVpBFDUZvdj1XOuvA+UEvVuiRQ=;
 b=U3AXRp7AIaQwzZ2uHFJCC1EDzMHUpzI8xf3HiO6hJHFObwyX/KMq5y4MbS3Foh9riP
 Lks2XAXLN18a0NNVTyXD2x2vEbS3FnOfAqfn60rhB+4u/b1GBILqf9MKXiw5odV3RR/v
 CINQfOnTL/TQB1JHeIMmNyieKVXHqH0UcJo+A2JPAlK0ovIMRZ5fZsXONinMr0SsLdQP
 +uE2P44JUWC7yXlMUi5cTZKM1xRLsiUgZoETN6QDHJp1tx2SgKlY6o6U8ZtwBQEqz7dZ
 hqWQpE0y0opuI9P//75+XFNr7j3xvVf3zBaBPVhP5NvBrwZSUAAdy/polwtd58KIvfao
 v4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Mxtsabkw4+l/WTVOoVpBFDUZvdj1XOuvA+UEvVuiRQ=;
 b=QWzGZ+tUhTZQU0MyAuhmWhthSaOUaZPXG1twgfj4yAlUj1qh7zRRDGG4tLiThJbk6L
 +/tFfB/nrPRdJ21BmkubysGZ7F0r2uAYdUTiqdxmAAZNPsUZqNSkOkvFsn5Uxn9dKCqS
 0aPffx1kMGMgyYtylom8y7WVkxGSxvJrVsE4af2Wd/nbimuU3AcDz7zB2nXbzFbw0LfF
 mWBEL/hn0FK54kL/PKGh1/kfLnJY163bc5iFTzVam3udOBalAowsFm5+FaYOzg96GIzh
 THuVIVx/j4yKLvYx4i1cpXp3OShE7WPTR0Sj9UVlnLQZkuZvYcvDGuDKBhKfkbXCLjor
 6kvQ==
X-Gm-Message-State: AGi0PuZA2buxv/iYH3sQLSAaVluphZZ3rt9I5Aos9X61sVYPBIT7OSTa
 1Iwj0pqqoOJUmmlA+K0wUdj5h6WiDoz0bw==
X-Google-Smtp-Source: APiQypKaPO+w/LwGvSQL9A2a+3WVZoctjtFWdYEzPwBEXfGm6aAGdkKnXswjxR5UsyyIoArpBdaYYw==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr3827252wme.75.1586167936519; 
 Mon, 06 Apr 2020 03:12:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] dma/xlnx-zdma: Clear DMA_DONE when halting
Date: Mon,  6 Apr 2020 11:12:03 +0100
Message-Id: <20200406101205.23027-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Clear DMA_DONE when halting the DMA channel.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200402134721.27863-4-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 6a4699757af..dd893bc420f 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -520,6 +520,7 @@ static void zdma_process_descr(XlnxZDMA *s)
     if (src_cmd == CMD_HALT) {
         zdma_set_state(s, PAUSED);
         ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, DMA_PAUSE, 1);
+        ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, DMA_DONE, false);
         zdma_ch_imr_update_irq(s);
         return;
     }
-- 
2.20.1


