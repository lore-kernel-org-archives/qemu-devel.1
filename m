Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44E5CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5C62064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gg4OUCU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5C62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIm3-00018F-Da
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8y-0008Gr-5j
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-0001GN-Ma
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:47 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-000114-FR
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: by mail-qt1-x843.google.com with SMTP id e14so12964116qto.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mDaUYtXyoxKyQ6YIW+CzLKUl72EI9Ve9jhEUulKMydM=;
 b=Gg4OUCU0+YuFSqTxloUy7xv2L7XQ97PXUiiSXzc3OEJN69plKDFY10+lNGtEh/JgPh
 2gmFn56lZzKeCyS4HAQycasM59zb1a6NxSRcubR8fqEHDm8F7sgbUtucEhIWaWQ1cREK
 mbgfkVLrGz6CW3a24YoMkuFJlYIBldjwFt9iuI8u5mPONaSl9QLHwN3H3dFwuaUqVrxL
 nXa2tlQ+h6wh9JrHlGX1dpnvCma4z4lsyr1vr1MpMaBssLlWX512qydTq0QD30cc5X+S
 qMnzKA+fnXAhu+OX4xs8gxUFzlzOhtevyK4NnhzOE71A2tK4DR9fm2nRQNZMKFja+tSw
 3Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mDaUYtXyoxKyQ6YIW+CzLKUl72EI9Ve9jhEUulKMydM=;
 b=gP21xiRv+OmRei96pqjO851HIKDb8TE0MOQ3+3WFqUeGUA7nz20BGyneCuMD98Oy8u
 XsDD/WzJijAOZmifLqTTlSBTWt1MQeMQtoS5EysaMe9vwubxo/IUWGyq3a/H8jvONh3P
 ZOSt3C/XRK10dfH2v59kI05r8iBkZmlz1SiZV8hARdY7KbiqOnz+29eKyZfFvw36AD9J
 EOGaVzoXuBII8/mleibOjHYGY2B57wzESbpqg9bil711/RA3yXDeJSqDv5MTMDQPigN/
 me3jMQxCH+DaERMp6hpPkWr/IQFnCzxW8C3b0dvYWPZiTqxdw4o60vgvsN3o3slvoRN/
 /zLA==
X-Gm-Message-State: APjAAAX4cvKa6d6XZebpmVNPXdD9MlxbIUa07bKYCEAkTraoVq9zGHVD
 04MZoHgvk/bsFZwKvz37R3iRULVvQqU=
X-Google-Smtp-Source: APXvYqys8wHbq7bxQaP9EGhwpGtkYN0t1ZVGiyLNue4oAW5g+nfQyJ1gU4XubMIS4hLPOAIFyCWOdg==
X-Received: by 2002:ad4:51cb:: with SMTP id p11mr5186448qvq.81.1571842869476; 
 Wed, 23 Oct 2019 08:01:09 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 05/24] target/arm: Split out rebuild_hflags_m32
Date: Wed, 23 Oct 2019 11:00:38 -0400
Message-Id: <20191023150057.25731-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a function to compute the values of the TBFLAG_A32 bits
that will be cached, and are used by M-profile.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4c65476d93..d4303420da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11083,6 +11083,29 @@ static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    uint32_t flags = 0;
+
+    if (arm_v7m_is_handler_mode(env)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
+    }
+
+    /*
+     * v8M always applies stack limit checks unless CCR.STKOFHFNMIGN
+     * is suppressing them because the requested execution priority
+     * is less than 0.
+     */
+    if (arm_feature(env, ARM_FEATURE_V8) &&
+        !((mmu_idx & ARM_MMU_IDX_M_NEGPRI) &&
+          (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
+    }
+
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11168,7 +11191,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     } else {
         *pc = env->regs[15];
-        flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            flags = rebuild_hflags_m32(env, fp_el, mmu_idx);
+        } else {
+            flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+        }
+
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
@@ -11204,20 +11233,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
-    if (arm_v7m_is_handler_mode(env)) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
-    }
-
-    /* v8M always applies stack limit checks unless CCR.STKOFHFNMIGN is
-     * suppressing them because the requested execution priority is less than 0.
-     */
-    if (arm_feature(env, ARM_FEATURE_V8) &&
-        arm_feature(env, ARM_FEATURE_M) &&
-        !((mmu_idx  & ARM_MMU_IDX_M_NEGPRI) &&
-          (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
-    }
-
     if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
         FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) != env->v7m.secure) {
         flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
-- 
2.17.1


