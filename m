Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2C1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B9E2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbqZJ0Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B9E2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmay-0002Vz-7R
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmBX-0000F6-Qu
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:56 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmBV-0002wM-Sz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id b201so2213766pfb.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DygMgaLNYWylv0GTxLN5OGupaR/Qw7NMFeyBm/ipLyw=;
 b=jbqZJ0Eo9YZgRKTRl3hgxDM412RQ/caXNLyUVoYYbsp8YUVrPMuLLzp1XDRAG0UdAT
 41HnDbpubXYXmnVNVqohBcfFARrqUwOEJ9GROm7gIrv4UAAyWUq65Hs7bV8dUKeglPuL
 p8mLOSksFkyS/yHMEprBZI7wCELuQCibBN5PTScurmh4cG7x7iLSxyg2CLJlMNbEeYdu
 mNHxHu9ztCq5K+zT4S+GWf4dtFw8ttyaQbVq5L5u5OyTiF+PSFURlUZGCZSZ/k8lG9J3
 wCXrQYxcCS6vqYP670pEIMSq/pNQTroFJb5/U+QWSpeM6VqgnCdDQVrhLNXbSY+nGPtO
 Du1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DygMgaLNYWylv0GTxLN5OGupaR/Qw7NMFeyBm/ipLyw=;
 b=Cu3RkLUqGTRXYRWvY42MzGQ4ZDNO15YVqUYf58d/KZ7GpwSZsOtyX7b9rmUPobvuzo
 sgVhNZkIYRlfRK9pYAzfCdO/51TkrxUgpVb69VURpjFv/SWdX8Hf308D/d88eRtWSAx7
 2jYLSmeQulqIoi7Q/ObX6KJM4RQIEDfg1trhXTTZ0CRvFxyQmio5HUmuCjALl28mgDw4
 OwBjI0rG7B0TEBi0x6/BrENr8tz66nnUKPNWi/28bq5DfetujoAYEvl+98GPSOIO/6o3
 uericvSq7T2b7MKmI4YZIFjjn6FrR6CSNj6I8vtuW3Cdxc3w7AqM1ekLn7wctSjiBa7x
 oqOQ==
X-Gm-Message-State: AOAM532dYM2YU35pVGtAYkk9Qu0gqT46y9h0LSP/jqH7O9VMD70nDHc8
 dGy/44qgn+2sVwK8TnxawyoQqIhfhK8=
X-Google-Smtp-Source: ABdhPJw9NIW7WkQl/6IqrQau5OJkRlKdXkvviTbIJuseRx8g4LOb0E890/ammEYBlgu/zy4wCVMtFg==
X-Received: by 2002:a62:14d7:: with SMTP id 206mr1867955pfu.245.1592454592007; 
 Wed, 17 Jun 2020 21:29:52 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j17sm1157899pgk.66.2020.06.17.21.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:29:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 047/100] target/arm: Implement SVE2 bitwise ternary
 operations
