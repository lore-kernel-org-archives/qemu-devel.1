Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8FFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D62206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Usfqed0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D62206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV0wr-0002Zh-Ef
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sp-0003FO-8o
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0so-0004j7-6z
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:18 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sn-0004iJ-OG
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:17 -0400
Received: by mail-pl1-x644.google.com with SMTP id h11so5176625plr.11
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NFh/cV4KerzqWvcCyd3UKrXMuXUL/sOfyhSZ6x7PVt0=;
 b=Usfqed0MHgVVZ2KmBv9T5DH20+FAL3bIVPO4RjQCR7KdUfvXEXRZQKnTPnRQtR/YEU
 2WpWxb2kbgpHA0P1dsLS+vAmJP7SbhnzDzrGElMmTzGpdsqLp6Qr+V5qvrQF0LrCWsZH
 iT1I+mzYjdVIVc0pPckGGicPuFlvSPRNX16rXm923Scwx8BRfTKGvOrs/VCnwFrp7CK5
 oX4wHquDCVA2b7HGckWJN3/yRewCVsqpLZRSD+ej88zUIOuDmW/OuMwDq3TIhq5TirKt
 VRttz71fZWtuBJ3t5HGFo1Tf4viVN1igi0fIYnDBko5Ppj5gghGdS23hf+OxAM8t9BoZ
 a41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NFh/cV4KerzqWvcCyd3UKrXMuXUL/sOfyhSZ6x7PVt0=;
 b=KyENjHMydEvlRxXP6v+dh3pL8AvBpwq8fhgq91JtrO+tO4JVcdRsN9Se8XY11PUzkf
 pmC+p79WYoXVWAO+c8/tGCybS+ylUd5TfVEsyR/nLoEdd0xYW/YqWIb3sNWjhnaJQ0Gr
 XRnNAwzcIWB+LItyUHogY3yJdy5Ru8+GqucvlKY2saImDRKZYwSaNyLdY5cmiURasAbf
 h+DJtiJuxAZJtWoBNz8Gw3J/q/LK0m/kgb+MX5C216QtVT9ECHQ1EY9VdiTP4CsrWapT
 tdC4XhrtdG81UWK1P08CKa3aEndupXYGxoY5+GfjlIc9FqzyO0kpElxBwZRtr/alF7Gf
 NL/A==
X-Gm-Message-State: AGi0PuZ7UFNFeK/v+bdXretdbZ7YJg9ca/sKXOUxALTzIMde7VvTD8qT
 Ry73XlN4CuAzNICd35picPpEe4eWFyM=
X-Google-Smtp-Source: APiQypJH7MdIqXq8XDAd0bCY5vn/aiYyIl5/Cf5FzSxpMiWluRPEnyJyD+dGerlyIwKb//YBQU6EDg==
X-Received: by 2002:a17:902:8ec1:: with SMTP id
 x1mr6157461plo.325.1588459515899; 
 Sat, 02 May 2020 15:45:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/15] target/arm: Wrap vector cmtst/ushl/sshl GVecGen3 in
 GVecGen3Fn
Date: Sat,  2 May 2020 15:44:56 -0700
Message-Id: <20200502224503.2282-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
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

Provide a functional interface for the vector expansion.
This fits better with the existing set of helpers that
we provide for other operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |  10 ++-
 target/arm/translate-a64.c |  18 ++---
 target/arm/translate.c     | 159 ++++++++++++++++++++-----------------
 3 files changed, 101 insertions(+), 86 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 4fbcdf1294..b3e47e7a7f 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -291,9 +291,13 @@ void gen_gvec_mla(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
-extern const GVecGen3 cmtst_op[4];
-extern const GVecGen3 sshl_op[4];
-extern const GVecGen3 ushl_op[4];
+void gen_gvec_cmtst(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_ushl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 extern const GVecGen4 uqadd_op[4];
 extern const GVecGen4 sqadd_op[4];
 extern const GVecGen4 uqsub_op[4];
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2b5ae4d43a..2be6ab541e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -594,15 +594,6 @@ static void gen_gvec_fn4(DisasContext *s, bool is_q, int rd, int rn, int rm,
             is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
-/* Expand a 3-operand AdvSIMD vector operation using an op descriptor.  */
-static void gen_gvec_op3(DisasContext *s, bool is_q, int rd,
-                         int rn, int rm, const GVecGen3 *gvec_op)
-{
-    tcg_gen_gvec_3(vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
-                   vec_full_reg_offset(s, rm), is_q ? 16 : 8,
-                   vec_full_reg_size(s), gvec_op);
-}
-
 /* Expand a 3-operand operation using an out-of-line helper.  */
 static void gen_gvec_op3_ool(DisasContext *s, bool is_q, int rd,
                              int rn, int rm, int data, gen_helper_gvec_3 *fn)
@@ -11210,8 +11201,11 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                        (u ? uqsub_op : sqsub_op) + size);
         return;
     case 0x08: /* SSHL, USHL */
-        gen_gvec_op3(s, is_q, rd, rn, rm,
-                     u ? &ushl_op[size] : &sshl_op[size]);
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_ushl, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sshl, size);
+        }
         return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
@@ -11250,7 +11244,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         return;
     case 0x11:
         if (!u) { /* CMTST */
-            gen_gvec_op3(s, is_q, rd, rn, rm, &cmtst_op[size]);
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_cmtst, size);
             return;
         }
         /* else CMEQ */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index da807242ff..e5aa78c88a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4878,27 +4878,31 @@ static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
     tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
 }
 
