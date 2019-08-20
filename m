Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1981C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687FE206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srraqAe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687FE206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Bld-0006lk-9k
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BM0-0000JR-OX
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLz-0000A0-8l
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:44 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLy-00005t-Vk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:43 -0400
Received: by mail-pf1-x441.google.com with SMTP id i30so4112082pfk.9
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8b+r+7+wrJNiKK+el1m+NNiACbtE+S7w+cGIQmCdH8g=;
 b=srraqAe90z7WTNHwfkHfQkfGqnTVgX31c7VXOoaffni+fDLjsAZQ1G25thp+51wEwv
 EmEjuk4m7ZhknJE0TtV+5+RuyK9gA8IFRioNHsjPRR+p0uuGtQYrn2Cho3ff7e3THz3R
 6q9hx4CcC0WgMusZjgwkuEtq1E9E5mAjknbq0Pp5hVZs/pfDoJdvYGr30vHn9frBbroX
 x4k9LKbUmxmGybX7/7Fe5ZTl/AFlFtHOTP9y8SsQ2WZB1L6xi+eLUR3ai0i6o5FTACG8
 bhDIx3Wmr2AaYFfkXI6k56s3V8YbIRUl+HSVpEzMTnDuvDPB9QdUdfk0DMiTBJGeFE99
 DN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8b+r+7+wrJNiKK+el1m+NNiACbtE+S7w+cGIQmCdH8g=;
 b=XyaHkGxOpO6kp+DIPoMINNqGIWYXwDSFrN8GDiraS7xQ88mLQ73puMU+WaY+khYczt
 kM/XgbgdmKyoXWVQ+jdat5k0q3k0ElhXlVf3+xRn+MlyvX8y3ZYqo4FDxEgP2Sixnj2V
 wJ/tanDPlI83pWyJy08qGXuQwVd4tepoNBpCh5OIWm1eGkhxd1DrRkFNZZBB46Mp3fe9
 dw6VXsXRhmXF0vtqh8AadVHHkJ3/9K92ATa5uo304TERLctJ2mdxmhLg0KDx7yWQHOVu
 cYtpLzhUc8Y0uq3YSTlXk4oQOkRJkOOqpL7vnhPz4njJ+GYJAL3Q9sgfR/HTt9RQAnjh
 e2cg==
X-Gm-Message-State: APjAAAWM5xiKCjfXC77QOIIxHP4bT0fV401ArqwExZQxulV+y2RRL8mW
 snXKZ9FtkfgNQRfPUDXTGYzYZsfFBf4=
X-Google-Smtp-Source: APXvYqwU/l0OC+qdvbUS0NqK34m5nMKCP4/ikb7LV3srDxORJDIOHKJ/WPZZV0Vdn9tNvuzVqwQdBQ==
X-Received: by 2002:aa7:842f:: with SMTP id q15mr31988912pfn.250.1566335258741; 
 Tue, 20 Aug 2019 14:07:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:15 -0700
Message-Id: <20190820210720.18976-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v5 12/17] target/arm: Add arm_rebuild_hflags
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

This function assumes nothing about the current state of the cpu,
and writes the computed value to env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  6 ++++++
 target/arm/helper.c | 30 ++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9606222942..602c879395 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3293,6 +3293,12 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
         *opaque);
 
+/**
+ * arm_rebuild_hflags:
+ * Rebuild the cached TBFLAGS for arbitrary changed processor state.
+ */
+void arm_rebuild_hflags(CPUARMState *env);
+
 /**
  * aa32_vfp_dreg:
  * Return a pointer to the Dn register within env in 32-bit mode.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b905d61898..83ae33dae5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11160,17 +11160,35 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_internal(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+
+    if (is_a64(env)) {
+        return rebuild_hflags_a64(env, el, fp_el, mmu_idx);
+    } else if (arm_feature(env, ARM_FEATURE_M)) {
+        return rebuild_hflags_m32(env, fp_el, mmu_idx);
+    } else {
+        return rebuild_hflags_a32(env, fp_el, mmu_idx);
+    }
+}
+
+void arm_rebuild_hflags(CPUARMState *env)
+{
+    env->hflags = rebuild_hflags_internal(env);
+}
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    int current_el = arm_current_el(env);
-    int fp_el = fp_exception_el(env, current_el);
     uint32_t flags, pstate_for_ss;
 
+    flags = rebuild_hflags_internal(env);
+
     if (is_a64(env)) {
         *pc = env->pc;
-        flags = rebuild_hflags_a64(env, current_el, fp_el, mmu_idx);
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
@@ -11179,8 +11197,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         *pc = env->regs[15];
 
         if (arm_feature(env, ARM_FEATURE_M)) {
-            flags = rebuild_hflags_m32(env, fp_el, mmu_idx);
-
             if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
                 FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
                 != env->v7m.secure) {
@@ -11204,8 +11220,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
-
             /*
              * Note that XSCALE_CPAR shares bits with VECSTRIDE.
              * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
-- 
2.17.1


