Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C6C46477
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFC821721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyNwwTlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFC821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39372 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOmz-00035s-6f
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58751)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcv-0007tg-5S
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOct-0003w8-Fy
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:32992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcr-0003si-Ba
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id n9so20572074wru.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=B6ZUgC//PSMrRR2oNuVHItj5SGKIBntukxvLi8+tvVc=;
 b=XyNwwTlUVXrNSI2go6fXy7VC3+DEcfFLaHiuS8g/Xq8GRrROZLeHaf2uVs87x2z1jg
 Jqq7BoADWuDP+gLGLLrMKmdibxii/B5Xc4k5KrSEkJc+wRczAfXn0YTGf0buj+XixzUx
 OxAmqwynbEDkNZjJtOoVXi6zrgqRKefkIIzD/Hd6vqqPQZGDp34Zeyax5Ly89OBeyQVP
 Wm8cQkpbLlfWH0661BvdompUK3ZBCBo//cTy++oABOnZKp8FUxEqfmo+ExbYnuS2tQls
 eTgyHYKP0POMaK2B9q0GmlbQzUKYzhNUOE2wlV9kXEl/3nG8xVs2XJs3puD54dxvrmsK
 Yd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B6ZUgC//PSMrRR2oNuVHItj5SGKIBntukxvLi8+tvVc=;
 b=MZP+AXoxPv2plTBYOMYpFVts9AZOzC7KcRLgqi6bNG9bF+lzyFPm72o7ZSMLDy35wL
 /gxg3vCf2lx07yczQO5k1FGfq9okU24A/8JezYN5kWNwrxqpTE23TgJ2ZEHaEjRjyx6j
 Cxa4GrRVD7zY64QQldh6KKffUseRSYw989jZEOeE1u6fI3gVV4Hom4dtLcxVb6HgCYOx
 1RWa5YWafp+b2PJ4yL3pNjdEkKIY8AzbfRJm+dm/2/v2Dwb15qOx8J1iYBuGCpLxb7xb
 m4gI89yy1QuLIZoSOviwjE1vMh37QHP5whDhlxHdK9oqmM0E8nPrc36DN721XkAhAoNY
 d4cA==
X-Gm-Message-State: APjAAAV+Sp+Vicbl/3A90qk6BkSZTngg6H7WGfztBzM1iu3/43LSKCZL
 Dwd/sBsK2t/uPzFKl0M/UGsADs9Fe9gm6g==
X-Google-Smtp-Source: APXvYqwJ5EGbo1KDLTE+2aNxngt+RQnAoFR0Ig2Jm8XAKlnlwAY2nTP/uyf38FerkGgRiHyAE0aHaA==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr58138851wrn.244.1560428077939; 
 Thu, 13 Jun 2019 05:14:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:47 +0100
Message-Id: <20190613121433.5246-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 02/48] target/arm: Use tcg_gen_gvec_bitsel
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

This replaces 3 target-specific implementations for BIT, BIF, and BSL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190518191934.21887-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.h |  2 +
 target/arm/translate.h     |  3 --
 target/arm/translate-a64.c | 15 ++++++--
 target/arm/translate.c     | 78 +++-----------------------------------
 4 files changed, 20 insertions(+), 78 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 63d958cf504..9569bc5963d 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -122,5 +122,7 @@ typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
                          uint32_t, uint32_t);
 typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
+typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
 
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index f357b767cb9..01ae454dcf1 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -238,9 +238,6 @@ static inline void gen_ss_advance(DisasContext *s)
 }
 
 /* Vector operations shared between ARM and AArch64.  */