Date: Wed, 17 Jun 2020 21:25:51 -0700
Message-Id: <20200618042644.1685561-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |   6 ++
 target/arm/sve.decode      |  12 +++
 target/arm/sve_helper.c    |  50 +++++++++
 target/arm/translate-sve.c | 213 +++++++++++++++++++++++++++++++++++++
 4 files changed, 281 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4c4a8b27b1..7e159fd0ef 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2055,3 +2055,9 @@ DEF_HELPER_FLAGS_6(sve2_fminp_zpzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve2_fminp_zpzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_eor3, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_bcax, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_bsl1n, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_bsl2n, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_nbsl, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 19d503e2f4..a50afd40c2 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -124,6 +124,10 @@
 @rda_rn_rm      ........ esz:2 . rm:5 ... ... rn:5 rd:5 \
                 &rrrr_esz ra=%reg_movprfx
 
+# Four operand with unused vector element size
+@rdn_ra_rm_e0   ........ ... rm:5 ... ... ra:5 rd:5 \
+                &rrrr_esz esz=0 rn=%reg_movprfx
+
 # Three operand with "memory" size, aka immediate left shift
 @rd_rn_msz_rm   ........ ... rm:5 .... imm:2 rn:5 rd:5          &rrri
 
@@ -379,6 +383,14 @@ ORR_zzz         00000100 01 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 EOR_zzz         00000100 10 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 BIC_zzz         00000100 11 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 
+# SVE2 bitwise ternary operations
+EOR3            00000100 00 1 ..... 001 110 ..... .....         @rdn_ra_rm_e0
+BSL             00000100 00 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
+BCAX            00000100 01 1 ..... 001 110 ..... .....         @rdn_ra_rm_e0
+BSL1N           00000100 01 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
+BSL2N           00000100 10 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
+NBSL            00000100 11 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
+
 ### SVE Index Generation Group
 
 # SVE index generation (immediate start, immediate increment)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 5d80dc8c58..c690e86d1d 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6390,3 +6390,53 @@ DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
+
+void HELPER(sve2_eor3)(void *vd, void *vn, void *vm, void *vk, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm, *k = vk;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = n[i] ^ m[i] ^ k[i];
+    }
+}
+
+void HELPER(sve2_bcax)(void *vd, void *vn, void *vm, void *vk, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm, *k = vk;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = n[i] ^ (m[i] & ~k[i]);
+    }
+}
+
+void HELPER(sve2_bsl1n)(void *vd, void *vn, void *vm, void *vk, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm, *k = vk;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = (~n[i] & k[i]) | (m[i] & ~k[i]);
+    }
+}
+
+void HELPER(sve2_bsl2n)(void *vd, void *vn, void *vm, void *vk, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm, *k = vk;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = (n[i] & k[i]) | (~m[i] & ~k[i]);
+    }
+}
+
+void HELPER(sve2_nbsl)(void *vd, void *vn, void *vm, void *vk, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm, *k = vk;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = ~((n[i] & k[i]) | (m[i] & ~k[i]));
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 97e26c8ff5..6fada01d22 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -217,6 +217,17 @@ static void gen_gvec_fn_zzz(DisasContext *s, GVecGen3Fn *gvec_fn,
             vec_full_reg_offset(s, rm), vsz, vsz);
 }
 
+/* Invoke a vector expander on four Zregs.  */
+static void gen_gvec_fn_zzzz(DisasContext *s, GVecGen4Fn *gvec_fn,
+                             int esz, int rd, int rn, int rm, int ra)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    gvec_fn(esz, vec_full_reg_offset(s, rd),
+            vec_full_reg_offset(s, rn),
+            vec_full_reg_offset(s, rm),
+            vec_full_reg_offset(s, ra), vsz, vsz);
+}
+
 /* Invoke a vector move on two Zregs.  */
 static bool do_mov_z(DisasContext *s, int rd, int rn)
 {
@@ -329,6 +340,208 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a)
     return do_zzz_fn(s, a, tcg_gen_gvec_andc);
 }
 
