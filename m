Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C04DC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537E12332A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZd0p26a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537E12332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BTJ-0007yN-0X
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BM0-0000JQ-LZ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLz-0000AC-9l
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:44 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLz-0008Vv-0r
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:43 -0400
Received: by mail-pg1-x541.google.com with SMTP id n4so24215pgv.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+UTATQdJP366blpEIT1qjPbjVC5kfEMHdA4PBzrTe/4=;
 b=dZd0p26aPDnKIpfWcl4MFBr6FX/sKYvncmZi2JgsTDMkrRfV4NEXQJYSR8PFBsGnQB
 FSNeCOVE70BLpODW+UpoVTVA4HfP77YyC9jhZk1WiIx1m94Rrlg9zHg+phPdS/0NCBKp
 y7ogiBN5y2iVD4ot9W4Obh0IEfHAaGTSW8JB3j+mI9Tqi304SmzosXyP5MU3qvsbuP6l
 mJEFlFUb6mV6qI8bCe5SHgOPDXeQanW2l50jlIBiZbWylvOtosfAkiXfP7hbDd/cv+yT
 MbUoIGE1BqieAFEWKiPY5+q7uPCJv/b71XjoM9gegW+CcnUWrQgjxA4LWTZ+Jb7w2f5N
 Z9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+UTATQdJP366blpEIT1qjPbjVC5kfEMHdA4PBzrTe/4=;
 b=pTbogCMM7l399b0nEOMIMxMxRnlr5AXyU/0gyuSv364e9p7rOHM3miugdl87+Tb/eh
 zENEnIGSEWQj50MRMk0QqrGw1LhPnjMSVHuYavAe7WjgUGtIy/1Rk6YCwgB6RVqezlW9
 AA5GjprE0uk3bFmUE6vVs9zu4itcgXVJBlPU7853UdYuRkg5MdAknrlcWD21Q/mrIJU2
 Sm2KDtDUzYtEtx61XZSNrrDpXJp3NZnTXsqoPuFnSSIsaXwiQthae3xrFZG+UTjxWuuy
 xTlCgNxaOPp0DT+7fsUcEkhI+DfFf6z0nDZSPWbEyXfm+HdMV8CknmP0tv+i83z0sg5l
 TwHg==
X-Gm-Message-State: APjAAAWy3GFx26L3GGcWSbD0l9KFHxQAtxS1Qjrv68jY4W4rz7vC5Q0e
 laADqCf8Vjn/riniYJwqiXjdCbYKEvY=
X-Google-Smtp-Source: APXvYqyhokL/aaCXF9uKqlCLGWDyPTH4EEgO2sq6f0dAQOIGuS15spyKHNjCd8LmstxQOEiRr1pqRA==
X-Received: by 2002:aa7:91d3:: with SMTP id z19mr31940123pfa.135.1566335256425; 
 Tue, 20 Aug 2019 14:07:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:13 -0700
Message-Id: <20190820210720.18976-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v5 10/17] target/arm: Simplify set of PSTATE_SS
 in cpu_get_tb_cpu_state
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

Hoist the variable load for PSTATE into the existing test vs is_a64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3889b9295a..c01b3027e0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11159,7 +11159,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags;
+    uint32_t flags, pstate_for_ss;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11167,6 +11167,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
+        pstate_for_ss = env->pstate;
     } else {
         *pc = env->regs[15];
 
@@ -11219,9 +11220,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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
@@ -11229,16 +11232,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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


