Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B65EC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688642184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DseId2oZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688642184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa3y-0000pO-DM
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55051)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3R-0007Wh-50
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3L-0005SN-Dt
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:35 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa34-0005CA-Su
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:16 -0400
Received: by mail-pl1-x644.google.com with SMTP id m9so16103155pls.8
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=977zpll3Lrh9zG8jniq9vN96HTImzzFHjKLkZ1hP4n4=;
 b=DseId2oZFx+acaehK6luoLMXk9v7Oc63rzZqBqcOnBQFu35Ziebc9IUfbRB8JEMNpt
 FHsu/T5Yx6b5faWSVKnj6mlgMSVhsj+21LfCjbIWYB5iTEX8EXx6lmfcV/FFod1HvCut
 SS1pZajUZWTGsd1PO9Jyjl0RVQgXa4iFbEQHxZhglzsZ9FytneDD3wnsVpO47JZBcliC
 T/1B9af8Pa+ekbJikCWbVqyLNzQYY/4DJPVBLk/Bvv7sloGdZABzJJfIWgk/+utBdloE
 q2DJYl8TuMaX+1GQVLUWwrg4y9J2mI8g3FGkLtTQ6BB1S4TRTLViC04iwl7xxHd+MVsE
 cuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=977zpll3Lrh9zG8jniq9vN96HTImzzFHjKLkZ1hP4n4=;
 b=jrX6wi/ok03LezXvJ1TcoUbvJsFelREVXIzvtAKaIB36ZNWIf+u9UzDWw0rZxZ1iIm
 pwvMLJFbtQVBE0AES5hrKfLof3Sv6SeHX9ed5UX+9cIAT2/HcKEGvi7fVF5BaEco0rHe
 scPnxeD0tVk+ytsY2pyvmx3yC2GQ7dQ5OJP/AjvC33J1kQJCyWnpQ1qBKtkrt1g0Q44L
 4pP96rfcK0vC5SlMyR7bpX50EIY4kjIuImXAjWaeYSyZ3qnC4uLAduhD7+7+IRA4Sc2N
 S0sq4Hcxfl60Tj8DqzKUvfPVEomBxGROkGqdy59Iuxl0UHmdIX5N9K2V4Wuv8ztFHP1v
 uKeg==
X-Gm-Message-State: APjAAAWopDKhSa3YnhOesj9ao3wt0rJYruu7iY8MluugWpCd1c17gKjY
 QCjefrovQE+TjGm4eEN9/He4DTlRWjk=
X-Google-Smtp-Source: APXvYqzLFM1WgkGyOON7MzpFjdHapuI2wh8ULkne/38hR2b+DMdTYIJaz70TGKy711+LKVvCYWPDgQ==
X-Received: by 2002:a17:902:9b81:: with SMTP id
 y1mr61488786plp.194.1563570230165; 
 Fri, 19 Jul 2019 14:03:50 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:20 -0700
Message-Id: <20190719210326.15466-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH for-4.2 18/24] target/arm: Update arm_sctlr for
 VHE
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use this function in many more places in order to select
the correct control.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h          | 10 ++++++----
 target/arm/arch_dump.c    |  2 +-
 target/arm/helper-a64.c   |  2 +-
 target/arm/helper.c       | 10 +++++-----
 target/arm/pauth_helper.c |  9 +--------
 5 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7310adfd9b..7efbb488d9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3104,11 +3104,13 @@ static inline bool arm_sctlr_b(CPUARMState *env)
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
index 54c328b844..db13a8f9c0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3868,7 +3868,7 @@ static void aa64_fpsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult aa64_daif_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
 {
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -3887,7 +3887,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
     /* Cache invalidate/clean: NOP, but EL0 must UNDEF unless
      * SCTLR_EL1.UCI is set.
      */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCI)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCI)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -4114,7 +4114,7 @@ static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
     /* We don't implement EL2, so the only control on DC ZVA is the
      * bit in the SCTLR which can prohibit access for EL0.
      */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_DZE)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -5344,7 +5344,7 @@ static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
     /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
      * but the AArch32 CTR has its own reginfo struct)
      */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCT)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -8161,7 +8161,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
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


