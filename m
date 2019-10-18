Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEAACA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2819121835
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlSNcfVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2819121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWM1-0000Mu-Sk
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWIp-0006P9-O4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWIn-0005M1-ST
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWIn-0005Kq-NG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:37 -0400
Received: by mail-pl1-x642.google.com with SMTP id c3so3197440plo.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+UgAJ6EhcwGdb7pezBRTrZ79eaC+NjRs0dqrTWfzTFo=;
 b=XlSNcfVErnQtom0GJDyUW051sL+xfl4993QiT/Izb3Ol9gNuFHuxiuVohqlNjAQ+OE
 zXTrPvaoTrd+PB4iEhEdvRrzMcFTRnYLYMvd5OdGWpKewCpDx7vOnAvEjHALLuEMdq3i
 g6oSmw8JPpnS+/K+u1RMC/xBpSnx97gWZcPom0ZoQLCVgJKOjyOjVMwd9ypsfFEBJn/2
 iaF5Qn636yH/0x/patzvI1XMGzC1SCr8enowIZazAXTH/ZNaOh5PiVCCs+dd5pdCbbQw
 ViRY0rdo6TLbmJNk9lJK5Py6vMUpXVQyh6LT96dCpTic4yT6UK4EwL/47GgqCz7SdR14
 w3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+UgAJ6EhcwGdb7pezBRTrZ79eaC+NjRs0dqrTWfzTFo=;
 b=AKEdytv+5qgdDQoaxmTwbAcb8xG18vxZoSRaJwgPnVTrDjPr9RdZ0xH+lFYN/AF/Zz
 tU7lvSDZj2+QLxNb0cQS4lw1v0avuwdxcUWPjFfoCnoU0TlNZpOOEeRb1PjFpJ2/WbZa
 Dnc1L7szYdIn4JP4NUZsxLxXvIL8tXB9zC+8SYMMibIQC6KM/xiczdJPurN27XRRDfM7
 IYssJCZOz2URPTrOtBBR1ACmVv4fiv4gEDlBXQYPawP21keKAljjm9r/tNXF1IibzuO+
 YOXg2YCU94Vm6vYzM08nVk13IyUV4PHbv3WCgSouGKVN5vqCb1Za5zvyNktYGo9Eylvn
 v6yg==
X-Gm-Message-State: APjAAAVNpcDb35aVrs/Fsh6Eh9S6L8u0Ya5rTDPLH4I2kBVGt7w6TqHt
 57+eujmHXjt+WoXuhXAQAh3ldYhrHao=
X-Google-Smtp-Source: APXvYqz69a4CPwAo0eTu6B9qVkn8iJX02uE+0/tfuJ3Th1Z1TuXKQnp+X1StAZNCFuh1g0l926LnYw==
X-Received: by 2002:a17:902:8507:: with SMTP id
 bj7mr10594199plb.73.1571420675884; 
 Fri, 18 Oct 2019 10:44:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 03/22] target/arm: Split out rebuild_hflags_common_32
Date: Fri, 18 Oct 2019 10:44:12 -0700
Message-Id: <20191018174431.1784-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
that will be cached, and are used by all profiles.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 69da04786e..f05d042474 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11070,6 +11070,15 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
     return flags;
 }
 
+static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
+                                         ARMMMUIdx mmu_idx, uint32_t flags)
+{
+    flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+    flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
+
+    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11141,7 +11150,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags = 0;
+    uint32_t flags;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11151,12 +11160,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     } else {
         *pc = env->regs[15];
+        flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
-        flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
@@ -11166,8 +11174,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A32,
                                XSCALE_CPAR, env->cp15.c15_cpar);
         }
-
-        flags = rebuild_hflags_common(env, fp_el, mmu_idx, flags);
     }
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-- 
2.17.1


