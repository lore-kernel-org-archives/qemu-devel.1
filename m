Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04B0ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867892089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3HJ+WlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867892089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLAwW-000706-GA
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 14:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArm-00012b-NZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArl-0000pv-NE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLArl-0000pX-Hr
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id p30so1877127pgl.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+UgAJ6EhcwGdb7pezBRTrZ79eaC+NjRs0dqrTWfzTFo=;
 b=x3HJ+WlZiIOQaJOpC7HfOW8NG5F/im4gZXFPtNgCl8FUUpjgkQI5cmvqa+AbjDLGrL
 gkg0h6VMkX60fMCBHiLvxaWP+VAUi2Mnnm3nYzhf1xtzaTchsZtmVHWPx5bjO2bPpi4k
 AGIxN1c/DX4MRsstodj/FN/TUuzIQLQ8o9pUTpHiQSEoDWrcEKpcsFWhT3qcbDS0SNDc
 AdomEEoshsoQ+a4zW+wQ0G1cJok5Jsj2tbjAVUzeFZTKsyWZnkBVt4ajs37Oha6ikM5o
 5MEdKbYMB6DaxOp33i3q0YvINvZDwUt24X/sWOk1S2eQNgE3YoULikRmnjPpJnxLQRDg
 0Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+UgAJ6EhcwGdb7pezBRTrZ79eaC+NjRs0dqrTWfzTFo=;
 b=obws+UIaRiqk6jIueK7sw1J1kAgr9jPECpuofLMxz3/9+qtdhIHmigUGKOzCQT7UqF
 zO0bvPBm+wdHmCgGfxsqg7nPVEbWREtKaPGDGUUPsZWREW+yPc70RqW/fr9huF41uTMv
 vDwbuPSVXUhYWA1XsFVV47zye5lZ3rUgTGTg6O9AlrQza9JmVOpwujSLPczJkLykQSRp
 GyLHtsBrNs+gPuir2ZTWHLsv2V+Wsyovw2GghSh+WTd28NP0BD5ZiMs5EdYlGU+fj7q1
 RvBjsQcV2SxkquQvr7UF1t0iykbwnmW3F8mykdk6aM6pEV+i43kaKRo+6wX3f9d6omAq
 Y62g==
X-Gm-Message-State: APjAAAUxGa8rwzt3tp9hFK7MARu9ZieukApP0fmbQHjNYAhdJZMzPLDA
 a6nt5Lklwx37Xrkv6xjNlQoJxQQH4yA=
X-Google-Smtp-Source: APXvYqxiHkAnUltM428PI2J8Xy8Ij94agtTkYLlajqZ3QL/rHi2QhgnDev9vKcuqVJycD9XBDV0shA==
X-Received: by 2002:a62:ed01:: with SMTP id u1mr1865679pfh.54.1571338276212;
 Thu, 17 Oct 2019 11:51:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/20] target/arm: Split out rebuild_hflags_common_32
Date: Thu, 17 Oct 2019 11:50:53 -0700
Message-Id: <20191017185110.539-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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


