Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD2C2D0ED
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5785C20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzrtufDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5785C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbo4-0003tK-EN
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbch-00031H-2t
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbce-0001si-C2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:14 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbce-0001rZ-2I
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:12 -0400
Received: by mail-pg1-x542.google.com with SMTP id j29so3657723pgl.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I6ankYmNHyYeNrJfSSg8aj/RPi8jQqHs2aTejgbW4Ig=;
 b=ZzrtufDME0y+UJkq2FPDh6+9jlGlN/tr0Pd6WEgBMrlaseWdFI3acjL9qpda9yEysN
 q2AxjuPLIXfu5O0i/5bxmcNiLhc85OHlh0ezSju9DtpuWvwW4tDP4M4iQQ6GezZPydnX
 v6mn/e/NadYwKNe5LmAXsJ1oxEsChdNBtIxeew/R1SYKDmJNhd7YEjYaVPQGYyRBlJ24
 D8AeAxrrojx6uQwCds18/Whd1bqAQoXbpYpl2K+UkcaJea+yfClQIwH6ons/36JENfvy
 7VRA0Dd8wrh6uYGcS5ypIAJQP4uljGKZAzdyVBLimu9GDM+GBSSj+PawlvSUTj2wN6xM
 doMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I6ankYmNHyYeNrJfSSg8aj/RPi8jQqHs2aTejgbW4Ig=;
 b=DcnGLkq/AwSCAVr2LDZ4OxHYQdaSj6QC8Z9w8qGjbljAr7gER259yCo/l1RJRtm4y/
 BSsSXRtKOoIOG4UP5tD8rcdGJ/tK0mLCKGAdjPEptw2IWJuMylKce4HAd853AokcvCsF
 bR/6dpW+6/cgOmSyCfcy3GMLtv7eo7MLU59yfF3bDb95cNseAHb0in/uBUKVQqP5Aup3
 Hn+s1WJWit5OQx+oGxLApP9fCDwh547/fvobLcjxuzqF9RJf4KoX5SDrchpsTFiRLVfE
 NWuDoJJUvwekNB6d4GskrLpuTi6sTHfmx5PZH3ZoyLO7x70N3rTcRn/AbXW1hHydvBuz
 anBw==
X-Gm-Message-State: ANhLgQ1kwdrSdiHhcQDP3gttFCN/FcK+lR4yxt9y6HKkG63X7YK44evZ
 kFuqn1xaeHQnYyfFi9v31PoUJM19X80=
X-Google-Smtp-Source: ADFU+vtOVygUkutX1dEAtenD5j2XE9k7y+XDdDJ43QAyJXNsMD6IOq0HGY1RtMyT+P/X9WsO/9m1Rg==
X-Received: by 2002:a63:e607:: with SMTP id g7mr10814971pgh.303.1585264150252; 
 Thu, 26 Mar 2020 16:09:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/31] target/arm: Create arm_gen_gvec_{u,s}{rshr,rsra}
Date: Thu, 26 Mar 2020 16:08:31 -0700
Message-Id: <20200326230838.31112-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create vectorized versions of handle_shri_with_rndacc
for shift+round and shift+round+accumulate.  Add out-of-line
helpers in preparation for longer vector lengths from SVE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  20 ++
 target/arm/translate-a64.h |   9 +
 target/arm/translate-a64.c | 458 ++++++++++++++++++++++++++++++++++++-
 target/arm/vec_helper.c    |  50 ++++
 4 files changed, 534 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index dc6a43dbd8..1ffd840f1d 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -718,6 +718,26 @@ DEF_HELPER_FLAGS_3(gvec_usra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_usra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_usra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_srshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_urshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_urshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_urshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_urshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_srsra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srsra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srsra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srsra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_ursra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 65c0280498..7846e91e51 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -129,4 +129,13 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
 typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 
+void arm_gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                        int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void arm_gen_gvec_urshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                        int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void arm_gen_gvec_srsra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                        int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void arm_gen_gvec_ursra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                        int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d50207fcfb..37ee85f867 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -8561,6 +8561,453 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
     }
 }
 
