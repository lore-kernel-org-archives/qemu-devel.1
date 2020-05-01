Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F16C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB1F2073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeqkh+/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB1F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUd1I-0004N5-6I
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 17:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcyl-00087j-R1
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUcyk-0005RQ-Qj
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcyk-0005L0-Ca
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:50 -0400
Received: by mail-pl1-x642.google.com with SMTP id s10so4065319plr.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NCRdTQpU6yVNUEPlJLLGHU6a3sZwRzAjgbWbdlsQ8MI=;
 b=zeqkh+/TTsglElLbIFN3hMBdRqpEcOVZrxll/0xRs0LR3WESm+7VqhGjiEbt+6Wa6a
 wvbmPdUDEw2ao/Tj0IBs95uktmpKEZNUI0+EBAnc33kIwAp3zguks+7IuQ0xqjZSidWv
 dWGYxzbmGViSeaxOrlkIrSLL3hvok7sLUbwu4RuFBqeMQCxryul9q7eCLPoIURuCizdC
 9mJwDs0SVvzVMGeiYfRUgHPK5In0xFNylFYU5eyeeUOBmzakVXOY1PrmhDD0ZyrZ+Ya8
 zLKUDjQkZAFGz22sZfz2xufpeH+5POLdFLeOQH+1LJWOHa205q0Hdu9czxhdbygjVdZ0
 EuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NCRdTQpU6yVNUEPlJLLGHU6a3sZwRzAjgbWbdlsQ8MI=;
 b=i4gPN5dfmHldgBQShBXq3RSXU4J/+UKRY0Z6dhOoJPjxUmOAFev0Y3Wp/wq5y+uekQ
 6MsTzFx92HFOLXn7O9ZisJo4+ISisHRvVPdmxam2Yz7MZiAYWblFDP0Ucue5bcMhjZAs
 bh3yKZfeeRvCQgf9Kzsg33xAl51Pvv9Xjrodo54E2vAssGBJxqcDDPJHitTfL/iSLuYp
 zoE8c3rgbiuLSah+o0eiXMGfnC4RiibprqogapvCHVoDosqnCjcF5IS+HHnVvkkkBqwt
 0ZIPNHsLIWlcoDUgebMf7vEehewtie+lVKIxWwmRqxyWeIVM9MyzB0k+rg+kaB/3zSB4
 83Dw==
X-Gm-Message-State: AGi0Pua8N0COAODul8yhb/3LpES3G4aFF266busL8kcjMZHyfKTEIDoZ
 A4+2GjzPVLrQimBUtLmH0O0W8pIRweM=
X-Google-Smtp-Source: APiQypK8JnamwgbovmVDestWVoN4HBBTW6eVcczVaR2bL26fP4fbzTb/vlxcxBK+DdhoKqbWBVpFBQ==
X-Received: by 2002:a17:902:b082:: with SMTP id
 p2mr1780209plr.245.1588367628486; 
 Fri, 01 May 2020 14:13:48 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g22sm514552pju.21.2020.05.01.14.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 14:13:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/arm: Create gen_gvec_[us]sra
Date: Fri,  1 May 2020 14:13:40 -0700
Message-Id: <20200501211345.30410-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501211345.30410-1-richard.henderson@linaro.org>
References: <20200501211345.30410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::642
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
 target/arm/helper.h        |  10 +++
 target/arm/translate.h     |   7 +-
 target/arm/translate-a64.c |  15 +---
 target/arm/translate.c     | 161 ++++++++++++++++++++++---------------
 target/arm/vec_helper.c    |  25 ++++++
 5 files changed, 139 insertions(+), 79 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 5817626b20..9bc162345c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -691,6 +691,16 @@ DEF_HELPER_FLAGS_4(gvec_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(neon_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_ssra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ssra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ssra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ssra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_usra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_usra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_usra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_usra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 98b319f3f6..a39cf22666 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -285,8 +285,6 @@ extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
 extern const GVecGen3 sshl_op[4];
 extern const GVecGen3 ushl_op[4];
-extern const GVecGen2i ssra_op[4];
-extern const GVecGen2i usra_op[4];
 extern const GVecGen2i sri_op[4];
 extern const GVecGen2i sli_op[4];
 extern const GVecGen4 uqadd_op[4];
@@ -299,6 +297,11 @@ void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
 void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 
+void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 010b36633e..03f4dc5805 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10205,19 +10205,8 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
 
     switch (opcode) {
     case 0x02: /* SSRA / USRA (accumulate) */
-        if (is_u) {
-            /* Shift count same as element size produces zero to add.  */
-            if (shift == 8 << size) {
-                goto done;
-            }
-            gen_gvec_op2i(s, is_q, rd, rn, shift, &usra_op[size]);
-        } else {
-            /* Shift count same as element size produces all sign to add.  */
-            if (shift == 8 << size) {
-                shift -= 1;
-            }
-            gen_gvec_op2i(s, is_q, rd, rn, shift, &ssra_op[size]);
-        }
+        gen_gvec_fn2i(s, is_q, rd, rn, shift,
+                      is_u ? gen_gvec_usra : gen_gvec_ssra, size);
         return;
     case 0x08: /* SRI */
         /* Shift count same as element size is valid but does nothing.  */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a96899549b..04114906d7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4146,33 +4146,51 @@ static void gen_ssra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     tcg_gen_add_vec(vece, d, d, a);
 }
 
-static const TCGOpcode vecop_list_ssra[] = {
-    INDEX_op_sari_vec, INDEX_op_add_vec, 0
-};
+void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_ssra8_i64,
+          .fniv = gen_ssra_vec,
+          .fno = gen_helper_gvec_ssra_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_ssra16_i64,
+          .fniv = gen_ssra_vec,
+          .fno = gen_helper_gvec_ssra_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_ssra32_i32,
+          .fniv = gen_ssra_vec,
+          .fno = gen_helper_gvec_ssra_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_ssra64_i64,
+          .fniv = gen_ssra_vec,
+          .fno = gen_helper_gvec_ssra_b,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
 
-const GVecGen2i ssra_op[4] = {
-    { .fni8 = gen_ssra8_i64,
-      .fniv = gen_ssra_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_ssra,
-      .vece = MO_8 },
-    { .fni8 = gen_ssra16_i64,
-      .fniv = gen_ssra_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_ssra,
-      .vece = MO_16 },
-    { .fni4 = gen_ssra32_i32,
-      .fniv = gen_ssra_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_ssra,
-      .vece = MO_32 },
-    { .fni8 = gen_ssra64_i64,
-      .fniv = gen_ssra_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .opt_opc = vecop_list_ssra,
-      .load_dest = true,
-      .vece = MO_64 },
-};
+    /* tszimm encoding produces immediates in the range [1..esize]. */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /*
+     * Shifts larger than the element size are architecturally valid.
+     * Signed results in all sign bits.
+     */
+    shift = MIN(shift, (8 << vece) - 1);
+    tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+}
 
 static void gen_usra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
@@ -4204,33 +4222,55 @@ static void gen_usra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     tcg_gen_add_vec(vece, d, d, a);
 }
 
