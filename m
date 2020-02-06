Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE989C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5D5206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnlqFw+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5D5206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf4P-0000xK-Px
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoV-0003Ix-Ew
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoT-0007io-I4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:15 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoT-0007cK-8K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:13 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so5802243wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=upHYF1UMXzuY7YGdgMwFvDjEH+GvpeNijlwWGAtlcaE=;
 b=qnlqFw+p76jInhDSPdcAgJuAvEbBOOE6v+YY7TCYWjY7g6MaWzHDos/xvGRRxax9JI
 TDMHor4GKMkvyEjcwIxhYSLhTaXdd4sFzCSEl+lU1wYUql0nWrpddipMddOCKBrhjz24
 DsRTe0+sAbAoVudKR/M+fNaPGbOhjm9bHv0q8Rj689MA8K22zjss9Ax3Lz6xmu5Q0jM8
 HBxc7wmGywucKIJ9rYxn8tIzXw0lIjYIE3GgS+2aiY9VMAhW4cH2Cnb4vKgbQCzVb1g7
 5RPm0Cv3I2Oly2BFvzf4YmcTiT9D10zacFp6m+kOhrYFXzICisM4+arrR4Lc8bmaI6Fm
 zy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=upHYF1UMXzuY7YGdgMwFvDjEH+GvpeNijlwWGAtlcaE=;
 b=PmgG2xLaCWYH1ByC3qIowcPkHPnKKL40GECA0ApTMqHUZN5+kIRluCW2iBf1r/kasq
 mLl6ENgobfd1XHnze8mUKT8//4pfYAgHPvJBvQhh6LZppBlLm5ludT2eG4dkJki7L5Mk
 hP5vFLcbbt2jqBdCFr6/erZCTt1g55NV/2G2IXMSHvatzv2uaMZyVWYXjH06u/LfbNxB
 hKX95iBCDB4cVnc7Q78ymztPkDQrrnab9WgvDsQyrp8CI8s3oad1GdOosWxpCVLXPgF4
 Bz3hb9fMDVPeMDuvD1RCWI+9eiliXFTt+YPR08xLPKVix8jH6EhBnVmPl5G6nvzxNlzA
 gyvg==
X-Gm-Message-State: APjAAAUqKn5Eozg7N8Fe29BaiRQexauFXxWwYb4ibYlI4PUKb9rkm22Q
 CuJ5uJoDjsrkifRFmdoyiuhAW+cM3IKWhA==
X-Google-Smtp-Source: APXvYqxQDPtVtcSO1VWSDsTuPlxkzG6TqhAYVT2HHOHScUvsb3QcVign/FCMwL4Y6VObq5Qh+QR2lw==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr3890632wma.89.1580986511787; 
 Thu, 06 Feb 2020 02:55:11 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 26/41] target/arm: Update timer access for VHE
Date: Thu,  6 Feb 2020 10:54:33 +0000
Message-Id: <20200206105448.4726-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 102 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 996865a3a2..992ab2a15f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2324,10 +2324,18 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
      * Writable only at the highest implemented exception level.
      */
     int el = arm_current_el(env);
