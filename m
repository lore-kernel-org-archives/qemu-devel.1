Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D7C2D0E8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC6A2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjgIBZIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC6A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbtT-0004V1-5r
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbck-00036k-0z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcg-0001wd-JA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:16 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcg-0001vE-BO
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:14 -0400
Received: by mail-pf1-x441.google.com with SMTP id h72so3555250pfe.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cxkAq7ERmXI5Oy2mbhzOoAS+SoesHDepdGEbK1/bQ9Y=;
 b=JjgIBZIlijmglWEbZ7lrd8BT5g+5KVANuj7duhBiwhmyHPRb5QOPpuVBtopUwnklAF
 Ze1bX9ffvz9JKLzBaroqlN06xXjfmo8W1lK7evBO8bLItA1btrH/0fxYdg2iGCcC6pP5
 wRTUCZ4yboS5M92auL2ttn0WYkokzR/TyMnDnyj70YBDMPGJNv/YxRJEzBamLrS/mhIP
 mBS6sdxw/4RjVw8mk5hugNZKjYmJRbh2hqV8jcp5RH7yZwgsKBrNagRG9q6/a+cwCm6d
 8ukBXc6h+eMXiILNf2vwn+OfWA3jBMmm5KTGGukx3nePDJ6dFs/ksZhyYl0JjlzNdOsK
 CCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cxkAq7ERmXI5Oy2mbhzOoAS+SoesHDepdGEbK1/bQ9Y=;
 b=KsmN8GRTHWCaKzdQzhvgKHoMMeGbv5D7GcooJ1VHcmj029EhkV0w1/RPOahoZ+pBYQ
 tZ8lXT7emCqQLItOCJwl6qqJNXgLizskRX83ZBk0RitYeCUumTkb9WEPG6+KqViGPN5P
 LuU/OxsDKxRpLbb97Vaw4MgNIp+0bCui93w1+iGP2zubXDAbkudvSS4PKQ91VaLdnv0w
 lTUJmsFZQG5t+36Bo1s3cgUS2MYskg4PhaaJImuoawqvBI50YiWXwht/q0rS8I15bG5N
 2+UD8k3Z80hyt71raC6NeJkUuVkcaf/YcEFQmEog4aUIj7pN6PPf+T1DFvZkOSQkhY04
 igCg==
X-Gm-Message-State: ANhLgQ2Zp8aShONhFhBnkORNhaQyJl71jSchwG9Iorjbz0VKGT9ipi3J
 OeAcjwOEvE7v4Ftcbem1BhxYLTJibYY=
X-Google-Smtp-Source: ADFU+vsi4yr5jP9LqsfKWeZ7N/C/U/IrI/Bc/fTTSwdtLL+IdKN3/+f4w7eLioOgok5H/3PEv73sdA==
X-Received: by 2002:a63:f95c:: with SMTP id q28mr3719550pgk.321.1585264152438; 
 Thu, 26 Mar 2020 16:09:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/31] target/arm: Create arm_gen_gvec_{sri,sli}
Date: Thu, 26 Mar 2020 16:08:33 -0700
Message-Id: <20200326230838.31112-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions eliminate duplication of the special cases for
this operation.  They match up with the GVecGen2iFn typedef.

