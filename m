Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1164C83003
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7D7208E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcrIq6Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7D7208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTyan-0000Pu-LR
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyYu-0006yL-BC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyXc-0004jB-Ss
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:28 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTyXc-0004it-Fk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:03:08 -0400
Received: by mail-pj1-x1044.google.com with SMTP id hi11so58529pjb.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gsEJ37kFBNib5jJ+8MTgXRz3AX625bRkZVxUHawfefw=;
 b=lcrIq6MxITkYZT+ZbCpZx4mRysfEHcGumTPMNoUSVchseyN73aSszo5YX4kjBZCD5O
 1kK5Sr6Dl6D1owviLMvpb7SaLhokLV8U+65TGlVuzWhdAkWorcA4iXlcelWwo87eJ0IA
 8vVGgRk7Ddtl9ggfTtqvzYu3wy+hK99VLEkH7mMkpRj2zfFw3DiRnscZDYIhwsu2ujRW
 3APC+2xnjPRjJy8GQHIcb8k5tMGfHMgPgnFo9oi/pwOLALpl9GoRP+cRKUtKdeTuO/ec
 2W7aDmEyYwBCLwngWDveA6U02Byz+haKiMsYCdVl5OFfhpnctuGFUGsWFB82c2LvVir6
 u3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gsEJ37kFBNib5jJ+8MTgXRz3AX625bRkZVxUHawfefw=;
 b=Uf/Ov4NBQkoACkIXhl1fpXdlxPPK1qUsQBrjEQU0CKP1T4sOehOGrwg/MYN3DwvHRN
 tPXFz/mx00V60TbVxYje2KiLxasQi+ltiQGdDfKt2zfekKD11ZUE1CPEbuuem+JKBo3k
 BY1e1q6SNE3INy6rka515HItaQmWcq0yupvj09gwR0QHEuYu9mFfTOaqkXgzbottCqCD
 OQxFEDXTrrI6nT3nt/mx/C1MlL3fHa/uTu8O80HRznWaeK/DB8r5hu7oEkwEeamdIYuL
 I1i37Q6x43BMgD758KusrduuH8uXqSsnZhNbevx4r2j5EQuyR6gqeW3NwGulTzzvZG5+
 hH2w==
X-Gm-Message-State: AGi0PuYofatblGSXUQ4DoTXzP8LUuz3NDXzP9wNgEU1aIKVxP6FjqrC/
 Xikhkww2yQ1fEhzYE87Qzq4hREM2oa4=
X-Google-Smtp-Source: APiQypKmkJ1ttTrGLLJbJv0LLx0M/TA37loq+i7GqVc/kuX9X/oZok8IYMqtcL1QfO9TvZRmkC3MBQ==
X-Received: by 2002:a17:90a:8c3:: with SMTP id 3mr254605pjn.147.1588212186400; 
 Wed, 29 Apr 2020 19:03:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y3sm409284pjb.41.2020.04.29.19.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 19:03:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] target/arm: Convert aes and sm4 to gvec helpers
