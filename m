Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB59C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7183F2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7183F2225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXbY-00054H-9k
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kZXXP-0007SO-Bg; Mon, 02 Nov 2020 05:58:11 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:39540
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kZXXL-0006ir-V7; Mon, 02 Nov 2020 05:58:10 -0500
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id A17D85FD4A;
 Mon,  2 Nov 2020 11:58:02 +0100 (CET)
From: remi.denis.courmont@huawei.com
To: qemu-arm@nongnu.org
Subject: [PATCH 02/14] target/arm: use arm_is_el2_enabled() where applicable
Date: Mon,  2 Nov 2020 12:57:50 +0200
Message-Id: <20201102105802.39332-2-remi.denis.courmont@huawei.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <2172054.ElGaqSPkdT@basile.remlab.net>
References: <2172054.ElGaqSPkdT@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:2:5a1a::; envelope-from=remi@remlab.net;
 helo=ns207790.ip-94-23-215.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 05:57:15
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

Do not assume that EL2 is available in non-secure context.
That equivalence is broken by ARMv8.4-SEL2.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu.h        |  4 ++--
 target/arm/helper-a64.c |  8 +-------
 target/arm/helper.c     | 33 +++++++++++++--------------------
 3 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index aaf3671806..263e650560 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2099,7 +2099,7 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
         return aa64;
     }
 
