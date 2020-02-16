Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F3C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3256F2084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daVeXO4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3256F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Rik-0002Oz-DP
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3RgW-0007rh-4Q
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3RgU-0004uZ-LD
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:40 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3RgU-0004ts-FB
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:42:38 -0500
Received: by mail-pf1-x443.google.com with SMTP id n7so7797500pfn.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 13:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BlbLiic8tZvSZ65YWPCZvJVkerl00AuqwrCb0HcI98k=;
 b=daVeXO4OWCYwn8hr9NIbeneAn/kv0LTzrBn4xXLYCFhMbjRUDE4Vu03fz1NZPEdMtJ
 DFY/UGqotBgCtK/cJYN8R/j4ungtDq4vdttzsmOHNX5TrDUFgOENyyw5D//fkjrhR+tj
 5WR3xjyh625Nbt9yNJHaN2+4IajCEJkiZTriObpAPZmd0z7E9a4G/pzKi5JKSeEZhGUo
 cBoxiWqpdMKWFZ3ugGCkCEhcqABvMzLGTjZtFSq6SGew5iiLm+nV7jK+XeHtulKujxVT
 sH04SxpCYOoTIneJG4gSU8eEFzBDvL1LUS2rwszCRVxzMLJwNdqcQn/DiXlfrsrT8F77
 HQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BlbLiic8tZvSZ65YWPCZvJVkerl00AuqwrCb0HcI98k=;
 b=DtSFfBrI7Zdf7BozGyl2ZfESSSHf1nwVjbjPvMZA0FWt9kdydPZM5MdWjR9uKwBaYH
 fKK7CzkRZTAmbg+5P1pcwt+iYTAg1hyVapREyl3jK+HMGrlsljwRe+u9ogRd9J3m8UUz
 YEMsRF8X2ZqkwaHqSSYZ95adO7mISlBfO9nMHvMmJ690GktZXI7erylLsJorTB89CTsq
 sNnzVdLIXumlXsHX1Cua+zWR9JFEKF7skiTS9H+yBVX1uVqopaowg8d1DjqVpIN3ppXA
 BD9XjtGh/QbnOpH5sOg80TevWx3pF4DUs+Sl/NPguiyYQGQTZ9mEg0N+IA9YJjb7dLFF
 Sw9A==
X-Gm-Message-State: APjAAAXjVBNEN4LQeA5AtGE4zuSUb1icHxrS2tT15scu+Jk4O71n2Dj4
 fzReiy27aEknAK5ZQ0BHONTDeDDAqgc=
X-Google-Smtp-Source: APXvYqzZNJlRmQSYV2ShwRVfCF9j4wg9Z8R0bE03kKogWtbLGySOi3EGHSgYnSEiW5B6tpkqlvyuOQ==
X-Received: by 2002:a65:40c8:: with SMTP id u8mr11334728pgp.188.1581889357162; 
 Sun, 16 Feb 2020 13:42:37 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z29sm14821848pgc.21.2020.02.16.13.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 13:42:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] target/arm: Convert PMULL.64 to gvec
Date: Sun, 16 Feb 2020 13:42:31 -0800
Message-Id: <20200216214232.4230-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216214232.4230-1-richard.henderson@linaro.org>
References: <20200216214232.4230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  4 +---
 target/arm/neon_helper.c   | 30 ------------------------------
 target/arm/translate-a64.c | 28 +++-------------------------
 target/arm/translate.c     | 16 ++--------------
 target/arm/vec_helper.c    | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 72 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 82450a3f96..4352fae3db 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -562,9 +562,6 @@ DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(dc_zva, void, env, i64)
 
-DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
 DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s16, TCG_CALL_NO_RWG,
@@ -696,6 +693,7 @@ DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index 9e7a9a1ac5..6a107da0e1 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -2152,33 +2152,3 @@ void HELPER(neon_zip16)(void *vd, void *vm)
     rm[0] = m0;
     rd[0] = d0;
 }
