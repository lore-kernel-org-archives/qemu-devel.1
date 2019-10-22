Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657232184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cu3apOc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657232184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMudJ-0004LP-AH
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuH3-00031b-Rs
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuH2-0001OL-Ge
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuH2-0001O8-AY
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id t16so12960321wrr.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GSepKuBdExAvu93R1VSsheMCP0CVd7/15avmFDHul9k=;
 b=Cu3apOc5mDK9FyIqAQNVtQUXMl94slUh8V1K1GQ/fK117UuOaTKcxgPA8XYf0RUogQ
 CWXUac3OW+YxXgdEIJGa87LAY3+DP19Jwf9Lnt/gxz6UpdwQ8vox+qTikFWn95DAC7F+
 EijFyh4S07tMhM2LhC9/zT6v93LHw5pKmhn4LWBpfX8lJwaMigAsyHL65Z1yl39N2mmW
 ePVrXGt9xIGg5p9gbeLh8UY0RYpXaQqxvA6LsNWDHHyEG95USYExhTn0ILJJA/3EbbB+
 R5UD1zGszxoD9W0EcEF7QkXy/UrGitO5hhKQ269q5hIaLH14RiQ8j24UTI2BuxtzobrK
 DGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GSepKuBdExAvu93R1VSsheMCP0CVd7/15avmFDHul9k=;
 b=YuWqKO313LmDYjUCDeSuVIThSEuhMI2KVzTjudSIOWKQIJ4HRw7oIpreVLRNUG1fvH
 u5bjkAg+drLud5TpQVBeC161k1U7Aoc8E5+ulJCy8HrR0nuE3iCjWGR6jkL5HQk6p00u
 y0leMlJPmFCckKrH3d83MFEyaBHEWwfz9RseqjC9NOczCvK7s2AJQj0nHJoMzjmFOVl3
 fGZsoXOsCo4jWm9Md2qn0DZXIdRONsl+HNAC9REj5AwUNKUFQ3WpYtWK93+qppAetCiK
 tgSQwKkGTrleXzs7LlzvpUqsjNnTJI7hNLjP5Ay2wPiY7HSJBsshR6yAv9l5lcaSuB5A
 x94Q==
X-Gm-Message-State: APjAAAVOVyeBgH5NI0/LkETcTmO5yxd3f5fh7poL/+Nf4mILMX1yTxcq
 D6ySYHgJ5xUXozoeqxwETiC1L5tL6FU=
X-Google-Smtp-Source: APXvYqyOYy6htDb3Y5W+97zmQGRjfikMHXpm/zi9KVk7/joQc3vW7VKMjeZ2hfOA0jJSTVI6yZavTw==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr3781298wrl.235.1571751150694; 
 Tue, 22 Oct 2019 06:32:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/41] target/arm: Add arm_rebuild_hflags
Date: Tue, 22 Oct 2019 14:31:15 +0100
Message-Id: <20191022133134.14487-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This function assumes nothing about the current state of the cpu,
and writes the computed value to env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  6 ++++++
 target/arm/helper.c | 30 ++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9909ff89d4f..d844ea21d8d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3297,6 +3297,12 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
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
index 89aa6fd9339..85de96d071a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11198,17 +11198,35 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
@@ -11217,8 +11235,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         *pc = env->regs[15];
 
         if (arm_feature(env, ARM_FEATURE_M)) {
-            flags = rebuild_hflags_m32(env, fp_el, mmu_idx);
-
             if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
                 FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
                 != env->v7m.secure) {
@@ -11242,8 +11258,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
-
             /*
              * Note that XSCALE_CPAR shares bits with VECSTRIDE.
              * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
-- 
2.20.1


