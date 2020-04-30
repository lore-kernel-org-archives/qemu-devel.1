Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D3C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F13720787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJ5qRTTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F13720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDwg-00066x-HV
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeN-00022l-5Y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdr-0001Gg-94
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdq-0001FY-RW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id x17so8174724wrt.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l8VA/iThXhnqkBkxtC9ELSbE+ekhmsnZea++PtUSqsg=;
 b=mJ5qRTTPyxHrfVnMEqC/e5fum/vpMCPFljzQffSpAskEEg5Gs5ZrqidfFBoOjy65bZ
 HB1W2S5aFYAz5N3bt/IEuUaM/VeiSpL9Ke98lyAc/e7Z4cpZthMQwuYEJhTad3XGUDsJ
 9ra+mbwCl/r29RdCjPFDX0BvAkX6aNaT+ayYWHir1mOcZDx6SoBwW1GjDPSvAbkZhmJi
 AfU7192QOu/JTOCSKDRz7yU+Sopj4QOQFWw+vmXeu+XejVvMq6W58AnFquXl3ViolNP2
 HDgWFg1s0t79GRBD5pm1lLJo8ZuFjVT56hCZh+WNTXt6jlCew0HF60kuJW+I/iqEiwkc
 Frvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l8VA/iThXhnqkBkxtC9ELSbE+ekhmsnZea++PtUSqsg=;
 b=QlRn6Vi+9eWDFjxDshIvfw79N3Dlj9FE641gpnU1bC1dHkBJtNzWy+xWE7YX/LrmDV
 GS8Qv1oPGpwG9wwX5XvGCihaRotnHLgvW6t7ZyR49geplO+Zze6JZvQASrxEsUMTqTte
 JZtejfTM2jzuZMqiILvLGUgcVJTZB26d04W9K8iiOpAxmskKpDF+tpK8wsUNc6AWFx1g
 d9NXKUnMzi/L3DeAAEPTodFRQTS+z8bYvmIaEBgKnt8S++ypl8RRH6KGl+MzQ+ksw3Nl
 BA032NF+nQSC0qCDlhOF0N1dnfwaJl0wcD0AQvlOgj203xEGk/9fAH4V0f4zvoYVFS/n
 BXNg==
X-Gm-Message-State: AGi0PuZzcK6ktrNC1M7ejVSaZtznfJ/eFDwQzb8r1u2zuAV25G8f/isH
 WfTBjJR1bMOKZW7d1MowNOpPMQ46kLuMpg==
X-Google-Smtp-Source: APiQypI5xzqHyzXk4dZS6FWpEVve5BlJiPDA3L6IS83JYAZxdoWNnrNEX/w//LVCwbyv1oAfWsEHPQ==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr5255139wru.258.1588270233389; 
 Thu, 30 Apr 2020 11:10:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 21/36] target/arm: Convert Neon 3-reg-same SHA to decodetree
Date: Thu, 30 Apr 2020 19:09:48 +0100
Message-Id: <20200430181003.21682-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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

Convert the Neon SHA instructions in the 3-reg-same group
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 139 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  46 +----------
 target/arm/neon-dp.decode       |  10 +++
 3 files changed, 151 insertions(+), 44 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index c8beb048fa2..161313ad879 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -769,3 +769,142 @@ static bool trans_VQRDMLSH_3s(DisasContext *s, arg_3same *a)
     };
     return do_vqrdmlah(s, a, fns[a->size]);
 }
