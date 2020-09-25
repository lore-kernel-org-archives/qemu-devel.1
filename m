Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A499C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6743206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6743206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkDW-0001mp-ML
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.price@arm.com>)
 id 1kLk9S-0000OD-1a
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:36:26 -0400
Received: from foss.arm.com ([217.140.110.172]:32882)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steven.price@arm.com>) id 1kLk9P-0002Qm-Q1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:36:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D77011B3;
 Fri, 25 Sep 2020 02:36:22 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EAD83F718;
 Fri, 25 Sep 2020 02:36:20 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v3 1/2] arm64: kvm: Save/restore MTE registers
Date: Fri, 25 Sep 2020 10:36:06 +0100
Message-Id: <20200925093607.3051-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925093607.3051-1-steven.price@arm.com>
References: <20200925093607.3051-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=steven.price@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 05:36:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Haibo Xu <Haibo.Xu@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, qemu-devel@nongnu.org,
 Dave Martin <Dave.Martin@arm.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define the new system registers that MTE introduces and context switch
them. The MTE feature is still hidden from the ID register as it isn't
supported in a VM yet.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_host.h          |  4 ++++
 arch/arm64/include/asm/sysreg.h            |  3 ++-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
 arch/arm64/kvm/sys_regs.c                  | 14 ++++++++++----
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e52c927aade5..4f4360dd149e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -126,6 +126,8 @@ enum vcpu_sysreg {
 	SCTLR_EL1,	/* System Control Register */
 	ACTLR_EL1,	/* Auxiliary Control Register */
 	CPACR_EL1,	/* Coprocessor Access Control */
+	RGSR_EL1,	/* Random Allocation Tag Seed Register */
+	GCR_EL1,	/* Tag Control Register */
 	ZCR_EL1,	/* SVE Control */
 	TTBR0_EL1,	/* Translation Table Base Register 0 */
 	TTBR1_EL1,	/* Translation Table Base Register 1 */
@@ -142,6 +144,8 @@ enum vcpu_sysreg {
 	TPIDR_EL1,	/* Thread ID, Privileged */
 	AMAIR_EL1,	/* Aux Memory Attribute Indirection Register */
 	CNTKCTL_EL1,	/* Timer Control Register (EL1) */
+	TFSRE0_EL1,	/* Tag Fault Status Register (EL0) */
+	TFSR_EL1,	/* Tag Fault Stauts Register (EL1) */
 	PAR_EL1,	/* Physical Address Register */
 	MDSCR_EL1,	/* Monitor Debug System Control Register */
 	MDCCINT_EL1,	/* Monitor Debug Comms Channel Interrupt Enable Reg */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 52eefe2f7d95..cd60677551b7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -563,7 +563,8 @@
 #define SCTLR_ELx_M	(BIT(0))
 
 #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M  | SCTLR_ELx_A | SCTLR_ELx_C | \
-			 SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB)
+			 SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB | \
+			 SCTLR_ELx_ITFSB)
 
 /* SCTLR_EL2 specific flags. */
 #define SCTLR_EL2_RES1	((BIT(4))  | (BIT(5))  | (BIT(11)) | (BIT(16)) | \
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 7a986030145f..a124ffa49ba3 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -18,6 +18,11 @@
 static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
+	if (system_supports_mte()) {
+		ctxt_sys_reg(ctxt, RGSR_EL1)	= read_sysreg_s(SYS_RGSR_EL1);
+		ctxt_sys_reg(ctxt, GCR_EL1)	= read_sysreg_s(SYS_GCR_EL1);
+		ctxt_sys_reg(ctxt, TFSRE0_EL1)	= read_sysreg_s(SYS_TFSRE0_EL1);
+	}
 }
 
 static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
@@ -45,6 +50,8 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 	ctxt_sys_reg(ctxt, CNTKCTL_EL1)	= read_sysreg_el1(SYS_CNTKCTL);
 	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg(par_el1);
 	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);
+	if (system_supports_mte())
+		ctxt_sys_reg(ctxt, TFSR_EL1) = read_sysreg_el1(SYS_TFSR);
 
 	ctxt_sys_reg(ctxt, SP_EL1)	= read_sysreg(sp_el1);
 	ctxt_sys_reg(ctxt, ELR_EL1)	= read_sysreg_el1(SYS_ELR);
@@ -63,6 +70,11 @@ static inline void __sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
 static inline void __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, MDSCR_EL1),  mdscr_el1);
+	if (system_supports_mte()) {
+		write_sysreg_s(ctxt_sys_reg(ctxt, RGSR_EL1), SYS_RGSR_EL1);
+		write_sysreg_s(ctxt_sys_reg(ctxt, GCR_EL1), SYS_GCR_EL1);
+		write_sysreg_s(ctxt_sys_reg(ctxt, TFSRE0_EL1), SYS_TFSRE0_EL1);
+	}
 }
 
 static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
@@ -106,6 +118,8 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 	write_sysreg_el1(ctxt_sys_reg(ctxt, CNTKCTL_EL1), SYS_CNTKCTL);
 	write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),	par_el1);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),	tpidr_el1);
+	if (system_supports_mte())
+		write_sysreg_el1(ctxt_sys_reg(ctxt, TFSR_EL1), SYS_TFSR);
 
 	if (!has_vhe() &&
 	    cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT) &&
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 379f4969d0bd..a655f172b5ad 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1391,6 +1391,12 @@ static bool access_mte_regs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return false;
 }
 
+static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
+				   const struct sys_reg_desc *rd)
+{
+	return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
+}
+
 /* sys_reg_desc initialiser for known cpufeature ID registers */
 #define ID_SANITISED(name) {			\
 	SYS_DESC(SYS_##name),			\
@@ -1557,8 +1563,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ACTLR_EL1), access_actlr, reset_actlr, ACTLR_EL1 },
 	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
 
-	{ SYS_DESC(SYS_RGSR_EL1), access_mte_regs },
-	{ SYS_DESC(SYS_GCR_EL1), access_mte_regs },
+	{ SYS_DESC(SYS_RGSR_EL1), access_mte_regs, reset_unknown, RGSR_EL1, .visibility = mte_visibility },
+	{ SYS_DESC(SYS_GCR_EL1), access_mte_regs, reset_unknown, GCR_EL1, .visibility = mte_visibility },
 
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
@@ -1584,8 +1590,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
 
-	{ SYS_DESC(SYS_TFSR_EL1), access_mte_regs },
-	{ SYS_DESC(SYS_TFSRE0_EL1), access_mte_regs },
+	{ SYS_DESC(SYS_TFSR_EL1), access_mte_regs, reset_unknown, TFSR_EL1, .visibility = mte_visibility },
+	{ SYS_DESC(SYS_TFSRE0_EL1), access_mte_regs, reset_unknown, TFSRE0_EL1, .visibility = mte_visibility },
 
 	{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
 	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
-- 
2.20.1


