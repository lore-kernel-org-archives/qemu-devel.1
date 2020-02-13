Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F9C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4052073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5TDJ8tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4052073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fyb-0002nM-5s
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh7-0004aV-86
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh4-00025x-Sg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:21 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fh4-00021F-Kx
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:18 -0500
Received: by mail-wr1-x42f.google.com with SMTP id z3so7011131wru.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WDft/NDcEl4kFlZmhHF7J/+9YwKodUFstT/1PqT2KXo=;
 b=Y5TDJ8tx6ULmwdpo7uVPpUtUBVv6SZMUOuU6j0/HMqg5MlRmHFsUxR5N5W2g2Eamr9
 jH/l9khhCUTPQusIPeFfvv7uXOpY1tcegmJM3OJgQh6EsGgpdGj4jcADcYjs8I3JlESe
 krIlgaw8JxxjjgpK4g1AA8EVXrSSLzIOKEaRkf2Lge2e7eumvaK8RrhSsrkcRxEZ01WB
 8IJPMdsMVwOi/ZkqrKdi9Hq2pmb7mcn+i2lSm/Och9AYY6lY94DGO4PGLz91QHyAjTqu
 IPcirwXJZ7LMvoXwZKJtLsLd20MsxzOZOw6w8nAnUq7mLmuIeMetiy/cHbu4PrCPpjzR
 CirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WDft/NDcEl4kFlZmhHF7J/+9YwKodUFstT/1PqT2KXo=;
 b=KVjE47783MYxUQo5k/H2equb5SUTsbNTlt/Z/QeSLR1eEZ7A5gwsuS3b9BaycupJHC
 O8UGX0PUtZJZ/mfhmIKn2VeiQOyxoLMxnOZr6p4XYJ/kn3ynu4jYeBw3/+vZsrv+28P+
 jm1/BHAxledmF3izAF4PF0QuhKOOZFBzS7ZgHAhrXfbA3rR44xOsKtbUfV2zs67I7ozJ
 BvXCq3oARbAA3WqRz+Eukm7UrYV2fVYPd+Azybr2PfcT9RtrGQnVgCYs/lzAwaLgrnGq
 rU2FL4RPvbHG1pqgD5I3va6k7RtOZFPEcviTAtQBiD0Z6dKs+EnWX7f1yFrruhXZlP5k
 8HLw==
X-Gm-Message-State: APjAAAVvRQ+G3jKDWzIiE/xpPTWmQLC0OINyEub6SqcXI/0YRxRpvbGK
 WfrKk+/RUbZVwa8JcHOv/64mkYspDF8=
X-Google-Smtp-Source: APXvYqzmx2nwNj/to1Qgh4M4MtUlXMvlW4M+0dIy/K0rY/Y+Jd68s2Y50yCBwIM0D2erGE9WbKwvwQ==
X-Received: by 2002:adf:a381:: with SMTP id l1mr22042821wrb.102.1581604934943; 
 Thu, 13 Feb 2020 06:42:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/46] target/arm: Set PAN bit as required on exception entry
Date: Thu, 13 Feb 2020 14:41:22 +0000
Message-Id: <20200213144145.818-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

The PAN bit is preserved, or set as per SCTLR_ELx.SPAN,
plus several other conditions listed in the ARM ARM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200208125816.14954-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 178757d2719..de16ce79add 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8763,8 +8763,12 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
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
@@ -8777,7 +8781,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
     /* Set new mode endianness */
     env->uncached_cpsr &= ~CPSR_E;
-    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
+    if (env->cp15.sctlr_el[new_el] & SCTLR_EE) {
         env->uncached_cpsr |= CPSR_E;
     }
     /* J and IL must always be cleared for exception entry */
@@ -8788,6 +8792,25 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->thumb = (env->cp15.sctlr_el[2] & SCTLR_TE) != 0;
         env->elr_el[2] = env->regs[15];
     } else {
+        /* CPSR.PAN is normally preserved preserved unless...  */
+        if (cpu_isar_feature(aa64_pan, env_archcpu(env))) {
+            switch (new_el) {
+            case 3:
+                if (!arm_is_secure_below_el3(env)) {
+                    /* ... the target is EL3, from non-secure state.  */
+                    env->uncached_cpsr &= ~CPSR_PAN;
+                    break;
+                }
+                /* ... the target is EL3, from secure state ... */
+                /* fall through */
+            case 1:
+                /* ... the target is EL1 and SCTLR.SPAN is 0.  */
+                if (!(env->cp15.sctlr_el[new_el] & SCTLR_SPAN)) {
+                    env->uncached_cpsr |= CPSR_PAN;
+                }
+                break;
+            }
+        }
         /*
          * this is a lie, as there was no c1_sys on V4T/V5, but who cares
          * and we should just guard the thumb mode on V4
@@ -9050,6 +9073,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     unsigned int new_el = env->exception.target_el;
     target_ulong addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
+    unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
 
     /*
@@ -9129,20 +9153,43 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
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