+
+static bool trans_SHA1_3s(DisasContext *s, arg_SHA1_3s *a)
+{
+    TCGv_ptr ptr1, ptr2, ptr3;
+    TCGv_i32 tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_sha1, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    ptr1 = vfp_reg_ptr(true, a->vd);
+    ptr2 = vfp_reg_ptr(true, a->vn);
+    ptr3 = vfp_reg_ptr(true, a->vm);
+    tmp = tcg_const_i32(a->optype);
+    gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp);
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_ptr(ptr1);
+    tcg_temp_free_ptr(ptr2);
+    tcg_temp_free_ptr(ptr3);
+
+    return true;
+}
+
+static bool trans_SHA256H_3s(DisasContext *s, arg_SHA256H_3s *a)
+{
+    TCGv_ptr ptr1, ptr2, ptr3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_sha2, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    ptr1 = vfp_reg_ptr(true, a->vd);
+    ptr2 = vfp_reg_ptr(true, a->vn);
+    ptr3 = vfp_reg_ptr(true, a->vm);
+    gen_helper_crypto_sha256h(ptr1, ptr2, ptr3);
+    tcg_temp_free_ptr(ptr1);
+    tcg_temp_free_ptr(ptr2);
+    tcg_temp_free_ptr(ptr3);
+
+    return true;
+}
+
+static bool trans_SHA256H2_3s(DisasContext *s, arg_SHA256H2_3s *a)
+{
+    TCGv_ptr ptr1, ptr2, ptr3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_sha2, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    ptr1 = vfp_reg_ptr(true, a->vd);
+    ptr2 = vfp_reg_ptr(true, a->vn);
+    ptr3 = vfp_reg_ptr(true, a->vm);
+    gen_helper_crypto_sha256h2(ptr1, ptr2, ptr3);
+    tcg_temp_free_ptr(ptr1);
+    tcg_temp_free_ptr(ptr2);
+    tcg_temp_free_ptr(ptr3);
+
+    return true;
+}
+
+static bool trans_SHA256SU1_3s(DisasContext *s, arg_SHA256SU1_3s *a)
+{
+    TCGv_ptr ptr1, ptr2, ptr3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_sha2, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    ptr1 = vfp_reg_ptr(true, a->vd);
+    ptr2 = vfp_reg_ptr(true, a->vn);
+    ptr3 = vfp_reg_ptr(true, a->vm);
+    gen_helper_crypto_sha256su1(ptr1, ptr2, ptr3);
+    tcg_temp_free_ptr(ptr1);
+    tcg_temp_free_ptr(ptr2);
+    tcg_temp_free_ptr(ptr3);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index adc42362469..160638e2a7c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4711,7 +4711,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int vec_size;
     uint32_t imm;
     TCGv_i32 tmp, tmp2, tmp3, tmp4, tmp5;
-    TCGv_ptr ptr1, ptr2, ptr3;
+    TCGv_ptr ptr1, ptr2;
     TCGv_i64 tmp64;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -4755,49 +4755,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
         switch (op) {
-        case NEON_3R_SHA:
-            /* The SHA-1/SHA-256 3-register instructions require special
-             * treatment here, as their size field is overloaded as an
-             * op type selector, and they all consume their input in a
-             * single pass.
-             */
-            if (!q) {
-                return 1;
-            }
-            if (!u) { /* SHA-1 */
-                if (!dc_isar_feature(aa32_sha1, s)) {
-                    return 1;
-                }
-                ptr1 = vfp_reg_ptr(true, rd);
-                ptr2 = vfp_reg_ptr(true, rn);
-                ptr3 = vfp_reg_ptr(true, rm);
-                tmp4 = tcg_const_i32(size);
-                gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp4);
-                tcg_temp_free_i32(tmp4);
-            } else { /* SHA-256 */
-                if (!dc_isar_feature(aa32_sha2, s) || size == 3) {
-                    return 1;
-                }
-                ptr1 = vfp_reg_ptr(true, rd);
-                ptr2 = vfp_reg_ptr(true, rn);
-                ptr3 = vfp_reg_ptr(true, rm);
-                switch (size) {
-                case 0:
-                    gen_helper_crypto_sha256h(ptr1, ptr2, ptr3);
-                    break;
-                case 1:
-                    gen_helper_crypto_sha256h2(ptr1, ptr2, ptr3);
-                    break;
-                case 2:
-                    gen_helper_crypto_sha256su1(ptr1, ptr2, ptr3);
-                    break;
-                }
-            }
-            tcg_temp_free_ptr(ptr1);
-            tcg_temp_free_ptr(ptr2);
-            tcg_temp_free_ptr(ptr3);
-            return 0;
-
         case NEON_3R_VPADD_VQRDMLAH:
             if (!u) {
                 break;  /* VPADD */
@@ -4828,6 +4785,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VMUL:
         case NEON_3R_VML:
         case NEON_3R_VSHL:
+        case NEON_3R_SHA:
             /* Already handled by decodetree */
             return 1;
         }
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ce0db476c88..f22606b2bd5 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -86,4 +86,14 @@ VMUL_3s          1111 001 0 0 . .. .... .... 1001 . . . 1 .... @3same
 VMUL_p_3s        1111 001 1 0 . .. .... .... 1001 . . . 1 .... @3same
 
 VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
+
+SHA1_3s          1111 001 0 0 . optype:2 .... .... 1100 . 1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+SHA256H_3s       1111 001 1 0 . 00 .... .... 1100 . 1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+SHA256H2_3s      1111 001 1 0 . 01 .... .... 1100 . 1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+SHA256SU1_3s     1111 001 1 0 . 10 .... .... 1100 . 1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
 VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
-- 
2.20.1


