Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4FFA372C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 04:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8636205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 04:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfzAzPUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8636205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKxda-0008OU-VM
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 00:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKxcX-00077P-2L
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 00:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKxcV-00025d-Lv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 00:42:40 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKxcV-00025A-Fy
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 00:42:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id s17so499464plp.6
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 21:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PZpnzCTp4TAl1mRs0mTpxpQvQZ85cY78nrzStIrtedc=;
 b=JfzAzPUF2/99Y/+DBBydjMifYJAY57nm3672k93VYO/eY3zjqys2cRNrLVii9SgnO2
 pM2u3chbNOBYnAS9wYSOqv8oqDMMiaynAQhFCF63Gc+nMr/omG7NfbjJJp8AVCd6EDIi
 FgnAgHSfcd+Dc6oeisrWp2ZcaCnMQE5KBzRmqk7oAGC+eHoljg8DfqS2BK7H/aLvpYP1
 s8PPTwrEjaM/fDrUv/HYHbs3ODwjyvawTFsCnmn82zcocAbS0WHtDZq2v7O97HW3JeWs
 PoD5e0hto/HiNNEq1TgO+oZGpF7gxeLZsYLUGepHTfwM5S3ygNR6ud/FeQlUqX4vwlyg
 4n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PZpnzCTp4TAl1mRs0mTpxpQvQZ85cY78nrzStIrtedc=;
 b=aIwjWlEiyLthqZ87qNilNINvK9Lp1PeXfj/WPmLb7EuDXC8wvZPZqdUZTzETUVJOAt
 96WgQqh4h+HedBGPTCtSWb9BUxrPrJ/NcF5TWW4jMae0WI8lDX2LEepRh/qsLXk6kA8M
 ZtdrYKXx7BCz9ZaU3F9h+y26WYQZV9YcwrBHKW/NtpztEgUpZjX9fw1QC/x1qHiHvZBj
 eOuciyJX/OOkEEgb+LBGt1/WhlGaSJ72xHkGVrd7+KKku1KEllE1VIkiCRBeQ8W17H7x
 DZC6eHJsMMP8AaReZOyQCu0iQZ+D2IbDPcVjcT3FD5O5z2OftFOtau3WbqfNpFQfZEUZ
 yNZg==
X-Gm-Message-State: APjAAAXx5xwt/LeCASaxyQCcZmViNHnWYNazjxqKxCgjE6ErRrw3ubtO
 H7HS/xlrYwtEaW76dfpqoR+2HrPCGdY=
X-Google-Smtp-Source: APXvYqw+03t31Ft674h0hhjX1d7HyFAfkdpkwPz7iMkYqZT5ks07Fpwv67FLBdfpIn8fHpv0J4jwCg==
X-Received: by 2002:a17:902:900c:: with SMTP id
 a12mr1994684plp.30.1571287357948; 
 Wed, 16 Oct 2019 21:42:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n15sm718923pjt.13.2019.10.16.21.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 21:42:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/arm: Convert PMUL.8 to gvec
Date: Wed, 16 Oct 2019 21:42:30 -0700
Message-Id: <20191017044232.27601-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017044232.27601-1-richard.henderson@linaro.org>
References: <20191017044232.27601-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The gvec form will be needed for implementing SVE2.

Extend the implementation to operate on uint64_t instead of uint32_t.
Use a counted inner loop instead of terminating when op1 goes to zero,
looking toward the required implementation for ARMv8.4-DIT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  3 ++-
 target/arm/neon_helper.c   | 22 ----------------------
 target/arm/translate-a64.c | 10 +++-------
 target/arm/translate.c     | 11 ++++-------
 target/arm/vec_helper.c    | 30 ++++++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index fc0d594a14..800446e537 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -335,7 +335,6 @@ DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
 DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
-DEF_HELPER_2(neon_mul_p8, i32, i32, i32)
 DEF_HELPER_2(neon_mull_p8, i64, i32, i32)
 
 DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
