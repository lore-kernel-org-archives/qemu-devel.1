Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48D0C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECC42184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSeP84tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECC42184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa5B-0006O3-C6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55101)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3V-0007qF-Lo
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3R-0005Vq-Ab
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:40 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3R-0005Bo-2u
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:37 -0400
Received: by mail-pf1-x441.google.com with SMTP id y15so14687201pfn.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PI1YJc5YjWIF6+6p2IKRfVxeRzTCt2ZI5L41svkHvyA=;
 b=fSeP84tgg7Nt0wuBvWuN/KQpTt+NTz1zkjNVBd1d3/FCcB8i9G9LUv5hKmDzTGf+/l
 M/Ql/nTcf+ezfkbd0nRUkAJKUv7I79M1qIBCiuEYuleNkay0p0g8NrEq6c8zTObCAYxC
 9OO0YS+Bo1g4/fr7yinlILJbiM7m78LUc5JpV3WYRixuVke8zZ8rdQPQg/1tiH5oe+AI
 8RGrudM75eeY5q/s4UekghhcRqIwMHqXxNdWAQf6oMM3dZxWqYEvGRanhkyfstnRePTo
 +F0AC23PirmkxNulrOUq6xnlxn8Om/mex1eHfiofKc6LCbBmiaPtUhTR7ciqxZqjW4xS
 a3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PI1YJc5YjWIF6+6p2IKRfVxeRzTCt2ZI5L41svkHvyA=;
 b=E86ariTWn1uVBbe0coIJlslHXDvEsdJKGwlvwEfgIupN3zyP2xSgBO+CJwoahPkIX5
 8Ln9HuQqTLbJcJBQHxobYQF6pK4U34qqn/dAm11ucTuFOEFBmygfvGWFbHb4ZNjVZs19
 vtL2WxUa7NBbg1rd/Fw4ZBgOdoqMztCOSoQ290YpTMWHyv8VrsN26klLR2AIaoM8ZHpO
 3jjR0Qvbmq9qZwEDAhRSd1bJ05/WnClQSEV7XdLyaVu0218H4WoP+5SS/X2OHqRXmTAy
 X1FyD3vA0grWfswmxjEqGRSMFN/Tr9LCUj6HcZmSa+6+MRzqTQXaPYEdZrK+TO8f0qVP
 jWHA==
X-Gm-Message-State: APjAAAW8i6VRxdABUQDLhURSAT4W5/vC1LzbQi+R4PVNqhoPPYnAwvGZ
 foO9QGn7tRFppMSH0muL6H/DwFowFPU=
X-Google-Smtp-Source: APXvYqwj1XYa6VYiOtBE5hhhScW1k2Gg7XxT6H4ND3GfGLm6kT+ev2d99uXVZ2lus+7onPtmOJKeOQ==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr29545532pgh.325.1563570229038; 
 Fri, 19 Jul 2019 14:03:49 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:19 -0700
Message-Id: <20190719210326.15466-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH for-4.2 17/24] target/arm: Update arm_mmu_idx
 for VHE
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This covers initial generation in arm_mmu_idx, and reconstruction
in core_to_arm_mmu_idx.  As a conseqeuence, we also need a bit in
TBFLAGS in order to make the latter reliable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  2 ++
 target/arm/helper.c | 42 +++++++++++++++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4b537c4613..7310adfd9b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3158,6 +3158,8 @@ FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
 /* Target EL if we take a floating-point-disabled exception */
 FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
 FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
+/* For A profile only, if EL2 is AA64 and HCR_EL2.E2H is set.  */
+FIELD(TBFLAG_ANY, E2H, 22, 1)
 
 /* Bit usage when in AArch32 state: */
 FIELD(TBFLAG_A32, THUMB, 0, 1)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2d5658f9e3..54c328b844 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11250,21 +11250,29 @@ int fp_exception_el(CPUARMState *env, int cur_el)
 
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
+    e2h = (env->cp15.hcr_el2 & HCR_E2H) != 0;
+    if (!arm_el_is_aa64(env, 2)) {
+        e2h = false;
+    }
+
     switch (mmu_idx) {
     case ARMMMUIdx_E0:
-        return ARMMMUIdx_EL10_0;
+        return e2h ? ARMMMUIdx_EL20_0 : ARMMMUIdx_EL10_0;
     case ARMMMUIdx_E1:
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
@@ -11292,24 +11300,28 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 
 ARMMMUIdx arm_mmu_idx(CPUARMState *env)
 {
+    bool e2h, sec;
     int el;
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
+    sec = arm_is_secure_below_el3(env);
+    e2h = (env->cp15.hcr_el2 & HCR_E2H) != 0;
+    if (!arm_el_is_aa64(env, 2)) {
+        e2h = false;
+    }
+
     el = arm_current_el(env);
     switch (el) {
     case 0:
-        /* TODO: ARMv8.1-VHE */
+        return sec ? ARMMMUIdx_SE0 : e2h ? ARMMMUIdx_EL20_0 : ARMMMUIdx_EL10_0;
     case 1:
-        return (arm_is_secure_below_el3(env)
-                ? ARMMMUIdx_SE0 + el
-                : ARMMMUIdx_EL10_0 + el);
+        return sec ? ARMMMUIdx_SE1 : ARMMMUIdx_EL10_1;
     case 2:
-        /* TODO: ARMv8.1-VHE */
         /* TODO: ARMv8.4-SecEL2 */
-        return ARMMMUIdx_E2;
+        return e2h ? ARMMMUIdx_EL20_2 : ARMMMUIdx_E2;
     case 3:
         return ARMMMUIdx_SE3;
     default:
@@ -11421,6 +11433,14 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX, arm_to_core_mmu_idx(mmu_idx));
 
+    /*
+     * Include E2H in TBFLAGS so that core_to_arm_mmu_idx can
+     * reliably determine E1&0 vs E2&0 regimes.
+     */
+    if (arm_el_is_aa64(env, 2) && (env->cp15.hcr_el2 & HCR_E2H)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, E2H, 1);
+    }
+
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
      *  SS_ACTIVE   PSTATE.SS   State
-- 
2.17.1