-static const TCGOpcode vecop_list_cmtst[] = { INDEX_op_cmp_vec, 0 };
-
-const GVecGen3 cmtst_op[4] = {
-    { .fni4 = gen_helper_neon_tst_u8,
-      .fniv = gen_cmtst_vec,
-      .opt_opc = vecop_list_cmtst,
-      .vece = MO_8 },
-    { .fni4 = gen_helper_neon_tst_u16,
-      .fniv = gen_cmtst_vec,
-      .opt_opc = vecop_list_cmtst,
-      .vece = MO_16 },
-    { .fni4 = gen_cmtst_i32,
-      .fniv = gen_cmtst_vec,
-      .opt_opc = vecop_list_cmtst,
-      .vece = MO_32 },
-    { .fni8 = gen_cmtst_i64,
-      .fniv = gen_cmtst_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .opt_opc = vecop_list_cmtst,
-      .vece = MO_64 },
-};
+void gen_gvec_cmtst(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_cmp_vec, 0 };
+    static const GVecGen3 ops[4] = {
+        { .fni4 = gen_helper_neon_tst_u8,
+          .fniv = gen_cmtst_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni4 = gen_helper_neon_tst_u16,
+          .fniv = gen_cmtst_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_cmtst_i32,
+          .fniv = gen_cmtst_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_cmtst_i64,
+          .fniv = gen_cmtst_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 void gen_ushl_i32(TCGv_i32 dst, TCGv_i32 src, TCGv_i32 shift)
 {
@@ -5016,29 +5020,33 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
     tcg_temp_free_vec(rsh);
 }
 
-static const TCGOpcode ushl_list[] = {
-    INDEX_op_neg_vec, INDEX_op_shlv_vec,
-    INDEX_op_shrv_vec, INDEX_op_cmp_vec, 0
-};
-
-const GVecGen3 ushl_op[4] = {
-    { .fniv = gen_ushl_vec,
-      .fno = gen_helper_gvec_ushl_b,
-      .opt_opc = ushl_list,
-      .vece = MO_8 },
-    { .fniv = gen_ushl_vec,
-      .fno = gen_helper_gvec_ushl_h,
-      .opt_opc = ushl_list,
-      .vece = MO_16 },
-    { .fni4 = gen_ushl_i32,
-      .fniv = gen_ushl_vec,
-      .opt_opc = ushl_list,
-      .vece = MO_32 },
-    { .fni8 = gen_ushl_i64,
-      .fniv = gen_ushl_vec,
-      .opt_opc = ushl_list,
-      .vece = MO_64 },
-};
+void gen_gvec_ushl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_neg_vec, INDEX_op_shlv_vec,
+        INDEX_op_shrv_vec, INDEX_op_cmp_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_ushl_vec,
+          .fno = gen_helper_gvec_ushl_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_ushl_vec,
+          .fno = gen_helper_gvec_ushl_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_ushl_i32,
+          .fniv = gen_ushl_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_ushl_i64,
+          .fniv = gen_ushl_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 void gen_sshl_i32(TCGv_i32 dst, TCGv_i32 src, TCGv_i32 shift)
 {
@@ -5150,29 +5158,33 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     tcg_temp_free_vec(tmp);
 }
 
-static const TCGOpcode sshl_list[] = {
-    INDEX_op_neg_vec, INDEX_op_umin_vec, INDEX_op_shlv_vec,
-    INDEX_op_sarv_vec, INDEX_op_cmp_vec, INDEX_op_cmpsel_vec, 0
-};
-
-const GVecGen3 sshl_op[4] = {
-    { .fniv = gen_sshl_vec,
-      .fno = gen_helper_gvec_sshl_b,
-      .opt_opc = sshl_list,
-      .vece = MO_8 },
-    { .fniv = gen_sshl_vec,
-      .fno = gen_helper_gvec_sshl_h,
-      .opt_opc = sshl_list,
-      .vece = MO_16 },
-    { .fni4 = gen_sshl_i32,
-      .fniv = gen_sshl_vec,
-      .opt_opc = sshl_list,
-      .vece = MO_32 },
-    { .fni8 = gen_sshl_i64,
-      .fniv = gen_sshl_vec,
-      .opt_opc = sshl_list,
-      .vece = MO_64 },
-};
+void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_neg_vec, INDEX_op_umin_vec, INDEX_op_shlv_vec,
+        INDEX_op_sarv_vec, INDEX_op_cmp_vec, INDEX_op_cmpsel_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_sshl_vec,
+          .fno = gen_helper_gvec_sshl_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_sshl_vec,
+          .fno = gen_helper_gvec_sshl_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_sshl_i32,
+          .fniv = gen_sshl_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_sshl_i64,
+          .fniv = gen_sshl_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
@@ -5548,8 +5560,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 tcg_gen_gvec_cmp(TCG_COND_EQ, size, rd_ofs, rn_ofs, rm_ofs,
                                  vec_size, vec_size);
             } else { /* VTST */
-                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
-                               vec_size, vec_size, &cmtst_op[size]);
+                gen_gvec_cmtst(size, rd_ofs, rn_ofs, rm_ofs,
+                               vec_size, vec_size);
             }
             return 0;
 
@@ -5584,8 +5596,13 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 
         case NEON_3R_VSHL:
             /* Note the operation is vshl vd,vm,vn */
-            tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
-                           u ? &ushl_op[size] : &sshl_op[size]);
+            if (u) {
+                gen_gvec_ushl(size, rd_ofs, rm_ofs, rn_ofs,
+                              vec_size, vec_size);
+            } else {
+                gen_gvec_sshl(size, rd_ofs, rm_ofs, rn_ofs,
+                              vec_size, vec_size);
+            }
             return 0;
         }
 
-- 
2.20.1