-
-/* Helper function for 64 bit polynomial multiply case:
- * perform PolynomialMult(op1, op2) and return either the top or
- * bottom half of the 128 bit result.
- */
-uint64_t HELPER(neon_pmull_64_lo)(uint64_t op1, uint64_t op2)
-{
-    int bitnum;
-    uint64_t res = 0;
-
-    for (bitnum = 0; bitnum < 64; bitnum++) {
-        if (op1 & (1ULL << bitnum)) {
-            res ^= op2 << bitnum;
-        }
-    }
-    return res;
-}
-uint64_t HELPER(neon_pmull_64_hi)(uint64_t op1, uint64_t op2)
-{
-    int bitnum;
-    uint64_t res = 0;
-
-    /* bit 0 of op1 can't influence the high 64 bits at all */
-    for (bitnum = 1; bitnum < 64; bitnum++) {
-        if (op1 & (1ULL << bitnum)) {
-            res ^= op2 >> (64 - bitnum);
-        }
-    }
-    return res;
-}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c96ed28f9d..6ce1131860 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10648,30 +10648,6 @@ static void handle_3rd_narrowing(DisasContext *s, int is_q, int is_u, int size,
     clear_vec_high(s, is_q, rd);
 }
 
-static void handle_pmull_64(DisasContext *s, int is_q, int rd, int rn, int rm)
-{
-    /* PMULL of 64 x 64 -> 128 is an odd special case because it
-     * is the only three-reg-diff instruction which produces a
-     * 128-bit wide result from a single operation. However since
-     * it's possible to calculate the two halves more or less
-     * separately we just use two helper calls.
-     */
-    TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-    TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-    TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-    read_vec_element(s, tcg_op1, rn, is_q, MO_64);
-    read_vec_element(s, tcg_op2, rm, is_q, MO_64);
-    gen_helper_neon_pmull_64_lo(tcg_res, tcg_op1, tcg_op2);
-    write_vec_element(s, tcg_res, rd, 0, MO_64);
-    gen_helper_neon_pmull_64_hi(tcg_res, tcg_op1, tcg_op2);
-    write_vec_element(s, tcg_res, rd, 1, MO_64);
-
-    tcg_temp_free_i64(tcg_op1);
-    tcg_temp_free_i64(tcg_op2);
-    tcg_temp_free_i64(tcg_res);
-}
-
 /* AdvSIMD three different
  *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+---+------+--------+-----+------+------+
@@ -10736,7 +10712,9 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
             if (!fp_access_check(s)) {
                 return;
             }
-            handle_pmull_64(s, is_q, rd, rn, rm);
+            /* The Q field specifies lo/hi half input for this insn.  */
+            gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
+                             gen_helper_gvec_pmull_q);
             return;
         }
         goto is_widening;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4581373e31..e2dbafa161 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5870,23 +5870,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                  * outside the loop below as it only performs a single pass.
                  */
                 if (op == 14 && size == 2) {
-                    TCGv_i64 tcg_rn, tcg_rm, tcg_rd;
-
                     if (!dc_isar_feature(aa32_pmull, s)) {
                         return 1;
                     }
-                    tcg_rn = tcg_temp_new_i64();
-                    tcg_rm = tcg_temp_new_i64();
-                    tcg_rd = tcg_temp_new_i64();
-                    neon_load_reg64(tcg_rn, rn);
-                    neon_load_reg64(tcg_rm, rm);
-                    gen_helper_neon_pmull_64_lo(tcg_rd, tcg_rn, tcg_rm);
-                    neon_store_reg64(tcg_rd, rd);
-                    gen_helper_neon_pmull_64_hi(tcg_rd, tcg_rn, tcg_rm);
-                    neon_store_reg64(tcg_rd, rd + 1);
-                    tcg_temp_free_i64(tcg_rn);
-                    tcg_temp_free_i64(tcg_rm);
-                    tcg_temp_free_i64(tcg_rd);
+                    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16,
+                                       0, gen_helper_gvec_pmull_q);
                     return 0;
                 }
 
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 854de0e279..79d2624f7b 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1164,3 +1164,36 @@ void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+/*
+ * 64x64->128 polynomial multiply.
+ * Because of the lanes are not accessed in strict columns,
+ * this probably cannot be turned into a generic helper.
+ */
+void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    intptr_t hi = simd_data(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; i += 2) {
+        uint64_t nn = n[i + hi];
+        uint64_t mm = m[i + hi];
+        uint64_t rhi = 0;
+        uint64_t rlo = 0;
+
+        /* Bit 0 can only influence the low 64-bit result.  */
+        if (nn & 1) {
+            rlo = mm;
+        }
+
+        for (j = 1; j < 64; ++j) {
+            uint64_t mask = -((nn >> j) & 1);
+            rlo ^= (mm << j) & mask;
+            rhi ^= (mm >> (64 - j)) & mask;
+        }
+        d[i] = rlo;
+        d[i + 1] = rhi;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.20.1


