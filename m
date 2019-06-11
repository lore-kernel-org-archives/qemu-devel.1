Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFABC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407C42080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeVgCSSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407C42080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56306 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haei9-0007iF-HI
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39113)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haePu-0007Dg-JS
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePr-0007OM-BG
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePp-0007Jp-7R
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id c66so2435558wmf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eNBmWZIm97TjmvwdrXNoqxnA5CbE2nGaaTGyw39+1hQ=;
 b=GeVgCSSrJwgGKnMbAnoCMdGxfXYsgbTA3poOHyG2jWs+p3uqLi92pWtE61FijJ+wil
 BCmYmDpnjqD+dKytPC5wy7wSUI363stV9Q9BjSf3/zyTe+7b1YaLDSDklZm/arABRWjh
 muUDRP+7d7Uq4q+9byBHFzmP21O9n68N6NDivBe7elrMrY5pHXa9XoTw/2o/Xy33IVTs
 YroBQfdXwfZBidmi7W1aGwdPCrhEE1CrxDVCONcCvYeKXx7XcZzYDZgaREtbDrr42D6f
 M/MRkZZguuJchZ8h7ao65QReIm8hJFirk2ppFIaSjZizFOymO1wYXx7LCbXwZwW9MkqX
 yxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eNBmWZIm97TjmvwdrXNoqxnA5CbE2nGaaTGyw39+1hQ=;
 b=LnaO48udcQhKjg8dOy551GP0EQczXkK/ThZe2OGMsv+y+slrHnjKvxSLNSDm863Phr
 6GdH1AVRZKin7pNXLd9g6Xxb27XSQfL2CGvKqWwSNU1UZVJx5afp/8nASrJsym7e1slh
 WsRUi8ByJorIKGH9KinXD+hhCLW528NbU4dh7sDmkA+ksAGDgH0LybpqVI9+2YGGgZfm
 6+9cMn5bAZ2geFmKnyyj8M+8pLLTkxs+wmsGj7Of1JlMgQpEOxMBmhKhh0FZzc+zqewV
 W/QwdgDFUeG+DZvs7q1kWuY7VVYgiVoEcuQmkUoQ5f4rpjHlE9ZBUO42EfvDG1r7cUTQ
 QP/g==
X-Gm-Message-State: APjAAAXpGYrqu6Lhepf4GvHwyEiT5lYHmecE4DmCycAE08qET+dNH2tF
 ++uI39to+mwuD4wEo3kzDU9xAA==
X-Google-Smtp-Source: APXvYqy4j7iaF/kVFX2NF78LMs/a41eOo2kAidTMG7o618GAamSUdvGlSN/26hlf2LtbCb7Q6cxhUg==
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr17977485wmh.109.1560250445478; 
 Tue, 11 Jun 2019 03:54:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:20 +0100
Message-Id: <20190611105351.9871-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2 11/42] target/arm: Add helpers for VFP
 register loads and stores
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

The current VFP code has two different idioms for
loading and storing from the VFP register file:
 1 using the gen_mov_F0_vreg() and similar functions,
   which load and store to a fixed set of TCG globals
   cpu_F0s, CPU_F0d, etc
 2 by direct calls to tcg_gen_ld_f64() and friends

We want to phase out idiom 1 (because the use of the
fixed globals is a relic of a much older version of TCG),
but idiom 2 is quite longwinded:
 tcg_gen_ld_f64(tmp, cpu_env, vfp_reg_offset(true, reg))
requires us to specify the 64-bitness twice, once in
the function name and once by passing 'true' to
vfp_reg_offset(). There's no guard against accidentally
passing the wrong flag.

Instead, let's move to a convention of accessing 64-bit
registers via the existing neon_load_reg64() and
neon_store_reg64(), and provide new neon_load_reg32()
and neon_store_reg32() for the 32-bit equivalents.

Implement the new functions and use them in the code in
translate-vfp.inc.c. We will convert the rest of the VFP
code as we do the decodetree conversion in subsequent
commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 40 +++++++++++++++++-----------------
 target/arm/translate.c         | 10 +++++++++
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 2f070a6e0d9..24358f3d3eb 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -179,8 +179,8 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         tcg_gen_ext_i32_i64(nf, cpu_NF);
         tcg_gen_ext_i32_i64(vf, cpu_VF);
 
