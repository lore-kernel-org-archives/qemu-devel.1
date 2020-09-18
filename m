Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299D3C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD8821D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYS1pFZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD8821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLwx-00037j-G7
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHq-0000oT-Gd
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:37881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHj-0007Cg-D5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id w7so3995290pfi.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F9WZxYtN1t58DJuwcxgcE7EyJ0JsU31eFbA5w0cg3Y0=;
 b=VYS1pFZDx12BJTVstF/LJ4p8Mleko9uRxS3mzWWmag0XVEXWtHOMLepVt3148bNZsP
 m/OtHBQzgd5cl9i6p1e01yFLOUfPRbkEhLEpQ1RjrXn5dzobvvmOevf2hEz/1wVfmj4E
 SrfbgxgoXZNO/S5OphKUsB9Vyh1Svh4dmMy2JoH+IdWAykKII7UsOVN0VP5zEyknFqJq
 CHdfrHy709E5A00vIfCdNzl3aWVrWBX89ycch8Xcs/ltOecuYbsZOUg2giaIHbsQ7H4n
 0jdBWaBWfgH1YH0g9sbQt/G6oqffJ3R/fVlWygvV1sBOky9QBZbk4+WsLZ5w58MMF0x4
 wD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F9WZxYtN1t58DJuwcxgcE7EyJ0JsU31eFbA5w0cg3Y0=;
 b=AwMW7uiZkor/IQe9Q7wjHAKq+gajDFAL5mH3RPMBnr3qX7zquPpKAXFNcqH0hoshnK
 e1e4QlRgjuP08O2oePjjk3jVOFYM8UugE4jV6D6kHZcxcHQ5Aq7FyW7QUSJNXs7Wk/Ks
 UF1HQi6U5Qh9jYsLX5buDP30i3HIIPd0zfCqXgHwHU1uBXwILN1dB2WjJG2xga1bOTey
 ch2dnCzXngzltw9K+x1gvux9I4r2PtcwLRl8yw+vl7he6VGeiXtIwxYUGUu4HXHV4IaA
 GGVWgoIrkebsLj58Mqfhp72h6fC4MF37oEk/iLm88oCPM0uYdd0DsYD2N47cPeYkGcKq
 SDJw==
X-Gm-Message-State: AOAM5336KZjuTOetOncaL2hJ7QjeIKwNTZB/EHHx/iDSk5XAtTqeT4qa
 X0xB88qOrLMA9AgJii3r8ZGMqn12xCeYVA==
X-Google-Smtp-Source: ABdhPJyGMQ0spxS3OXzCQR3X4lF/WMlJgFZfvjfJOdCPXxEVCa2KXUqhN9Q6jsEWzYFGxGfGL9alXg==
X-Received: by 2002:a62:406:0:b029:142:2501:3978 with SMTP id
 6-20020a6204060000b029014225013978mr16388530pfe.61.1600454337103; 
 Fri, 18 Sep 2020 11:38:57 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 49/81] target/arm: Implement SVE2 FMMLA
Date: Fri, 18 Sep 2020 11:37:19 -0700
Message-Id: <20200918183751.2787647-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200422165503.13511-1-steplong@quicinc.com>
[rth: Fix indexing in helpers, expand macro to straight functions.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 10 ++++++
 target/arm/helper-sve.h    |  3 ++
 target/arm/sve.decode      |  4 +++
 target/arm/sve_helper.c    | 74 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 34 ++++++++++++++++++
 5 files changed, 125 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5ed2f2c65b..aaefbf0167 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3917,6 +3917,16 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_f32mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F32MM) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_f64mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index d472fc009d..2c6d3431ec 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2662,3 +2662,6 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 1b5bd2d193..11e724d3a2 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1389,6 +1389,10 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
+### SVE2 floating point matrix multiply accumulate
+
+FMMLA           01100100 .. 1 ..... 111001 ..... .....  @rda_rn_rm
+
 ### SVE2 Memory Gather Load Group
 
 # SVE2 64-bit gather non-temporal load
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index e0bd0fbe78..aaf336118b 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7258,3 +7258,77 @@ void HELPER(sve2_xar_s)(void *vd, void *vn, void *vm, uint32_t desc)
         d[i] = ror32(n[i] ^ m[i], shr);
     }
 }
