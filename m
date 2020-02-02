Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407DDC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C6720658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9kv1ZVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C6720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3lj-0005Wc-8B
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gz-0003hZ-IA
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gy-00026a-AY
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:53 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3gy-00025Q-42
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:52 -0500
Received: by mail-pg1-x541.google.com with SMTP id b9so5712355pgk.12
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LdEIwR4tXW88OebyAe9sT02I9h4JxavRP0Kmc9yS4sc=;
 b=C9kv1ZVjKKQMfNYOlK7ZVqvZpsVvWdMPdcSlIAmOmf6jge2A/N0JbGqQ/8hKZrIJcq
 I0eXalnRgc1DgJT+aCyptQ4C29z+a8hqCxBy8gbtM7TyH7yLL4WZA0+zoo60qQEnwE9O
 i+OITKQRtmG3YESPPD+MSX/DUuWh+ySRjZfUgWLrv/SkSP/slqH3iJDAAXL3eUkEmq1k
 Rv9rjhSf1WzIC0EMNfxA74w8yOhYbI5Fq/HFo7oSaqQx3pJQ2/73/7n31HbWoXw4lWXn
 /5QKDq8+OTaMDpFrOA8M64cfWpJ8JvdUy7h52J6HAwoZKYWnNbabICKX7tu+opnR+dJN
 qxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LdEIwR4tXW88OebyAe9sT02I9h4JxavRP0Kmc9yS4sc=;
 b=DR/dZKWn51ZyRJnOv/F47ZX+XdWpb3osP9lJl+nyX2eS0oJF4lYdjr0rnKcfb7Pd2O
 yw3jfvBTCKndb0hwqW6ZJAqjMS19JmDT1xfcCKBcpbv+1Daj6lyhqTgJ8/KBkLoX45NZ
 kTDPtdEkE7GStGyTipxH81JLvxKigvDFOGUkTbMGPb89/FAkVQlWhtr2T+YSkuokSA/0
 IRrwR3z6RT+nJljj9j8dmAQfFsLtPZIPVO0vB0Q/qhkZ/hKy9CzAbvsUIiFk/DD/pCnJ
 2ghvpXprLLI1Ved8qftwIbhHSNhu3nFgS3GPSUTnz1q6Ht679Ciilo6sfncpPyumrUU0
 BjuA==
X-Gm-Message-State: APjAAAU1Joo7rzN1+Mpd9BjbAreORc/9/iAidjN+ux+YxYDSYGlsgSBt
 lMQLdlHO3IAw+M3IMigDWgNBB/1vCFQ=
X-Google-Smtp-Source: APXvYqwgI6kiGm5sSix1bEGS9PzDlRsUSSDsv2d3yQ1+OJpjRLej7ZiNLNLPkfFnNdRJ+xlWJTBGKg==
X-Received: by 2002:a62:cece:: with SMTP id y197mr18383547pfg.9.1580605490891; 
 Sat, 01 Feb 2020 17:04:50 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/14] target/arm: Set PAN bit as required on exception
 entry
Date: Sat,  1 Feb 2020 17:04:33 -0800
Message-Id: <20200202010439.6410-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PAN bit is preserved, or set as per SCTLR_ELx.SPAN,
plus several other conditions listed in the ARM ARM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Tidy preservation of CPSR_PAN in take_aarch32_exception (pmm).
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 18e4cbb63c..4c0eb7e7d9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8772,8 +8772,12 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
                                    uint32_t mask, uint32_t offset,
                                    uint32_t newpc)
 {
+    int new_el;
+
     /* Change the CPU state so as to actually take the exception. */
     switch_mode(env, new_mode);
+    new_el = arm_current_el(env);
+
     /*
      * For exceptions taken to AArch32 we must clear the SS bit in both
      * PSTATE and in the old-state value we save to SPSR_<mode>, so zero it now.
@@ -8786,7 +8790,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
     /* Set new mode endianness */
     env->uncached_cpsr &= ~CPSR_E;
-    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
+    if (env->cp15.sctlr_el[new_el] & SCTLR_EE) {
         env->uncached_cpsr |= CPSR_E;
     }
     /* J and IL must always be cleared for exception entry */
@@ -8797,6 +8801,12 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->thumb = (env->cp15.sctlr_el[2] & SCTLR_TE) != 0;
         env->elr_el[2] = env->regs[15];
     } else {
+        /* CPSR.PAN is preserved unless target is EL1 and SCTLR.SPAN == 0. */
+        if (cpu_isar_feature(aa64_pan, env_archcpu(env))
+            && new_el == 1
+            && !(env->cp15.sctlr_el[1] & SCTLR_SPAN)) {
+            env->uncached_cpsr |= CPSR_PAN;
+        }
         /*
          * this is a lie, as there was no c1_sys on V4T/V5, but who cares
          * and we should just guard the thumb mode on V4
@@ -9059,6 +9069,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     unsigned int new_el = env->exception.target_el;
     target_ulong addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
+    unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
 
     /*
@@ -9138,20 +9149,43 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     }
 
     if (is_a64(env)) {
-        env->banked_spsr[aarch64_banked_spsr_index(new_el)] = pstate_read(env);
+        old_mode = pstate_read(env);
         aarch64_save_sp(env, arm_current_el(env));
         env->elr_el[new_el] = env->pc;
     } else {
-        env->banked_spsr[aarch64_banked_spsr_index(new_el)] = cpsr_read(env);
+        old_mode = cpsr_read(env);
         env->elr_el[new_el] = env->regs[15];
 
         aarch64_sync_32_to_64(env);
 
         env->condexec_bits = 0;
     }
+    env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
+
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
+    if (cpu_isar_feature(aa64_pan, cpu)) {
+        /* The value of PSTATE.PAN is normally preserved, except when ... */
+        new_mode |= old_mode & PSTATE_PAN;
+        switch (new_el) {
+        case 2:
+            /* ... the target is EL2 with HCR_EL2.{E2H,TGE} == '11' ...  */
+            if ((arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE))
+                != (HCR_E2H | HCR_TGE)) {
+                break;
+            }
+            /* fall through */
+        case 1:
+            /* ... the target is EL1 ... */
+            /* ... and SCTLR_ELx.SPAN == 0, then set to 1.  */
+            if ((env->cp15.sctlr_el[new_el] & SCTLR_SPAN) == 0) {
+                new_mode |= PSTATE_PAN;
+            }
+            break;
+        }
+    }
+
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
     aarch64_restore_sp(env, new_el);
-- 
2.20.1


