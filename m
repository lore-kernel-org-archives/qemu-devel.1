Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D791C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A78206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZhrTj5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A78206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxXo-0006ZG-V7
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCU-0004Bs-Od
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCT-0008Gs-KR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:50 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCT-0008CE-Ci
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:49 -0500
Received: by mail-pj1-x1043.google.com with SMTP id r67so508014pjb.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B70lUsejZyqB+eYbfOUUmwYftosrBwYUJeBX3Yctqno=;
 b=nZhrTj5CPpy36/NRxqphTe4VNUA/eJa7SViOdyFJCCyd9AvP9m/dJkslUcXh30bfqR
 JJmburJ2oPLq5uz8qm41dTKXf+zbsBwxmrA1EOPWv9qD2pfLmvDmzHc6dv1BLAHJGVdM
 pVMlSg0lDbwof3d5e/470xPAovxcY9Tqodirts/GaN32+qIWNNLKgup5c3KLgm4YrIFr
 gMn+Eab8Ljj2wVuogOWFXrHi+bb0IBP/jTPAwWKS9XUeshb4cEwcOTNiqKEDm9Fsol8L
 Q+KWPSTJFTsitVUuuQhZkMLEY9m92dnl5mouexOzFrCfgiL5pRwLCq+WmZ0h/VBrftiq
 xneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B70lUsejZyqB+eYbfOUUmwYftosrBwYUJeBX3Yctqno=;
 b=PdepMMr94l5Ql9FKAOjLdqozhZYpRZii/2SqVi+tVTMoXOf5oi1Udx9RyF1fXhrNWD
 sQX1zDsMEZRQtQ87gfR/uBlKVn9/aL4nDJLKqwsrD9QvyEsCBz8E/j5OLTB31vVAv3d6
 lke7lt1g5AXYYYhyX7IfboVXsyUjPuasq7SXHz6SIlfrzxI9wDZgW+9dnUbRY87XX4c6
 7nVsMr41j0sLufTa8QhvYDxAGHMmDsz6zb6Y6qMSICPPvuVfu6guyYolkfPOXVaaOVyj
 CDJ9eNKx6EkRiRO3Nq4vnt2V4xckgCUayY9+m1VRIDFbuWRN3Ys4NUfk3tAODPXcgyNP
 dMIA==
X-Gm-Message-State: APjAAAXwsKu0UptgEKigV5UoYwpDhOVXxWV8yVSe4mwKZqiaSjNnkV3a
 ZEmCspB5a+x2kK6oqOqPl0nsRBraIHo=
X-Google-Smtp-Source: APXvYqx6CAdRF0wntfuI3zXREzfGM+To6EK4CWrN3cyvxKygOXC/1WXjv8WyJPYmRqp7tKzuTdpzvw==
X-Received: by 2002:a17:902:8ec9:: with SMTP id
 x9mr1953139plo.182.1580342206210; 
 Wed, 29 Jan 2020 15:56:46 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 24/41] target/arm: Update ctr_el0_access for EL2
Date: Wed, 29 Jan 2020 15:55:57 -0800
Message-Id: <20200129235614.29829-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to include checks against HCR_EL2.TID2.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 33f4cbbc64..e79237ea12 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5264,11 +5264,27 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
 static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
-    /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
-     * but the AArch32 CTR has its own reginfo struct)
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TID2) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TID2) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
 
     if (arm_current_el(env) < 2 && arm_hcr_el2_eff(env) & HCR_TID2) {
-- 
2.20.1


