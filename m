Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98A4C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70173208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="is/PFaW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70173208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58bQ-0006tt-GO
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582v-000076-6V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582t-00042K-JG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:37815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582t-0003zN-CC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id a6so1779846wme.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MIWznLdnWE1pFMfHWxMiE6FxWKUgvMpAlD3wW7jfjds=;
 b=is/PFaW8zGweogkPvLVDAlK23Sq+QlNGBClHztcIvNP/nwuxVe1PJDMHuqLXXB+Bai
 ur1hX3zM8jm4Lv79tHysw78gzr8vt/lrhh9yrbVWCtbIpu44hLczkGv64ssk1/9osPj1
 oQjz4Wg5Ysg2qTt0RVbV0JpVgq1O0k1t9k0xluME8s0Alb4Xc9m6U9NNkAfd90SsNgKP
 kSeWxFFikZwLnBA5sBTWfRpn56vL3uaQqJUsOP7Tgz8NL7Kn70Jmd+x4eFU5WEN4kinL
 yu69krCbBZmm+FoEt3EQQ+yY5f1ogfqVqtAJPO9B4b3YsUN8oAxTeXawyssi255EDflU
 l3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MIWznLdnWE1pFMfHWxMiE6FxWKUgvMpAlD3wW7jfjds=;
 b=MobHtLO6gl2Xz+3iMO0CjjbNvfwXPreGmfwzYQp9LuWgHLsd2IsKCW9sbCvIefle6G
 fFnIy4COYGhY+xpKS9sUz1TJJ1mIx+CN0PFxcTcQxgjdBTRZarj+tQq1U4L4TrkajTAf
 d9dWxyWa7IiJLf1jXzbiWGUkENzQqLY/51mn6uQVQZiaEJpO8LnoqD8oRPbGRc2yg41K
 tLK9YXBipyPGrTWc2Ru86Ltn7Z3F26uuFggrlBYRd4Z9ZL55w+k7Feyupg3Ur7zr/G6X
 y53vgpGdcw/TgewrVeBvKF6X9MPEh0Myc7dfIInOczQgpd7rwN1GCBrnEaydrxQVQptw
 r4BA==
X-Gm-Message-State: APjAAAUM/DLaXyKeUBAjK/RFHPj0CacoeTgUi3Brg+UGscqXKlBest6Z
 +MsyeNNNW2lX5Y2KIY6YPAK/UvvqsJ1BwQ==
X-Google-Smtp-Source: APXvYqyjWXtgfwSpxOjyHl4sJfhL37PvL/N4KL60vpe57In8ttnzC6wigYBj/zibd9TK1yu10+61Lg==
X-Received: by 2002:a1c:7712:: with SMTP id t18mr3982364wmi.32.1582290521168; 
 Fri, 21 Feb 2020 05:08:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/52] target/arm: Rename isar_feature_aa32_fpdp_v2
Date: Fri, 21 Feb 2020 13:07:36 +0000
Message-Id: <20200221130740.7583-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

The old name, isar_feature_aa32_fpdp, does not reflect
that the test includes VFPv2.  We will introduce further
feature tests for VFPv3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200214181547.21408-7-richard.henderson@linaro.org
[PMM: fixed grammar in commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  4 ++--
 target/arm/translate-vfp.inc.c | 40 +++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5a62586dd29..1e2aae276bf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3467,9 +3467,9 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
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
index ba46e2557a1..e94876c30ca 100644
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
 
@@ -1827,7 +1827,7 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1926,7 +1926,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2070,7 +2070,7 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2143,7 +2143,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2209,7 +2209,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2269,7 +2269,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2330,7 +2330,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2389,7 +2389,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2417,7 +2417,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2445,7 +2445,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2499,7 +2499,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2539,7 +2539,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2632,7 +2632,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2728,7 +2728,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-- 
2.20.1


