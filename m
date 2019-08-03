Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC05C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0952087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHFbLtM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0952087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzFh-0006qW-24
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33000)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5D-0006vh-H6
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5B-0007Ri-F9
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz59-0007Pd-IZ
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:43 -0400
Received: by mail-pf1-x443.google.com with SMTP id i189so37625822pfg.10
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fQb2baX8+br9XDTjkUGb5FILfpDmjfnieLRvexjfCRg=;
 b=ZHFbLtM2E06kgJw7hT0Egbeg9owC+1p6dPnG4drYYDaV1gn4UGEFq6dm4GnDGTxgJ6
 yPYbHxLvHHTQ3bYaIFZwUNkS/1xDppWkvjVkOmRUqHXoI+Tf4z1UGdu1DjksEdf8uGXl
 +SuFpIsNLFprQtP1if5EjQGhtH8IcVn+wwwCn7GLUllKJRV88oqO8J/DCg0D5HJfDnT6
 +o5weLX8BQujymbxv3/CzWAb7CFIMmM4VCf+WhyDSWqlwF8rYhiXKUZaPemUAn9/qU3C
 TBMaSgrAct7EUoGw408h+YJRJYNrc2S3hF6DF8YeT/KQP1YpAbN8O6n1vfsTauCdmhs1
 Q2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fQb2baX8+br9XDTjkUGb5FILfpDmjfnieLRvexjfCRg=;
 b=Ji/0e/9NCqsV79Pua8kJGIHSkQ3sEpueoao3DPf+DFIqbr8jwCs2MEiFgQPLP7mWbw
 qzgAVLWsul8rY/VZnw9MZftoPRYo8SNp08cKFuyZVCTWCqMuB6DZHhDhmWXkLpgT2UY6
 EmkmTHY0RoYGA+4HirYhLfNHqsVY1Iw69MUDGX50pJv8gFnT9v5KkdwDYHh6alP4NAFR
 feaF31fYpYgpgwcfet0zkh4K+/hBPP0xp0tZRv7zn6lDVotlos1L3/GhpeukZ2EFR80j
 yMCw9/lzAdV9+WWhjz94rSv4fmFil9QmVXOm51O+p/PcuKt4raFr775tnHUvG1r5j+n+
 b0hw==
X-Gm-Message-State: APjAAAWvN7Qc1ZlDV6mQnvhELEaLs+1lGofN07789rODXcKc58u6upze
 eMHfl3E7sPqnYT2iDiqkKB5dRsKaKhA=
X-Google-Smtp-Source: APXvYqxINb8Pz4XuN9P/UruqFE4PZJ/nLF369CIR3xnPOPBp6QD6RZuXQ+W29y3PmKGblH6A890Abw==
X-Received: by 2002:aa7:8b10:: with SMTP id f16mr66690094pfd.44.1564858119468; 
 Sat, 03 Aug 2019 11:48:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:57 -0700
Message-Id: <20190803184800.8221-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 31/34] target/arm: Update {fp,
 sve}_exception_el for VHE
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When TGE+E2H are both set, CPACR_EL1 is ignored.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d481716b97..2939454c8a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5539,7 +5539,9 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
 int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
-    if (el <= 1) {
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+
+    if (el <= 1 && (hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
         bool disabled = false;
 
         /* The CPACR.ZEN controls traps to EL1:
@@ -5554,8 +5556,7 @@ int sve_exception_el(CPUARMState *env, int el)
         }
         if (disabled) {
             /* route_to_el2 */
-            return (arm_feature(env, ARM_FEATURE_EL2)
-                    && (arm_hcr_el2_eff(env) & HCR_TGE) ? 2 : 1);
+            return hcr_el2 & HCR_TGE ? 2 : 1;
         }
 
         /* Check CPACR.FPEN.  */
@@ -11263,8 +11264,6 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
-    int fpen;
-
     /* CPACR and the CPTR registers don't exist before v6, so FP is
      * always accessible
      */
@@ -11292,30 +11291,34 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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
2.17.1


