Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36171C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EE2214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XW5Zn18B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EE2214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0515-0002gG-53
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i1-0000k0-EP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i0-00039s-0n
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:17 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hz-000392-PG
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:15 -0500
Received: by mail-wr1-x443.google.com with SMTP id a6so2913247wrx.12
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QYnoVMkywmY6XVGGWRidC9UHjs8ccQpGBlGTx9rUDOw=;
 b=XW5Zn18BkFtnWk7XB901/5W+BdbxubGToOSv5/8BIZX/nXi4qASMm0sGN2kBkOGviX
 nxEe1+CJN7ZCJ/j5f2b0oWCVz/Zy4z/cQ2r9WXRg98Urp5vjk3/6ngdKUV3xHVpqHe2X
 OCalNHOUzGzwF/AxK3MOOMT5hHAVfqO4lJMkiqPUGPB3538mjuXZMieJPOVuTiTPMbTW
 HZLAfAsmRbB2q5DS7lKKom/PpRmEBfyFQEpdEW+/kR0jU1OSHo0B5/Uh4heAYuVbCS0L
 sKFDb12K/vxkIxlGxAnGTbnnLVvAqPtdGd7N0rRoEMhOHd4BqVQVBnulABdGVHfOLqUS
 ehgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYnoVMkywmY6XVGGWRidC9UHjs8ccQpGBlGTx9rUDOw=;
 b=KyTGDkl6MgYEjFIcLqqbqaPXiQTmmdgWlUHKdT3wu7Kln2GmuVdlv8M5qsOUDwTgt/
 iPcDH9/gcHMr7N28fVuEGStRmpaWCmULQHMSS4ARy7GctWd39EHzh5p+oF6CHqKydSjY
 zKfGptU+FpnBbrIXsKhnFScorAp6+BW/1hCYjGGADHIUnKlG7neIQPxQj9qtmzednNQf
 mkZBmV0a+vPbiAUGxIl4XruAP36kGq+mZyYNpRQltv3LQZDfZM+uWyAre+Fb0MaHhIV1
 QDj9oVrX1j1EjY/WJtXt4sgacT3l2dmf7TzWbtZE6qg08ReRB0kxg1gjcjZcRCk/q2NL
 IyvA==
X-Gm-Message-State: APjAAAUySoN1+m+AaODPzXdJgMjXpGBVrVOK3ctL9qzEta/8MVZw/tXs
 f/Awl2uMBx8sgIFVuLqhnYRz/MNyXdk=
X-Google-Smtp-Source: APXvYqxhiwtnK4iUaMtIkDh/vHdyeFao/1ZJ47FgJfwdzD8NMo1LdMBqPESvbDBkvPwYi3vxRPMZVw==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr5283037wrn.128.1581086054455; 
 Fri, 07 Feb 2020 06:34:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/48] target/arm: Update timer access for VHE
Date: Fri,  7 Feb 2020 14:33:22 +0000
Message-Id: <20200207143343.30322-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-27-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 102 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 996865a3a20..992ab2a15f1 100644
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


