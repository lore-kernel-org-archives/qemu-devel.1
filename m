Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84908C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A42A2082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A42A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqj3H-0007jy-91
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 16:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1jqj2M-0006zq-PD; Wed, 01 Jul 2020 16:08:54 -0400
Received: from mail.csgraf.de ([188.138.100.120]:40968
 helo=zulu616.server4you.de) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1jqj2K-0002sY-Ml; Wed, 01 Jul 2020 16:08:54 -0400
Received: from server.alex.local (x4d024519.dyn.telefonica.de [77.2.69.25])
 by csgraf.de (Postfix) with ESMTPSA id A80B339002CE;
 Wed,  1 Jul 2020 22:08:49 +0200 (CEST)
From: Alexander Graf <agraf@csgraf.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Treat unknown SMC calls as NOP
Date: Wed,  1 Jul 2020 22:08:48 +0200
Message-Id: <20200701200848.26746-1-agraf@csgraf.de>
X-Mailer: git-send-email 2.16.4
Received-SPF: pass client-ip=188.138.100.120; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 15:51:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently treat unknown SMC calls as UNDEF. This behavior is different
from KVM, which treats them as NOP.

Unfortunately, the UNDEF exception breaks running Windows for ARM in QEMU,
as that probes an OEM SMCCC call on boot, but does not expect to receive
an UNDEF exception as response.

So instead, let's follow the KVM path and ignore SMC calls that we don't
handle. This fixes booting the Windows 10 for ARM preview in TCG for me.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
---
 target/arm/helper.c    |  8 ++++++++
 target/arm/op_helper.c | 13 ++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc9c29f998..bc1bd2e704 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9778,6 +9778,14 @@ void arm_cpu_do_interrupt(CPUState *cs)
         return;
     }
 
+    if (cs->exception_index == EXCP_SMC &&
+        !arm_feature(env, ARM_FEATURE_EL3) &&
+        cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
+        /* Treat unknown SMC calls as NOP, just like KVM */
+        qemu_log_mask(CPU_LOG_INT, "...handled as NOP\n");
+        return;
+    }
+
     /*
      * Semihosting semantics depend on the register width of the code
      * that caused the exception, not the target exception level, so
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index b1065216b2..42b1687860 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -823,7 +823,7 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
      *
      *  Conduit SMC, valid call  Trap to EL2         PSCI Call
      *  Conduit SMC, inval call  Trap to EL2         Undef insn
-     *  Conduit not SMC          Undef insn          Undef insn
+     *  Conduit not SMC          nop                 nop
      */
 
     /* On ARMv8 with EL3 AArch64, SMD applies to both S and NS state.
@@ -838,16 +838,11 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
 
     if (!arm_feature(env, ARM_FEATURE_EL3) &&
         cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
-        /* If we have no EL3 then SMC always UNDEFs and can't be
-         * trapped to EL2. PSCI-via-SMC is a sort of ersatz EL3
-         * firmware within QEMU, and we want an EL2 guest to be able
-         * to forbid its EL1 from making PSCI calls into QEMU's
-         * "firmware" via HCR.TSC, so for these purposes treat
-         * PSCI-via-SMC as implying an EL3.
+        /* If we have no EL3 then we simulate KVM behavior which
+         * simply treats every unknown SMC as a nop.
          * This handles the very last line of the previous table.
          */
-        raise_exception(env, EXCP_UDEF, syn_uncategorized(),
-                        exception_target_el(env));
+        return;
     }
 
     if (cur_el == 1 && (arm_hcr_el2_eff(env) & HCR_TSC)) {
-- 
2.16.4


