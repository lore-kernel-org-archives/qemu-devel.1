Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C3FC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799882054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqKD0wbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799882054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOqm-0002AZ-KE
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOk0-0006y6-P9
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjq-0002uF-MT
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjq-0002tb-Gr
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id j17so16628546wru.13
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PzdovVtNp3mfDYAEJlHSjvapxn9iZ3p1XuB2BfZl6uY=;
 b=RqKD0wbAS9KPhFCzEL5MFw0OOpvBL8mHSXGKVyvIMdkf8f+YN4QfXULVQx+9Y/7waH
 aXQDmTbTm9AN6Dzoje1Tk7CWX5GLaK5pDrhbTq7ckFjaKJCzRaNvWZXVXds6rXUuCHuv
 +Tl7kiZrRhQyc4NesIs1UwEDPi5eeNAPiS+FoXZC1+cdbE6aM/bUHFXGB05M4Lzt4KsR
 +LqBZMGVqgFTx2hgqzQyfbvcbs/+30P/21c3tAmi4B27hEzsSxA+qjoLzHXr7naVxmGd
 0CIiWvTK6nfn7sZz/Ra5ph/Sdaw6C5Xsi4rcinpaWcW88o+OKpzmKpIvDuyTMa1/nH8U
 6XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PzdovVtNp3mfDYAEJlHSjvapxn9iZ3p1XuB2BfZl6uY=;
 b=mAstC2GegkX+vZYx2RfVZmBX6BaAL+TCZzPzyOsWmApG/9/qrVG0UT7/XhJLQ+19KA
 X8wjUvfTrjuVRQTl4ItpyShbmgk0gdQ2BMg9ybVY7sl3WgEyvNyY57o3hXOsMDm5MM5Z
 z+WQ26V6upVNRhO8PXRfTj2xtKnqPuTRUfAXzypJsYPkasJe0Fz842WY1Lo2Aeu8b+w5
 0ZuEoi+zEgtnWWU7RGgnyoNQwMwbViyLAMIZe8ceqUkct/qyEVUO9hr+bP39CqItzfbr
 9srviaO8UqJhS73v1oKOXptTfWnRi+lXhJQ4G3ilRdAhQD90t8g+PV0m0gXW5We0GB5v
 ZveA==
X-Gm-Message-State: AGi0Pua4MPY8cx8Ie/JprEveQD8Tkii/yuBhWDnIZ8+/gz0ygVSttlAM
 wE/jjVF6L9kuH6RLtB1MtPCoPcrJ4it+3w==
X-Google-Smtp-Source: APiQypJGtQcyUxdD3vcX+40x5dPZbzshddXm+HySJvQ56uwUWO/Uk46mslgUtgukdmCL859jDgPs1A==
X-Received: by 2002:adf:a482:: with SMTP id g2mr17787604wrb.214.1586167937426; 
 Mon, 06 Apr 2020 03:12:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] dma/xlnx-zdma: Advance the descriptor address when
 stopping
Date: Mon,  6 Apr 2020 11:12:04 +0100
Message-Id: <20200406101205.23027-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

Advance the descriptor address when stopping the channel.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200402134721.27863-5-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index dd893bc420f..e856d233f2d 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -514,7 +514,6 @@ static void zdma_process_descr(XlnxZDMA *s)
     if (ptype == PT_REG || src_cmd == CMD_STOP) {
         ARRAY_FIELD_DP32(s->regs, ZDMA_CH_CTRL2, EN, 0);
         zdma_set_state(s, DISABLED);
-        return;
     }
 
     if (src_cmd == CMD_HALT) {
-- 
2.20.1


