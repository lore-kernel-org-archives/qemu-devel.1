Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF96C43215
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72E6207DD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWhlzSTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72E6207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHHo-0001u2-GM
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH36-0002X2-Qf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH35-0006HX-IB
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:40 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH35-0006DQ-6w
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:39 -0500
Received: by mail-pf1-x444.google.com with SMTP id l22so2565838pff.9
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vu6ogLPsJVc9JMwH067ih3gg/dp3iZ1trwEWoF/7t8M=;
 b=yWhlzSTj6kVcbNTGlCIMl6monUDG4Ac9Td0llETvm0RevFBHmhK2x+Dp86EvPHIgE4
 IK4PmufTmN//ZgZzK4DkVJ8kH57ixQCHGR0zQ3l0+fAOV8g4Glq+pHSBnXQejIBtH1Js
 8B1d3shdJ+Xp3hmkC09ujmMZHrKXRj8ztL4S1RdZ4LmLOS/SLjEjw5+L+qaV2PoI23wX
 8elJCddzCrPJr5LMyE/iVQATVjRq3XJiBApczBlKpcenKZQQ674h7hT7EmLDovvWJMVo
 OBx4EpMCxhyjgDY4qvh9Hlsw2bbx5x9/rT2y737oMmxSPpqoP2MJq6cFdjDdIO0riT/z
 rCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Vu6ogLPsJVc9JMwH067ih3gg/dp3iZ1trwEWoF/7t8M=;
 b=QgpL78PfheZayRVx6kTOByQNbgK1AlNBpsBL3Fsp35fLb4z9eBz0d1WaP0Wkz8GvuJ
 Ew43QyHq9D0A6V2jKhWtOMkoyAv9NKZMdFFO7MZo15YlO+DChcOYkjmlBrRQ/uMmFXW2
 b7OpEXLQaozsxbpe/6vyY73G8Q0XCcCJs6DQ+bWla/RJECAt84kQy1gOIHLfH4XozP8R
 ymYwi2vvMq7lPWRDucwZUvUPqI/CyFe9x575tH2HYhr+zHeLaV22Retw/nqgzfGlTEvG
 faQO6DTEyuYKUAl/Rw/7Ziho6+MyYGftygpALl56zRFybMwAt9ZcaCFymQ1KPPUz+44p
 1Xnw==
X-Gm-Message-State: APjAAAX/Zw8hOFixD0HMPfebtTveBQiVZRednmevYujEjlYJOV/0bt5K
 DyNgLhH3xDq5btLg8EGz654augUUiN8=
X-Google-Smtp-Source: APXvYqy89O23x/eC+YnGuksZRxhqnAZKKc8dl/r2bd4Tm09wkZ5QW3CLobuxgUexODgR40WZXzS0sA==
X-Received: by 2002:a62:4e4e:: with SMTP id c75mr308764pfb.144.1575413617804; 
 Tue, 03 Dec 2019 14:53:37 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] target/arm: Add arm_mmu_idx_is_stage1
Date: Tue,  3 Dec 2019 14:53:24 -0800
Message-Id: <20191203225333.17055-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

Use a common predicate for querying stage1-ness.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 11 +++++++++++
 target/arm/helper.c    |  8 +++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 49dac2a677..850f204f14 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1034,6 +1034,17 @@ static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
 #endif
 
+static inline bool arm_mmu_idx_is_stage1(ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /*
  * Parameters of a given virtual address, as extracted from the
  * translation control register (TCR) for a given regime.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f3785d5ad6..fdb86ea427 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3212,8 +3212,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         bool take_exc = false;
 
         if (fi.s1ptw && current_el == 1 && !arm_is_secure(env)
-            && (mmu_idx == ARMMMUIdx_Stage1_E1
-                || mmu_idx == ARMMMUIdx_Stage1_E0)) {
+            && arm_mmu_idx_is_stage1(mmu_idx)) {
             /*
              * Synchronous stage 2 fault on an access made as part of the
              * translation table walk for AT S1E0* or AT S1E1* insn
@@ -9159,8 +9158,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if ((env->cp15.hcr_el2 & HCR_DC) &&
-        (mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1)) {
+    if ((env->cp15.hcr_el2 & HCR_DC) && arm_mmu_idx_is_stage1(mmu_idx)) {
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         return true;
     }
@@ -9469,7 +9467,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
                                ARMMMUFaultInfo *fi)
 {
-    if ((mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1) &&
+    if (arm_mmu_idx_is_stage1(mmu_idx) &&
         !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
-- 
2.17.1