Add out-of-line helpers.  We got away with only having inline
expanders because the neon vector size is only 16 bytes, and
we know that the inline expansion will always succeed.
When we reuse this for SVE, tcg-gvec-op may decide to use an
out-of-line helper due to longer vector lengths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  10 ++
 target/arm/translate.h     |   7 +-
 target/arm/translate-a64.c |  20 +---
 target/arm/translate.c     | 186 +++++++++++++++++++++----------------
 target/arm/vec_helper.c    |  38 ++++++++
 5 files changed, 160 insertions(+), 101 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1ffd840f1d..5ef7bb158f 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -738,6 +738,16 @@ DEF_HELPER_FLAGS_3(gvec_ursra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ursra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ursra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_sri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_sli_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sli_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sli_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sli_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 1c5cdf13e3..843ecc1472 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -291,8 +291,6 @@ extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
 extern const GVecGen3 sshl_op[4];
 extern const GVecGen3 ushl_op[4];
-extern const GVecGen2i sri_op[4];
-extern const GVecGen2i sli_op[4];
 extern const GVecGen4 uqadd_op[4];
 extern const GVecGen4 sqadd_op[4];
 extern const GVecGen4 uqsub_op[4];
@@ -308,6 +306,11 @@ void arm_gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void arm_gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                        int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void arm_gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                      int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void arm_gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                      int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 37ee85f867..f7d492cce4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -680,16 +680,6 @@ static void gen_gvec_fn4(DisasContext *s, bool is_q, int rd, int rn, int rm,
             is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
-/* Expand a 2-operand + immediate AdvSIMD vector operation using
- * an op descriptor.
- */
-static void gen_gvec_op2i(DisasContext *s, bool is_q, int rd,
-                          int rn, int64_t imm, const GVecGen2i *gvec_op)
-{
-    tcg_gen_gvec_2i(vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
-                    is_q ? 16 : 8, vec_full_reg_size(s), imm, gvec_op);
-}
-
 /* Expand a 3-operand AdvSIMD vector operation using an op descriptor.  */
 static void gen_gvec_op3(DisasContext *s, bool is_q, int rd,
                          int rn, int rm, const GVecGen3 *gvec_op)
@@ -11132,12 +11122,9 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         gen_gvec_fn2i(s, is_q, rd, rn, shift,
                       is_u ? arm_gen_gvec_usra : arm_gen_gvec_ssra, size);
         return;
+
     case 0x08: /* SRI */
-        /* Shift count same as element size is valid but does nothing.  */
-        if (shift == 8 << size) {
-            goto done;
-        }
-        gen_gvec_op2i(s, is_q, rd, rn, shift, &sri_op[size]);
+        gen_gvec_fn2i(s, is_q, rd, rn, shift, arm_gen_gvec_sri, size);
         return;
 
     case 0x00: /* SSHR / USHR */
@@ -11188,7 +11175,6 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     }
     tcg_temp_free_i64(tcg_round);
 
- done:
     clear_vec_high(s, is_q, rd);
 }
 
@@ -11213,7 +11199,7 @@ static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
     }
 
     if (insert) {
-        gen_gvec_op2i(s, is_q, rd, rn, shift, &sli_op[size]);
+        gen_gvec_fn2i(s, is_q, rd, rn, shift, arm_gen_gvec_sli, size);
     } else {
         gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shli, size);
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f5768014d1..bb6db53598 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4111,47 +4111,62 @@ static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 
 static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
-    if (sh == 0) {
-        tcg_gen_mov_vec(d, a);
-    } else {
-        TCGv_vec t = tcg_temp_new_vec_matching(d);
-        TCGv_vec m = tcg_temp_new_vec_matching(d);
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
 
-        tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK((8 << vece) - sh, sh));
-        tcg_gen_shri_vec(vece, t, a, sh);
-        tcg_gen_and_vec(vece, d, d, m);
-        tcg_gen_or_vec(vece, d, d, t);
+    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK((8 << vece) - sh, sh));
+    tcg_gen_shri_vec(vece, t, a, sh);
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
 
-        tcg_temp_free_vec(t);
-        tcg_temp_free_vec(m);
-    }
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(m);
 }
 
-static const TCGOpcode vecop_list_sri[] = { INDEX_op_shri_vec, 0 };
+void arm_gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                      int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_shri_vec, 0 };
+    const GVecGen2i ops[4] = {
+        { .fni8 = gen_shr8_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_shr16_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_shr32_ins_i32,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_shr64_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
 
-const GVecGen2i sri_op[4] = {
-    { .fni8 = gen_shr8_ins_i64,
-      .fniv = gen_shr_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sri,
-      .vece = MO_8 },
-    { .fni8 = gen_shr16_ins_i64,
-      .fniv = gen_shr_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sri,
-      .vece = MO_16 },
-    { .fni4 = gen_shr32_ins_i32,
-      .fniv = gen_shr_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sri,
-      .vece = MO_32 },
-    { .fni8 = gen_shr64_ins_i64,
-      .fniv = gen_shr_ins_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .load_dest = true,
-      .opt_opc = vecop_list_sri,
-      .vece = MO_64 },
-};
+    /* tszimm encoding produces immediates in the range [1..esize]. */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /* Shift of esize leaves destination unchanged. */
+    if (shift < (8 << vece)) {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    } else {
+        /* Nop, but we do need to clear the tail. */
+        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
+    }
+}
 
 static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
@@ -4189,47 +4204,60 @@ static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 
 static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
-    if (sh == 0) {
-        tcg_gen_mov_vec(d, a);
-    } else {
-        TCGv_vec t = tcg_temp_new_vec_matching(d);
-        TCGv_vec m = tcg_temp_new_vec_matching(d);
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
 
-        tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK(0, sh));
-        tcg_gen_shli_vec(vece, t, a, sh);
-        tcg_gen_and_vec(vece, d, d, m);
-        tcg_gen_or_vec(vece, d, d, t);
+    tcg_gen_shli_vec(vece, t, a, sh);
+    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK(0, sh));
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
 
