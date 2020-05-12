Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F2BCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E41206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYvfBvPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E41206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY63-0002ed-Jg
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwA-0006a5-HD
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw9-00069D-GG
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id h17so7408455wrc.8
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kVCumtOJ/X5yIQDESAlRm3BAiW9FGll9wJVdRpfR4eg=;
 b=gYvfBvPUqHBPhvMm8rtMFXRdY9/euVj2Qr7pAEtIoYhvZ9YzMqVspNBzq+chcYPJ0i
 1UHS8MT6mL18s99a+MLzuoxY1PZ1gEbBY1cVaYqe0N7uNg9yQihx2i7KRhH557Up7tmk
 NZrBcI4kxdSOMJU6wELUj3mPLi6KrtbXjqmVTryaHuLwUmdVbKy1QNOpSFTbsOE7Ruq4
 JYIcV2FV8Yw6orA/uH4AOcsz2O3oRVSeUa/dBg5PkHbYNYLXHHQzBGT7vRe7VsJkXbob
 JRoNFF2zQHUr18zfoVe/9kphILGfpEVfLYfcwzE4Qp3evSK9npU0leSfqeVqYWLaytaZ
 V/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kVCumtOJ/X5yIQDESAlRm3BAiW9FGll9wJVdRpfR4eg=;
 b=seCuSVcMTJZ8bQnqTvgx6/jLyg8lHsShx919qm6Q4XRunURhhvuQtW/y0w6cxaEDEr
 1EIGSaEAsAA83BMiNSyb22ANZJlAVv9xCkZXqu1xNXsibJs8NFUXKxVdA4RAH9mkw9rK
 kIHNW7mpHztTFa51dECYMJcEFrwoXsFuRUy8zQOhiT13ZuUAHAJGGJB8Zb8B3BsSnrKA
 HKb5y4S+rjWOm63o3qgb6kIK//2pEm8JUz4+7NELabJD4Ebb37NB4RP1VZ60t1zTsZL2
 uSVXuIlsE3505Nx51sGP1I0pTfwu3mn9O/mVSAcGvUKM7bRHCu0SbQCbDkQvkyCj9kNj
 cfPg==
X-Gm-Message-State: AGi0PuZqOjBzgLPA7Wj3HIsyA/Z0+Y+za+4h7RuMqWnFGguBB0YYkgDl
 zEXbzvdQ2Ddim97BHfewqQ1rxg==
X-Google-Smtp-Source: APiQypJnPILQhW+0u5CqwEUdd0VbL6ObH8xheA0Q8h+LuOey+hSt0cF7pBkByavux5e8PPcXuChLYw==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr25614588wrq.169.1589301560203; 
 Tue, 12 May 2020 09:39:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 09/17] target/arm: Convert Neon VPADD 3-reg-same insns to
 decodetree
Date: Tue, 12 May 2020 17:38:56 +0100
Message-Id: <20200512163904.10918-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon integer VPADD 3-reg-same insns to decodetree.  These
are 'pairwise' operations.  (Note that VQRDMLAH, which shares the
same primary opcode but has U=1, has already been converted.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  2 ++
 target/arm/translate-neon.inc.c |  2 ++
 target/arm/translate.c          | 19 +------------------
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 03f39a0b44b..9bbb2dd77e0 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -153,6 +153,8 @@ VPMAX_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 0 .... @3same_q0
 VPMIN_S_3s       1111 001 0 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 VPMIN_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 
+VPADD_3s         1111 001 0 0 . .. .... .... 1011 . . . 1 .... @3same_q0
+
 VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
 
 SHA1_3s          1111 001 0 0 . optype:2 .... .... 1100 . 1 . 0 .... \
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 7db6b856598..e0137364075 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -990,8 +990,10 @@ static bool do_3same_pair(DisasContext *s, arg_3same *a, NeonGenTwoOpFn *fn)
 #define gen_helper_neon_pmax_u32  tcg_gen_umax_i32
 #define gen_helper_neon_pmin_s32  tcg_gen_smin_i32
 #define gen_helper_neon_pmin_u32  tcg_gen_umin_i32
+#define gen_helper_neon_padd_u32  tcg_gen_add_i32
 
 DO_3SAME_PAIR(VPMAX_S, pmax_s)
 DO_3SAME_PAIR(VPMIN_S, pmin_s)
 DO_3SAME_PAIR(VPMAX_U, pmax_u)
 DO_3SAME_PAIR(VPMIN_U, pmin_u)
+DO_3SAME_PAIR(VPADD, padd_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 82be4d40282..ce30417014d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5397,13 +5397,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
         switch (op) {
-        case NEON_3R_VPADD_VQRDMLAH:
-            if (!u) {
-                break;  /* VPADD */
-            }
-            /* VQRDMLAH : handled by decodetree */
-            return 1;
-
         case NEON_3R_VFM_VQRDMLSH:
             if (!u) {
                 /* VFM, VFMS */
@@ -5438,6 +5431,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQRSHL:
         case NEON_3R_VPMAX:
         case NEON_3R_VPMIN:
+        case NEON_3R_VPADD_VQRDMLAH:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5448,9 +5442,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         pairwise = 0;
         switch (op) {
-        case NEON_3R_VPADD_VQRDMLAH:
-            pairwise = 1;
-            break;
         case NEON_3R_FLOAT_ARITH:
             pairwise = (u && size < 2); /* if VPADD (float) */
             break;
@@ -5528,14 +5519,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
             }
             break;
-        case NEON_3R_VPADD_VQRDMLAH:
-            switch (size) {
-            case 0: gen_helper_neon_padd_u8(tmp, tmp, tmp2); break;
-            case 1: gen_helper_neon_padd_u16(tmp, tmp, tmp2); break;
-            case 2: tcg_gen_add_i32(tmp, tmp, tmp2); break;
-            default: abort();
-            }
-            break;
         case NEON_3R_FLOAT_ARITH: /* Floating point arithmetic. */
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.20.1


