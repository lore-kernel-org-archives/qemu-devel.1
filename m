Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076FFECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A4B2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWqvcsHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A4B2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLB02-0002Co-U7
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 14:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAro-00014m-Cj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArn-0000qo-0d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:20 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLArm-0000qN-RV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:18 -0400
Received: by mail-pg1-x543.google.com with SMTP id 23so1869079pgk.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wk2rFtSmeyIzF6QnNFgZDZnR49h41R/PQfqDCLolPT8=;
 b=LWqvcsHxCL65vPcrjAt9j3r+wBkdpmSzYoL2h9szRSUzTBmvhxItK3wEP1Y3hiDrZ4
 Ri2X3uv8zNDoQBF2wYvWWRjDdEm8z2loF8BG5+8wncW2TBgsth+x+JLUT7bi79woGQKX
 qKcnyd1AA+vgf733RPz+rTVtAT1Xso3cMWQX+746L518nQJs60I6w4ypj8k/g8+cRS/C
 dO7VJJQjLbJVJTW2PbLqORcHgmDHeRtD3GGZCQpmiY+4za32dOlg1J621ljLKQNBcy+R
 +nf3DLxCK4HbhTC6HUxLQYm//M2nXNnGuf0JTnDBGhbW2HKw/PgJRowZ8KR+dpjfKEXJ
 gNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wk2rFtSmeyIzF6QnNFgZDZnR49h41R/PQfqDCLolPT8=;
 b=ZoINyZs9iVFggOk7F+NAmjjKS/Innwxt2ZZKfyWXxeY2PeSvEIbxZDuj6LLZE0Q7bk
 No446jn5rORvr73NeV6k4RCmVJHCh3OBhQjCTJYqV1wqhw+ZfEW3SVHjSMVZTUGNHTdh
 z8qfwrlhsroXWGYDTKL+eK4vg9GLopKjtYd0By3OWSHttlUZvjzddjqlgNcDjJeeKlMN
 BPm4PjO3wnaoAZ5DHXVaOwMtuJoOJxGV+Ceva9XctKD4H+lVShNYtuqkR3iJYOc5h8rS
 eiuW4LcMVRo5RLcSRhfEYDYKezB4U9xZ/0QciuohGpoyj+A9suGakX3OkdP8ERoDc9JG
 fpvw==
X-Gm-Message-State: APjAAAVbp3h/4xKVfuuAvdr8hGOQ227fGFJK51ZVM92E7bkcIIQDRNJF
 KQ3XtM4km11YuTvnnzJ0y2kTvCrW0N4=
X-Google-Smtp-Source: APXvYqyQDeMqLHxb9SSEJcEumuUKVLfJr0DEnKt+Q/TjXDr4T19kZXCs9p+Wy3UTXWGatLMZO69Rgg==
X-Received: by 2002:a17:90a:b292:: with SMTP id
 c18mr6168103pjr.4.1571338277438; 
 Thu, 17 Oct 2019 11:51:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/20] target/arm: Split arm_cpu_data_is_big_endian
Date: Thu, 17 Oct 2019 11:50:54 -0700
Message-Id: <20191017185110.539-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Set TBFLAG_ANY.BE_DATA in rebuild_hflags_common_32 and
rebuild_hflags_a64 instead of rebuild_hflags_common, where we do
not need to re-test is_a64() nor re-compute the various inputs.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 49 +++++++++++++++++++++++++++------------------
 target/arm/helper.c | 16 +++++++++++----
 2 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ad79a6153b..4d961474ce 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3108,33 +3108,44 @@ static inline uint64_t arm_sctlr(CPUARMState *env, int el)
     }
 }
 
+static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
+                                                  bool sctlr_b)
+{
+#ifdef CONFIG_USER_ONLY
+    /*
+     * In system mode, BE32 is modelled in line with the
+     * architecture (as word-invariant big-endianness), where loads
+     * and stores are done little endian but from addresses which
+     * are adjusted by XORing with the appropriate constant. So the
+     * endianness to use for the raw data access is not affected by
+     * SCTLR.B.
+     * In user mode, however, we model BE32 as byte-invariant
+     * big-endianness (because user-only code cannot tell the
+     * difference), and so we need to use a data access endianness
+     * that depends on SCTLR.B.
+     */
+    if (sctlr_b) {
+        return true;
+    }
+#endif
+    /* In 32bit endianness is determined by looking at CPSR's E bit */
+    return env->uncached_cpsr & CPSR_E;
+}
+
+static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
+{
+    return sctlr & (el ? SCTLR_EE : SCTLR_E0E);
+}
 
 /* Return true if the processor is in big-endian mode. */
 static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 {
-    /* In 32bit endianness is determined by looking at CPSR's E bit */
     if (!is_a64(env)) {
-        return
-#ifdef CONFIG_USER_ONLY
-            /* In system mode, BE32 is modelled in line with the
-             * architecture (as word-invariant big-endianness), where loads
-             * and stores are done little endian but from addresses which
-             * are adjusted by XORing with the appropriate constant. So the
-             * endianness to use for the raw data access is not affected by
-             * SCTLR.B.
-             * In user mode, however, we model BE32 as byte-invariant
-             * big-endianness (because user-only code cannot tell the
-             * difference), and so we need to use a data access endianness
-             * that depends on SCTLR.B.
-             */
-            arm_sctlr_b(env) ||
-#endif
-                ((env->uncached_cpsr & CPSR_E) ? 1 : 0);
+        return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
     } else {
         int cur_el = arm_current_el(env);
         uint64_t sctlr = arm_sctlr(env, cur_el);
-
-        return (sctlr & (cur_el ? SCTLR_EE : SCTLR_E0E)) != 0;
+        return arm_cpu_data_is_big_endian_a64(cur_el, sctlr);
     }
 }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f05d042474..4c65476d93 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11061,9 +11061,6 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
     flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX,
                        arm_to_core_mmu_idx(mmu_idx));
 
-    if (arm_cpu_data_is_big_endian(env)) {
-        flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
-    }
     if (arm_singlestep_active(env)) {
         flags = FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
     }
@@ -11073,7 +11070,14 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
 static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
                                          ARMMMUIdx mmu_idx, uint32_t flags)
 {
-    flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+    bool sctlr_b = arm_sctlr_b(env);
+
+    if (sctlr_b) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, 1);
+    }
+    if (arm_cpu_data_is_big_endian_a32(env, sctlr_b)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
+    }
     flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
 
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
@@ -11122,6 +11126,10 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 
     sctlr = arm_sctlr(env, el);
 
+    if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
+    }
+
     if (cpu_isar_feature(aa64_pauth, env_archcpu(env))) {
         /*
          * In order to save space in flags, we record only whether
-- 
2.17.1


