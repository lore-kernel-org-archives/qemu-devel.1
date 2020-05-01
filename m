Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B127CC35280
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677962073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTguEinA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677962073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUd1O-0004d6-76
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 17:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcyo-00089r-V6
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUcyn-0005hB-Gm
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:54 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcyn-0005Yt-2T
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:53 -0400
Received: by mail-pl1-x644.google.com with SMTP id s10so4065353plr.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AcqetdDay4HpRD3f/y6CLMiPz3CMxc+7RZyifvagB/c=;
 b=rTguEinA+u4TdwAwxnyR9AbVAC788W90QfvtaoUfDcT0bkiqbY6n6Z2wuJCmh4DwNV
 dRQyvciSzUrwM3rNt7bhyfh7OVtdPW2xs16uhUWRQTXbfyHiiuQzyj7d4Sz5CpktzdTj
 oeZA/nIbM+eeczLe5t6Aw4zL3HoEwMFwpPTKn+fw7fa7+zG+4nUwp1WX7NV4ssEEr0t+
 sIWsYhrt/kG4Xzb0rlEEQTrHxkAKEAMkVD0GUcLxagqeoYR0vHzZPH3CPuyH61Iat+Ak
 SCXZTdXkoSIIGT/90/qscE8gV4HxgkbvpaZN+by1rhbAoieIzc/ZPLp0lnlridbouRJz
 gA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AcqetdDay4HpRD3f/y6CLMiPz3CMxc+7RZyifvagB/c=;
 b=ULZirm7nAglVsCiVliTeTDbViD+0A2fy85OyaqbNT3KTqx1qtrIeHnhoov8+1DyIch
 msDv0jlzF6VLB6hFCK/n1EFo28f4Z/XNHq8LSVt0W9MDBpCoWw168nOrpgolW52RteAM
 zAGmBGQ50AHzzeH0Pn725msySAvod3vnz49Usua3Czld8cfDJQcBXh+Ju7mm5YSPFkqK
 /LLBo0LTWRWWIJRj/Tg29uTfCwnUPjaL+gI/bcVz5jNBhTK+Cp4Pj9nvDCsXNyWSnGgE
 0aiFNCAbM+q6S5EGPOl3hLyi3zZD9yCUEcqiuF+bRRs1kz/W9/Mpxis4kD1yBlYwN0U2
 7hdQ==
X-Gm-Message-State: AGi0Pua4VsWXlEXXWNvNoc800UT7ser/xv761ijwMigiDWqpMjG/wKZ/
 ft+KrNA6bJ+BvYeKvBgDrrAdQ668qCA=
X-Google-Smtp-Source: APiQypJ34nmakcNkHrc2fV+oPz0KTwbfDlgO00iZ+xCareqXnOxGK9j9hQkj4for/zYir/0xZCf8Sg==
X-Received: by 2002:a17:902:748c:: with SMTP id
 h12mr6446615pll.310.1588367630989; 
 Fri, 01 May 2020 14:13:50 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g22sm514552pju.21.2020.05.01.14.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 14:13:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] target/arm: Create gen_gvec_{sri,sli}
Date: Fri,  1 May 2020 14:13:42 -0700
Message-Id: <20200501211345.30410-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501211345.30410-1-richard.henderson@linaro.org>
References: <20200501211345.30410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org
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
index aeb1f52455..33c76192d2 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -721,6 +721,16 @@ DEF_HELPER_FLAGS_3(gvec_ursra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
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
index 823821f82c..7a2008f0dd 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -285,8 +285,6 @@ extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
 extern const GVecGen3 sshl_op[4];
 extern const GVecGen3 ushl_op[4];
-extern const GVecGen2i sri_op[4];
-extern const GVecGen2i sli_op[4];
 extern const GVecGen4 uqadd_op[4];
 extern const GVecGen4 sqadd_op[4];
 extern const GVecGen4 uqsub_op[4];
@@ -311,6 +309,11 @@ void gen_gvec_srsra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_ursra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                     int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1ef05d5ce1..bc326dadda 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -602,16 +602,6 @@ static void gen_gvec_op2(DisasContext *s, bool is_q, int rd,
                    is_q ? 16 : 8, vec_full_reg_size(s), gvec_op);
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
@@ -10208,12 +10198,9 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         gen_gvec_fn2i(s, is_q, rd, rn, shift,
                       is_u ? gen_gvec_usra : gen_gvec_ssra, size);
         return;
+
     case 0x08: /* SRI */
-        /* Shift count same as element size is valid but does nothing.  */
-        if (shift == 8 << size) {
-            goto done;
-        }
-        gen_gvec_op2i(s, is_q, rd, rn, shift, &sri_op[size]);
+        gen_gvec_fn2i(s, is_q, rd, rn, shift, gen_gvec_sri, size);
         return;
 
     case 0x00: /* SSHR / USHR */
@@ -10264,7 +10251,6 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     }
     tcg_temp_free_i64(tcg_round);
 
- done:
     clear_vec_high(s, is_q, rd);
 }
 
@@ -10289,7 +10275,7 @@ static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
     }
 
     if (insert) {
-        gen_gvec_op2i(s, is_q, rd, rn, shift, &sli_op[size]);
+        gen_gvec_fn2i(s, is_q, rd, rn, shift, gen_gvec_sli, size);
     } else {
         gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shli, size);
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d724022cb6..f730eb5b75 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4726,47 +4726,62 @@ static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 
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
+void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz)
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
@@ -4804,47 +4819,60 @@ static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 
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
+void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz)
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
@@ -6089,20 +6117,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     /* Right shift comes here negative.  */
                     shift = -shift;
-                    /* Shift out of range leaves destination unchanged.  */
-                    if (shift < 8 << size) {
-                        tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size, vec_size,
-                                        shift, &sri_op[size]);
-                    }
+                    gen_gvec_sri(size, rd_ofs, rm_ofs, shift,
+                                 vec_size, vec_size);
                     return 0;
 
                 case 5: /* VSHL, VSLI */
                     if (u) { /* VSLI */
-                        /* Shift out of range leaves destination unchanged.  */
-                        if (shift < 8 << size) {
-                            tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size,
-                                            vec_size, shift, &sli_op[size]);
-                        }
+                        gen_gvec_sli(size, rd_ofs, rm_ofs, shift,
+                                     vec_size, vec_size);
                     } else { /* VSHL */
                         /* Shifts larger than the element size are
                          * architecturally valid and results in zero.
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index fd8b2bff49..096fea67ef 100644
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


