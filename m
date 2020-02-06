Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD5C352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE43320659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHbekVXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE43320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izexl-0003cg-WD
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoT-0003DD-Ac
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoS-0007YN-2X
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoR-0007Pi-JB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:11 -0500
Received: by mail-wm1-x342.google.com with SMTP id b17so6491169wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RBZPzjgbWPxT7+atkMAWCoK503hCqnX1kOHSw+0786s=;
 b=PHbekVXTS5MzHz6FCdzB7ZbrIVefO8sdLFTN7brHwxokAAxObFOq1qdwklnpQZvolT
 w7/hzOTlCKWwP1at1lVyMGoJIeVeEIV8LTcN4Lb+9/lxZtcwa09dkWrlu4XblgNatPu7
 AVgFKKUSgNFyV3C44Ydbur5TplN0jnt1yClEgtPi7u7XhsUmwZno67R5V680Io7a0/Vf
 1YSa4L70P3oI6iDxTrZtfY/uWrm9Zf1E0/l9ZTnLwUrjyGM+G0awUBMKPGNEb3xb2Q5i
 z6CN/BDFJPaapNVMVSjhtLO+PC/1qCvtHcZ9tIftHNiT8OIfwx9TrG8ONsXBMddoD9aE
 VQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RBZPzjgbWPxT7+atkMAWCoK503hCqnX1kOHSw+0786s=;
 b=QpXPxVjDGkSZSRWLURnghU3wFO7wEXv0JYjEEGEvhluxDjlrdHC+LuCLVLKSZBFUJj
 9MXLkguTOrKdcsMFCadem1TOgOhl/lnDSZbV7cyXsXlaw0x0lBmdHefzWrZwgY9jDYKm
 wngTySwD7PT8inL/FGu3CaZAbWXz0EdM1urWM15zR5/lBgjFC687Tt9lavdIH2EvOWUJ
 QH0i8eYBnpu40bcjWl3Wq8uPlcO6S4W8CcRpzM7B8p38SFonw2XsIdhrrywixKjiJCHT
 5+jcQYRpMHz4tIZV2R6g0QTGK2WgNemmz9VCKcMJUNNE9iq1Y185GaLs9TOQY/bDSivV
 PHEg==
X-Gm-Message-State: APjAAAVcHyt1wvo9ycjzALQNiV8bYhX1CPvo0U3Q4Weezq20xmRsap9E
 9Gf6JP1ETaC+IS9STDEfFyYYB/UJdv8HWw==
X-Google-Smtp-Source: APXvYqySyuMC+mqTAgFnECmULrpYq8/gLzr60ph+m2uLhJcM12/bP6DWm4sMTuk9yhLx9uiobE/PtA==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr3748201wme.64.1580986509356; 
 Thu, 06 Feb 2020 02:55:09 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 23/41] target/arm: Update aa64_zva_access for EL2
Date: Thu,  6 Feb 2020 10:54:30 +0000
Message-Id: <20200206105448.4726-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

The comment that we don't support EL2 is somewhat out of date.
Update to include checks against HCR_EL2.TDZ.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e4f368d96b..e41bece6b5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4159,11 +4159,27 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                       bool isread)
 {
-    /* We don't implement EL2, so the only control on DC ZVA is the
-     * bit in the SCTLR which can prohibit access for EL0.
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_DZE)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TDZ) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TDZ) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     return CP_ACCESS_OK;
 }
-- 
2.20.1