-static const TCGOpcode vecop_list_usra[] = {
-    INDEX_op_shri_vec, INDEX_op_add_vec, 0
-};
+void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_usra8_i64,
+          .fniv = gen_usra_vec,
+          .fno = gen_helper_gvec_usra_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8, },
+        { .fni8 = gen_usra16_i64,
+          .fniv = gen_usra_vec,
+          .fno = gen_helper_gvec_usra_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16, },
+        { .fni4 = gen_usra32_i32,
+          .fniv = gen_usra_vec,
+          .fno = gen_helper_gvec_usra_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32, },
+        { .fni8 = gen_usra64_i64,
+          .fniv = gen_usra_vec,
+          .fno = gen_helper_gvec_usra_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64, },
+    };
 
-const GVecGen2i usra_op[4] = {
-    { .fni8 = gen_usra8_i64,
-      .fniv = gen_usra_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_usra,
-      .vece = MO_8, },
-    { .fni8 = gen_usra16_i64,
-      .fniv = gen_usra_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_usra,
-      .vece = MO_16, },
-    { .fni4 = gen_usra32_i32,
-      .fniv = gen_usra_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_usra,
-      .vece = MO_32, },
-    { .fni8 = gen_usra64_i64,
-      .fniv = gen_usra_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .load_dest = true,
-      .opt_opc = vecop_list_usra,
-      .vece = MO_64, },
-};
+    /* tszimm encoding produces immediates in the range [1..esize]. */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /*
+     * Shifts larger than the element size are architecturally valid.
+     * Unsigned results in all zeros as input to accumulate: nop.
+     */
+    if (shift < (8 << vece)) {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    } else {
+        /* Nop, but we do need to clear the tail. */
+        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
+    }
+}
 
 static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
@@ -5596,19 +5636,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case 1:  /* VSRA */
                     /* Right shift comes here negative.  */
                     shift = -shift;
-                    /* Shifts larger than the element size are architecturally
-                     * valid.  Unsigned results in all zeros; signed results
-                     * in all sign bits.
-                     */
-                    if (!u) {
-                        tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size, vec_size,
-                                        MIN(shift, (8 << size) - 1),
-                                        &ssra_op[size]);
-                    } else if (shift >= 8 << size) {
-                        /* rd += 0 */
+                    if (u) {
+                        gen_gvec_usra(size, rd_ofs, rm_ofs, shift,
+                                      vec_size, vec_size);
                     } else {
-                        tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size, vec_size,
-                                        shift, &usra_op[size]);
+                        gen_gvec_ssra(size, rd_ofs, rm_ofs, shift,
+                                      vec_size, vec_size);
                     }
                     return 0;
 
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 3d534188a8..230085b35e 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -899,6 +899,31 @@ void HELPER(gvec_sqsub_d)(void *vd, void *vq, void *vn,
     clear_tail(d, oprsz, simd_maxsz(desc));
 }
 
+
+#define DO_SRA(NAME, TYPE)                              \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);               \
+    int shift = simd_data(desc);                        \
+    TYPE *d = vd, *n = vn;                              \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {        \
+        d[i] += n[i] >> shift;                          \
+    }                                                   \
+    clear_tail(d, oprsz, simd_maxsz(desc));             \
+}
+
+DO_SRA(gvec_ssra_b, int8_t)
+DO_SRA(gvec_ssra_h, int16_t)
+DO_SRA(gvec_ssra_s, int32_t)
+DO_SRA(gvec_ssra_d, int64_t)
+
+DO_SRA(gvec_usra_b, uint8_t)
+DO_SRA(gvec_usra_h, uint16_t)
+DO_SRA(gvec_usra_s, uint32_t)
+DO_SRA(gvec_usra_d, uint64_t)
+
+#undef DO_SRA
+
 /*
  * Convert float16 to float32, raising no exceptions and
  * preserving exceptional values, including SNaN.
-- 
2.20.1


