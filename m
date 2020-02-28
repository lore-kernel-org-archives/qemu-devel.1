Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB353C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A949F2468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBZoeXyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949F2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7il5-0003ET-Lf
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifF-0007YQ-DR
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifD-0001uM-SI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:01 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifD-0001tw-Lg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:59 -0500
Received: by mail-wm1-x342.google.com with SMTP id i10so8616502wmd.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YZu863NKaGXhWKWNne24xSYUgnIGai+DzFIAU+N7iSk=;
 b=VBZoeXyQnZ8iR8499S2q6Oi+uI2sCSK1nAscoRW22bD+7JG3wx6FySvg9nlSl8X1n6
 x+GVnb7mCAfm9pSK3ZJ+/l93LIYM1d+J8bEB3EAWtklLSFB1YeILL4+hMUyzbtrT5XCM
 wKzYJsncC/lYlovXCy3cCJPbwFvPWGIMD4Ud6EtpsjJ12zGBofSsDsUywCQjxzhYTwBj
 nklN+chPOU74CTtnN/vhkx78tX6lDj39Ub+IrgdulgQMMtk7fCuvfxSYX98Nlca6BdJH
 Xs/uvfHiYeVsKT2SblSf9jkOOmiqQ/MCGUlkllT90ebecVL4qnrxeStZ8I87Xxv/PxQW
 WgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YZu863NKaGXhWKWNne24xSYUgnIGai+DzFIAU+N7iSk=;
 b=UK0WSmVas/dYa1yyoXkQkpSuA5pYKPOABHES0y091S5gRoM0sw1paIfg6SgyhaPO36
 BdJKoXlv2TcqKzii4DL7Ck28ss99/TP77+BL4QAP6g6rMj2kkN6EbH7YCN5BE6Y3HWp1
 cHwb8CUFRPPKs93wyU7jjPsseRuCmEEj9JHeNI9GpWQq21JBhbuDAB32NoaZ+MZtBAEX
 +Am4JXM+dEd9ylE96d/oN4hDNfQnok3VOz8txjWBuvF0ORNq3eUmJ9qBv6inAD1MfJEd
 6uiS9AS5hZLJLWJ9NN0kiZxFrK+Ud1abA0yApgai+EIByzK+ftt/iTUGfagP8gNRHY5x
 5H6Q==
X-Gm-Message-State: APjAAAV2viAAsXBVYgoGF5ZCheT8UQlZJ9lZpmyf//6C5NK2TAzI5OMD
 IJIYQti8jlYtk746+BJH5f59iG4c4S5slg==
X-Google-Smtp-Source: APXvYqyj/hjjEMXoHlKZwIADjKDOXPrP6HWnDHGOADUFV+hWLUPosbVmm1w+bwSJPDFGp86WuLlNnw==
X-Received: by 2002:a1c:984a:: with SMTP id a71mr5799398wme.185.1582907938374; 
 Fri, 28 Feb 2020 08:38:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/33] target/arm: Add missing checks for fpsp_v2
Date: Fri, 28 Feb 2020 16:38:20 +0000
Message-Id: <20200228163840.23585-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We will eventually remove the early ARM_FEATURE_VFP test,
so add a proper test for each trans_* that does not already
have another ISA test.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224222232.13807-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 78 ++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 51d46f43027..f88a95438fc 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -555,6 +555,13 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
     int pass;
     uint32_t offset;
 
+    /* SIZE == 2 is a VFP instruction; otherwise NEON.  */
+    if (a->size == 2
+        ? !dc_isar_feature(aa32_fpsp_v2, s)
+        : !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
@@ -564,10 +571,6 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
     pass = extract32(offset, 2, 1);
     offset = extract32(offset, 0, 2) * 8;
 
-    if (a->size != 2 && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -614,6 +617,13 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
     int pass;
     uint32_t offset;
 
+    /* SIZE == 2 is a VFP instruction; otherwise NEON.  */
+    if (a->size == 2
+        ? !dc_isar_feature(aa32_fpsp_v2, s)
+        : !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
@@ -623,10 +633,6 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
     pass = extract32(offset, 2, 1);
     offset = extract32(offset, 0, 2) * 8;
 
-    if (a->size != 2 && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -700,6 +706,10 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     TCGv_i32 tmp;
     bool ignore_vfp_enabled = false;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
         /*
          * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
@@ -844,6 +854,10 @@ static bool trans_VMOV_single(DisasContext *s, arg_VMOV_single *a)
 {
     TCGv_i32 tmp;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -873,6 +887,10 @@ static bool trans_VMOV_64_sp(DisasContext *s, arg_VMOV_64_sp *a)
 {
     TCGv_i32 tmp;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     /*
      * VMOV between two general-purpose registers and two single precision
      * floating point registers
@@ -908,8 +926,12 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
 
     /*
      * VMOV between two general-purpose registers and one double precision
-     * floating point register
+     * floating point register.  Note that this does not require support
+     * for double precision arithmetic.
      */
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
@@ -946,6 +968,10 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
     uint32_t offset;
     TCGv_i32 addr, tmp;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -977,6 +1003,11 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
     TCGv_i32 addr;
     TCGv_i64 tmp;
 
+    /* Note that this does not require support for double arithmetic.  */
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
@@ -1013,6 +1044,10 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
     TCGv_i32 addr, tmp;
     int i, n;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     n = a->imm;
 
     if (n == 0 || (a->vd + n) > 32) {
@@ -1086,6 +1121,11 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
     TCGv_i64 tmp;
     int i, n;
 
+    /* Note that this does not require support for double arithmetic.  */
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     n = a->imm >> 1;
 
     if (n == 0 || (a->vd + n) > 32 || n > 16) {
@@ -1234,6 +1274,10 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     TCGv_i32 f0, f1, fd;
     TCGv_ptr fpst;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -1388,6 +1432,10 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
     int veclen = s->vec_len;
     TCGv_i32 f0, fd;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -2023,6 +2071,10 @@ static bool trans_VCMP_sp(DisasContext *s, arg_VCMP_sp *a)
 {
     TCGv_i32 vd, vm;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     /* Vm/M bits must be zero for the Z variant */
     if (a->z && a->vm != 0) {
         return false;
@@ -2466,6 +2518,10 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
     TCGv_i32 vm;
     TCGv_ptr fpst;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2684,6 +2740,10 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
     TCGv_i32 vm;
     TCGv_ptr fpst;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
-- 
2.20.1


