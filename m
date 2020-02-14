Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C41C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF01F2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjUdmAd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF01F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fda-0004Nn-5b
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVS-0004Nr-2B
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVQ-0000Dw-N4
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:01 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVQ-0000Ci-GS
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:00 -0500
Received: by mail-pl1-x644.google.com with SMTP id t14so4012132plr.8
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pElnR5+ZNReOFV25D5Wd4OZyDSMZOeR76smz6O5bwn4=;
 b=hjUdmAd37aNlIq8IPlsbcSfAKHSjpi6isiDOKLK17Crix6/2Ymba1cQmYhnge/Av9z
 WQmvvodmneZ9sDBJo/ItH1l55Zg63Ygi0+aR+eMbROTckEjyrWpFgNKdMJIGLQn9tMez
 IrU7qvvsbODT/yzg4IwAVlcy2NQDaLZuA8FDOGhcZeZqkK6uqRTrgjE+7MNAodMAzUw2
 ZGI8HiYrrMVoVr5jW+/IKGGml4jA7vlmGuLfGs1jZFtgXen0dibBseQpFqEtx36IE2Ls
 mq/7ueBm4EK1aDCvaXfde3W9bsXd++1055DVx9I/B5RKfo58VP1nEVS3D5J0UfZuefVZ
 P5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pElnR5+ZNReOFV25D5Wd4OZyDSMZOeR76smz6O5bwn4=;
 b=G0HWUj22hzV3Altaznz3kdLgwYrJu0hzNjy0pRjXzlR4iiu8lyXjMTF11RQ5sxJYL3
 9gAuFcrR26mt7Xj8mnwC8+Iaku5ddqfQdKJT8YDGlbp8W5s3TwMztNX1NXiqOAkarF2I
 OTsqWKu0IKn19upbYeOBeQ3iH9JZV6mpmCs0MR59rTs6lPMfClp6PvfW46sZlUOHLSQY
 6Uac0OcxbH8B49uGVQbq5J7GUiwYEc1GKTLIY9uDnBsEEokTMTvz0JMFlUwrf9AbdOdj
 /tZi7gF6LUoSzSQ+pTXuAn/3cYwFyjKtjh7iol22NZTEsYWnFm9DeFtq/IJknAl0U0vb
 FV6g==
X-Gm-Message-State: APjAAAWfFbMJ4MbwbGHEXtKD7oHyFRxn5hnw3wayHAaiTqadzSqIAmKm
 NSlhkoRIqDnPgq4B2x/XRfWEfAfyNT0=
X-Google-Smtp-Source: APXvYqzm2G8FnQhPwmYjcskc/H6ubcvwbrWQs1mqkJBkFgAnUANH4keHnBjW+ta9ohlLynRmkTRWLw==
X-Received: by 2002:a17:902:7b92:: with SMTP id
 w18mr4534765pll.72.1581704159122; 
 Fri, 14 Feb 2020 10:15:59 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:15:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/19] target/arm: Replace ARM_FEATURE_VFP3 checks with fp{sp,
 dp}_v3
Date: Fri, 14 Feb 2020 10:15:37 -0800
Message-Id: <20200214181547.21408-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

Sort this check to the start of a trans_* function.
Merge this with any existing test for fpdp_v2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 0c55140127..9e5516f208 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -717,7 +717,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
          * VFPv2 allows access to FPSID from userspace; VFPv3 restricts
          * all ID registers to privileged access only.
          */
-        if (IS_USER(s) && arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+        if (IS_USER(s) && dc_isar_feature(aa32_fpsp_v3, s)) {
             return false;
         }
         ignore_vfp_enabled = true;
@@ -746,7 +746,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     case ARM_VFP_FPINST:
     case ARM_VFP_FPINST2:
         /* Not present in VFPv3 */
-        if (IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+        if (IS_USER(s) || dc_isar_feature(aa32_fpsp_v3, s)) {
             return false;
         }
         break;
@@ -1871,12 +1871,12 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 
     vd = a->vd;
 
-    if (!dc_isar_feature(aa32_fpshvec, s) &&
-        (veclen != 0 || s->vec_stride != 0)) {
+    if (!dc_isar_feature(aa32_fpsp_v3, s)) {
         return false;
     }
 
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+    if (!dc_isar_feature(aa32_fpshvec, s) &&
+        (veclen != 0 || s->vec_stride != 0)) {
         return false;
     }
 
@@ -1921,7 +1921,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
     vd = a->vd;
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v3, s)) {
         return false;
     }
 
@@ -1935,10 +1935,6 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         return false;
     }
 
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2563,7 +2559,7 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
     TCGv_ptr fpst;
     int frac_bits;
 
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+    if (!dc_isar_feature(aa32_fpsp_v3, s)) {
         return false;
     }
 
@@ -2623,11 +2619,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     TCGv_ptr fpst;
     int frac_bits;
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+    if (!dc_isar_feature(aa32_fpdp_v3, s)) {
         return false;
     }
 
-- 
2.20.1