Date: Wed, 29 Apr 2020 19:02:55 -0700
Message-Id: <20200430020303.20264-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430020303.20264-1-richard.henderson@linaro.org>
References: <20200430020303.20264-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this conversion, we will be able to use the same helpers
with sve.  This also fixes a bug in which we failed to clear
the high bits of the SVE register after an AdvSIMD operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  6 ++--
 target/arm/vec_internal.h  | 10 ++++++
 target/arm/crypto_helper.c | 72 +++++++++++++++++++++++++++-----------
 target/arm/translate-a64.c | 56 ++++++++++++++++++-----------
 target/arm/translate.c     | 27 +++++++-------
 target/arm/vec_helper.c    | 10 ------
 6 files changed, 115 insertions(+), 66 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 032d5cdfbd..6623b6689a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -513,7 +513,7 @@ DEF_HELPER_FLAGS_2(neon_qzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_2(neon_qzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_2(neon_qzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
 
-DEF_HELPER_FLAGS_3(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sha1_3reg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -534,8 +534,8 @@ DEF_HELPER_FLAGS_5(crypto_sm3tt, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(crypto_sm3partw1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_3(crypto_sm3partw2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
-DEF_HELPER_FLAGS_2(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_4(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
diff --git a/target/arm/vec_internal.h b/target/arm/vec_internal.h
index ac365123c4..7eaffeb060 100644
--- a/target/arm/vec_internal.h
+++ b/target/arm/vec_internal.h
@@ -20,6 +20,16 @@
 #ifndef TARGET_ARM_VEC_INTERNALS_H
 #define TARGET_ARM_VEC_INTERNALS_H
 
+static inline void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
+{
+    uint64_t *d = vd + opr_sz;
+    uintptr_t i;
+
+    for (i = opr_sz; i < max_sz; i += 8) {
+        *d++ = 0;
+    }
+}
+
 static inline int32_t do_sqrshl_bhs(int32_t src, int32_t shift, int bits,
                                     bool round, uint32_t *sat)
 {
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index f800266727..6bd5a3d2d0 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -13,7 +13,9 @@
 
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes.h"
+#include "vec_internal.h"
 
 union CRYPTO_STATE {
     uint8_t    bytes[16];
@@ -29,18 +31,15 @@ union CRYPTO_STATE {
 #define CR_ST_WORD(state, i)   (state.words[i])
 #endif
 
-void HELPER(crypto_aese)(void *vd, void *vm, uint32_t decrypt)
+static void do_crypto_aese(uint64_t *rd, uint64_t *rn,
+                           uint64_t *rm, bool decrypt)
 {
     static uint8_t const * const sbox[2] = { AES_sbox, AES_isbox };
     static uint8_t const * const shift[2] = { AES_shifts, AES_ishifts };
-    uint64_t *rd = vd;
-    uint64_t *rm = vm;
     union CRYPTO_STATE rk = { .l = { rm[0], rm[1] } };
-    union CRYPTO_STATE st = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE st = { .l = { rn[0], rn[1] } };
     int i;
 
-    assert(decrypt < 2);
-
     /* xor state vector with round key */
     rk.l[0] ^= st.l[0];
     rk.l[1] ^= st.l[1];
@@ -54,7 +53,18 @@ void HELPER(crypto_aese)(void *vd, void *vm, uint32_t decrypt)
     rd[1] = st.l[1];
 }
 
-void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
+void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    bool decrypt = simd_data(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_aese(vd + i, vn + i, vm + i, decrypt);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
+
+static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, bool decrypt)
 {
     static uint32_t const mc[][256] = { {
         /* MixColumns lookup table */
@@ -190,13 +200,9 @@ void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
         0xbe805d9f, 0xb58d5491, 0xa89a4f83, 0xa397468d,
     } };
 
-    uint64_t *rd = vd;
-    uint64_t *rm = vm;
     union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
     int i;
 
-    assert(decrypt < 2);
-
     for (i = 0; i < 16; i += 4) {
         CR_ST_WORD(st, i >> 2) =
             mc[decrypt][CR_ST_BYTE(st, i)] ^
@@ -209,6 +215,17 @@ void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
     rd[1] = st.l[1];
 }
 
+void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    bool decrypt = simd_data(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_aesmc(vd + i, vm + i, decrypt);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
+
 /*
  * SHA-1 logical functions
  */
@@ -638,12 +655,10 @@ static uint8_t const sm4_sbox[] = {
     0x79, 0xee, 0x5f, 0x3e, 0xd7, 0xcb, 0x39, 0x48,
 };
 
-void HELPER(crypto_sm4e)(void *vd, void *vn)
+static void do_crypto_sm4e(uint64_t *rd, uint64_t *rn, uint64_t *rm)
 {
-    uint64_t *rd = vd;
-    uint64_t *rn = vn;
-    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
-    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE d = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE n = { .l = { rm[0], rm[1] } };
     uint32_t t, i;
 
     for (i = 0; i < 4; i++) {
@@ -665,11 +680,18 @@ void HELPER(crypto_sm4e)(void *vd, void *vn)
     rd[1] = d.l[1];
 }
 
-void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm)
+void HELPER(crypto_sm4e)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_sm4e(vd + i, vn + i, vm + i);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
+
+static void do_crypto_sm4ekey(uint64_t *rd, uint64_t *rn, uint64_t *rm)
 {
-    uint64_t *rd = vd;
-    uint64_t *rn = vn;
-    uint64_t *rm = vm;
     union CRYPTO_STATE d;
     union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
     union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
@@ -693,3 +715,13 @@ void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm)
     rd[0] = d.l[0];
     rd[1] = d.l[1];
 }
+
+void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_sm4ekey(vd + i, vn + i, vm + i);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 632c1c34ed..b2adf3a39e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -682,6 +682,15 @@ static void gen_gvec_op2(DisasContext *s, bool is_q, int rd,
                    is_q ? 16 : 8, vec_full_reg_size(s), gvec_op);
 }
 
+/* Expand a 2-operand operation using an out-of-line helper.  */
+static void gen_gvec_op2_ool(DisasContext *s, bool is_q, int rd,
+                             int rn, int data, gen_helper_gvec_2 *fn)
+{
+    tcg_gen_gvec_2_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
+}
+
 /* Expand a 3-operand AdvSIMD vector operation using an op descriptor.  */
 static void gen_gvec_op3(DisasContext *s, bool is_q, int rd,
                          int rn, int rm, const GVecGen3 *gvec_op)
@@ -14455,9 +14464,8 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int decrypt;
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
-    TCGv_i32 tcg_decrypt;
-    CryptoThreeOpIntFn *genfn;
+    gen_helper_gvec_2 *genfn2 = NULL;
+    gen_helper_gvec_3 *genfn3 = NULL;
 
     if (!dc_isar_feature(aa64_aes, s) || size != 0) {
         unallocated_encoding(s);
@@ -14467,19 +14475,19 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     switch (opcode) {
     case 0x4: /* AESE */
         decrypt = 0;
-        genfn = gen_helper_crypto_aese;
+        genfn3 = gen_helper_crypto_aese;
         break;
     case 0x6: /* AESMC */
         decrypt = 0;
-        genfn = gen_helper_crypto_aesmc;
+        genfn2 = gen_helper_crypto_aesmc;
         break;
     case 0x5: /* AESD */
         decrypt = 1;
-        genfn = gen_helper_crypto_aese;
+        genfn3 = gen_helper_crypto_aese;
         break;
     case 0x7: /* AESIMC */
         decrypt = 1;
-        genfn = gen_helper_crypto_aesmc;
+        genfn2 = gen_helper_crypto_aesmc;
         break;
     default:
         unallocated_encoding(s);
@@ -14489,16 +14497,11 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     if (!fp_access_check(s)) {
         return;
     }
-
-    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-    tcg_decrypt = tcg_const_i32(decrypt);
-
-    genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_decrypt);
-
-    tcg_temp_free_ptr(tcg_rd_ptr);
-    tcg_temp_free_ptr(tcg_rn_ptr);
-    tcg_temp_free_i32(tcg_decrypt);
+    if (genfn2) {
+        gen_gvec_op2_ool(s, true, rd, rn, decrypt, genfn2);
+    } else {
+        gen_gvec_op3_ool(s, true, rd, rd, rn, decrypt, genfn3);
+    }
 }
 
 /* Crypto three-reg SHA
@@ -14641,13 +14644,15 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
  */
 static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
 {
+    static const GVecGen3 sm4ekey_op = { .fno = gen_helper_crypto_sm4ekey };
     int opcode = extract32(insn, 10, 2);
     int o =  extract32(insn, 14, 1);
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool feature;
-    CryptoThreeOpFn *genfn;
+    CryptoThreeOpFn *genfn = NULL;
+    const GVecGen3 *gvecop = NULL;
 
     if (o == 0) {
         switch (opcode) {
@@ -14682,7 +14687,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
             break;
         case 2: /* SM4EKEY */
             feature = dc_isar_feature(aa64_sm4, s);
-            genfn = gen_helper_crypto_sm4ekey;
+            gvecop = &sm4ekey_op;
             break;
         default:
             unallocated_encoding(s);
@@ -14699,6 +14704,11 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (gvecop) {
+        gen_gvec_op3(s, true, rd, rn, rm, gvecop);
+        return;
+    }
+
     if (genfn) {
         TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
 
@@ -14751,6 +14761,7 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
     bool feature;
     CryptoTwoOpFn *genfn;
+    gen_helper_gvec_3 *gvecfn = NULL;
 
     switch (opcode) {
     case 0: /* SHA512SU0 */
@@ -14759,7 +14770,7 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
         break;
     case 1: /* SM4E */
         feature = dc_isar_feature(aa64_sm4, s);
-        genfn = gen_helper_crypto_sm4e;
+        gvecfn = gen_helper_crypto_sm4e;
         break;
     default:
         unallocated_encoding(s);
@@ -14775,6 +14786,11 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (gvecfn) {
+        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, gvecfn);
+        return;
+    }
+
     tcg_rd_ptr = vec_full_reg_ptr(s, rd);
     tcg_rn_ptr = vec_full_reg_ptr(s, rn);
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 94a81b8323..caa98ed309 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6925,22 +6925,23 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     if (!dc_isar_feature(aa32_aes, s) || ((rm | rd) & 1)) {
                         return 1;
                     }
-                    ptr1 = vfp_reg_ptr(true, rd);
-                    ptr2 = vfp_reg_ptr(true, rm);
-
-                     /* Bit 6 is the lowest opcode bit; it distinguishes between
-                      * encryption (AESE/AESMC) and decryption (AESD/AESIMC)
-                      */
-                    tmp3 = tcg_const_i32(extract32(insn, 6, 1));
-
+                    /*
+                     * Bit 6 is the lowest opcode bit; it distinguishes
+                     * between encryption (AESE/AESMC) and decryption
+                     * (AESD/AESIMC).
+                     */
                     if (op == NEON_2RM_AESE) {
-                        gen_helper_crypto_aese(ptr1, ptr2, tmp3);
+                        tcg_gen_gvec_3_ool(vfp_reg_offset(true, rd),
+                                           vfp_reg_offset(true, rd),
+                                           vfp_reg_offset(true, rm),
+                                           16, 16, extract32(insn, 6, 1),
+                                           gen_helper_crypto_aese);
                     } else {
-                        gen_helper_crypto_aesmc(ptr1, ptr2, tmp3);
+                        tcg_gen_gvec_2_ool(vfp_reg_offset(true, rd),
+                                           vfp_reg_offset(true, rm),
+                                           16, 16, extract32(insn, 6, 1),
+                                           gen_helper_crypto_aesmc);
                     }
-                    tcg_temp_free_ptr(ptr1);
-                    tcg_temp_free_ptr(ptr2);
-                    tcg_temp_free_i32(tmp3);
                     break;
                 case NEON_2RM_SHA1H:
                     if (!dc_isar_feature(aa32_sha1, s) || ((rm | rd) & 1)) {
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 2339be124c..25dca56090 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -38,16 +38,6 @@
 #define H4(x)  (x)
 #endif
 
-static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
-{
-    uint64_t *d = vd + opr_sz;
-    uintptr_t i;
-
-    for (i = opr_sz; i < max_sz; i += 8) {
-        *d++ = 0;
-    }
-}
-
 /* Signed saturating rounding doubling multiply-accumulate high half, 8-bit */
 void HELPER(sve2_sqrdmlah_b)(void *vd, void *vn, void *vm,
                              void *va, uint32_t desc)
-- 
2.20.1


