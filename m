Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E69C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F84B214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRc0qw3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F84B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j051p-0004wh-F4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i8-00013d-PU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i7-0003Nn-Gl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04i7-0003MV-9m
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:23 -0500
Received: by mail-wr1-x444.google.com with SMTP id a6so2913738wrx.12
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uvVs7AbJlQzoOOjIZQudyT2Qfx8L7K31YrCEz2YjTWE=;
 b=fRc0qw3Mluk1edQfA543Uri3Q96sXB19Q8GY4ZaGZvUy7ZYWNC+Iw+XHKnuT+mydfA
 Shd4RzsbjtC5+bYatX2uHn9SaFuTNYu719K4AVD1JzfCcbiYL24NXaXf5nE6xqIlP7p+
 aTa7V6SG2yL67oW9vDMbAghzOqD1vxYpC2b8kSb3figRohrGDWUhtfkPI5XCaVp3lznD
 We1cqs/ar06vdgIcKi8GUxlYcgfIQwnKY4L+eUrcJh+wvjYVv7eM9kLli9SN75GKghf6
 kQtZDlZrv8eSTnu1tNa6HZNjQn/YYM073EdXOv6vqJwQhO9n6n0X77e88vyHu/sIa0nw
 nTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uvVs7AbJlQzoOOjIZQudyT2Qfx8L7K31YrCEz2YjTWE=;
 b=qyQgBn3eR1Q9Ue3mDiecyLnAlnJA+7IWg5wqX1/yAm1oKSjwdRYJ3uH6Jti059Ctvb
 TVToWL2emTc8dC7IqayvhL32qvpHM70tibhOU3mlEVzUj35yH5qsu/DNJJO10VaLI+yk
 ycBgSIoHA1AvNBNoldIYjFvyauDk9eMp9L0zDewTVxcbDd1cMT6kSDVQdA3gOqyo/Vbh
 Yh+EEhSr1vzHuno5odBl+1TIQCsik0wnAv5Z4owc3inru4WxmjKqfGOUaLQ25WGNFSR/
 IcW/gPjmAu3S/i/LhDQbHisiyxq4QM/BChLurQ+YpvpLfDc/NKAiPsFh6D82RaE1XQFs
 wCug==
X-Gm-Message-State: APjAAAWFCf23Xv1w8W0XJRCp9s/isfcKIA289YiFyuTms2n47q+uD+9m
 CcF1pMt0VyRQQFSi9oJq07OBc/tOfYg=
X-Google-Smtp-Source: APXvYqxl5rEAzv8X+ZE7pcZ26a0LuPebCQEd7u1N2Z4MBECmWarLvhzB4qOv/kgJ6eef5tbd591O9g==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr4992000wrs.365.1581086062113; 
 Fri, 07 Feb 2020 06:34:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/48] target/arm: Update {fp,sve}_exception_el for VHE
Date: Fri,  7 Feb 2020 14:33:29 +0000
Message-Id: <20200207143343.30322-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

When TGE+E2H are both set, CPACR_EL1 is ignored.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-34-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 56a62b11d09..9627b4aab15 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5791,7 +5791,9 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
 int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
-    if (el <= 1) {
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+
+    if (el <= 1 && (hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
         bool disabled = false;
 
         /* The CPACR.ZEN controls traps to EL1:
@@ -5806,8 +5808,7 @@ int sve_exception_el(CPUARMState *env, int el)
         }
         if (disabled) {
             /* route_to_el2 */
-            return (arm_feature(env, ARM_FEATURE_EL2)
-                    && (arm_hcr_el2_eff(env) & HCR_TGE) ? 2 : 1);
+            return hcr_el2 & HCR_TGE ? 2 : 1;
         }
 
         /* Check CPACR.FPEN.  */
@@ -11691,8 +11692,6 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
-    int fpen;
-
     /* CPACR and the CPTR registers don't exist before v6, so FP is
      * always accessible
      */
@@ -11720,30 +11719,34 @@ int fp_exception_el(CPUARMState *env, int cur_el)
      * 0, 2 : trap EL0 and EL1/PL1 accesses
      * 1    : trap only EL0 accesses
      * 3    : trap no accesses
+     * This register is ignored if E2H+TGE are both set.
      */
-    fpen = extract32(env->cp15.cpacr_el1, 20, 2);
-    switch (fpen) {
-    case 0:
-    case 2:
-        if (cur_el == 0 || cur_el == 1) {
-            /* Trap to PL1, which might be EL1 or EL3 */
-            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
+    if ((arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+        int fpen = extract32(env->cp15.cpacr_el1, 20, 2);
+
+        switch (fpen) {
+        case 0:
+        case 2:
+            if (cur_el == 0 || cur_el == 1) {
+                /* Trap to PL1, which might be EL1 or EL3 */
+                if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
+                    return 3;
+                }
+                return 1;
+            }
+            if (cur_el == 3 && !is_a64(env)) {
+                /* Secure PL1 running at EL3 */
                 return 3;
             }
-            return 1;
+            break;
+        case 1:
+            if (cur_el == 0) {
+                return 1;
+            }
+            break;
+        case 3:
+            break;
         }
-        if (cur_el == 3 && !is_a64(env)) {
-            /* Secure PL1 running at EL3 */
-            return 3;
-        }
-        break;
-    case 1:
-        if (cur_el == 0) {
-            return 1;
-        }
-        break;
-    case 3:
-        break;
     }
 
     /*
-- 
2.20.1