+    uint64_t hcr;
+    uint32_t cntkctl;
 
     switch (el) {
     case 0:
-        if (!extract32(env->cp15.c14_cntkctl, 0, 2)) {
+        hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            cntkctl = env->cp15.cnthctl_el2;
+        } else {
+            cntkctl = env->cp15.c14_cntkctl;
+        }
+        if (!extract32(cntkctl, 0, 2)) {
             return CP_ACCESS_TRAP;
         }
         break;
@@ -2355,17 +2363,47 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
 {
     unsigned int cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
+    uint64_t hcr = arm_hcr_el2_eff(env);
 
-    /* CNT[PV]CT: not visible from PL0 if ELO[PV]CTEN is zero */
-    if (cur_el == 0 &&
-        !extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
-        return CP_ACCESS_TRAP;
-    }
+    switch (cur_el) {
+    case 0:
+        /* If HCR_EL2.<E2H,TGE> == '11': check CNTHCTL_EL2.EL0[PV]CTEN. */
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            return (extract32(env->cp15.cnthctl_el2, timeridx, 1)
+                    ? CP_ACCESS_OK : CP_ACCESS_TRAP_EL2);
+        }
 
-    if (arm_feature(env, ARM_FEATURE_EL2) &&
-        timeridx == GTIMER_PHYS && !secure && cur_el < 2 &&
-        !extract32(env->cp15.cnthctl_el2, 0, 1)) {
-        return CP_ACCESS_TRAP_EL2;
+        /* CNT[PV]CT: not visible from PL0 if EL0[PV]CTEN is zero */
+        if (!extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
+            return CP_ACCESS_TRAP;
+        }
+
+        /* If HCR_EL2.<E2H,TGE> == '10': check CNTHCTL_EL2.EL1PCTEN. */
+        if (hcr & HCR_E2H) {
+            if (timeridx == GTIMER_PHYS &&
+                !extract32(env->cp15.cnthctl_el2, 10, 1)) {
+                return CP_ACCESS_TRAP_EL2;
+            }
+        } else {
+            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
+            if (arm_feature(env, ARM_FEATURE_EL2) &&
+                timeridx == GTIMER_PHYS && !secure &&
+                !extract32(env->cp15.cnthctl_el2, 1, 1)) {
+                return CP_ACCESS_TRAP_EL2;
+            }
+        }
+        break;
+
+    case 1:
+        /* Check CNTHCTL_EL2.EL1PCTEN, which changes location based on E2H. */
+        if (arm_feature(env, ARM_FEATURE_EL2) &&
+            timeridx == GTIMER_PHYS && !secure &&
+            (hcr & HCR_E2H
+             ? !extract32(env->cp15.cnthctl_el2, 10, 1)
+             : !extract32(env->cp15.cnthctl_el2, 0, 1))) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        break;
     }
     return CP_ACCESS_OK;
 }
@@ -2375,19 +2413,41 @@ static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
 {
     unsigned int cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
+    uint64_t hcr = arm_hcr_el2_eff(env);
 
-    /* CNT[PV]_CVAL, CNT[PV]_CTL, CNT[PV]_TVAL: not visible from PL0 if
-     * EL0[PV]TEN is zero.
-     */
-    if (cur_el == 0 &&
-        !extract32(env->cp15.c14_cntkctl, 9 - timeridx, 1)) {
-        return CP_ACCESS_TRAP;
-    }
+    switch (cur_el) {
+    case 0:
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            /* If HCR_EL2.<E2H,TGE> == '11': check CNTHCTL_EL2.EL0[PV]TEN. */
+            return (extract32(env->cp15.cnthctl_el2, 9 - timeridx, 1)
+                    ? CP_ACCESS_OK : CP_ACCESS_TRAP_EL2);
+        }
 
-    if (arm_feature(env, ARM_FEATURE_EL2) &&
-        timeridx == GTIMER_PHYS && !secure && cur_el < 2 &&
-        !extract32(env->cp15.cnthctl_el2, 1, 1)) {
-        return CP_ACCESS_TRAP_EL2;
+        /*
+         * CNT[PV]_CVAL, CNT[PV]_CTL, CNT[PV]_TVAL: not visible from
+         * EL0 if EL0[PV]TEN is zero.
+         */
+        if (!extract32(env->cp15.c14_cntkctl, 9 - timeridx, 1)) {
+            return CP_ACCESS_TRAP;
+        }
+        /* fall through */
+
+    case 1:
+        if (arm_feature(env, ARM_FEATURE_EL2) &&
+            timeridx == GTIMER_PHYS && !secure) {
+            if (hcr & HCR_E2H) {
+                /* If HCR_EL2.<E2H,TGE> == '10': check CNTHCTL_EL2.EL1PTEN. */
+                if (!extract32(env->cp15.cnthctl_el2, 11, 1)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
+                if (!extract32(env->cp15.cnthctl_el2, 1, 1)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        }
+        break;
     }
     return CP_ACCESS_OK;
 }
-- 
2.20.1