-        tcg_temp_free_vec(t);
-        tcg_temp_free_vec(m);
-    }
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(m);
 }
 
-static const TCGOpcode vecop_list_sli[] = { INDEX_op_shli_vec, 0 };
+void arm_gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                      int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_shli_vec, 0 };
+    const GVecGen2i ops[4] = {
+        { .fni8 = gen_shl8_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_shl16_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_shl32_ins_i32,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_shl64_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
 
-const GVecGen2i sli_op[4] = {
-    { .fni8 = gen_shl8_ins_i64,
-      .fniv = gen_shl_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sli,
-      .vece = MO_8 },
-    { .fni8 = gen_shl16_ins_i64,
-      .fniv = gen_shl_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sli,
-      .vece = MO_16 },
-    { .fni4 = gen_shl32_ins_i32,
-      .fniv = gen_shl_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sli,
-      .vece = MO_32 },
-    { .fni8 = gen_shl64_ins_i64,
-      .fniv = gen_shl_ins_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .load_dest = true,
-      .opt_opc = vecop_list_sli,
-      .vece = MO_64 },
-};
+    /* tszimm encoding produces immediates in the range [0..esize-1]. */
+    tcg_debug_assert(shift >= 0);
+    tcg_debug_assert(shift < (8 << vece));
+
+    if (shift == 0) {
+        tcg_gen_gvec_mov(vece, rd_ofs, rm_ofs, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
 
 static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
@@ -5451,20 +5479,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     /* Right shift comes here negative.  */
                     shift = -shift;
-                    /* Shift out of range leaves destination unchanged.  */
-                    if (shift < 8 << size) {
-                        tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size, vec_size,
-                                        shift, &sri_op[size]);
-                    }
+                    arm_gen_gvec_sri(size, rd_ofs, rm_ofs, shift,
+                                     vec_size, vec_size);
                     return 0;
 
                 case 5: /* VSHL, VSLI */
                     if (u) { /* VSLI */
-                        /* Shift out of range leaves destination unchanged.  */
-                        if (shift < 8 << size) {
-                            tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size,
-                                            vec_size, shift, &sli_op[size]);
-                        }
+                        arm_gen_gvec_sli(size, rd_ofs, rm_ofs, shift,
+                                         vec_size, vec_size);
                     } else { /* VSHL */
                         /* Shifts larger than the element size are
                          * architecturally valid and results in zero.
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index c6a39c188e..27035a8a42 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -974,6 +974,44 @@ DO_RSRA(gvec_ursra_d, uint64_t)
 
 #undef DO_RSRA
 
+#define DO_SRI(NAME, TYPE)                              \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);               \
+    int shift = simd_data(desc);                        \
+    TYPE *d = vd, *n = vn;                              \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {        \
+        d[i] = deposit64(d[i], 0, sizeof(TYPE) * 8 - shift, n[i] >> shift); \
+    }                                                   \
+    clear_tail(d, oprsz, simd_maxsz(desc));             \
+}
+
+DO_SRI(gvec_sri_b, uint8_t)
+DO_SRI(gvec_sri_h, uint16_t)
+DO_SRI(gvec_sri_s, uint32_t)
+DO_SRI(gvec_sri_d, uint64_t)
+
+#undef DO_SRI
+
+#define DO_SLI(NAME, TYPE)                              \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);               \
+    int shift = simd_data(desc);                        \
+    TYPE *d = vd, *n = vn;                              \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {        \
+        d[i] = deposit64(d[i], shift, sizeof(TYPE) * 8 - shift, n[i]); \
+    }                                                   \
+    clear_tail(d, oprsz, simd_maxsz(desc));             \
+}
+
+DO_SLI(gvec_sli_b, uint8_t)
+DO_SLI(gvec_sli_h, uint16_t)
+DO_SLI(gvec_sli_s, uint32_t)
+DO_SLI(gvec_sli_d, uint64_t)
+
+#undef DO_SLI
+
 /*
  * Convert float16 to float32, raising no exceptions and
  * preserving exceptional values, including SNaN.
-- 
2.20.1