+static void gen_srshr8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    TCGv_i64 ones = tcg_const_i64(dup_const(MO_8, 1));
+
+    /* Shift one less than the requested amount. */
+    if (shift > 1) {
+        tcg_gen_vec_sar8i_i64(a, a, shift - 1);
+    }
+
+    /* The low bit is the rounding bit.  Mask it off.  */
+    tcg_gen_and_i64(t, a, ones);
+
+    /* Finish the shift. */
+    tcg_gen_vec_sar8i_i64(d, a, 1);
+
+    /* Round. */
+    tcg_gen_vec_add8_i64(d, d, t);
+
+    tcg_temp_free_i64(t);
+    tcg_temp_free_i64(ones);
+}
+
+static void gen_srshr16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    TCGv_i64 ones = tcg_const_i64(dup_const(MO_16, 1));
+
+    if (shift > 1) {
+        tcg_gen_vec_sar16i_i64(a, a, shift - 1);
+    }
+    tcg_gen_and_i64(t, a, ones);
+    tcg_gen_vec_sar16i_i64(d, a, 1);
+    tcg_gen_vec_add16_i64(d, d, t);
+
+    tcg_temp_free_i64(t);
+    tcg_temp_free_i64(ones);
+}
+
+static void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_sari_i32(a, a, shift - 1);
+    tcg_gen_andi_i32(t, a, 1);
+    tcg_gen_sari_i32(d, a, 1);
+    tcg_gen_add_i32(d, d, t);
+
+    tcg_temp_free_i32(t);
+}
+
+static void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sari_i64(a, a, shift - 1);
+    tcg_gen_andi_i64(t, a, 1);
+    tcg_gen_sari_i64(d, a, 1);
+    tcg_gen_add_i64(d, d, t);
+
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t shift)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_sari_vec(vece, a, a, shift - 1);
+    tcg_gen_dupi_vec(vece, ones, 1);
+    tcg_gen_and_vec(vece, t, a, ones);
+    tcg_gen_sari_vec(vece, d, a, 1);
+    tcg_gen_add_vec(vece, d, d, t);
+
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(ones);
+}
+
+void arm_gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                        int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_srshr8_i64,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_srshr16_i64,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_srshr32_i32,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_srshr64_i64,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    if (shift == (8 << vece)) {
+        /*
+         * Shifts larger than the element size are architecturally valid.
+         * Signed results in all sign bits.  With rounding, this produces
+         *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
+         * I.e. always zero.
+         */
+        tcg_gen_gvec_dup8i(rd_ofs, opr_sz, max_sz, 0);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
+
+static void gen_srsra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    gen_srshr8_i64(t, a, shift);
+    tcg_gen_vec_add8_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srsra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    gen_srshr16_i64(t, a, shift);
+    tcg_gen_vec_add16_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srsra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+    gen_srshr32_i32(t, a, shift);
+    tcg_gen_add_i32(d, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_srsra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    gen_srshr64_i64(t, a, shift);
+    tcg_gen_add_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srsra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t shift)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    gen_srshr_vec(vece, t, a, shift);
+    tcg_gen_add_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void arm_gen_gvec_srsra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                        int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_srsra8_i64,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fni8 = gen_srsra16_i64,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_srsra32_i32,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_srsra64_i64,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /*
+     * Shifts larger than the element size are architecturally valid.
+     * Signed results in all sign bits.  With rounding, this produces
+     *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
+     * I.e. always zero.  With accumulation, this leaves D unchanged.
+     */
+    if (shift != (8 << vece)) {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    } else {
+        /* Nop, but we do need to clear the tail. */
+        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
+    }
+}
+
+static void gen_urshr8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    TCGv_i64 ones = tcg_const_i64(dup_const(MO_8, 1));
+
+    /* Shift one less than the requested amount. */
+    if (shift > 1) {
+        tcg_gen_vec_shr8i_i64(a, a, shift - 1);
+    }
+
+    /* The low bit is the rounding bit.  Mask it off.  */
+    tcg_gen_and_i64(t, a, ones);
+
+    /* Finish the shift. */
+    tcg_gen_vec_shr8i_i64(d, a, 1);
+
+    /* Round. */
+    tcg_gen_vec_add8_i64(d, d, t);
+
+    tcg_temp_free_i64(t);
+    tcg_temp_free_i64(ones);
+}
+
+static void gen_urshr16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    TCGv_i64 ones = tcg_const_i64(dup_const(MO_16, 1));
+
+    if (shift > 1) {
+        tcg_gen_vec_shr16i_i64(a, a, shift - 1);
+    }
+    tcg_gen_and_i64(t, a, ones);
+    tcg_gen_vec_shr16i_i64(d, a, 1);
+    tcg_gen_vec_add16_i64(d, d, t);
+
+    tcg_temp_free_i64(t);
+    tcg_temp_free_i64(ones);
+}
+
+static void gen_urshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_shri_i32(a, a, shift - 1);
+    tcg_gen_andi_i32(t, a, 1);
+    tcg_gen_shri_i32(d, a, 1);
+    tcg_gen_add_i32(d, d, t);
+
+    tcg_temp_free_i32(t);
+}
+
+static void gen_urshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(a, a, shift - 1);
+    tcg_gen_andi_i64(t, a, 1);
+    tcg_gen_shri_i64(d, a, 1);
+    tcg_gen_add_i64(d, d, t);
+
+    tcg_temp_free_i64(t);
+}
+
+static void gen_urshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t shift)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_shri_vec(vece, a, a, shift - 1);
+    tcg_gen_dupi_vec(vece, ones, 1);
+    tcg_gen_and_vec(vece, t, a, ones);
+    tcg_gen_shri_vec(vece, d, a, 1);
+    tcg_gen_add_vec(vece, d, d, t);
+
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(ones);
+}
+
+void arm_gen_gvec_urshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                        int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_urshr8_i64,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_urshr16_i64,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_urshr32_i32,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_urshr64_i64,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    if (shift == (8 << vece)) {
+        /*
+         * Shifts larger than the element size are architecturally valid.
+         * Unsigned results in zero.  With rounding, this produces a
+         * copy of the most significant bit.
+         */
+        tcg_gen_gvec_shri(vece, rd_ofs, rm_ofs, shift - 1, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
+
+static void gen_ursra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    if (shift == 8) {
+        tcg_gen_vec_shr8i_i64(t, a, 7);
+    } else {
+        gen_urshr8_i64(t, a, shift);
+    }
+    tcg_gen_vec_add8_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_ursra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    if (shift == 16) {
+        tcg_gen_vec_shr16i_i64(t, a, 15);
+    } else {
+        gen_urshr16_i64(t, a, shift);
+    }
+    tcg_gen_vec_add16_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_ursra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    if (shift == 32) {
+        tcg_gen_shri_i32(t, a, 31);
+    } else {
+        gen_urshr32_i32(t, a, shift);
+    }
+    tcg_gen_add_i32(d, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_ursra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    if (shift == 64) {
+        tcg_gen_shri_i64(t, a, 63);
+    } else {
+        gen_urshr64_i64(t, a, shift);
+    }
+    tcg_gen_add_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_ursra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t shift)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    if (shift == (8 << vece)) {
+        tcg_gen_shri_vec(vece, t, a, (8 << vece) - 1);
+    } else {
+        gen_urshr_vec(vece, t, a, shift);
+    }
+    tcg_gen_add_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void arm_gen_gvec_ursra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                        int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_ursra8_i64,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fni8 = gen_ursra16_i64,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_ursra32_i32,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_ursra64_i64,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+}
+
 /* SSHR[RA]/USHR[RA] - Scalar shift right (optional rounding/accumulate) */
 static void handle_scalar_simd_shri(DisasContext *s,
                                     bool is_u, int immh, int immb,
@@ -10712,10 +11159,15 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         return;
 
     case 0x04: /* SRSHR / URSHR (rounding) */
-        break;
+        gen_gvec_fn2i(s, is_q, rd, rn, shift,
+                      is_u ? arm_gen_gvec_urshr : arm_gen_gvec_srshr, size);
+        return;
+
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        accumulate = true;
-        break;
+        gen_gvec_fn2i(s, is_q, rd, rn, shift,
+                      is_u ? arm_gen_gvec_ursra : arm_gen_gvec_srsra, size);
+        return;
+
     default:
         g_assert_not_reached();
     }
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index aaaccc0a2d..c6a39c188e 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -924,6 +924,56 @@ DO_SRA(gvec_usra_d, uint64_t)
 
 #undef DO_SRA
 
+#define DO_RSHR(NAME, TYPE)                             \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);               \
+    int shift = simd_data(desc);                        \
+    TYPE *d = vd, *n = vn;                              \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {        \
+        TYPE tmp = n[i] >> (shift - 1);                 \
+        d[i] = (tmp >> 1) + (tmp & 1);                  \
+    }                                                   \
+    clear_tail(d, oprsz, simd_maxsz(desc));             \
+}
+
+DO_RSHR(gvec_srshr_b, int8_t)
+DO_RSHR(gvec_srshr_h, int16_t)
+DO_RSHR(gvec_srshr_s, int32_t)
+DO_RSHR(gvec_srshr_d, int64_t)
+
+DO_RSHR(gvec_urshr_b, uint8_t)
+DO_RSHR(gvec_urshr_h, uint16_t)
+DO_RSHR(gvec_urshr_s, uint32_t)
+DO_RSHR(gvec_urshr_d, uint64_t)
+
+#undef DO_RSHR
+
+#define DO_RSRA(NAME, TYPE)                             \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);               \
+    int shift = simd_data(desc);                        \
+    TYPE *d = vd, *n = vn;                              \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {        \
+        TYPE tmp = n[i] >> (shift - 1);                 \
+        d[i] += (tmp >> 1) + (tmp & 1);                 \
+    }                                                   \
+    clear_tail(d, oprsz, simd_maxsz(desc));             \
+}
+
+DO_RSRA(gvec_srsra_b, int8_t)
+DO_RSRA(gvec_srsra_h, int16_t)
+DO_RSRA(gvec_srsra_s, int32_t)
+DO_RSRA(gvec_srsra_d, int64_t)
+
+DO_RSRA(gvec_ursra_b, uint8_t)
+DO_RSRA(gvec_ursra_h, uint16_t)
+DO_RSRA(gvec_ursra_s, uint32_t)
+DO_RSRA(gvec_ursra_d, uint64_t)
+
+#undef DO_RSRA
+
 /*
  * Convert float16 to float32, raising no exceptions and
  * preserving exceptional values, including SNaN.
-- 
2.20.1


