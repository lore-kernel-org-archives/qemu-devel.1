Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B136C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA10B2468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhrXQwrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA10B2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ihs-0004Mj-1d
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifC-0007SV-Vs
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifB-0001sq-8D
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:58 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifB-0001sC-0W
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:57 -0500
Received: by mail-wm1-x341.google.com with SMTP id n64so2576823wme.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=shlVhcZnOZKNj4cL6nMd6uYbiv5CWaO9bwOYlKOsNRM=;
 b=vhrXQwrwhGOYuQefwV/eM8yTI0kUKey+5Ymuo1qp/XeKTQUBqyooUW+feOvDVTz9kd
 aONa6zNw8EP2mOt0XHPpVyVxo5PFIBaQgYDWo55cC1LpjHElkjSSyb+8KoQ2BhB4uNhk
 KTOsTC5Rzy5vUNxY+yhmGp52tPfiFHJdGZr0dZlJ54x+5RjA9/4l466McRLqDrNJZFaa
 SZ1eYK1T/bMwtRBYmpCYmPO12BqMogFImm8gRCPXgeYxYGCOcJtOoY53s+IT5rKSDqvo
 yCV8UN9HXEAKFtcEpQKklzlPxE/81ni7LHMvUltwu9p/nJ+iLM/ZjQ3Gq8yW+mSxm/1+
 i3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=shlVhcZnOZKNj4cL6nMd6uYbiv5CWaO9bwOYlKOsNRM=;
 b=gie3vtEaa+Z/CqFrScA3oVzQLuvvin2u1lqo68QN9WGsnqVn6zCB7HvrNTkinN7nje
 VtMWEPR9DCfcqd1KELIoLc6yfWMssfDTHJz5LP4oYK8b0kLSMfDWJo75K4qCGglO9Ru8
 FiojXRZmgiXRnD1ik6AA/37AnxqWwCUw/Cj16gpE9wJtDcCc4yMnhJ1RhvVFz4JYheY8
 7BY7wHvcWABZlnTC645TbahDvaLlgTxofnaBuWRh4UYnXtKLepxyWDjscHjz7KR7DN64
 wbyhu8MBeZ06xWqQzUdCy/k+j8MWloMhD/EcVVfyPdDTzgkD4LgEhMRuMlFLFkOp9mKl
 NbmQ==
X-Gm-Message-State: APjAAAUehowdKRQGZqCNZ/f5i+gPqnL6kP+70LaJQrtWLwIp672Ehwnj
 7allKxTuxuiveQnk2Jjiyc0zhI8ReFf46A==
X-Google-Smtp-Source: APXvYqzkgNwkXtmTc7rg6tl0fUs8WNNuTOe+8DkdMb47CK5p9xy5+/i/mJT2vshSDSFVvjnb6yE+TA==
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr5463185wmi.108.1582907935199; 
 Fri, 28 Feb 2020 08:38:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/33] target/arm: Perform fpdp_v2 check first
Date: Fri, 28 Feb 2020 16:38:18 +0000
Message-Id: <20200228163840.23585-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Shuffle the order of the checks so that we test the ISA
before we test anything else, such as the register arguments.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224222232.13807-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 140 +++++++++++++++++----------------
 1 file changed, 71 insertions(+), 69 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index e94876c30ca..ff301650455 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -200,13 +200,13 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
 
@@ -333,13 +333,13 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
 
@@ -419,13 +419,13 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vd) & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vm | a->vd) & 0x10)) {
         return false;
     }
 
@@ -483,12 +483,12 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -1308,12 +1308,12 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     TCGv_i64 f0, f1, fd;
     TCGv_ptr fpst;
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vn | vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vn | vm) & 0x10)) {
         return false;
     }
 
@@ -1457,12 +1457,12 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     int veclen = s->vec_len;
     TCGv_i64 f0, fd;
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
         return false;
     }
 
@@ -1827,7 +1827,9 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
         return false;
     }
 
@@ -1921,12 +1923,12 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
     vd = a->vd;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (vd & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (vd & 0x10)) {
         return false;
     }
 
@@ -2060,6 +2062,10 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
 {
     TCGv_i64 vd, vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     /* Vm/M bits must be zero for the Z variant */
     if (a->z && a->vm != 0) {
         return false;
@@ -2070,10 +2076,6 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2134,6 +2136,10 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     TCGv_i32 tmp;
     TCGv_i64 vd;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
         return false;
     }
@@ -2143,10 +2149,6 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2200,6 +2202,10 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     TCGv_i32 tmp;
     TCGv_i64 vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
         return false;
     }
@@ -2209,10 +2215,6 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2260,6 +2262,10 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     TCGv_ptr fpst;
     TCGv_i64 tmp;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2269,10 +2275,6 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2321,6 +2323,10 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     TCGv_i64 tmp;
     TCGv_i32 tcg_rmode;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2330,10 +2336,6 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2380,6 +2382,10 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     TCGv_ptr fpst;
     TCGv_i64 tmp;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2389,10 +2395,6 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2412,12 +2414,12 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     TCGv_i64 vd;
     TCGv_i32 vm;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2440,12 +2442,12 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     TCGv_i64 vm;
     TCGv_i32 vd;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -2494,12 +2496,12 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     TCGv_i64 vd;
     TCGv_ptr fpst;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2530,6 +2532,10 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     TCGv_i32 vd;
     TCGv_i64 vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_jscvt, s)) {
         return false;
     }
@@ -2539,10 +2545,6 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2623,6 +2625,10 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     TCGv_ptr fpst;
     int frac_bits;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
         return false;
     }
@@ -2632,10 +2638,6 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2723,12 +2725,12 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     TCGv_i64 vm;
     TCGv_ptr fpst;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
-- 
2.20.1


