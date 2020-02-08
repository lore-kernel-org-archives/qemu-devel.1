Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F941C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C55020726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNBFx+gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C55020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pn4-0004Gx-8K
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgw-0000oV-Jr
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgv-0005BB-BV
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:34 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgv-00058b-51
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id t3so2034453wru.7
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5rep4zmfN+I/zzXm7mpLZvAoU6SaVw4L5kdUpJxxpog=;
 b=PNBFx+gu5l69Qc/iAOvWkB5jdyGzCHQT7O9KdZz7fU440YzNlOT3AzLJrpmwMpCquc
 iWw5LlOWhQf7Gp9sP6Y/UHBgto86e8+5EpVvUHZ4yGIdJaPIm/QLCWEuznZuXdxpE/nO
 YF2IkTedwtgv6nU7vgqSe1wglUJ0mY6gZiEhFZagLj7GzZ4TEoXP1rZiYWjbTZC2VdnQ
 +YFg2brZJMAANuBLVUpE6KHQ+1Groyz1lJ6dy51fqXIxKL1EtDt5W08LivwRDfxmt+T/
 GtGmKU+C5Hvz9sCpYEnukb2sD5vD1sPJwzsE2ooeg3fMZhb/tsgTkMJtHrrBc/a+2TeM
 Y/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5rep4zmfN+I/zzXm7mpLZvAoU6SaVw4L5kdUpJxxpog=;
 b=fAaM2N4J1ZpwZCnQhdl5nlkd3yUcEUG4ciIzU3+MTO21R5sg2iK4L2prPK0suRzP9b
 4o4IcBWIjb+I3IoqZn+mTGfzrR8qKyBuTJPEKD7hJDIObtXhquMbcbisyKztO7viTSUL
 P4pTiNMP+L1NAq+7eLALdo1fQeYnTmSqMS3EFWAaKNHEfRTifFCrTfv1MOMIfyt0H34h
 3cvqP741/p3K7i7I53Mb9A1QYirUCLriI0wTIjC0OTpRFZPyypRMbpAqWrjaJPNGmfIl
 LN7dbVj/0et8jowp2blwrYpbF0BjKNgkwJdRi3uO0+nHVsocTE5t9YitCNyjFU7u0Fxx
 EcnA==
X-Gm-Message-State: APjAAAVX0Mc3F4le/LSScODVCF1rzyVr6rRbS3cseSGuBAiMAPzfSmJl
 zyUF/eeNXmT17LZ59gBtnsruHEK3EyxwoQ==
X-Google-Smtp-Source: APXvYqwc91ClSAE75kBIlj1BWHTBejUKDqMMWy6fNkSybl6PYJGfgf/T1rCylOvmtrerPWUA+po04A==
X-Received: by 2002:adf:ecc6:: with SMTP id s6mr5451347wro.345.1581166711877; 
 Sat, 08 Feb 2020 04:58:31 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/20] target/arm: Set PAN bit as required on exception
 entry
Date: Sat,  8 Feb 2020 12:58:10 +0000
Message-Id: <20200208125816.14954-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
v4: Fix exception entry to EL3.
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 178757d271..de16ce79ad 100644
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


