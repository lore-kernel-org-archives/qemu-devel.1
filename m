Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64921C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4C32087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAYOiJWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4C32087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzEu-00057K-Dv
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32810)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4z-0006f5-0D
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4x-0007LB-QF
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4x-0007Kd-Ko
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id o13so37653202pgp.12
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=990oq3Jk2iwM+tnufP71c3BjXCbJEu9Ritd8u64nkfc=;
 b=QAYOiJWrEQohdb0ezaHo0wG2XvNgh80GWi42I6kfRjO7WMPazyDP9i06wrRYddoSmU
 uyWtoHoeIPKeWz96c/rCKqO39n5zTWue5SNHTTkA1XC6iG+6ZOMSqHc+Jnt2jYSObR7g
 4LCzxJW17ZhlCD8D5oiuCWB++EnKAFLT0MCCHTQ+3lXrIzhAwhnQWkynvvh7ui4Hmnde
 slOiqtQA0ZYhfC0IX1XsB3XRFp5NRnCg3KJ/ArwUzKqCT7DWx7qNFsZULQdA0t2qb0o3
 EwS5cLkpEZI6NqR2ovZNEd7H5962ZgpoL+IfwuIZp3XjH5BIC+RWyRx9hNIhqiqG5jbB
 njkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=990oq3Jk2iwM+tnufP71c3BjXCbJEu9Ritd8u64nkfc=;
 b=VGySwlEc4wi9KEzw61M/+cQywbEx75V8t/0C0EITqPEwSJKu1loUXtsXh8W0k4UC4U
 Erb3wbtld31694AUu3NfhkPjWL1yiQ0PsOQJHMvgx9dDvSYvKf469kvIK+eAlU+5kwVJ
 XEln+4P+Mq7xKVWmVVik0eXT7FNhETAPTNApby+txaraJErmAvNzPiMQQIEqs2w9X0bz
 Ts7QtQ7FfON8INmoOY/j+lgiAkCDKb2lL8Hk30uFzHWC3L4Cfq8rQY00NmRVoaC1e4Wu
 4AUPwoGCqTkZprpZDt8dHreYTmuy2OErHAeFtpUWKgVEdsmi9TDOV8hM7b4WfUkauR/D
 51lA==
X-Gm-Message-State: APjAAAVU9CqPYgJEGYA3gZYS6A6GzSC80EBKj6PlbpyL6oYuDOyUMUmV
 6RCp3AOpgHL1okvGhyQAaXMV4yE+6Zs=
X-Google-Smtp-Source: APXvYqwhG6VHzfES0jWWi8+IF7AlBXj5dQ588Do/GJ4ibhrfMcKk9x05R7KxkIdGCGEbm/v8yQ3G6g==
X-Received: by 2002:a17:90a:9bc5:: with SMTP id
 b5mr10473944pjw.109.1564858110427; 
 Sat, 03 Aug 2019 11:48:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:49 -0700
Message-Id: <20190803184800.8221-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 23/34] target/arm: Update arm_mmu_idx for VHE
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

Return the indexes for the EL2&0 regime when the appropriate bits
are set within HCR_EL2.  This happens for initial generation in
arm_mmu_idx, and reconstruction in core_to_arm_mmu_idx.

In order to make this reliable, we also need a bit in TBFLAGS.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Consistently check E2H & TGE & ELUsingAArch32(EL2).
---
 target/arm/cpu.h    |  2 ++
 target/arm/helper.c | 51 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b5300f9014..8d90a4fc4d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3153,6 +3153,8 @@ FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
 /* Target EL if we take a floating-point-disabled exception */
 FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
 FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
+/* For A profile only, if EL2 is AA64 and HCR_EL2.<E2H,TGE> == 11 */
+FIELD(TBFLAG_ANY, E2H_TGE, 22, 1)
 
 /* Bit usage when in AArch32 state: */
 FIELD(TBFLAG_A32, THUMB, 0, 1)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5472424179..a570d43232 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11257,21 +11257,31 @@ int fp_exception_el(CPUARMState *env, int cur_el)
 
 ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
 {
+    bool e2h;
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         return mmu_idx | ARM_MMU_IDX_M;
     }
 
     mmu_idx |= ARM_MMU_IDX_A;
+    if (mmu_idx & ARM_MMU_IDX_S) {
+        return mmu_idx;
+    }
+
+    /*
+     * All remaining states are non-secure, so we can directly
+     * access hcr_el2 for these two bits.
+     */
+    e2h = (env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)
+          && arm_el_is_aa64(env, 2);
+
     switch (mmu_idx) {
     case 0 | ARM_MMU_IDX_A:
-        return ARMMMUIdx_EL10_0;
+        return e2h ? ARMMMUIdx_EL20_0 : ARMMMUIdx_EL10_0;
     case 1 | ARM_MMU_IDX_A:
         return ARMMMUIdx_EL10_1;
     case ARMMMUIdx_E2:
-    case ARMMMUIdx_SE0:
-    case ARMMMUIdx_SE1:
-    case ARMMMUIdx_SE3:
-        return mmu_idx;
+        return e2h ? ARMMMUIdx_EL20_2 : ARMMMUIdx_E2;
     default:
         g_assert_not_reached();
     }
@@ -11300,25 +11310,27 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 ARMMMUIdx arm_mmu_idx(CPUARMState *env)
 {
     int el;
+    bool e2h;
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
     el = arm_current_el(env);
+    if (el == 3 || arm_is_secure_below_el3(env)) {
+        return ARMMMUIdx_SE0 + el;
+    }
+
+    e2h = (env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)
+          && arm_el_is_aa64(env, 2);
+
     switch (el) {
     case 0:
-        /* TODO: ARMv8.1-VHE */
+        return e2h ? ARMMMUIdx_EL20_0 : ARMMMUIdx_EL10_0;
     case 1:
-        return (arm_is_secure_below_el3(env)
-                ? ARMMMUIdx_SE0 + el
-                : ARMMMUIdx_EL10_0 + el);
+        return ARMMMUIdx_EL10_1;
     case 2:
-        /* TODO: ARMv8.1-VHE */
-        /* TODO: ARMv8.4-SecEL2 */
-        return ARMMMUIdx_E2;
-    case 3:
-        return ARMMMUIdx_SE3;
+        return e2h ? ARMMMUIdx_EL20_2 : ARMMMUIdx_E2;
     default:
         g_assert_not_reached();
     }
@@ -11428,6 +11440,17 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX, arm_to_core_mmu_idx(mmu_idx));
 
+    /*
+     * Include E2H in TBFLAGS so that core_to_arm_mmu_idx can
+     * reliably determine EL1&0 vs EL2&0 regimes.
+     */
+    if (arm_el_is_aa64(env, 2)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            flags = FIELD_DP32(flags, TBFLAG_ANY, E2H_TGE, 1);
+        }
+    }
+
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
      *  SS_ACTIVE   PSTATE.SS   State
-- 
2.17.1