+
+void HELPER(fmmla_s)(void *vd, void *vn, void *vm, void *va,
+                     void *status, uint32_t desc)
+{
+    intptr_t s, opr_sz = simd_oprsz(desc) / (sizeof(float32) * 4);
+
+    for (s = 0; s < opr_sz; ++s) {
+        float32 *n = vn + s * sizeof(float32) * 4;
+        float32 *m = vm + s * sizeof(float32) * 4;
+        float32 *a = va + s * sizeof(float32) * 4;
+        float32 *d = vd + s * sizeof(float32) * 4;
+        float32 n00 = n[H4(0)], n01 = n[H4(1)];
+        float32 n10 = n[H4(2)], n11 = n[H4(3)];
+        float32 m00 = m[H4(0)], m01 = m[H4(1)];
+        float32 m10 = m[H4(2)], m11 = m[H4(3)];
+        float32 p0, p1;
+
+        /* i = 0, j = 0 */
+        p0 = float32_mul(n00, m00, status);
+        p1 = float32_mul(n01, m01, status);
+        d[H4(0)] = float32_add(a[H4(0)], float32_add(p0, p1, status), status);
+
+        /* i = 0, j = 1 */
+        p0 = float32_mul(n00, m10, status);
+        p1 = float32_mul(n01, m11, status);
+        d[H4(1)] = float32_add(a[H4(1)], float32_add(p0, p1, status), status);
+
+        /* i = 1, j = 0 */
+        p0 = float32_mul(n10, m00, status);
+        p1 = float32_mul(n11, m01, status);
+        d[H4(2)] = float32_add(a[H4(2)], float32_add(p0, p1, status), status);
+
+        /* i = 1, j = 1 */
+        p0 = float32_mul(n10, m10, status);
+        p1 = float32_mul(n11, m11, status);
+        d[H4(3)] = float32_add(a[H4(3)], float32_add(p0, p1, status), status);
+    }
+}
+
+void HELPER(fmmla_d)(void *vd, void *vn, void *vm, void *va,
+                     void *status, uint32_t desc)
+{
+    intptr_t s, opr_sz = simd_oprsz(desc) / (sizeof(float64) * 4);
+
+    for (s = 0; s < opr_sz; ++s) {
+        float64 *n = vn + s * sizeof(float64) * 4;
+        float64 *m = vm + s * sizeof(float64) * 4;
+        float64 *a = va + s * sizeof(float64) * 4;
+        float64 *d = vd + s * sizeof(float64) * 4;
+        float64 n00 = n[0], n01 = n[1], n10 = n[2], n11 = n[3];
+        float64 m00 = m[0], m01 = m[1], m10 = m[2], m11 = m[3];
+        float64 p0, p1;
+
+        /* i = 0, j = 0 */
+        p0 = float64_mul(n00, m00, status);
+        p1 = float64_mul(n01, m01, status);
+        d[0] = float64_add(a[0], float64_add(p0, p1, status), status);
+
+        /* i = 0, j = 1 */
+        p0 = float64_mul(n00, m10, status);
+        p1 = float64_mul(n01, m11, status);
+        d[1] = float64_add(a[1], float64_add(p0, p1, status), status);
+
+        /* i = 1, j = 0 */
+        p0 = float64_mul(n10, m00, status);
+        p1 = float64_mul(n11, m01, status);
+        d[2] = float64_add(a[2], float64_add(p0, p1, status), status);
+
+        /* i = 1, j = 1 */
+        p0 = float64_mul(n10, m10, status);
+        p1 = float64_mul(n11, m11, status);
+        d[3] = float64_add(a[3], float64_add(p0, p1, status), status);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0cb10ac3e2..63acb25921 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7677,6 +7677,40 @@ DO_SVE2_ZPZZ_FP(FMINP, fminp)
  * SVE Integer Multiply-Add (unpredicated)
  */
 
+static bool trans_FMMLA(DisasContext *s, arg_rrrr_esz *a)
+{
+    gen_helper_gvec_4_ptr *fn;
+
+    switch (a->esz) {
+    case MO_32:
+        if (!dc_isar_feature(aa64_sve2_f32mm, s)) {
+            return false;
+        }
+        fn = gen_helper_fmmla_s;
+        break;
+    case MO_64:
+        if (!dc_isar_feature(aa64_sve2_f64mm, s)) {
+            return false;
+        }
+        fn = gen_helper_fmmla_d;
+        break;
+    default:
+        return false;
+    }
+
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vec_full_reg_offset(s, a->ra),
+                           status, vsz, vsz, 0, fn);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
 static bool do_sqdmlal_zzzw(DisasContext *s, arg_rrrr_esz *a,
                             bool sel1, bool sel2)
 {
-- 
2.25.1


