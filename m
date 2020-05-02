Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2616CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18B7206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqRmyHGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18B7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV0yd-0006DS-1G
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sz-0003N3-Et
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0sy-0004sD-5u
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sx-0004qc-NU
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:27 -0400
Received: by mail-pg1-x542.google.com with SMTP id o18so1332754pgg.8
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+liplU8tAVfM4Ulw1/YXG/0tJBrp4eVoUpZCRifSwxM=;
 b=XqRmyHGEJBgUClJwGZruu8bRvSDQ47A00rHKttB+hqI1dZL31C6bQcQr8TeHiZKfUi
 KHwuFvlhp+mQIkBkHUWAa6n1KvDTYHOA60kcg3VcxGIl1wyue3i+1thsZIKXwc8mqSSq
 uC8Q5lVnmEtVHd9giVm6+G02sSx++tXZ1hqnbIxDkacpJ3tSpjNQXjLc7a+JO4nQHMri
 nNx3r28bFD3HCYGyypIuhyBhmzAbhWu+PWj+Ew2Pd0g1HQsBJclldYdkdFEAI3he0cMM
 6gt+21lpPJA9HKPbPR07HWcJQ12TeFdwTF2MO5YHbuouh5KLj1SPZDK0cQXyWbsTDODq
 UIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+liplU8tAVfM4Ulw1/YXG/0tJBrp4eVoUpZCRifSwxM=;
 b=ViH9MI1Xm+g62z8zLqLPBR46arlKNl0lwE7vRWvMtuNz+4aW7zocWBDjdlnB68RDXz
 ouMkqzmFGdAE4WThzHEx0fzsxPeThQhysOYqT+x9vAh0bp8QAjYki+NzJBN/ipbMVcqT
 O6f1mcazzcvkFPDPbN+VcXw8w3uVuBbhT45L5g3UjFCZGXR9PkbL5PQMNThTHoKRmbkd
 nVi6ygyKKeBKdKkoJ+4UX1DWzjOXUubItVYIpe+nZx5CposL690WckEZAGrbT1upZoUC
 UkYsSP1QTSfOWg+g1o7uvU8HlUquDiKuudqgh0pge219RvBd54H0Ua9sUBtR2Q/RHx/z
 a6NA==
X-Gm-Message-State: AGi0PubNxna2D9jCeiwM1KFaGIklxejLb+RoqxjMLncTqR7YvLFMcKV4
 L7Uu8KF8RqBFeOMkQNt0WfyRnWXLmwo=
X-Google-Smtp-Source: APiQypLfF1n8fnwFSjv/u4eWMJJmKF+jyplXVk03PG5wGHqJI5860D/EA1TE7U7W/1bKFvRVO8oijA==
X-Received: by 2002:aa7:8ec1:: with SMTP id b1mr10639157pfr.103.1588459525773; 
 Sat, 02 May 2020 15:45:25 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/15] target/arm: Vectorize SABD/UABD
Date: Sat,  2 May 2020 15:45:02 -0700
Message-Id: <20200502224503.2282-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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

Include 64-bit element size in preparation for SVE2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  10 +++
 target/arm/translate.h     |   5 ++
 target/arm/translate-a64.c |   8 ++-
 target/arm/translate.c     | 133 ++++++++++++++++++++++++++++++++++++-
 target/arm/vec_helper.c    |  24 +++++++
 5 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index aed3050965..4678d3a6f4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -731,6 +731,16 @@ DEF_HELPER_FLAGS_3(gvec_sli_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sli_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sli_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_sabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_uabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 76cd3d31c7..d4c4111a5c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -337,6 +337,11 @@ void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                           uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1821a8e09d..38f72bf550 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11207,6 +11207,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smin, size);
         }
         return;
+    case 0xe: /* SABD, UABD */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uabd, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sabd, size);
+        }
+        return;
     case 0x10: /* ADD, SUB */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
@@ -11339,7 +11346,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genenvfn = fns[size][u];
                 break;
             }
-            case 0xe: /* SABD, UABD */
             case 0xf: /* SABA, UABA */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 532768d65f..e0c4de2898 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5374,6 +5374,126 @@ void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
+static void gen_sabd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_sub_i32(t, a, b);
+    tcg_gen_sub_i32(d, b, a);
+    tcg_gen_movcond_i32(TCG_COND_LT, d, a, b, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_sabd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_sub_i64(d, b, a);
+    tcg_gen_movcond_i64(TCG_COND_LT, d, a, b, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_sabd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_smin_vec(vece, t, a, b);
+    tcg_gen_smax_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_smin_vec, INDEX_op_smax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_sabd_i32,
+          .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_sabd_i64,
+          .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_uabd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_sub_i32(t, a, b);
+    tcg_gen_sub_i32(d, b, a);
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_uabd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_sub_i64(d, b, a);
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_uabd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_umin_vec(vece, t, a, b);
+    tcg_gen_umax_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_umin_vec, INDEX_op_umax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_uabd_i32,
+          .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_uabd_i64,
+          .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
    We process data in a mixture of 32-bit and 64-bit chunks.
@@ -5642,6 +5762,16 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                               vec_size, vec_size);
             }
             return 0;
+
+        case NEON_3R_VABD:
+            if (u) {
+                gen_gvec_uabd(size, rd_ofs, rn_ofs, rm_ofs,
+                              vec_size, vec_size);
+            } else {
+                gen_gvec_sabd(size, rd_ofs, rn_ofs, rm_ofs,
+                              vec_size, vec_size);
+            }
+            return 0;
         }
 
         if (size == 3) {
@@ -5772,9 +5902,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQRSHL:
             GEN_NEON_INTEGER_OP_ENV(qrshl);
             break;
-        case NEON_3R_VABD:
-            GEN_NEON_INTEGER_OP(abd);
-            break;
         case NEON_3R_VABA:
             GEN_NEON_INTEGER_OP(abd);
             tcg_temp_free_i32(tmp2);
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index a483841add..a4972d02fc 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1407,3 +1407,27 @@ DO_CMP0(gvec_cgt0_h, int16_t, >)
 DO_CMP0(gvec_cge0_h, int16_t, >=)
 
 #undef DO_CMP0
+
+#define DO_ABD(NAME, TYPE)                                      \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    TYPE *d = vd, *n = vn, *m = vm;                             \
+                                                                \
+    for (i = 0; i < opr_sz / sizeof(TYPE); ++i) {               \
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];         \
+    }                                                           \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                    \
+}
+
+DO_ABD(gvec_sabd_b, int8_t)
+DO_ABD(gvec_sabd_h, int16_t)
+DO_ABD(gvec_sabd_s, int32_t)
+DO_ABD(gvec_sabd_d, int64_t)
+
+DO_ABD(gvec_uabd_b, uint8_t)
+DO_ABD(gvec_uabd_h, uint16_t)
+DO_ABD(gvec_uabd_s, uint32_t)
+DO_ABD(gvec_uabd_d, uint64_t)
+
+#undef DO_ABD
-- 
2.20.1


