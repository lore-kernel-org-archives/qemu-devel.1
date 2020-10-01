Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8C8C4727F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C3820780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wmW5cn7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C3820780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzyJ-0003rW-PF
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsW-0004vR-Dn
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsU-0002xl-LV
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id k15so6104266wrn.10
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xJiJCZ6Kf1JVAV1tSNe0wywihXchNANfTnHnXrmJzNE=;
 b=wmW5cn7Mclc+G0aMQ0+gWIYFekQPm1cNJwPrqECtO96hXDdts8lBFE8QzD/Fu5SxbF
 3hf0jzILdK4d01z9bY98GN6KVb9GqQjeqINyBpUzphkk9ISCP9a68+ynXr8F4smNlAx1
 +JrZdgCFtrm0bCKnQoa8pSGIY0neHMdFq1fFyXl3rxMrdfp6dOZG4GXsES1GovvM0jUU
 igwTWpz1uVjv22aAIXNh2ZpjOlTVvjRsBKEHuMcA7uoeHCoaMH2tV27VeO/X+jwWFpad
 MxR40hn5AYPI9vVqkpWy8+B8Pyh3RuEzb8CXmXSFid3HxErxo1V/9Uv4MWayRzwPRk48
 gLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xJiJCZ6Kf1JVAV1tSNe0wywihXchNANfTnHnXrmJzNE=;
 b=N3SHam37QHc1b0K0cPJtHZao4UKWTx0vkaL1KHgdnXcoXyREN/0FnIm/PYwuJ8413o
 BmJnEAFTT/Cvsqg8oX4RQOEPe2nBW31/uT2GWw8B7MZbgQqNiqJ1+IekZL266+ZvMKOM
 nV1Ci08USWNKzjNcg7bsbx7CI1ExiU6RBuyHMIBy+hWZq4Yojj/OXgGHkPOV1h3RU5Er
 gNczLM4115mICMqdAsYw2A1fR6DPtMkPjLU+XkAp6/86xxnXWMkrAkGf4KW/aEJSChWK
 5MX0G0WD2BSkuBAq4WsFXBZFMK/RYwCtmZz4I1+wQVJvpWjktYsXMwOdEfZlJx6JovRB
 j8Ww==
X-Gm-Message-State: AOAM533Yz70tpiv0KTxCXsd1cAzN9HU2aFvO0xaCZSoedYNJrtIXnlv3
 iYkT/Us70ZsCHeD2CVpxOhYOR/cto3V2Fhdx
X-Google-Smtp-Source: ABdhPJwms7jYu2ZXDD4CW5n+YOxVn1J5U//kk5pKN2w9KBSjHQi+45+Z0ihe8d1P9op6b9BlBVXlsg==
X-Received: by 2002:adf:dcc7:: with SMTP id x7mr9598833wrm.203.1601563693036; 
 Thu, 01 Oct 2020 07:48:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/18] target/arm: Fix sve ldr/str
Date: Thu,  1 Oct 2020 15:47:47 +0100
Message-Id: <20201001144759.5964-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The mte update missed a bit when producing clean addresses.

Fixes: b2aa8879b88
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200916014102.2446323-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e4cd6b62517..c0d8a5863a2 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4290,7 +4290,7 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         for (i = 0; i < len_align; i += 8) {
             tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEQ);
             tcg_gen_st_i64(t0, cpu_env, vofs + i);
-            tcg_gen_addi_i64(clean_addr, cpu_reg_sp(s, rn), 8);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
         }
         tcg_temp_free_i64(t0);
     } else {
@@ -4379,7 +4379,7 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         for (i = 0; i < len_align; i += 8) {
             tcg_gen_ld_i64(t0, cpu_env, vofs + i);
             tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEQ);
-            tcg_gen_addi_i64(clean_addr, cpu_reg_sp(s, rn), 8);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
         }
         tcg_temp_free_i64(t0);
     } else {
-- 
2.20.1