-extern const GVecGen3 bsl_op;
-extern const GVecGen3 bit_op;
-extern const GVecGen3 bif_op;
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f53cd288158..e9954eb78f7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -704,6 +704,15 @@ static void gen_gvec_fn3(DisasContext *s, bool is_q, int rd, int rn, int rm,
             vec_full_reg_offset(s, rm), is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
+/* Expand a 4-operand AdvSIMD vector operation using an expander function.  */
+static void gen_gvec_fn4(DisasContext *s, bool is_q, int rd, int rn, int rm,
+                         int rx, GVecGen4Fn *gvec_fn, int vece)
+{
+    gvec_fn(vece, vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
+            vec_full_reg_offset(s, rm), vec_full_reg_offset(s, rx),
+            is_q ? 16 : 8, vec_full_reg_size(s));
+}
+
 /* Expand a 2-operand + immediate AdvSIMD vector operation using
  * an op descriptor.
  */
@@ -10918,13 +10927,13 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
         return;
 
     case 5: /* BSL bitwise select */
-        gen_gvec_op3(s, is_q, rd, rn, rm, &bsl_op);
+        gen_gvec_fn4(s, is_q, rd, rd, rn, rm, tcg_gen_gvec_bitsel, 0);
         return;
     case 6: /* BIT, bitwise insert if true */
-        gen_gvec_op3(s, is_q, rd, rn, rm, &bit_op);
+        gen_gvec_fn4(s, is_q, rd, rm, rn, rd, tcg_gen_gvec_bitsel, 0);
         return;
     case 7: /* BIF, bitwise insert if false */
-        gen_gvec_op3(s, is_q, rd, rn, rm, &bif_op);
+        gen_gvec_fn4(s, is_q, rd, rm, rd, rn, tcg_gen_gvec_bitsel, 0);
         return;
 
     default:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 096e338bf06..ab3026664af 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5755,72 +5755,6 @@ static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
     return 1;
 }
 
-/*
- * Expanders for VBitOps_VBIF, VBIT, VBSL.
- */
-static void gen_bsl_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
-{
-    tcg_gen_xor_i64(rn, rn, rm);
-    tcg_gen_and_i64(rn, rn, rd);
-    tcg_gen_xor_i64(rd, rm, rn);
-}
-
-static void gen_bit_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
-{
-    tcg_gen_xor_i64(rn, rn, rd);
-    tcg_gen_and_i64(rn, rn, rm);
-    tcg_gen_xor_i64(rd, rd, rn);
-}
-
-static void gen_bif_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
-{
-    tcg_gen_xor_i64(rn, rn, rd);
-    tcg_gen_andc_i64(rn, rn, rm);
-    tcg_gen_xor_i64(rd, rd, rn);
-}
-
-static void gen_bsl_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
-{
-    tcg_gen_xor_vec(vece, rn, rn, rm);
-    tcg_gen_and_vec(vece, rn, rn, rd);
-    tcg_gen_xor_vec(vece, rd, rm, rn);
-}
-
-static void gen_bit_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
-{
-    tcg_gen_xor_vec(vece, rn, rn, rd);
-    tcg_gen_and_vec(vece, rn, rn, rm);
-    tcg_gen_xor_vec(vece, rd, rd, rn);
-}
-
-static void gen_bif_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
-{
-    tcg_gen_xor_vec(vece, rn, rn, rd);
-    tcg_gen_andc_vec(vece, rn, rn, rm);
-    tcg_gen_xor_vec(vece, rd, rd, rn);
-}
-
-const GVecGen3 bsl_op = {
-    .fni8 = gen_bsl_i64,
-    .fniv = gen_bsl_vec,
-    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    .load_dest = true
-};
-
-const GVecGen3 bit_op = {
-    .fni8 = gen_bit_i64,
-    .fniv = gen_bit_vec,
-    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    .load_dest = true
-};
-
-const GVecGen3 bif_op = {
-    .fni8 = gen_bif_i64,
-    .fniv = gen_bif_vec,
-    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    .load_dest = true
-};
-
 static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
     tcg_gen_vec_sar8i_i64(a, a, shift);
@@ -6846,16 +6780,16 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                  vec_size, vec_size);
                 break;
             case 5: /* VBSL */
-                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
-                               vec_size, vec_size, &bsl_op);
+                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rd_ofs, rn_ofs, rm_ofs,
+                                    vec_size, vec_size);
                 break;
             case 6: /* VBIT */
-                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
-                               vec_size, vec_size, &bit_op);
+                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rn_ofs, rd_ofs,
+                                    vec_size, vec_size);
                 break;
             case 7: /* VBIF */
-                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
-                               vec_size, vec_size, &bif_op);
+                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rd_ofs, rn_ofs,
+                                    vec_size, vec_size);
                 break;
             }
             return 0;
-- 
2.20.1


