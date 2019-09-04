Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C2FC3A5AA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4672077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGBjdgwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4672077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5b2j-0006nv-00
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azh-00042B-GS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azg-00021b-Be
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:05 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azg-00020z-68
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:04 -0400
Received: by mail-pf1-x441.google.com with SMTP id q10so8851736pfl.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FjDIKcJDagE4KvmbL7+MpEBImmBNGJkd778M5x6AXXs=;
 b=UGBjdgwLFxZQx/7pCfVP8X7GevREYhNUXRnu5/WhhS3Dsv/v5o4cV4hg2C57d8LLK9
 WemmVHXsSrwYfz6RZq7JkIWRNh3EoG3qdTis/hP4Euey8urPGn/7fbFaVddiXPvnPg6y
 qbavQnIApVlH1A50cgjvtr+dylOE/8x5OT75eidBdTUvDZWws17i1u1+pGhTYL37dA5A
 tHIMgUkSojAZiWhT0nxdlCTksQfTRzyjmgNl0vOzHvxaMnCuFz1KpctmTxqc3vRloKhD
 KCYQYEvtIoLk8YxGujIxkmEKE7zjDmhUZUhZ7FeEIlbAMBC9mQuPUxbOiiz2cPzfoo/M
 qweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FjDIKcJDagE4KvmbL7+MpEBImmBNGJkd778M5x6AXXs=;
 b=pxMbrcJN2upH5yxOwWgpu2/488/YlWN6zHCYBmSmzC0JNORPVGvkMSUkkhkX2JDEXt
 hD3PJ1f0e/yj21iWCcMClthcPoZxBV7gDJWlCmAQdierIZjijyyMgYqo/F3vaCxdJbCA
 sCFhkaS6M6yP6mMN6HrIvNq827kx4Dr+YT9WaP74ugW4Gl5jnBEN0EzZ3dpIlTXUL2R2
 LRNyQhM2856wewnUCCM6quJ8CbFW9ovixFas4N42GU473Kj61FMMoNlNPBNc5+GtTkZo
 V85aSepT353oqMe1muFp/xtfYZJaRYiMv3qK+PWRE0RLzizunBb6kOEXrfvanydCqF9U
 z1Fg==
X-Gm-Message-State: APjAAAVqJXci8ShJyo5LHpapqC7SX6F8dxQsduTtvvEIp/6yeCsPaDnp
 SQfuZ5fbFBUEdUtd9BEvMyyxRSU17OQ=
X-Google-Smtp-Source: APXvYqyqccW8btYoqgllDrn7+3LpHRtsWtTHd29gzh21bx4YRhFMAHF8CdWmrrRj4yUbeAu9ZjCCoA==
X-Received: by 2002:aa7:9508:: with SMTP id b8mr31570203pfp.36.1567625462903; 
 Wed, 04 Sep 2019 12:31:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:29:51 -0700
Message-Id: <20190904193059.26202-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v4 01/69] target/arm: Use store_reg_from_load
 in thumb2 code
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function already includes the test for an interworking write
to PC from a load.  Change the T32 LDM implementation to match the
A32 LDM implementation.

For LDM, the reordering of the tests does not change valid
behaviour because the only case that differs is has rn == 15,
which is UNPREDICTABLE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b0d32ff8c9..a39f792463 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9742,13 +9742,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         /* Load.  */
                         tmp = tcg_temp_new_i32();
                         gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                        if (i == 15) {
-                            gen_bx_excret(s, tmp);
-                        } else if (i == rn) {
+                        if (i == rn) {
                             loaded_var = tmp;
                             loaded_base = 1;
                         } else {
-                            store_reg(s, i, tmp);
+                            store_reg_from_load(s, i, tmp);
                         }
                     } else {
                         /* Store.  */
@@ -10889,11 +10887,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 tcg_temp_free_i32(addr);
                 goto illegal_op;
             }
-            if (rs == 15) {
-                gen_bx_excret(s, tmp);
-            } else {
-                store_reg(s, rs, tmp);
-            }
+            store_reg_from_load(s, rs, tmp);
         } else {
             /* Store.  */
             tmp = load_reg(s, rs);
-- 
2.17.1


