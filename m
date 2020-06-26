Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5232EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9A8206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmN9zkoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9A8206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofKr-0002oE-Bq
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6A-0000Ei-0y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:18 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:47098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof68-0001uu-9o
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:17 -0400
Received: by mail-pf1-x42e.google.com with SMTP id b16so4033136pfi.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zif4Iu0ibSPdlekVkL/Ps4sAAAkBV8vgNAczaYynkk8=;
 b=bmN9zkoX/l7EMd2DZFwP78WH/jHAepb6WNBwh2TkCHdvpekI0TuM409yE6cN8NRlrt
 Fhwwb2qqx10va8+PM9UsKSY5lDbKRQvjyhxtLDf9D4ipfADhFUqqHgBLWsuUt/JjM+p4
 I/7fEFJc+UQaejai0lHJ9DVDhe2MCzVXAE3RnqkTloInu1iD2N/8Mi/IYlF55c9R11lO
 8LnsvwgdYu60r4/yraO4ZatdsJBMhoNX0A2iHcJfrnWEcdDUbmZs0acZenxEqYKCORW8
 oFht5mSXfBgFslbvPvLnEdJN6H/Svllv0QQWcarxkJvhVwJqX13TlG5/QbnxQHhiPPhs
 N+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zif4Iu0ibSPdlekVkL/Ps4sAAAkBV8vgNAczaYynkk8=;
 b=IsLXAIW8aHorytRfhV8FB1NQrb6/cxlPboWtL6gxHCqq4hDpPDAUyLYxFnSKfsohax
 g+pNyWu/sSuJRzwdnEtycyssSzPfVKJmepbeP8ePvNlHaRLALq5LfQejuRcVsRjGSh5L
 j8XaWGg434gnR3DThEXNEAN7ZfGVWlUNh0pxXsAynqPvG4lxFB6irUszDQs4zLy/IeaE
 QnqnB4kCHFqbu/CwZl6nz5RugSItzuqhz+kVJSUV75HemEm4/Ig1gAZuZvjj4FhFZ48M
 tSvNJTdMX8jdeS6k/TRdvb9erG+6iYto+GVDhZRSgH79vCSrbw4YILhoju90OLdtUBYi
 ycxw==
X-Gm-Message-State: AOAM531jKR7LeLjYDhEH4uPFEd3jEoo36XTDfLdOPDM+X3TIiDfUWN8p
 8fmYuNcu0h7angIS45ne5AfMIaNv07E=
X-Google-Smtp-Source: ABdhPJzj7cp+oLDyQjvHiyRDTlK7I1VHDBBkjuNuefW8k1uSPO/mrHk4+C/iM8hO+f+Nu1U4uF49dw==
X-Received: by 2002:a62:7883:: with SMTP id t125mr841219pfc.59.1593142334529; 
 Thu, 25 Jun 2020 20:32:14 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 21/46] target/arm: Move regime_el to internals.h
Date: Thu, 25 Jun 2020 20:31:19 -0700
Message-Id: <20200626033144.790098-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will shortly need this in mte_helper.c as well.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/helper.c    | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5c69d4e5a5..c36fcb151b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -913,6 +913,42 @@ static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+/* Return the exception level which controls this address translation regime */
+static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_Stage2:
+    case ARMMMUIdx_E2:
+        return 2;
+    case ARMMMUIdx_SE3:
+        return 3;
+    case ARMMMUIdx_SE10_0:
+        return arm_el_is_aa64(env, 3) ? 1 : 3;
+    case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
+    case ARMMMUIdx_MPrivNegPri:
+    case ARMMMUIdx_MUserNegPri:
+    case ARMMMUIdx_MPriv:
+    case ARMMMUIdx_MUser:
+    case ARMMMUIdx_MSPrivNegPri:
+    case ARMMMUIdx_MSUserNegPri:
+    case ARMMMUIdx_MSPriv:
+    case ARMMMUIdx_MSUser:
+        return 1;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Return the FSR value for a debug exception (watchpoint, hardware
  * breakpoint or BKPT insn) targeting the specified exception level.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d8c31d03da..d14313de66 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9793,42 +9793,6 @@ void arm_cpu_do_interrupt(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-/* Return the exception level which controls this address translation regime */
-static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-    case ARMMMUIdx_Stage2:
-    case ARMMMUIdx_E2:
-        return 2;
-    case ARMMMUIdx_SE3:
-        return 3;
-    case ARMMMUIdx_SE10_0:
-        return arm_el_is_aa64(env, 3) ? 1 : 3;
-    case ARMMMUIdx_SE10_1:
-    case ARMMMUIdx_SE10_1_PAN:
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_MPrivNegPri:
-    case ARMMMUIdx_MUserNegPri:
-    case ARMMMUIdx_MPriv:
-    case ARMMMUIdx_MUser:
-    case ARMMMUIdx_MSPrivNegPri:
-    case ARMMMUIdx_MSUserNegPri:
-    case ARMMMUIdx_MSPriv:
-    case ARMMMUIdx_MSUser:
-        return 1;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 uint64_t arm_sctlr(CPUARMState *env, int el)
 {
     /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
-- 
2.25.1


