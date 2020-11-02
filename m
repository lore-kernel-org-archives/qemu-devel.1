Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45822C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87432225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87432225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXYn-0001dK-Lc
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kZXXQ-0007UX-A7; Mon, 02 Nov 2020 05:58:12 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:39564
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kZXXO-0006lm-KZ; Mon, 02 Nov 2020 05:58:11 -0500
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 7F51560362;
 Mon,  2 Nov 2020 11:58:04 +0100 (CET)
From: remi.denis.courmont@huawei.com
To: qemu-arm@nongnu.org
Subject: [PATCH 09/14] target/arm: add ARMv8.4-SEL2 system registers
Date: Mon,  2 Nov 2020 12:57:57 +0200
Message-Id: <20201102105802.39332-9-remi.denis.courmont@huawei.com>
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

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu.h    |  2 ++
 target/arm/helper.c | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3fbb70e273..c047b17a81 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -323,9 +323,11 @@ typedef struct CPUARMState {
             uint64_t ttbr1_el[4];
         };
         uint64_t vttbr_el2; /* Virtualization Translation Table Base.  */
+        uint64_t vsttbr_el2; /* Secure Virtualization Translation Table. */
         /* MMU translation table base control. */
         TCR tcr_el[4];
         TCR vtcr_el2; /* Virtualization Translation Control.  */
+        TCR vstcr_el2; /* Secure Virtualization Translation Control. */
         uint32_t c2_data; /* MPU data cacheable bits.  */
         uint32_t c2_insn; /* MPU instruction cacheable bits.  */
         union { /* MMU domain access control register
diff --git a/target/arm/helper.c b/target/arm/helper.c
index eeae3ecff2..4c86e4f57c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5724,6 +5724,27 @@ static const ARMCPRegInfo el2_v8_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static CPAccessResult sel2_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_current_el(env) == 3 || arm_is_secure_below_el3(env)) {
+        return CP_ACCESS_OK;
+    }
+    return CP_ACCESS_TRAP_UNCATEGORIZED;
+}
+
+static const ARMCPRegInfo el2_sec_cp_reginfo[] = {
+    { .name = "VSTTBR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 6, .opc2 = 0,
+      .access = PL2_RW, .accessfn = sel2_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.vsttbr_el2) },
+    { .name = "VSTCR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 6, .opc2 = 2,
+      .access = PL2_RW, .accessfn = sel2_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.vstcr_el2) },
+    REGINFO_SENTINEL
+};
+
 static CPAccessResult nsacr_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -7745,6 +7766,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         if (arm_feature(env, ARM_FEATURE_V8)) {
             define_arm_cp_regs(cpu, el2_v8_cp_reginfo);
         }
+        if (cpu_isar_feature(aa64_sel2, cpu)) {
+            define_arm_cp_regs(cpu, el2_sec_cp_reginfo);
+        }
         /* RVBAR_EL2 is only implemented if EL2 is the highest EL */
         if (!arm_feature(env, ARM_FEATURE_EL3)) {
             ARMCPRegInfo rvbar = {
-- 
2.29.1


