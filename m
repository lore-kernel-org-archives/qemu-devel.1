Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41AFC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C13B2084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TW3t5Ayc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C13B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3RhL-0000Yt-RN
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3RgU-0007q4-VG
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3RgT-0004tB-Hc
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:38 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3RgT-0004sM-C8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:37 -0500
Received: by mail-pg1-x542.google.com with SMTP id z12so7997761pgl.4
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 13:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O2GXPDLFXihWuaiW0fDwrNaCDa99hsJ9UfIJrAM1orM=;
 b=TW3t5Ayc5JouTnjfgnOAe8PSFoU5aml6f3YdB6tJvjBpXz/XkQ8WALVeO8veWPXxmj
 w7QlzmW7xF/hGsi2paL1BGdTRSuii27ZHEWanO8eMz56WsN2hc/vax8OF7gXlR+L6dwq
 7KJ2p/RMCpyMhdQkKfrMfJ0mVByAXNnPQu5oUYjK5sAefpo8V/ulhgR2AF9obxwBysxE
 dGGc4//aaocKAIxswi5nG+vjyVuLv48QaxUStjYRmwhxhL8MqE8SmyuGBn02umo6AgBS
 m46seyWnj3KrwNyLNaQdnauNzj9Zzs70NzzJwxuGLWxgNBbK6gcLPUlem9O/oPAJgbQP
 TV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O2GXPDLFXihWuaiW0fDwrNaCDa99hsJ9UfIJrAM1orM=;
 b=dQsnnFnZ/WDUfdvfj5RNmF/NInSnSs0G65Xm/Bg6Xrcrn0OhRQEP5BXMQmT2M7srEz
 uvEy2s1Q7AptSYMhvkoq1GtDce3zefgzTmuspjCYYN6a+cJtN9yjLbU8YcIpoAkoemyj
 QbGbPLc44AsqzSbSXmdQMwMOod5hdpRGVya/FcRdcmg90LwpABO0VnMMdnDNePfYkP8V
 OfhY2EoZsSTbg4cCvKpUfeKhF9WSmlb8eWN3zfXctT3bZhLulmYa9cXOwQLTV7a6Lk2O
 P6NP5nC/oVlhEYBLxYaQMKBWwxd+RKSv1xcgWfH023ZjSl1RwKdpdbqTlkMjc5Qe3PxN
 +gaA==
X-Gm-Message-State: APjAAAU4uFdT1c5nKCw0TmGoZj0B5dgWx2c1m6r5H+WD6NTB/ucv25WO
 DLVAxfGhUHapPKvetJgW9ZIVDTrImJY=
X-Google-Smtp-Source: APXvYqwCX+NSsYSzBinz2e50TmZeK3ZWAh9Y/JrnDSB9C4rMkSEpMI8Es2Jr5UAoNX8zEOXhsfCnqQ==
X-Received: by 2002:a63:4a47:: with SMTP id j7mr14571862pgl.196.1581889355873; 
 Sun, 16 Feb 2020 13:42:35 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z29sm14821848pgc.21.2020.02.16.13.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 13:42:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] target/arm: Convert PMUL.8 to gvec
Date: Sun, 16 Feb 2020 13:42:30 -0800
Message-Id: <20200216214232.4230-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216214232.4230-1-richard.henderson@linaro.org>
References: <20200216214232.4230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The gvec form will be needed for implementing SVE2.

Extend the implementation to operate on uint64_t instead of uint32_t.
Use a counted inner loop instead of terminating when op1 goes to zero,
looking toward the required implementation for ARMv8.4-DIT.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Elide mask after right-shift on N, as we already do N & 1
    at the top of the loop.
---
 target/arm/helper.h        |  3 ++-
 target/arm/neon_helper.c   | 22 ----------------------
 target/arm/translate-a64.c | 10 +++-------
 target/arm/translate.c     | 11 ++++-------
 target/arm/vec_helper.c    | 30 ++++++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 459a278b5c..82450a3f96 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -342,7 +342,6 @@ DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
 DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
-DEF_HELPER_2(neon_mul_p8, i32, i32, i32)
 DEF_HELPER_2(neon_mull_p8, i64, i32, i32)
 
 DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
@@ -696,6 +695,8 @@ DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
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
index e42dcfebdd..c96ed28f9d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11160,9 +11160,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
@@ -11292,11 +11293,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
index c4dd14e053..4581373e31 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5007,16 +5007,17 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 
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
@@ -5206,10 +5207,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
index fcb3663903..854de0e279 100644
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
+            nn >>= 1;
+        }
+        d[i] = rr;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.20.1


