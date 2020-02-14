Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08066C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27E52086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYdkLkx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27E52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fej-0006G9-W6
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVU-0004RT-Eo
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVS-0000Eo-1A
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:04 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVR-0000EW-Pc
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:01 -0500
Received: by mail-pj1-x1043.google.com with SMTP id d5so4191272pjz.5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jaAC4b+WQDjTB8KwLDIOWST2Ik8xCOfklX+0EF0qKFI=;
 b=iYdkLkx91FTUw8c8aBjrmN1KPeXf/SG3+sU1Yc9XDgtYaNpxxaimOW3oXl0srjnFaS
 yO6s7pv4yulfxaEMidlD+sGi1+IDu7sxa3ipRq2LWe5sNxJQ5egSnP/qG/vQKfgchhLX
 f8E5m+APpOS3UzDT5hpdCakIQHO2iRP3qwsE3gIVK82+wXRpJzSQ6BieWbj0e8SBrlJy
 KHIbK2/+oErmPRQXYfJLpH7Z53yvmRNgr3Fl/dPVBPQkwA93WYqSFNgjjwLkiraLceUw
 UCp2N/QBGAPNZaGCIcMDwnWMsBu1FFEvkwOlODZHE86mIgIJodckAt7rybURduIKcfuv
 mN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jaAC4b+WQDjTB8KwLDIOWST2Ik8xCOfklX+0EF0qKFI=;
 b=dzVGicuCzXw9SQcOaDo4nq/h2PYNpBZ3xVpyXS4DPaOwr2XJh0vuhsfRR4zZWF0zG9
 p28yRCiKXck5Q/u9EeeiyEHkVrVQMD5w1h3VuHtRaDu8qX83UOmB+CDnI9HnJ9H4u4MK
 fDSfUeewqINWKyaKg2O6oT3AteNAZO2pEGd+QFg2kHT2ecX+s6rCkTLVYCqdNpWPzl8Z
 tAKq2enJEiWN0p7x96p1aGZJL8B4lJkLKKPhfiNeqgLsJAC9M7sPXCmUAoEBtJ+hZyro
 9HrVIGyubq0I2Th2kKLS5sQwfeMzrwea1ggR6Yl3ldLSy+ElflnY2ZHQq9SsjBxFmXjK
 mdHA==
X-Gm-Message-State: APjAAAVbNEDJFuQnGi91sonwgGLtU7uiUE8X+vZREQMVVL9y09hpoBRE
 /PUHBxolkKZlvFRrnsDOC/9Ushu8p7E=
X-Google-Smtp-Source: APXvYqyri7x81oPnuh6GV+wpNbaTh1DaWzdLLZQ/djrKMOXXFFFRlJlFlPCR3j+jQC6ojRRqe4NDfg==
X-Received: by 2002:a17:90a:628c:: with SMTP id
 d12mr5123055pjj.59.1581704160272; 
 Fri, 14 Feb 2020 10:16:00 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:15:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/19] target/arm: Add missing checks for fpsp_v2
Date: Fri, 14 Feb 2020 10:15:38 -0800
Message-Id: <20200214181547.21408-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

We will eventually remove the early ARM_FEATURE_VFP test,
so add a proper test for each trans_* that does not already
have another ISA test.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 78 ++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 9e5516f208..8913320259 100644
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
@@ -2021,6 +2069,10 @@ static bool trans_VCMP_sp(DisasContext *s, arg_VCMP_sp *a)
 {
     TCGv_i32 vd, vm;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     /* Vm/M bits must be zero for the Z variant */
     if (a->z && a->vm != 0) {
         return false;
@@ -2464,6 +2516,10 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
     TCGv_i32 vm;
     TCGv_ptr fpst;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2682,6 +2738,10 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
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


