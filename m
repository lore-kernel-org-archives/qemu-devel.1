Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E047CC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFBE2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYKE089k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFBE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fbJ-0008Lh-SW
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVP-0004LD-1L
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVN-00006I-GB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:58 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVN-00005y-9p
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:57 -0500
Received: by mail-pg1-x543.google.com with SMTP id g3so5208354pgs.11
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bLNTrgdvvZF7PnSY+r2yk4nJu3Fd25nqdhwKgVxP4y8=;
 b=GYKE089kTv91kmETyK0jyL74T8rE1zGRPjFKDuqFK8x9NzrPETSanVvoPuwszh31Qd
 DYH0f2BzDma5lvrDsxbW/qo5QHMoq98SXd5BE9hxCz4QhG2s3RmsySrQ/A6639kLyqkV
 wOXnN/9z77VRB4xks2cayOhzcySgt3hSD5KpYkPDS/HX+ABuC3emLNWzwauHFs+wLB5h
 D0t0aN59cZBO6Yj+ze09kLd37i8dmkxaDJQ0zLxiEPANyeJIBQTs+1R3/xPnYesUo3mi
 tQgT0nVXebtfJfw8NwTT+w9+vX5OcmI5rjB0/ZRbPCyAyeujbEujodmrVU8dkWkx2HW3
 HPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bLNTrgdvvZF7PnSY+r2yk4nJu3Fd25nqdhwKgVxP4y8=;
 b=fWt4oPGEqkJgZg3aXYfoE5+cvUp2JNBMQX9bhjw7MOsX8OhV6jD7MuCGbBku1G+YGL
 3zY7FDdMEy/SNNPfsrxUKfb4kzYFhrIipHFtvwmgot2Ev3XxnCJWaeMShKaQyipVXpKo
 xaY3Muy7sYF0P9NvmyamP2sFWp5FPM+FwHngmDk0luYb6VzvE432n+Lq5E38GdgMEr9U
 M5/gTLCNwe+rAAIW/AS/Q4tBfy0SJ9tlBWzja2Gj+m5nrZW+uPqZjHXM4d4t7sNm/VQc
 /2O/T+ZR/cv57+oULeN4iJLmjlnSVzrcby6l36TH3UnbOGqXen/X3VHynGLJdjIvfVSS
 NVoA==
X-Gm-Message-State: APjAAAVVZSU9DZd3ysyAcu6yPTK5X89TSl14wK/VZif8CazBjK6aeM6Z
 I9PS46mqWSQoSYO67xWoLiq0s6+CNWc=
X-Google-Smtp-Source: APXvYqw3x3UjxGmwNCl2/4Gd92AQHYyZfRgVgmNMG3ZtoeYuSY9UgLMiw4vhyTvhDpRzmWxQmstvhw==
X-Received: by 2002:a63:9257:: with SMTP id s23mr5037458pgn.0.1581704155908;
 Fri, 14 Feb 2020 10:15:55 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:15:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/19] target/arm: Rename isar_feature_aa32_fpdp_v2
Date: Fri, 14 Feb 2020 10:15:34 -0800
Message-Id: <20200214181547.21408-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

The old name, isar_feature_aa32_fpdp, does not reflect
that the test includes VFPv2.  We will introduce another
feature tests for VFPv3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  4 ++--
 target/arm/translate-vfp.inc.c | 40 +++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 85b90eaed2..5f08cbd2d8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3429,9 +3429,9 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
-static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
+static inline bool isar_feature_aa32_fpdp_v2(const ARMISARegisters *id)
 {
-    /* Return true if CPU supports double precision floating point */
+    /* Return true if CPU supports double precision floating point, VFPv2 */
     return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
 }
 
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 96a1d727c6..5290828d0d 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -206,7 +206,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -339,7 +339,7 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -425,7 +425,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -488,7 +488,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1313,7 +1313,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1462,7 +1462,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1826,7 +1826,7 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1925,7 +1925,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2069,7 +2069,7 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2142,7 +2142,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2208,7 +2208,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2268,7 +2268,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2329,7 +2329,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2388,7 +2388,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2416,7 +2416,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2444,7 +2444,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2498,7 +2498,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2538,7 +2538,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2631,7 +2631,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2727,7 +2727,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-- 
2.20.1


