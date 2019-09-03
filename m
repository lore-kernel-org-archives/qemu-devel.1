Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4775C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0C62077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zkenw7tN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0C62077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5AvE-0005wP-4q
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArR-0002pv-3X
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArP-0005x7-Tp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArP-0005wa-NC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id 30so7041727wrk.11
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NjtHLR890FdwVKLAyT2SN75yV6fIIwqW8EkRht8FO+8=;
 b=Zkenw7tNFlOyNSkp/8WXRNoHFBds3lE5LyDaCVMd6npQSpLsd3o9s9jpezofycxckc
 Wj3C0pebOoZn8zSnl7+fFpOuM2nc3bB/yqG1zsAP1U4DyrVKopmJG1oouphdNSNwbaFW
 4hvDUvzIeXLKuvYds7EXep+nmrlanzREhcDbc6ESEVVeCW3Rke3IoCNn6gcJ0pne93fh
 RoPA7GMiHcC593stot8qLwt1XGi1BXK8xxJOohF3vWzmnW3/z3DmHMa0gw7nrC66qlbb
 gUBS/tNp9PL0Snrt2WhGuusvyF5cuV52DhTXjaqZX00Mj8jAbS2S/QG5h+pxSowxcMR6
 iojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NjtHLR890FdwVKLAyT2SN75yV6fIIwqW8EkRht8FO+8=;
 b=YpCpFhCfHPurJvz5iV+24NOKE0ExS3HaNAQXIelL/fz8h/t94c/d8aH6AuWesKtlpI
 nuWYDplSlgFyolOxbkLwLvjNs2MC4hltULL/aj4A2/kuedq1wPj3T9jyljulHyvROvqB
 imS7yE0vnWuCgozkGST8TQxexGjX2yf1T3wmpr22sB4CNGJW29akb1kPhzvz29uP3TqJ
 tCDA863X2GQ4xHAIpXxE5SJGsUYC7G5KLF6TGEjMAO45EC+952wtSd0rGbinA18udCH/
 IrGxQhGUUNjZQfWfGnAA7IStMxTC2fl7MbgNg23gFAFfZvBXHJbClFrb+dJZq7k3q5Ef
 hvoQ==
X-Gm-Message-State: APjAAAXE3OnzAdb1Hyj3S8b5yj1hrGfmwp3231tHryK6zDAa6zbHkju5
 9zmVUhlyphfKZ6yMEo+t+sap4zkNseRWqA==
X-Google-Smtp-Source: APXvYqzwUqSRA3G8z5bDpYA/Gt+dmvzvMGR+qWtX0CBwaF6rG8YmpTS5NklKX4w+QX7R1PJJYIDDYw==
X-Received: by 2002:adf:f00b:: with SMTP id j11mr27073913wro.298.1567525006490; 
 Tue, 03 Sep 2019 08:36:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:21 +0100
Message-Id: <20190903153633.6651-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 09/21] target/arm: Fix SMMLS argument order
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

From: Richard Henderson <richard.henderson@linaro.org>

The previous simplification got the order of operands to the
subtraction wrong.  Since the 64-bit product is the subtrahend,
we must use a 64-bit subtract to properly compute the borrow
from the low-part of the product.

Fixes: 5f8cd06ebcf5 ("target/arm: Simplify SMMLA, SMMLAR, SMMLS, SMMLSR")
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190829013258.16102-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 78d93f63cab..cfebd35d268 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8831,7 +8831,16 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         if (rd != 15) {
                             tmp3 = load_reg(s, rd);
                             if (insn & (1 << 6)) {
-                                tcg_gen_sub_i32(tmp, tmp, tmp3);
+                                /*
+                                 * For SMMLS, we need a 64-bit subtract.
+                                 * Borrow caused by a non-zero multiplicand
+                                 * lowpart, and the correct result lowpart
+                                 * for rounding.
+                                 */
+                                TCGv_i32 zero = tcg_const_i32(0);
+                                tcg_gen_sub2_i32(tmp2, tmp, zero, tmp3,
+                                                 tmp2, tmp);
+                                tcg_temp_free_i32(zero);
                             } else {
                                 tcg_gen_add_i32(tmp, tmp, tmp3);
                             }
@@ -10075,7 +10084,14 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     if (insn & (1 << 20)) {
                         tcg_gen_add_i32(tmp, tmp, tmp3);
                     } else {
-                        tcg_gen_sub_i32(tmp, tmp, tmp3);
+                        /*
+                         * For SMMLS, we need a 64-bit subtract.
+                         * Borrow caused by a non-zero multiplicand lowpart,
+                         * and the correct result lowpart for rounding.
+                         */
+                        TCGv_i32 zero = tcg_const_i32(0);
+                        tcg_gen_sub2_i32(tmp2, tmp, zero, tmp3, tmp2, tmp);
+                        tcg_temp_free_i32(zero);
                     }
                     tcg_temp_free_i32(tmp3);
                 }
-- 
2.20.1


