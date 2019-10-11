Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E052CC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE91206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtpZUPFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE91206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxQk-0005JT-Dz
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGs-0002VV-Qj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGq-0007hf-Ov
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:02 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:41915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGq-0007hG-L1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:00 -0400
Received: by mail-yb1-xb41.google.com with SMTP id 206so3252987ybc.8
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v9G2/VGbpNHx6eaShg3TTMn08v+y+t3OtnZPnrlHvrg=;
 b=XtpZUPFp3W08t1JaA8a0gwAlWG96mYwUetMWaaiCpy9HSMGo6QV8Fw4jCrEVvggsQB
 vF6tZAvtgIjUmkKmbloMxKxEwZM+b4X7siCA2C/P6Wor8sBPopZKILt6LAi2M7orgBmA
 2mfelbVM/AnO9nLlQEHhbWZlpfYUnKKMnRQ6UKhWRHaDbEidF6hjN9nfFBoJkhVcgvQE
 Ko5O0LeKsAfm2iPhsWrYpS6xC0wvihOaWT6hfwaiozzUWpQIHrgTI2vltkYROdOYrrKT
 EeJvYM/7yT6M4yHRnCgT9yo7MK1v/PpBwx5xBdIjHwpX8E2XnnzB8AFCMfstHTje3FXA
 Htuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v9G2/VGbpNHx6eaShg3TTMn08v+y+t3OtnZPnrlHvrg=;
 b=Ke05nAS2missJZ2+cC6kQYuIWZhsJyTRuH3dCvdcZ/ElUTib9rPlldsYU8ScLQQ6Bf
 8rZyD2zQA8FoDB3KSeDRAflPJEHpNByDe8KtvIQuoXDNp1Nup2HqaFvYDjOnXxY4G2k0
 tQOjknwm56HfyTKQWf3kOpcZ9xHh4DP/loyFnYp9ntwgcdGjmb7xydrWyWrbqMNMyywz
 b3GyVTJ5y1WDUT+nWUXql9oUamuVSpZb2wxL7LzUJhE82n1wuPmgvnjU7B0qqJwXpJNB
 hxkSAKrUBv4V9ww9I2DGHyvDp1vZvztPd/+0acmXQ2wLOLSLRfljZljzgyna2x87PqyV
 ncQg==
X-Gm-Message-State: APjAAAWfMFKVuIlzzghLYKTS1gY9p1638yLG2CvO5Lp5/my7mzdYLAUM
 Q2EXFsb53nZRKChQpDxLDu7WSMuLAtE=
X-Google-Smtp-Source: APXvYqwpOTFvLbqsFlG+OSKfbCqn7ZzcOHOU7e6QvdMQi4A9DPe4yTn/CyOn6uPt9MSafECxPyUAxw==
X-Received: by 2002:a25:80c1:: with SMTP id c1mr10793698ybm.195.1570809359625; 
 Fri, 11 Oct 2019 08:55:59 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:55:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/20] target/arm: Simplify set of PSTATE_SS in
 cpu_get_tb_cpu_state
Date: Fri, 11 Oct 2019 11:55:36 -0400
Message-Id: <20191011155546.14342-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hoist the variable load for PSTATE into the existing test vs is_a64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2a62cf19a..398e5f5d6d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11197,7 +11197,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags;
+    uint32_t flags, pstate_for_ss;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11205,6 +11205,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
+        pstate_for_ss = env->pstate;
     } else {
         *pc = env->regs[15];
 
@@ -11257,9 +11258,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
+        pstate_for_ss = env->uncached_cpsr;
     }
 
-    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
+    /*
+     * The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
      *  SS_ACTIVE   PSTATE.SS   State
      *     0            x       Inactive (the TB flag for SS is always 0)
@@ -11267,16 +11270,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
      *     1            1       Active-not-pending
      * SS_ACTIVE is set in hflags; PSTATE_SS is computed every TB.
      */
-    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE)) {
-        if (is_a64(env)) {
-            if (env->pstate & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        } else {
-            if (env->uncached_cpsr & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        }
+    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE) &&
+        (pstate_for_ss & PSTATE_SS)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
     }
 
     *pflags = flags;
-- 
2.17.1


