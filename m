Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57209C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220E320787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+BjAqYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220E320787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDwR-0005Zo-7W
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeR-0002Dt-Om
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdv-0001Ic-Jc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdt-0001HL-Cj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id x4so2975473wmj.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BWZyfHEYrqWjJaA4NPsK0shM3MAJw9UJN6Xe8BGyE/Y=;
 b=D+BjAqYF5IwLRV6IRNQhbbMc1FMQd90t3ycT/jPbsYj2f2vkX4r+pieKZR0fW/Y6J+
 siLwz/1sz9aU0uhYeYrQ/Bxv25M3U8+U3CGr4PvXYLiqiCwu5Uyn+UUUver8ma2c7493
 dAqPldu5OBp2fUkKa8agXVNF2m/7m4F+m2nu1HWu3rJwdFWoqJwI5JLDJjyepPMkPYCS
 DdqJz7YsXugdIud0T4XoV590fBf3+DnTDJ9OS6EtrjTKMvhE47grtnYVOYMEsHdupBWC
 /G/F1+a8e+DMfytZ9WA1ykqz+zZwxL6xFBchS01svDT22w+BtlF+I79VPozXquH0o7yL
 54jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BWZyfHEYrqWjJaA4NPsK0shM3MAJw9UJN6Xe8BGyE/Y=;
 b=ILttlHmmPqU0gHCsp3Xea+RBQhMVLC/3DmSsRXbP+5+Udv0xQP6UBnUSq56hwJNAAV
 ZXOVnYns+LhYYunc8qY8ETnmBpp9eITrUHXGdVRe4KJZJm+KhNAC4kn0DkRiZnK0WJIw
 lhH+hLOFMkQswbZ8tpFSYmh4MIEvxdQ3KwHkV2hBAy6f4iJvufkPii5B1Nc4QQdCgeBJ
 7GzVao8MVhAERweOHokq+Z+ruoQkBRMwEAXELdagTPLewJE1jGQ2s5eDVsYRieYgm3KW
 Y7NXhAvxDmcH7GIqd9UIt+5tCDaoLRADqSERY4LY+91JehYTHVjisO7qVCWwFNYZ574D
 lLIw==
X-Gm-Message-State: AGi0PuZFzh+8ZOiyBTylRdAMXGhbs5XkxCiwnlcky5lykHhj2QBpq6tU
 W/ZEL8AqH9eMwMXDPszLr8u4MA==
X-Google-Smtp-Source: APiQypK6Opk7HzqavlSafFLktp33uJi6eEeVkC/XccMKtH62EykZ5d0U8dSgM24919UItCKi5ah7oQ==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr4424901wme.77.1588270235893; 
 Thu, 30 Apr 2020 11:10:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 23/36] target/arm: Convert Neon 64-bit element 3-reg-same insns
Date: Thu, 30 Apr 2020 19:09:50 +0100
Message-Id: <20200430181003.21682-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the 64-bit element insns in the 3-reg-same group
to decodetree. This covers VQSHL, VRSHL and VQRSHL where
size==0b11.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 62 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 38 ++------------------
 target/arm/neon-dp.decode       | 11 ++++++
 3 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 161313ad879..bc5afb368e3 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -908,3 +908,65 @@ static bool trans_SHA256SU1_3s(DisasContext *s, arg_SHA256SU1_3s *a)
 
     return true;
 }
+
+static bool do_3same_64(DisasContext *s, arg_3same *a, NeonGenTwo64OpFn *fn)
+{
+    /* Handle 3-reg-same operations to be performed 64 bits at a time */
+    TCGv_i64 rn, rm, rd;
+    int pass;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    rn = tcg_temp_new_i64();
+    rm = tcg_temp_new_i64();
+    rd = tcg_temp_new_i64();
+
+    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
+        neon_load_reg64(rn, a->vn + pass);
+        neon_load_reg64(rm, a->vm + pass);
+        fn(rd, rm, rn);
+        neon_store_reg64(rd, a->vd + pass);
+    }
+
+    tcg_temp_free_i64(rn);
+    tcg_temp_free_i64(rm);
+    tcg_temp_free_i64(rd);
+
+    return true;
+}
+
+#define DO_3SAME_64(INSN, FUNC)                                         \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        return do_3same_64(s, a, FUNC);                                 \
+    }
+
+#define DO_3SAME_64_ENV(INSN, FUNC)                                     \
+    static void gen_##INSN##_3s(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)     \
+    {                                                                   \
+        FUNC(d, cpu_env, n, m);                                         \
+    }                                                                   \
+    DO_3SAME_64(INSN, gen_##INSN##_3s)
+
+DO_3SAME_64(VRSHL_S64, gen_helper_neon_rshl_s64)
+DO_3SAME_64(VRSHL_U64, gen_helper_neon_rshl_u64)
+DO_3SAME_64_ENV(VQSHL_S64, gen_helper_neon_qshl_s64)
+DO_3SAME_64_ENV(VQSHL_U64, gen_helper_neon_qshl_u64)
+DO_3SAME_64_ENV(VQRSHL_S64, gen_helper_neon_qrshl_s64)
+DO_3SAME_64_ENV(VQRSHL_U64, gen_helper_neon_qrshl_u64)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 160638e2a7c..fb64eb3a800 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4791,42 +4791,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
 
         if (size == 3) {
-            /* 64-bit element instructions. */
-            for (pass = 0; pass < (q ? 2 : 1); pass++) {
-                neon_load_reg64(cpu_V0, rn + pass);
-                neon_load_reg64(cpu_V1, rm + pass);
-                switch (op) {
-                case NEON_3R_VQSHL:
-                    if (u) {
-                        gen_helper_neon_qshl_u64(cpu_V0, cpu_env,
-                                                 cpu_V1, cpu_V0);
-                    } else {
-                        gen_helper_neon_qshl_s64(cpu_V0, cpu_env,
-                                                 cpu_V1, cpu_V0);
-                    }
-                    break;
-                case NEON_3R_VRSHL:
-                    if (u) {
-                        gen_helper_neon_rshl_u64(cpu_V0, cpu_V1, cpu_V0);
-                    } else {
-                        gen_helper_neon_rshl_s64(cpu_V0, cpu_V1, cpu_V0);
-                    }
-                    break;
-                case NEON_3R_VQRSHL:
-                    if (u) {
-                        gen_helper_neon_qrshl_u64(cpu_V0, cpu_env,
-                                                  cpu_V1, cpu_V0);
-                    } else {
-                        gen_helper_neon_qrshl_s64(cpu_V0, cpu_env,
-                                                  cpu_V1, cpu_V0);
-                    }
-                    break;
-                default:
-                    abort();
-                }
-                neon_store_reg64(cpu_V0, rd + pass);
-            }
-            return 0;
+            /* 64-bit element instructions: handled by decodetree */
+            return 1;
         }
         pairwise = 0;
         switch (op) {
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index f22606b2bd5..a4932e550ed 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -68,6 +68,17 @@ VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
 VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same
 VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same
 
+# Insns operating on 64-bit elements (size!=0b11 handled elsewhere)
+@3same_64        .... ... . . . 11 .... .... .... . q:1 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=3
+
+VQSHL_S64_3s     1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_64
+VQSHL_U64_3s     1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_64
+VRSHL_S64_3s     1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_64
+VRSHL_U64_3s     1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_64
+VQRSHL_S64_3s    1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_64
+VQRSHL_U64_3s    1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_64
+
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
 VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
-- 
2.20.1


