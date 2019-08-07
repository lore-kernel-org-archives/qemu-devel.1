Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6733521743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTR4UeG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6733521743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvE2q-0004Nf-Og
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxX-0001Zb-K2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxW-0004w8-Hk
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:59 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxW-0004vZ-CE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id k8so38798915plt.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=S3x0I1syk+FpjUOME51Sa5kikQHI1eNJn5aK0q1qog4=;
 b=mTR4UeG7b76CFYD3I7WgV0qeo73dQZRYHu9XVs893lIFwhdZf4GADDX0WNwRFdT424
 0JyCDnNk9Nvotd7uo3z6yyYNp5ikuETD1mFFCC9nCnCxj7K7LrMTtCuWyj7F2zBSXyeX
 drvs4t5v8+5m1PSkHSF3+6cRiAuyNUjrsPDo/Y7bLeSL8fVEON0ItlIboRTpsuTXDLE7
 gBvXgvHp3PNpdxyarqAnMsFYrwosedT0Q/q1YhnMG4jOdsDQhMfQF/UG3Mi6CNl7yB/b
 0xpkCFHyvGMh1OYgLZzCm3DGYOa9O2x/YyARbxkVq+7xzxKBB5kUmL/Y1zp0g1guLZ5i
 CMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=S3x0I1syk+FpjUOME51Sa5kikQHI1eNJn5aK0q1qog4=;
 b=Yos9KOxgRkuWRoWJ/G7f9Js16peT2a33mzX7coIWNlkakZCicMNJy+mCGkE3wyXmyh
 BaCjv9MXOGyCxfadNyrRkWunPfk3lFvW7JfFjoQaddzSDnhYmp1rdJ6UoDjJpNnlTRZU
 QBln42unlqwhh4s0KGhLaBqkUG62W0EYDmARo1s9WCr48QgxAjX173eNmlY7f/5qxI/G
 sOJbGEbrWPpLPhwh0L9QbrvvScEbpGdqlIMFxc3ozfJuul1ylPabA2e3hKTuaa8Nlj27
 hU5RrPJ4fZa4yiDHccXdbMyK9/+gKy32LR8A3zVjLDFXSt7HQppsU26iFps+5pxDpx2J
 q4Pw==
X-Gm-Message-State: APjAAAVmn7Ca3pm56VFmkYDSUILiTrc1b5tDZViQF3N2wpZLW1nrtQfq
 pWfSq0qvfIDRmj9udX2BsVukAgS7OkQ=
X-Google-Smtp-Source: APXvYqwdRZYuoimb6ewuGO8wIlZejE5t0VqYNgrd7w0HdaH3WcE19tDYMI6LboqaEQjIEQrK5A1tfA==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr6452993plc.2.1565153637091; 
 Tue, 06 Aug 2019 21:53:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:35 -0700
Message-Id: <20190807045335.1361-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 11/11] target/arm: Remove helper_double_saturate
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

Replace x = double_saturate(y) with x = add_saturate(y, y).
There is no need for a separate more specialized helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h    |  1 -
 target/arm/op_helper.c | 15 ---------------
 target/arm/translate.c |  4 ++--
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 132aa1682e..1fb2cb5a77 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -6,7 +6,6 @@ DEF_HELPER_3(add_saturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_saturate, i32, env, i32, i32)
 DEF_HELPER_3(add_usaturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_usaturate, i32, env, i32, i32)
-DEF_HELPER_2(double_saturate, i32, env, s32)
 DEF_HELPER_FLAGS_2(sdiv, TCG_CALL_NO_RWG_SE, s32, s32, s32)
 DEF_HELPER_FLAGS_2(udiv, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_1(rbit, TCG_CALL_NO_RWG_SE, i32, i32)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 5e1625a1c8..0fd4bd0238 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -135,21 +135,6 @@ uint32_t HELPER(sub_saturate)(CPUARMState *env, uint32_t a, uint32_t b)
     return res;
 }
 
-uint32_t HELPER(double_saturate)(CPUARMState *env, int32_t val)
-{
-    uint32_t res;
-    if (val >= 0x40000000) {
-        res = ~SIGNBIT;
-        env->QF = 1;
-    } else if (val <= (int32_t)0xc0000000) {
-        res = SIGNBIT;
-        env->QF = 1;
-    } else {
-        res = val << 1;
-    }
-    return res;
-}
-
 uint32_t HELPER(add_usaturate)(CPUARMState *env, uint32_t a, uint32_t b)
 {
     uint32_t res = a + b;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2d447d4b90..846052acea 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8122,7 +8122,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             tmp = load_reg(s, rm);
             tmp2 = load_reg(s, rn);
             if (op1 & 2)
-                gen_helper_double_saturate(tmp2, cpu_env, tmp2);
+                gen_helper_add_saturate(tmp2, cpu_env, tmp2, tmp2);
             if (op1 & 1)
                 gen_helper_sub_saturate(tmp, cpu_env, tmp, tmp2);
             else
@@ -9965,7 +9965,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 tmp = load_reg(s, rn);
                 tmp2 = load_reg(s, rm);
                 if (op & 1)
-                    gen_helper_double_saturate(tmp, cpu_env, tmp);
+                    gen_helper_add_saturate(tmp, cpu_env, tmp, tmp);
                 if (op & 2)
                     gen_helper_sub_saturate(tmp, cpu_env, tmp2, tmp);
                 else
-- 
2.17.1


