Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F89C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542D6206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOz6AHkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542D6206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxVk-0004bp-0G
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGu-0002Xx-7y
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGt-0007jY-0k
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:04 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:33195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGs-0007jB-S9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:02 -0400
Received: by mail-yw1-xc43.google.com with SMTP id w140so3657474ywd.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=liE7k7KCDLaE4P9fXyFmPEwyl1E5DGcmCPn5aQ0Fr1o=;
 b=uOz6AHkd2d3q7ZVJfUDbFm+UrMVRxVL3WE/P8wG7lVudDqO0pAIurHwyg13Zy3JwOO
 W38gZMAutEp/EXIBFoZI/UTgKmr/J2KzNbc7Tjr0IVUUKcqRIEvMa+g4nwbTtHUsDqwI
 ZbSd+S0uOUDh/WboDzSpBxJs3QltLfF5jrJQilj3gwfyZzSt847AV1ny+oSne2bD9afL
 mX87w3Defe3sOZaUzOAkYgk+CVw3468VRKqckP1oEyEFhv7UUIqQOgZIkXjukn1QSASI
 XxRRX/hzaCG4NTLPetFVPuYQZT2PcMyVhfV7HP0obG8Qh6oZ5GAgMA+dlxgr1fRYMdNJ
 h/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=liE7k7KCDLaE4P9fXyFmPEwyl1E5DGcmCPn5aQ0Fr1o=;
 b=JEIVY9o+HnBMAxzNYNT7sE5piYjjK4PUIVzfbzMyOKPXtaIBEhlWMqtzoAe4IODPdO
 S7g8Ql0Mhm0AsDnDnjDX4UkUzcK25DHMXuebXsGDxJeXFnfrhadoIBP72AaIa7MOrDCO
 cI9NiZma3QJtZtI83+ba9g8AxtX53++i11X/RgiHVObzOAnsTERXCtjrphVWezcQZ5Pk
 SE014NwDNz9fUL8NV8sVv0zsqjnpF6HUfTz32pwI5ONeAYhTYwuVp3wsF4WacIQZsyZk
 NdSKOYir8SR4av7fyhD1S1o9HDepKwlo6k0RAKPN07qhEOLuj3OVij2eVl6Y3Azx4c8O
 zzIA==
X-Gm-Message-State: APjAAAVOu5i51uidzUtB3AapgawPaJf24JvKZzs8xB9idkbK94FYEZut
 8jNCcPjw/LzG1XdhXlCeSkRhkpyoQKo=
X-Google-Smtp-Source: APXvYqxnOcTOtvNg+9OKGE6lOUucbBU2xFdY8I81zb78ljBE7DMuuFgcNj6dS7Fze1NammGc6Z0nYw==
X-Received: by 2002:a81:2cc6:: with SMTP id s189mr2934231yws.154.1570809361992; 
 Fri, 11 Oct 2019 08:56:01 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:56:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/20] target/arm: Add arm_rebuild_hflags
Date: Fri, 11 Oct 2019 11:55:38 -0400
Message-Id: <20191011155546.14342-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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

This function assumes nothing about the current state of the cpu,
and writes the computed value to env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  6 ++++++
 target/arm/helper.c | 30 ++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9909ff89d4..d844ea21d8 100644
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
index 89aa6fd933..85de96d071 100644
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
2.17.1