+static bool do_sve2_zzzz_fn(DisasContext *s, arg_rrrr_esz *a, GVecGen4Fn *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_fn_zzzz(s, fn, a->esz, a->rd, a->rn, a->rm, a->ra);
+    }
+    return true;
+}
+
+static void gen_eor3_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
+{
+    tcg_gen_xor_i64(d, n, m);
+    tcg_gen_xor_i64(d, d, k);
+}
+
+static void gen_eor3_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
+                         TCGv_vec m, TCGv_vec k)
+{
+    tcg_gen_xor_vec(vece, d, n, m);
+    tcg_gen_xor_vec(vece, d, d, k);
+}
+
+static void gen_eor3(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                     uint32_t a, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_eor3_i64,
+        .fniv = gen_eor3_vec,
+        .fno = gen_helper_sve2_eor3,
+        .vece = MO_64,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
+}
+
+static bool trans_EOR3(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_sve2_zzzz_fn(s, a, gen_eor3);
+}
+
+static void gen_bcax_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
+{
+    tcg_gen_andc_i64(d, m, k);
+    tcg_gen_xor_i64(d, d, n);
+}
+
+static void gen_bcax_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
+                         TCGv_vec m, TCGv_vec k)
+{
+    tcg_gen_andc_vec(vece, d, m, k);
+    tcg_gen_xor_vec(vece, d, d, n);
+}
+
+static void gen_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                     uint32_t a, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_bcax_i64,
+        .fniv = gen_bcax_vec,
+        .fno = gen_helper_sve2_bcax,
+        .vece = MO_64,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
+}
+
+static bool trans_BCAX(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_sve2_zzzz_fn(s, a, gen_bcax);
+}
+
+static void gen_bsl(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                    uint32_t a, uint32_t oprsz, uint32_t maxsz)
+{
+    /* BSL differs from the generic bitsel in argument ordering. */
+    tcg_gen_gvec_bitsel(vece, d, a, n, m, oprsz, maxsz);
+}
+
+static bool trans_BSL(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_sve2_zzzz_fn(s, a, gen_bsl);
+}
+
+static void gen_bsl1n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
+{
+    tcg_gen_andc_i64(n, k, n);
+    tcg_gen_andc_i64(m, m, k);
+    tcg_gen_or_i64(d, n, m);
+}
+
+static void gen_bsl1n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
+                          TCGv_vec m, TCGv_vec k)
+{
+    if (TCG_TARGET_HAS_bitsel_vec) {
+        tcg_gen_not_vec(vece, n, n);
+        tcg_gen_bitsel_vec(vece, d, k, n, m);
+    } else {
+        tcg_gen_andc_vec(vece, n, k, n);
+        tcg_gen_andc_vec(vece, m, m, k);
+        tcg_gen_or_vec(vece, d, n, m);
+    }
+}
+
+static void gen_bsl1n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                      uint32_t a, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_bsl1n_i64,
+        .fniv = gen_bsl1n_vec,
+        .fno = gen_helper_sve2_bsl1n,
+        .vece = MO_64,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
+}
+
+static bool trans_BSL1N(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_sve2_zzzz_fn(s, a, gen_bsl1n);
+}
+
+static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
+{
+    /*
+     * Z[dn] = (n & k) | (~m & ~k)
+     *       =         | ~(m | k)
+     */
+    tcg_gen_and_i64(n, n, k);
+    if (TCG_TARGET_HAS_orc_i64) {
+        tcg_gen_or_i64(m, m, k);
+        tcg_gen_orc_i64(d, n, m);
+    } else {
+        tcg_gen_nor_i64(m, m, k);
+        tcg_gen_or_i64(d, n, m);
+    }
+}
+
+static void gen_bsl2n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
+                          TCGv_vec m, TCGv_vec k)
+{
+    if (TCG_TARGET_HAS_bitsel_vec) {
+        tcg_gen_not_vec(vece, m, m);
+        tcg_gen_bitsel_vec(vece, d, k, n, m);
+    } else {
+        tcg_gen_and_vec(vece, n, n, k);
+        tcg_gen_or_vec(vece, m, m, k);
+        tcg_gen_orc_vec(vece, d, n, m);
+    }
+}
+
+static void gen_bsl2n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                      uint32_t a, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_bsl2n_i64,
+        .fniv = gen_bsl2n_vec,
+        .fno = gen_helper_sve2_bsl2n,
+        .vece = MO_64,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
+}
+
+static bool trans_BSL2N(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_sve2_zzzz_fn(s, a, gen_bsl2n);
+}
+
+static void gen_nbsl_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
+{
+    tcg_gen_and_i64(n, n, k);
+    tcg_gen_andc_i64(m, m, k);
+    tcg_gen_nor_i64(d, n, m);
+}
+
+static void gen_nbsl_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
+                          TCGv_vec m, TCGv_vec k)
+{
+    tcg_gen_bitsel_vec(vece, d, k, n, m);
+    tcg_gen_not_vec(vece, d, d);
+}
+
+static void gen_nbsl(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                     uint32_t a, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_nbsl_i64,
+        .fniv = gen_nbsl_vec,
+        .fno = gen_helper_sve2_nbsl,
+        .vece = MO_64,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
+}
+
+static bool trans_NBSL(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_sve2_zzzz_fn(s, a, gen_nbsl);
+}
+
 /*
  *** SVE Integer Arithmetic - Unpredicated Group
  */
-- 
2.25.1


