Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9910C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237A9206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8HBu8bM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237A9206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLTx-000403-2A
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLH2-00089A-2W
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:20 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLH0-00075h-9z
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:19 -0400
Received: by mail-pj1-x1042.google.com with SMTP id jw11so3470986pjb.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=80TlpzmA1GZsK3dg+P8GxR+XGATZYs7NilsFyZcBo9o=;
 b=W8HBu8bMXGrg4RI5V6G7Y93OuUjG8KAOuEeoBKKyPQFvQ/aFh9hxz06KCkSqkovW6q
 NkBLEXs1XdaJe4V0fiNGse+t2yycJxhGlIWej4sqQZb6lR2bcc5QvQnarhJrti+eQRfE
 G5av3unxfe+r2b0L/HYLBkLi1FpKUaYnlKtUg1PAEHL2eMdJFf5z0o6kewBcw7H9KL6o
 /16BcUQe58ziT0TC33ZM9sEeXNvzEBlowBYwRAsRThN9YHoROSdlE+ZVNqu6uHxIFUgS
 zvQbR6KuzBQLT07G9VvYmFDVdLgXcvelAQYRMfewX7knvm6zrG1Ep1/a6+SReouhRkDF
 5hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=80TlpzmA1GZsK3dg+P8GxR+XGATZYs7NilsFyZcBo9o=;
 b=UGDXDAVa7o5YEHysFSuJ17uh+ojdDJwkd/vISnqv/lySmz/pYhp7jGzW03ekYc69OB
 LWV0/iNqkolTkmK+zUKLxwSyB/gE+aHUhWMRxPfnAJK0INEb3EYAebJLVfnEY7V3onDR
 2w7N+OBf1rh5ArpsJ7slE+QVyiCtcl0ME2wrN53pv5jpgYdYL+xF0zTphq4D3WmYFCua
 ysrHaNFzuR8vs6Dfo7RV+wXRp0KB+ttFNGt1XvrjElhS8fAMGItAB4XyjuaKL7YEojss
 oq3XYbqYXgOW0TiQ1JWTDjmVCSpyFGhwbhAPb+JfgrQz5xSzvoqViHsDBLLpxv2Byj18
 +itQ==
X-Gm-Message-State: AOAM5325zphPujgnAUo9vX0VEibQt/f2Cne+LLZjR2NoVouP0RbrPhjZ
 TN123JEe9605/Pkt6SMpWzKJIvFXkaio6Q==
X-Google-Smtp-Source: ABdhPJz1r9jAebZVTwspiOtAS1w6dC683rFtB3YROWi3plZdJaOb86iSNjsDh4XFTLlHd217S4rgFA==
X-Received: by 2002:a17:902:d909:b029:d0:cbe1:e716 with SMTP id
 c9-20020a170902d909b02900d0cbe1e716mr34245061plz.36.1600454296544; 
 Fri, 18 Sep 2020 11:38:16 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/81] target/arm: Implement PMULLB and PMULLT
Date: Fri, 18 Sep 2020 11:36:47 -0700
Message-Id: <20200918183751.2787647-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 10 ++++++++++
 target/arm/helper-sve.h    |  1 +
 target/arm/sve.decode      |  2 ++
 target/arm/translate-sve.c | 22 ++++++++++++++++++++++
 target/arm/vec_helper.c    | 24 ++++++++++++++++++++++++
 5 files changed, 59 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6f80a85fd0..59415184db 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3902,6 +3902,16 @@ static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) >= 2;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index fff7316292..fd1ebe180f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2363,3 +2363,4 @@ DEF_HELPER_FLAGS_4(sve2_umull_zzz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_umull_zzz_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sve2_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_pmull_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index f39ca29320..417b11fdd5 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1201,6 +1201,8 @@ USUBWT          01000101 .. 0 ..... 010 111 ..... .....  @rd_rn_rm
 
 SQDMULLB_zzz    01000101 .. 0 ..... 011 000 ..... .....  @rd_rn_rm
 SQDMULLT_zzz    01000101 .. 0 ..... 011 001 ..... .....  @rd_rn_rm
+PMULLB          01000101 .. 0 ..... 011 010 ..... .....  @rd_rn_rm
+PMULLT          01000101 .. 0 ..... 011 011 ..... .....  @rd_rn_rm
 SMULLB_zzz      01000101 .. 0 ..... 011 100 ..... .....  @rd_rn_rm
 SMULLT_zzz      01000101 .. 0 ..... 011 101 ..... .....  @rd_rn_rm
 UMULLB_zzz      01000101 .. 0 ..... 011 110 ..... .....  @rd_rn_rm
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 71ea0cd0c9..748730e1a8 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6040,6 +6040,28 @@ DO_SVE2_ZZZ_TB(SMULLT_zzz, smull_zzz, true, true)
 DO_SVE2_ZZZ_TB(UMULLB_zzz, umull_zzz, false, false)
 DO_SVE2_ZZZ_TB(UMULLT_zzz, umull_zzz, true, true)
 
+static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_gvec_pmull_q, gen_helper_sve2_pmull_h,
+        NULL,                    gen_helper_sve2_pmull_d,
+    };
+    if (a->esz == 0 && !dc_isar_feature(aa64_sve2_pmull128, s)) {
+        return false;
+    }
+    return do_sve2_zzw_ool(s, a, fns[a->esz], sel);
+}
+
+static bool trans_PMULLB(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_trans_pmull(s, a, false);
+}
+
+static bool trans_PMULLT(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_trans_pmull(s, a, true);
+}
+
 #define DO_SVE2_ZZZ_WTB(NAME, name, SEL2) \
 static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)       \
 {                                                               \
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 84e1ae3933..dcaf3926e1 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1750,6 +1750,30 @@ void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
         d[i] = pmull_h(nn, mm);
     }
 }
+
+static uint64_t pmull_d(uint64_t op1, uint64_t op2)
+{
+    uint64_t result = 0;
+    int i;
+
+    for (i = 0; i < 32; ++i) {
+        uint64_t mask = -((op1 >> i) & 1);
+        result ^= (op2 << i) & mask;
+    }
+    return result;
+}
+
+void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t sel = H4(simd_data(desc));
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *n = vn, *m = vm;
+    uint64_t *d = vd;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = pmull_d(n[2 * i + sel], m[2 * i + sel]);
+    }
+}
 #endif
 
 #define DO_CMP0(NAME, TYPE, OP)                         \
-- 
2.25.1


