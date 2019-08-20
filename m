Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B984C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EB622DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jN7XTRkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EB622DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BSe-0007EI-Sv
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLs-0000Gu-U6
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLo-0008Qn-9V
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:33 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLn-0008PO-Le
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:32 -0400
Received: by mail-pg1-x543.google.com with SMTP id p3so5139pgb.9
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=q1Zy0h8c3J4D30AFqGiFYUkCGaChDdqpfUNuVmWLPgM=;
 b=jN7XTRkfRBVPUpHW/tfohU5SfFaGZUq6eh1Dz11xAiHA3EZLmzD3JG1tVdp9kNpY4s
 7iYxabCwzS5xw2bAdWowKbwPiCcCjGK83zfTzBkP3g1rBQm2DW32ZJUm7eH0kb9a55+H
 HBglPPUKviN8JBvv2O/Nh2hE5/GLSIO26zocAdsm1YeSiQ1K0xODeodUpjVL0dfW+YtO
 Zv9+XZsBa2KWnZASn1BMq7G8ooDAvpMqRWMdTNStrvTWkxKh+2YglH1dioxBfLscYCgF
 E1w2+lG2Jdbh8l5rj8NLX9/SdXaGTKp9okMsfyp6UVoRAXZZeqRhIEf2RloiEkI0bS24
 n5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=q1Zy0h8c3J4D30AFqGiFYUkCGaChDdqpfUNuVmWLPgM=;
 b=UMECAMIYujVfePngteoTfSby5embpuqQ/gw+mnOSs5wYs9CBlc6zf44tDPAy0PJOnF
 gOStEujpZcp+4CvTxQnbGjL4SYYKg+DLKVmg1sNdcwc/kU/+tSfeOc05wbz5t0fr23Yf
 HiQw233Rtr50XsfAUhKZsHukTWLY352HdjLdENt2lGq0x0buG9Qw9+ofap0Gx9yKoaph
 uTUBLb4hk86z2GxOBeHPA15mHgTCgqifIwtuUJ8E2dlr8O497ygJ2nMc0qDYusjxWATv
 9S1ZMs1+TxVIqBrH2wjXfdEw02fbsfOEO4U8EvVgCp4yTAaDNxGB66Ub+tCPZuRKkdrz
 N1KQ==
X-Gm-Message-State: APjAAAXjGw96SjcnSmzUSLrxWzlR5k4Jco+yEdqeMLrfdz9L+3jkIgEQ
 RkP5Kxje2ILvC7DG7rfoumBhmg15ZP0=
X-Google-Smtp-Source: APXvYqzV65hMndSONwtC1jVcogCGF5rK5UGArUTcDswWhbPJAR7cyvUbH1MbXOQd/J/cMARyY412Kg==
X-Received: by 2002:a63:d84e:: with SMTP id k14mr26449715pgj.234.1566335249619; 
 Tue, 20 Aug 2019 14:07:29 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:08 -0700
Message-Id: <20190820210720.18976-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v5 05/17] target/arm: Split out
 rebuild_hflags_m32
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6570d7e195..c36ec6c530 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11045,6 +11045,29 @@ static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
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
@@ -11130,7 +11153,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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
@@ -11166,20 +11195,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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


