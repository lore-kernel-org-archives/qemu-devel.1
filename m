Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA7C31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD7B2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXxC9JbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD7B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzGF-000088-P3
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 15:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32841)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz50-0006hn-85
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4y-0007M5-Uo
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:34 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4y-0007La-OM
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id n190so2542683pgn.0
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nHfPCz5YwCEUlzjuGzWzTb7gnkajF/XBRvaJmIbxmI0=;
 b=hXxC9JbVWxcs5YnVTE4WAwREG86bgECaTH2NORht9mgPe6k9Dg2bTQSpTsz7SBlWuU
 QC+fxv5+FUgKq2V1gu/3cKNHYyfw/g8B7au/L2bg2YpkYwHH0Cv98WMv47VCA3swB2a1
 nTLBl0vHndkP0WIYA1EK8tqZXz8oKt4SHpEMwgxLVZGJ0Wl7nsMKnWUoGQaXHBJVjJz2
 eZvX91NtuWi3fa+Z83IlYexblAHHXEXauFI8A8ALj6zPdCcx6NvXUJXKitcGjf3NGEAf
 R6UnC+nKLtkwBr+DPP2UJ9+M7AgVayW+j8ct7QrGAryEIdARj+IJdKku/MSFucfVcw9M
 lyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nHfPCz5YwCEUlzjuGzWzTb7gnkajF/XBRvaJmIbxmI0=;
 b=VHbrfTvdyQlq//98G1+hYaOdjV//XD7DHVfN3U6lbSlEceGHz32pB1ad5reQelX/1D
 gdw3l9RuFOezZTa0Dt8S4+FImveZ+pWiV6/ZLvGNO3QAO2wwckW4HtrvCwgBqwJHZZcG
 vBJ95dbCaW4NhR7jgoLnQwXrNZeLpDUjy1dpVQ3Fk41vPb5wap85ylaL4OjTZOytqcFW
 MuzWGYyZgy5VPYgL2grQ4Rw3ns+ZH+xzyA8Z9Q6hf7KZeGyH3NSEw1QkwYxXOxaBXo9b
 e32foA87GFxY7qjPGBqGYYySCy4vPkRZzyAVkNo4z9Qg+7Dn4lCIrMJoXTwFbTbMslV4
 iZDg==
X-Gm-Message-State: APjAAAUzNiEq48ANcM6mZ6zwTN1uQt3Uvmt9LuAT37FgQ5C6CQwyMepZ
 yjGTk1BtLbONPl2LlFR9FZmkfhJFk5E=
X-Google-Smtp-Source: APXvYqx3Of1+yWCTj60XS0ZNONOuwP6m8JwYsCiapXVqwT+kjVBbmnxjspb3mk8OpmZcPOXEBs9xKg==
X-Received: by 2002:a63:184b:: with SMTP id 11mr70008432pgy.112.1564858111468; 
 Sat, 03 Aug 2019 11:48:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:50 -0700
Message-Id: <20190803184800.8221-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 24/34] target/arm: Update arm_sctlr for VHE
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

Use the correct sctlr for EL2&0 regime.  Due to header ordering,
and where arm_mmu_idx is declared, we need to move the function
out of line.  Use the function in many more places in order to
select the correct control.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Use arm_mmu_idx() to avoid incorrectly replicating the el2&0
    condition therein.  Drop the change to cpu_get_dump_info, as
    that needs a more significant rethink of hard-coded oddness.
---
 target/arm/cpu.h          | 11 +----------
 target/arm/helper-a64.c   |  2 +-
 target/arm/helper.c       | 14 ++++++++++++--
 target/arm/pauth_helper.c |  9 +--------
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8d90a4fc4d..d7c5a123a3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3096,16 +3096,7 @@ static inline bool arm_sctlr_b(CPUARMState *env)
         (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
 }
 
-static inline uint64_t arm_sctlr(CPUARMState *env, int el)
-{
-    if (el == 0) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-        return env->cp15.sctlr_el[1];
-    } else {
-        return env->cp15.sctlr_el[el];
-    }
-}
-
+uint64_t arm_sctlr(CPUARMState *env, int el);
 
 /* Return true if the processor is in big-endian mode. */
 static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
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
index a570d43232..9e9d2ce99b 100644
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
@@ -8718,6 +8718,16 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+uint64_t arm_sctlr(CPUARMState *env, int el)
+{
+    /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
+    if (el == 0) {
+        ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+        el = (mmu_idx == ARMMMUIdx_EL20_0 ? 2 : 1);
+    }
+    return env->cp15.sctlr_el[el];
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /* Return the SCTLR value which controls this address translation regime */
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