-        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg64(frn, rn);
+        neon_load_reg64(frm, rm);
         switch (a->cc) {
         case 0: /* eq: Z */
             tcg_gen_movcond_i64(TCG_COND_EQ, dest, zf, zero,
@@ -207,7 +207,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
             tcg_temp_free_i64(tmp);
             break;
         }
-        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg64(dest, rd);
         tcg_temp_free_i64(frn);
         tcg_temp_free_i64(frm);
         tcg_temp_free_i64(dest);
@@ -226,8 +226,8 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         frn = tcg_temp_new_i32();
         frm = tcg_temp_new_i32();
         dest = tcg_temp_new_i32();
-        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg32(frn, rn);
+        neon_load_reg32(frm, rm);
         switch (a->cc) {
         case 0: /* eq: Z */
             tcg_gen_movcond_i32(TCG_COND_EQ, dest, cpu_ZF, zero,
@@ -254,7 +254,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
             tcg_temp_free_i32(tmp);
             break;
         }
-        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg32(dest, rd);
         tcg_temp_free_i32(frn);
         tcg_temp_free_i32(frm);
         tcg_temp_free_i32(dest);
@@ -298,14 +298,14 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         frm = tcg_temp_new_i64();
         dest = tcg_temp_new_i64();
 
-        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg64(frn, rn);
+        neon_load_reg64(frm, rm);
         if (vmin) {
             gen_helper_vfp_minnumd(dest, frn, frm, fpst);
         } else {
             gen_helper_vfp_maxnumd(dest, frn, frm, fpst);
         }
-        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg64(dest, rd);
         tcg_temp_free_i64(frn);
         tcg_temp_free_i64(frm);
         tcg_temp_free_i64(dest);
@@ -316,14 +316,14 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         frm = tcg_temp_new_i32();
         dest = tcg_temp_new_i32();
 
-        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg32(frn, rn);
+        neon_load_reg32(frm, rm);
         if (vmin) {
             gen_helper_vfp_minnums(dest, frn, frm, fpst);
         } else {
             gen_helper_vfp_maxnums(dest, frn, frm, fpst);
         }
-        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg32(dest, rd);
         tcg_temp_free_i32(frn);
         tcg_temp_free_i32(frm);
         tcg_temp_free_i32(dest);
@@ -379,9 +379,9 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         TCGv_i64 tcg_res;
         tcg_op = tcg_temp_new_i64();
         tcg_res = tcg_temp_new_i64();
-        tcg_gen_ld_f64(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg64(tcg_op, rm);
         gen_helper_rintd(tcg_res, tcg_op, fpst);
-        tcg_gen_st_f64(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg64(tcg_res, rd);
         tcg_temp_free_i64(tcg_op);
         tcg_temp_free_i64(tcg_res);
     } else {
@@ -389,9 +389,9 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         TCGv_i32 tcg_res;
         tcg_op = tcg_temp_new_i32();
         tcg_res = tcg_temp_new_i32();
-        tcg_gen_ld_f32(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
+        neon_load_reg32(tcg_op, rm);
         gen_helper_rints(tcg_res, tcg_op, fpst);
-        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
+        neon_store_reg32(tcg_res, rd);
         tcg_temp_free_i32(tcg_op);
         tcg_temp_free_i32(tcg_res);
     }
@@ -440,14 +440,14 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         tcg_double = tcg_temp_new_i64();
         tcg_res = tcg_temp_new_i64();
         tcg_tmp = tcg_temp_new_i32();
-        tcg_gen_ld_f64(tcg_double, cpu_env, vfp_reg_offset(1, rm));
+        neon_load_reg64(tcg_double, rm);
         if (is_signed) {
             gen_helper_vfp_tosld(tcg_res, tcg_double, tcg_shift, fpst);
         } else {
             gen_helper_vfp_tould(tcg_res, tcg_double, tcg_shift, fpst);
         }
         tcg_gen_extrl_i64_i32(tcg_tmp, tcg_res);
-        tcg_gen_st_f32(tcg_tmp, cpu_env, vfp_reg_offset(0, rd));
+        neon_store_reg32(tcg_tmp, rd);
         tcg_temp_free_i32(tcg_tmp);
         tcg_temp_free_i64(tcg_res);
         tcg_temp_free_i64(tcg_double);
@@ -455,13 +455,13 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         TCGv_i32 tcg_single, tcg_res;
         tcg_single = tcg_temp_new_i32();
         tcg_res = tcg_temp_new_i32();
-        tcg_gen_ld_f32(tcg_single, cpu_env, vfp_reg_offset(0, rm));
+        neon_load_reg32(tcg_single, rm);
         if (is_signed) {
             gen_helper_vfp_tosls(tcg_res, tcg_single, tcg_shift, fpst);
         } else {
             gen_helper_vfp_touls(tcg_res, tcg_single, tcg_shift, fpst);
         }
-        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(0, rd));
+        neon_store_reg32(tcg_res, rd);
         tcg_temp_free_i32(tcg_res);
         tcg_temp_free_i32(tcg_single);
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e42a21d4aa5..3661ed57cd3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1689,6 +1689,16 @@ static inline void neon_store_reg64(TCGv_i64 var, int reg)
     tcg_gen_st_i64(var, cpu_env, vfp_reg_offset(1, reg));
 }
 
+static inline void neon_load_reg32(TCGv_i32 var, int reg)
+{
+    tcg_gen_ld_i32(var, cpu_env, vfp_reg_offset(false, reg));
+}
+
+static inline void neon_store_reg32(TCGv_i32 var, int reg)
+{
+    tcg_gen_st_i32(var, cpu_env, vfp_reg_offset(false, reg));
+}
+
 static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
 {
     TCGv_ptr ret = tcg_temp_new_ptr();
-- 
2.20.1