-    if (arm_feature(env, ARM_FEATURE_EL2) && !arm_is_secure_below_el3(env)) {
+    if (arm_is_el2_enabled(env)) {
         aa64 = aa64 && (env->cp15.hcr_el2 & HCR_RW);
     }
 
@@ -3043,7 +3043,7 @@ static inline int arm_debug_target_el(CPUARMState *env)
     bool secure = arm_is_secure(env);
     bool route_to_el2 = false;
 
-    if (arm_feature(env, ARM_FEATURE_EL2) && !secure) {
+    if (arm_is_el2_enabled(env)) {
         route_to_el2 = env->cp15.hcr_el2 & HCR_TGE ||
                        env->cp15.mdcr_el2 & MDCR_TDE;
     }
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 030821489b..c385fe82e9 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -972,8 +972,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
     if (new_el == -1) {
         goto illegal_return;
     }
-    if (new_el > cur_el
-        || (new_el == 2 && !arm_feature(env, ARM_FEATURE_EL2))) {
+    if (new_el > cur_el || (new_el == 2 && !arm_is_el2_enabled(env))) {
         /* Disallow return to an EL which is unimplemented or higher
          * than the current one.
          */
@@ -985,11 +984,6 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         goto illegal_return;
     }
 
-    if (new_el == 2 && arm_is_secure_below_el3(env)) {
-        /* Return to the non-existent secure-EL2 */
-        goto illegal_return;
-    }
-
     if (new_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
         goto illegal_return;
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 97bb6b8c01..70050134e0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1049,8 +1049,8 @@ static CPAccessResult cpacr_access(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     if (arm_feature(env, ARM_FEATURE_V8)) {
         /* Check if CPACR accesses are to be trapped to EL2 */
-        if (arm_current_el(env) == 1 &&
-            (env->cp15.cptr_el[2] & CPTR_TCPAC) && !arm_is_secure(env)) {
+        if (arm_current_el(env) == 1 && arm_is_el2_enabled(env) &&
+            (env->cp15.cptr_el[2] & CPTR_TCPAC)) {
             return CP_ACCESS_TRAP_EL2;
         /* Check if CPACR accesses are to be trapped to EL3 */
         } else if (arm_current_el(env) < 3 &&
@@ -2522,7 +2522,7 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
                                         bool isread)
 {
     unsigned int cur_el = arm_current_el(env);
-    bool secure = arm_is_secure(env);
+    bool has_el2 = arm_is_el2_enabled(env);
     uint64_t hcr = arm_hcr_el2_eff(env);
 
     switch (cur_el) {
@@ -2546,8 +2546,7 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
             }
         } else {
             /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
-            if (arm_feature(env, ARM_FEATURE_EL2) &&
-                timeridx == GTIMER_PHYS && !secure &&
+            if (has_el2 && timeridx == GTIMER_PHYS &&
                 !extract32(env->cp15.cnthctl_el2, 1, 1)) {
                 return CP_ACCESS_TRAP_EL2;
             }
@@ -2556,8 +2555,7 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
 
     case 1:
         /* Check CNTHCTL_EL2.EL1PCTEN, which changes location based on E2H. */
-        if (arm_feature(env, ARM_FEATURE_EL2) &&
-            timeridx == GTIMER_PHYS && !secure &&
+        if (has_el2 && timeridx == GTIMER_PHYS &&
             (hcr & HCR_E2H
              ? !extract32(env->cp15.cnthctl_el2, 10, 1)
              : !extract32(env->cp15.cnthctl_el2, 0, 1))) {
@@ -2572,7 +2570,7 @@ static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
                                       bool isread)
 {
     unsigned int cur_el = arm_current_el(env);
-    bool secure = arm_is_secure(env);
+    bool has_el2 = arm_is_el2_enabled(env);
     uint64_t hcr = arm_hcr_el2_eff(env);
 
     switch (cur_el) {
@@ -2593,8 +2591,7 @@ static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
         /* fall through */
 
     case 1:
-        if (arm_feature(env, ARM_FEATURE_EL2) &&
-            timeridx == GTIMER_PHYS && !secure) {
+        if (has_el2 && timeridx == GTIMER_PHYS) {
             if (hcr & HCR_E2H) {
                 /* If HCR_EL2.<E2H,TGE> == '10': check CNTHCTL_EL2.EL1PTEN. */
                 if (!extract32(env->cp15.cnthctl_el2, 11, 1)) {
@@ -4250,11 +4247,9 @@ static const ARMCPRegInfo strongarm_cp_reginfo[] = {
 
 static uint64_t midr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    ARMCPU *cpu = env_archcpu(env);
     unsigned int cur_el = arm_current_el(env);
-    bool secure = arm_is_secure(env);
 
-    if (arm_feature(&cpu->env, ARM_FEATURE_EL2) && !secure && cur_el == 1) {
+    if (arm_is_el2_enabled(env) && cur_el == 1) {
         return env->cp15.vpidr_el2;
     }
     return raw_read(env, ri);
@@ -4281,9 +4276,8 @@ static uint64_t mpidr_read_val(CPUARMState *env)
 static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     unsigned int cur_el = arm_current_el(env);
-    bool secure = arm_is_secure(env);
 
-    if (arm_feature(env, ARM_FEATURE_EL2) && !secure && cur_el == 1) {
+    if (arm_is_el2_enabled(env) && cur_el == 1) {
         return env->cp15.vmpidr_el2;
     }
     return mpidr_read_val(env);
@@ -5350,7 +5344,7 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
 {
     uint64_t ret = env->cp15.hcr_el2;
 
-    if (arm_is_secure_below_el3(env)) {
+    if (!arm_is_el2_enabled(env)) {
         /*
          * "This register has no effect if EL2 is not enabled in the
          * current Security state".  This is ARMv8.4-SecEL2 speak for
@@ -6147,7 +6141,7 @@ int sve_exception_el(CPUARMState *env, int el)
     /* CPTR_EL2.  Since TZ and TFP are positive,
      * they will be zero when EL2 is not present.
      */
-    if (el <= 2 && !arm_is_secure_below_el3(env)) {
+    if (el <= 2 && arm_is_el2_enabled(env)) {
         if (env->cp15.cptr_el[2] & CPTR_TZ) {
             return 2;
         }
@@ -8735,8 +8729,7 @@ static int bad_mode_switch(CPUARMState *env, int mode, CPSRWriteType write_type)
         }
         return 0;
     case ARM_CPU_MODE_HYP:
-        return !arm_feature(env, ARM_FEATURE_EL2)
-            || arm_current_el(env) < 2 || arm_is_secure_below_el3(env);
+        return !arm_is_el2_enabled(env) || arm_current_el(env) < 2;
     case ARM_CPU_MODE_MON:
         return arm_current_el(env) < 3;
     default:
@@ -12646,7 +12639,7 @@ int fp_exception_el(CPUARMState *env, int cur_el)
 
     /* CPTR_EL2 : present in v7VE or v8 */
     if (cur_el <= 2 && extract32(env->cp15.cptr_el[2], 10, 1)
-        && !arm_is_secure_below_el3(env)) {
+        && arm_is_el2_enabled(env)) {
         /* Trap FP ops at EL2, NS-EL1 or NS-EL0 to EL2 */
         return 2;
     }
-- 
2.29.1


