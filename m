Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61452C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD5B2171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJwlrZJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD5B2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvZw-0001QJ-Gn
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN1-0005Nl-Mr
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN0-0003gH-52
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:47 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMz-0003fQ-VV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:46 -0400
Received: by mail-pf1-x441.google.com with SMTP id 19so32507817pfa.4
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ANNHdO/zBUkLNhCgl4wRP8H0y0X0qC4dG7xLb+E0zx4=;
 b=hJwlrZJCHdgQWubKECzMUn3b7kQ09I+dYs05SKGnRm1d+8AyIatq3u9UgKJKRVGIOn
 wcwcfFXPbzsMtW6QRzVTurSySAQ8Z7hdusyNfiF/1oG/rBcpgMxH3QuxG+mYCgVqSVHz
 0YLHJ8SQx3Xlsj4/EMfwawe5W2JVii56TYkvH2B8W6jZu4RwdtYlSzRIdspTBHCCEt0k
 DSz0tnkOmky4F6YAUHjM2hjmfsvxZu6q6fz6sqF/7BlNVXfVt1WOZOM7zKbIQwDj9RcP
 w7CzBWbZ8mOuBZSzPHuzSoEvVr0QHrMEysqAKZ3I2ibTHlRZmX3NtW25DZin2PVO1mLL
 wYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ANNHdO/zBUkLNhCgl4wRP8H0y0X0qC4dG7xLb+E0zx4=;
 b=hMClBDwRx+fCXt5edXScGApQQzw5DR7xC2Ik8OwEgmfGAnoFMxr5aWYIrirVja3EWE
 n5Bm75ehrz1pwqr6Ggj0MfC3y8VM0BgP/mHhOoPQjB0BLXj9npK+uOXaViBP7byA1Tav
 wHEihyYJi19cewU36DPdpIWVwo1wV2atxInzDtIgtYF47O41asQVkq5tcpG9c/dA3z49
 CBIIhRbnQBIwkkrDo0r2wleV63vLl2fR9X2qVk4DjWiL8735AI1QjSbn9pBLnZ5Du4m6
 RPnDvvbc//rNrHG94cvBaYNg9KH4QR1mz3Zu0gwjIr7OMY/S1pMQqqAwvetARiHMvM9J
 /53Q==
X-Gm-Message-State: APjAAAX7iL22dpe4MV06AGF8iu4Z4t61+rJrD+4Y2TlwZxcm6cJIiw6q
 la8av4m8gF0IL/Z06EZlbhqhLPc0kVw=
X-Google-Smtp-Source: APXvYqzFjCmUxBGewxqBNn5FET3fk96MPNLs1F9/D0IYgxShOvD0XX7Ci68goWzC9PABhjaut3QjYg==
X-Received: by 2002:a17:90a:5887:: with SMTP id
 j7mr4659919pji.136.1564605524679; 
 Wed, 31 Jul 2019 13:38:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:05 -0700
Message-Id: <20190731203813.30765-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 24/32] target/arm: Update arm_sctlr for VHE
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use this function in many more places in order to select
the correct control.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h          | 10 ++++++----
 target/arm/arch_dump.c    |  2 +-
 target/arm/helper-a64.c   |  2 +-
 target/arm/helper.c       | 10 +++++-----
 target/arm/pauth_helper.c |  9 +--------
 5 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 64cda8dbea..c41da1d791 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3099,11 +3099,13 @@ static inline bool arm_sctlr_b(CPUARMState *env)
 static inline uint64_t arm_sctlr(CPUARMState *env, int el)
 {
     if (el == 0) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-        return env->cp15.sctlr_el[1];
-    } else {
-        return env->cp15.sctlr_el[el];
+        if (arm_el_is_aa64(env, 2) && (arm_hcr_el2_eff(env) & HCR_E2H)) {
+            el = 2;
+        } else {
+            el = 1;
+        }
     }
+    return env->cp15.sctlr_el[el];
 }
 
 
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 26a2c09868..5fbd008d8c 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -320,7 +320,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
      * dump a hypervisor that happens to be running an opposite-endian
      * kernel.
      */
-    info->d_endian = (env->cp15.sctlr_el[1] & SCTLR_EE) != 0
+    info->d_endian = (arm_sctlr(env, 1) & SCTLR_EE) != 0
                      ? ELFDATA2MSB : ELFDATA2LSB;
 
     return 0;
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 060699b901..3bf1b731e7 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -70,7 +70,7 @@ static void daif_check(CPUARMState *env, uint32_t op,
                        uint32_t imm, uintptr_t ra)
 {
     /* DAIF update to PSTATE. This is OK from EL0 only if UMA is set.  */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)) {
         raise_exception_ra(env, EXCP_UDEF,
                            syn_aa64_sysregtrap(0, extract32(op, 0, 3),
                                                extract32(op, 3, 3), 4,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 578dcfefbf..2883d6e568 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3867,7 +3867,7 @@ static void aa64_fpsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult aa64_daif_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
 {
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -3886,7 +3886,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
     /* Cache invalidate/clean: NOP, but EL0 must UNDEF unless
      * SCTLR_EL1.UCI is set.
      */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCI)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCI)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -4116,7 +4116,7 @@ static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
     /* We don't implement EL2, so the only control on DC ZVA is the
      * bit in the SCTLR which can prohibit access for EL0.
      */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_DZE)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -5348,7 +5348,7 @@ static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
     /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
      * but the AArch32 CTR has its own reginfo struct)
      */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCT)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -8167,7 +8167,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
     /* Set new mode endianness */
     env->uncached_cpsr &= ~CPSR_E;
-    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
+    if (arm_sctlr(env, arm_current_el(env)) & SCTLR_EE) {
         env->uncached_cpsr |= CPSR_E;
     }
     /* J and IL must always be cleared for exception entry */
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index d3194f2043..42c9141bb7 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -386,14 +386,7 @@ static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
 
 static bool pauth_key_enabled(CPUARMState *env, int el, uint32_t bit)
 {
-    uint32_t sctlr;
-    if (el == 0) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-        sctlr = env->cp15.sctlr_el[1];
-    } else {
-        sctlr = env->cp15.sctlr_el[el];
-    }
-    return (sctlr & bit) != 0;
+    return (arm_sctlr(env, el) & bit) != 0;
 }
 
 uint64_t HELPER(pacia)(CPUARMState *env, uint64_t x, uint64_t y)
-- 
2.17.1