@@ -689,6 +688,8 @@ DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index c581ffb7d3..9e7a9a1ac5 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -1131,28 +1131,6 @@ NEON_VOP(mul_u16, neon_u16, 2)
 
 /* Polynomial multiplication is like integer multiplication except the
    partial products are XORed, not added.  */
-uint32_t HELPER(neon_mul_p8)(uint32_t op1, uint32_t op2)
-{
-    uint32_t mask;
-    uint32_t result;
-    result = 0;
-    while (op1) {
-        mask = 0;
-        if (op1 & 1)
-            mask |= 0xff;
-        if (op1 & (1 << 8))
-            mask |= (0xff << 8);
-        if (op1 & (1 << 16))
-            mask |= (0xff << 16);
-        if (op1 & (1 << 24))
-            mask |= (0xff << 24);
-        result ^= op2 & mask;
-        op1 = (op1 >> 1) & 0x7f7f7f7f;
-        op2 = (op2 << 1) & 0xfefefefe;
-    }
-    return result;
-}
-
 uint64_t HELPER(neon_mull_p8)(uint32_t op1, uint32_t op2)
 {
     uint64_t result = 0;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 255a168df6..04e25cfe06 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11110,9 +11110,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x13: /* MUL, PMUL */
         if (!u) { /* MUL */
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
-            return;
+        } else {  /* PMUL */
+            gen_gvec_op3_ool(s, is_q, rd, rn, rm, 0, gen_helper_gvec_pmul_b);
         }
-        break;
+        return;
     case 0x12: /* MLA, MLS */
         if (u) {
             gen_gvec_op3(s, is_q, rd, rn, rm, &mls_op[size]);
@@ -11242,11 +11243,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x13: /* MUL, PMUL */
-                assert(u); /* PMUL */
-                assert(size == 0);
-                genfn = gen_helper_neon_mul_p8;
-                break;
             case 0x16: /* SQDMULH, SQRDMULH */
             {
                 static NeonGenTwoOpEnvFn * const fns[2][2] = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 598bb1cc00..b66a2f6b71 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5014,16 +5014,17 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 
         case NEON_3R_VMUL: /* VMUL */
             if (u) {
-                /* Polynomial case allows only P8 and is handled below.  */
+                /* Polynomial case allows only P8.  */
                 if (size != 0) {
                     return 1;
                 }
+                tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
+                                   0, gen_helper_gvec_pmul_b);
             } else {
                 tcg_gen_gvec_mul(size, rd_ofs, rn_ofs, rm_ofs,
                                  vec_size, vec_size);
-                return 0;
             }
-            break;
+            return 0;
 
         case NEON_3R_VML: /* VMLA, VMLS */
             tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
@@ -5213,10 +5214,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rd, pass);
             gen_neon_add(size, tmp, tmp2);
             break;
-        case NEON_3R_VMUL:
-            /* VMUL.P8; other cases already eliminated.  */
-            gen_helper_neon_mul_p8(tmp, tmp, tmp2);
-            break;
         case NEON_3R_VPMAX:
             GEN_NEON_INTEGER_OP(pmax);
             break;
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index fcb3663903..d401282c6f 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1134,3 +1134,33 @@ void HELPER(gvec_ushl_h)(void *vd, void *vn, void *vm, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+/*
+ * 8x8->8 polynomial multiply.
+ *
+ * Polynomial multiplication is like integer multiplication except the
+ * partial products are XORed, not added.
+ *
+ * TODO: expose this as a generic vector operation, as it is a common
+ * crypto building block.
+ */
+void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        uint64_t nn = n[i];
+        uint64_t mm = m[i];
+        uint64_t rr = 0;
+
+        for (j = 0; j < 8; ++j) {
+            uint64_t mask = (nn & 0x0101010101010101ull) * 0xff;
+            rr ^= mm & mask;
+            mm = (mm << 1) & 0xfefefefefefefefeull;
+            nn = (nn >> 1) & 0x7f7f7f7f7f7f7f7full;
+        }
+        d[i] = rr;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.17.1


