Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4716C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726FD2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVrQCDHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726FD2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fYa-0001Q4-HZ
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVK-0004Du-Fu
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVI-0008VC-QV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:54 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVI-0008Up-IV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:52 -0500
Received: by mail-pl1-x641.google.com with SMTP id c23so4018197plz.4
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NUF6GFUiKTx14rAhTmcqLDxmnGq1A1fKejGqoveF2Lc=;
 b=cVrQCDHFGN60z+AcOJDcrqN52UvAmXhlhWhM7f8XzcL9OyJeoSH/YlH63GXx0yxZbu
 g9DFvLbRbAjoiqZEANi8Fat2RparP5X+w6vDo6BNrKRryv1+YeMHZ0Gb18xWiNAPrpkq
 F4TxXapjBRDmWpMjDYuVuXadFC1TPfzvXTHikfmKy8iqNVL25sj5Yw+53f1c17Ugf1eZ
 Zdm1BzfaZbAq++GWXs3jJaGypYNFLCopasG7NfQ7wzDQ3MZnNyWawI46END2f4b4zKMs
 EzM7Hfl9+6glifyGJtYYE3MrTFl7jk8fghHe9JaB2NCE44vzJufyINgFCIv+mVmgRoi3
 TAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NUF6GFUiKTx14rAhTmcqLDxmnGq1A1fKejGqoveF2Lc=;
 b=T1ENW4PTC3a2uAwm2wZ0OyXFQO9Cn//vSMf90AD93v/BIX6aLlJ2ZmbZMyKf5Zc9ut
 xpJ9jfL5tNozKjqoT9gj2tzAIv1w8zYZh0V1imJCYT/Xe49qAPeUph+wXopNxGuTceMr
 oCXen8eaxhRi9W8d5x1YJ4ljxpARteyhjNCJ0nZVlWDABh24cV579AVNrkLhPrFKar1w
 nvXSg5zXg6TRa4laBl9ApgKAiRYliCPEDWhCabr082Yeo+V3bdaPJHCMOgqeON6GJFJ1
 eWC+2GEtfC8+r32f3lvOjtBEioet2Lsp+GT7n3Nc2m5tbT1DKS1jVoAIcW3GtoyElJ2s
 2YFg==
X-Gm-Message-State: APjAAAWMmPomzkdRpZfdCVGnGpYHiF2hf+okD3mLzltBs4fq6lx2udYT
 h6xrC6X6keoRYM4npYx9xAaU9D6o8CI=
X-Google-Smtp-Source: APXvYqwBsEH53EWgOTUGzhPfGyzUCA+J8ZUe9/f1Vvo/8z0dHWfglCGkp089Ysx1y/MW6718gUPwGw==
X-Received: by 2002:a17:902:9b8a:: with SMTP id
 y10mr4357682plp.114.1581704151005; 
 Fri, 14 Feb 2020 10:15:51 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:15:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/19] target/arm: Rename isar_feature_aa32_simd_r32
Date: Fri, 14 Feb 2020 10:15:30 -0800
Message-Id: <20200214181547.21408-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The old name, isar_feature_aa32_fp_d32, does not reflect
the MVFR0 field name, SIMDReg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  2 +-
 target/arm/translate-vfp.inc.c | 52 +++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 28cb2be6fc..f7139db02d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3412,7 +3412,7 @@ static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
 }
 
-static inline bool isar_feature_aa32_fp_d32(const ARMISARegisters *id)
+static inline bool isar_feature_aa32_simd_r32(const ARMISARegisters *id)
 {
     /* Return true if D16-D31 are implemented */
     return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) >= 2;
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index bf90ac0e5b..96a1d727c6 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -201,7 +201,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
@@ -334,7 +334,7 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
@@ -420,7 +420,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
         ((a->vm | a->vd) & 0x10)) {
         return false;
     }
@@ -484,7 +484,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -556,7 +556,7 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
     uint32_t offset;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
     }
 
@@ -615,7 +615,7 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
     uint32_t offset;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
     }
 
@@ -662,7 +662,7 @@ static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
     }
 
@@ -912,7 +912,7 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
      */
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -978,7 +978,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
     TCGv_i64 tmp;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -1101,7 +1101,7 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd + n) > 16) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd + n) > 16) {
         return false;
     }
 
@@ -1309,7 +1309,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     TCGv_ptr fpst;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((vd | vn | vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vn | vm) & 0x10)) {
         return false;
     }
 
@@ -1458,7 +1458,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     TCGv_i64 f0, fd;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((vd | vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
         return false;
     }
 
@@ -1822,7 +1822,7 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vn | a->vm) & 0x10)) {
         return false;
     }
 
@@ -1921,7 +1921,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     vd = a->vd;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (vd & 0x10)) {
         return false;
     }
 
@@ -2065,7 +2065,7 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2138,7 +2138,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd  & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd  & 0x10)) {
         return false;
     }
 
@@ -2204,7 +2204,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm  & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm  & 0x10)) {
         return false;
     }
 
@@ -2264,7 +2264,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2325,7 +2325,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2384,7 +2384,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2412,7 +2412,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     TCGv_i32 vm;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2440,7 +2440,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     TCGv_i32 vd;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -2494,7 +2494,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     TCGv_ptr fpst;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2534,7 +2534,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -2627,7 +2627,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2723,7 +2723,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     TCGv_ptr fpst;
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
-- 
2.20.1


