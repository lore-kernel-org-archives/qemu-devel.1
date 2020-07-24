Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B122C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D995520888
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkqmLXls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D995520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jylal-0001hJ-4X
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 20:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZP-00009y-5E
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:15 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:54950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZM-0008EL-0U
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:14 -0400
Received: by mail-pj1-x102c.google.com with SMTP id mn17so4186522pjb.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 17:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sujhg6CWtGD0cTKixZpHYTp8eVUCvTssOp7pcX2qTrI=;
 b=YkqmLXlsxvplRqaok+VAYFaN+60GrEEVw+VRXsOcWmtUC8TNIS1aBSMveiA7vU0uUY
 DjQzlaRYDFazEHFj5e8Qzm2kv6UqoZrCzZGFVxeOEWGNQsB9icnHYmSZ9NfvB1ba0q7N
 DtCIHVwcZIa65Kg5SLVwGlGheLrFLeaHodesZXG5ppKt2cGtSoNHhht3S2xlwH5gX49j
 HYkdia3Pr0Gqm5gSRQXVkLaSUvwH6VeZl7n1Bodh5CLnJr6c2iRUQodN+3NKrrUVsarY
 PTRNuHO1blHv/ATEx+8G9QxpjA0taenmEj7znN5VVfIztIegu8VnARH2cvUCtSLx8kGZ
 GViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sujhg6CWtGD0cTKixZpHYTp8eVUCvTssOp7pcX2qTrI=;
 b=UT+XsbqMs/9Nz6EG8lE/QLABnWdo0t0zjt9MfqKx76fTjm8yFtwoD3IjGsRZW5Zvak
 +ZmStAgARqj2zyspuoSGjoXgCTyLUfvhUyzIgWu5+bvpDa178I8WWcCwW5eQHQSfYJPr
 ihjObeH77u7k/7T5CtK3wIeDmKNddEjxeb6V9FzvRni1rdsU0jko9fsGK2jHsA36u2kq
 Pe6jGoiTh2iKfXVeq5EzSQ4PaJ7vPO7n/ScJROLEtPAZ6txC8tJqL97ZAjS1NUxYPcOd
 a7PY46xlYE6MGPHN/MV1otrYMJ/5QVPQSial+40vICVHq0jR9cqJOuRS1elj/bhwFcqi
 jLVQ==
X-Gm-Message-State: AOAM531q2o8MeMg9scQx0fKYYPvb4wgcNbZ+iaFGKKqdiwU2Tt0KRV7w
 U3T1gLNPvvj4+uNeCBBkzUkGHrxP9zI=
X-Google-Smtp-Source: ABdhPJzWg/t15KWfWrUgHe8cEmsVqTbxk7u7i5cF5iplcBKskoAMx72FZyU+LPXoW9WOb5jyoJDmNw==
X-Received: by 2002:a17:90a:71c4:: with SMTP id
 m4mr2934335pjs.178.1595550490256; 
 Thu, 23 Jul 2020 17:28:10 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id q20sm4224635pfn.111.2020.07.23.17.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 17:28:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] target/riscv: Generate nanboxed results from fp helpers
Date: Thu, 23 Jul 2020 17:28:01 -0700
Message-Id: <20200724002807.441147-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724002807.441147-1-richard.henderson@linaro.org>
References: <20200724002807.441147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org,
 zhiwei_liu@c-sky.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make sure that all results from single-precision scalar helpers
are properly nan-boxed to 64-bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/internals.h  |  5 +++++
 target/riscv/fpu_helper.c | 42 +++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 37d33820ad..9f4ba7d617 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -38,4 +38,9 @@ target_ulong fclass_d(uint64_t frs1);
 #define SEW32 2
 #define SEW64 3
 
+static inline uint64_t nanbox_s(float32 f)
+{
+    return f | MAKE_64BIT_MASK(32, 32);
+}
+
 #endif
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 4379756dc4..72541958a7 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -81,10 +81,16 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
     set_float_rounding_mode(softrm, &env->fp_status);
 }
 
+static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                           uint64_t frs3, int flags)
+{
+    return nanbox_s(float32_muladd(frs1, frs2, frs3, flags, &env->fp_status));
+}
+
 uint64_t helper_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
-    return float32_muladd(frs1, frs2, frs3, 0, &env->fp_status);
+    return do_fmadd_s(env, frs1, frs2, frs3, 0);
 }
 
 uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
@@ -96,8 +102,7 @@ uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
 uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
-    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_c,
-                          &env->fp_status);
+    return do_fmadd_s(env, frs1, frs2, frs3, float_muladd_negate_c);
 }
 
 uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
@@ -110,8 +115,7 @@ uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
 uint64_t helper_fnmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
-    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_product,
-                          &env->fp_status);
+    return do_fmadd_s(env, frs1, frs2, frs3, float_muladd_negate_product);
 }
 
 uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
@@ -124,8 +128,8 @@ uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
 uint64_t helper_fnmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
-    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_c |
-                          float_muladd_negate_product, &env->fp_status);
+    return do_fmadd_s(env, frs1, frs2, frs3,
+                      float_muladd_negate_c | float_muladd_negate_product);
 }
 
 uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
@@ -137,37 +141,37 @@ uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
 
 uint64_t helper_fadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_add(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_add(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_sub(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_sub(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fmul_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_mul(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_mul(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_div(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_div(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fmin_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_minnum(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_minnum(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fmax_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float32_maxnum(frs1, frs2, &env->fp_status);
+    return nanbox_s(float32_maxnum(frs1, frs2, &env->fp_status));
 }
 
 uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t frs1)
 {
-    return float32_sqrt(frs1, &env->fp_status);
+    return nanbox_s(float32_sqrt(frs1, &env->fp_status));
 }
 
 target_ulong helper_fle_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
@@ -209,23 +213,23 @@ uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t frs1)
 
 uint64_t helper_fcvt_s_w(CPURISCVState *env, target_ulong rs1)
 {
-    return int32_to_float32((int32_t)rs1, &env->fp_status);
+    return nanbox_s(int32_to_float32((int32_t)rs1, &env->fp_status));
 }
 
 uint64_t helper_fcvt_s_wu(CPURISCVState *env, target_ulong rs1)
 {
-    return uint32_to_float32((uint32_t)rs1, &env->fp_status);
+    return nanbox_s(uint32_to_float32((uint32_t)rs1, &env->fp_status));
 }
 
 #if defined(TARGET_RISCV64)
 uint64_t helper_fcvt_s_l(CPURISCVState *env, uint64_t rs1)
 {
-    return int64_to_float32(rs1, &env->fp_status);
+    return nanbox_s(int64_to_float32(rs1, &env->fp_status));
 }
 
 uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
 {
-    return uint64_to_float32(rs1, &env->fp_status);
+    return nanbox_s(uint64_to_float32(rs1, &env->fp_status));
 }
 #endif
 
@@ -266,7 +270,7 @@ uint64_t helper_fmax_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 
 uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
 {
-    return float64_to_float32(rs1, &env->fp_status);
+    return nanbox_s(float64_to_float32(rs1, &env->fp_status));
 }
 
 uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
-- 
2.25.1


