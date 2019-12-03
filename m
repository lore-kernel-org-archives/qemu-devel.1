Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4918BC43141
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0884E20674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ob/QqOW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0884E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47547 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyLB-0007xX-1U
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxI-0003M4-Sb
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxB-0008Sd-Ba
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:21 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:43739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxA-0008O5-PQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:17 -0500
Received: by mail-pj1-x1043.google.com with SMTP id g4so807900pjs.10
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2do0V8CqM/10UYZ2RnaFTjIn7GR8F62eVWz9oBJpzRE=;
 b=ob/QqOW8SOuhQmV/G+ro7DLzN+UfUL+Z3X9LDVs6m+tQ7hyHDah4jZsQzzAf/14Wgy
 vGDsa5035Y1tMJ1jnEdshjlvr00sctsdAA69sFVZz/kl5+oyaHHwbWLpEzGyIgmBdSen
 avWDFtXuI1AoQjet8p0YBwQNkj3i/ZYjACQRufIDm+nLkFwirfeGHctikgGKsoUZcH1a
 M82b877BeadjyS1KAz51QEkCl6mKvwe2FvjxEeD1JL7hJ+xTNQkdaEa7TByRrMtD2YiU
 ddyn0j3H5gHDaUoE3G1zhr8KeXNl82Vr81c3YFrGLNrTmwL9GRRvVYVyJK3DNIkYekRV
 eYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2do0V8CqM/10UYZ2RnaFTjIn7GR8F62eVWz9oBJpzRE=;
 b=ZOoBMdYJvnM8HwPL/ZrJAmD5MyDADgXZIvErv2DgXzpYIlY5aAmCvIJLQFqhAJasiP
 6J8UhDvsqkBIWO7M+ZBS0ZtJSjQxLHJrN8MD0l41uTX+3v4NPZ4c8hAJplQagUB3Ktx4
 4sq7mwA0qJjsK1XjMPcU3g5PFrulD1cJqMKRlJ8gbdUwAdQGIeNBh5XtqMdubsxh2ken
 KdgDMu0wVXeY94wVbgBL6R+rE2M/WI+XpxBNhPxT2qCW+GqrrtOWlPQvVW/8bwEuqv6x
 WnCfZQGbM72vxSk8HEE5U5wELAYi/fu+J1t1CQ+OVPfitoTD+7ZBlZ35s55KMDvmpmTO
 1MEw==
X-Gm-Message-State: APjAAAVVpzi8qO2exfu0Y+VstZBZx7xsX17I6yAP26BZGTdSxztvLpiE
 tbn0RQHnKLbt6kwlAG5FbXqTNE4BA8s=
X-Google-Smtp-Source: APXvYqxyA8kUMmrFgFrVJAyNLOmVM552ScBdYm7FahHiqqfe8DHFTx4m/MYaW6abgKJpyqAxFMnumQ==
X-Received: by 2002:a17:90a:a114:: with SMTP id
 s20mr2953739pjp.44.1575340214300; 
 Mon, 02 Dec 2019 18:30:14 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 27/40] target/arm: Add VHE system register redirection and
 aliasing
Date: Mon,  2 Dec 2019 18:29:24 -0800
Message-Id: <20191203022937.1474-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

Several of the EL1/0 registers are redirected to the EL2 version when in
EL2 and HCR_EL2.E2H is set.  Many of these registers have side effects.
Link together the two ARMCPRegInfo structures after they have been
properly instantiated.  Install common dispatch routines to all of the
relevant registers.

The same set of registers that are redirected also have additional
EL12/EL02 aliases created to access the original register that was
redirected.

Omit the generic timer registers from redirection here, because we'll
need multiple kinds of redirection from both EL0 and EL2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  44 ++++++++----
 target/arm/helper.c | 162 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4bd1bf915c..bb5a72520e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2488,19 +2488,6 @@ struct ARMCPRegInfo {
      */
     ptrdiff_t fieldoffset; /* offsetof(CPUARMState, field) */
 
-    /* Offsets of the secure and non-secure fields in CPUARMState for the
-     * register if it is banked.  These fields are only used during the static
-     * registration of a register.  During hashing the bank associated
-     * with a given security state is copied to fieldoffset which is used from
-     * there on out.
-     *
-     * It is expected that register definitions use either fieldoffset or
-     * bank_fieldoffsets in the definition but not both.  It is also expected
-     * that both bank offsets are set when defining a banked register.  This
-     * use indicates that a register is banked.
-     */
-    ptrdiff_t bank_fieldoffsets[2];
-
     /* Function for making any access checks for this register in addition to
      * those specified by the 'access' permissions bits. If NULL, no extra
      * checks required. The access check is performed at runtime, not at
@@ -2535,6 +2522,37 @@ struct ARMCPRegInfo {
      * fieldoffset is 0 then no reset will be done.
      */
     CPResetFn *resetfn;
+
+    union {
+        /*
+         * Offsets of the secure and non-secure fields in CPUARMState for
+         * the register if it is banked.  These fields are only used during
+         * the static registration of a register.  During hashing the bank
+         * associated with a given security state is copied to fieldoffset
+         * which is used from there on out.
+         *
+         * It is expected that register definitions use either fieldoffset
+         * or bank_fieldoffsets in the definition but not both.  It is also
+         * expected that both bank offsets are set when defining a banked
+         * register.  This use indicates that a register is banked.
+         */
+        ptrdiff_t bank_fieldoffsets[2];
+
+        /*
+         * "Original" writefn and readfn.
+         * For ARMv8.1-VHE register aliases, we overwrite the read/write
+         * accessor functions of various EL1/EL0 to perform the runtime
+         * check for which sysreg should actually be modified, and then
+         * forwards the operation.  Before overwriting the accessors,
+         * the original function is copied here, so that accesses that
+         * really do go to the EL1/EL0 version proceed normally.
+         * (The corresponding EL2 register is linked via opaque.)
+         */
+        struct {
+            CPReadFn *orig_readfn;
+            CPWriteFn *orig_writefn;
+        };
+    };
 };
 
 /* Macros which are lvalues for the field in CPUARMState for the
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1812588fa1..0baf188078 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5306,6 +5306,158 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+#ifndef CONFIG_USER_ONLY
+/* Test if system register redirection is to occur in the current state.  */
+static bool redirect_for_e2h(CPUARMState *env)
+{
+    return arm_current_el(env) == 2 && (arm_hcr_el2_eff(env) & HCR_E2H);
+}
+
+static uint64_t el2_e2h_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    CPReadFn *readfn;
+
+    if (redirect_for_e2h(env)) {
+        /* Switch to the saved EL2 version of the register.  */
+        ri = ri->opaque;
+        readfn = ri->readfn;
+    } else {
+        readfn = ri->orig_readfn;
+    }
+    if (readfn == NULL) {
+        readfn = raw_read;
+    }
+    return readfn(env, ri);
+}
+
+static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    CPWriteFn *writefn;
+
+    if (redirect_for_e2h(env)) {
+        /* Switch to the saved EL2 version of the register.  */
+        ri = ri->opaque;
+        writefn = ri->writefn;
+    } else {
+        writefn = ri->orig_writefn;
+    }
+    if (writefn == NULL) {
+        writefn = raw_write;
+    }
+    writefn(env, ri, value);
+}
+
+static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
+{
+    struct E2HAlias {
+        uint32_t src_key, dst_key, new_key;
+        const char *src_name, *dst_name, *new_name;
+        bool (*feature)(const ARMISARegisters *id);
+    };
+
+#define K(op0, op1, crn, crm, op2) \
+    ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
+
+    static const struct E2HAlias aliases[] = {
+        { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
+          "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
+        { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
+          "CPACR", "CPTR_EL2", "CPACR_EL12" },
+        { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
+          "TTBR0_EL1", "TTBR0_EL2", "TTBR0_EL12" },
+        { K(3, 0,  2, 0, 1), K(3, 4,  2, 0, 1), K(3, 5, 2, 0, 1),
+          "TTBR1_EL1", "TTBR1_EL2", "TTBR1_EL12" },
+        { K(3, 0,  2, 0, 2), K(3, 4,  2, 0, 2), K(3, 5, 2, 0, 2),
+          "TCR_EL1", "TCR_EL2", "TCR_EL12" },
+        { K(3, 0,  4, 0, 0), K(3, 4,  4, 0, 0), K(3, 5, 4, 0, 0),
+          "SPSR_EL1", "SPSR_EL2", "SPSR_EL12" },
+        { K(3, 0,  4, 0, 1), K(3, 4,  4, 0, 1), K(3, 5, 4, 0, 1),
+          "ELR_EL1", "ELR_EL2", "ELR_EL12" },
+        { K(3, 0,  5, 1, 0), K(3, 4,  5, 1, 0), K(3, 5, 5, 1, 0),
+          "AFSR0_EL1", "AFSR0_EL2", "AFSR0_EL12" },
+        { K(3, 0,  5, 1, 1), K(3, 4,  5, 1, 1), K(3, 5, 5, 1, 1),
+          "AFSR1_EL1", "AFSR1_EL2", "AFSR1_EL12" },
+        { K(3, 0,  5, 2, 0), K(3, 4,  5, 2, 0), K(3, 5, 5, 2, 0),
+          "ESR_EL1", "ESR_EL2", "ESR_EL12" },
+        { K(3, 0,  6, 0, 0), K(3, 4,  6, 0, 0), K(3, 5, 6, 0, 0),
+          "FAR_EL1", "FAR_EL2", "FAR_EL12" },
+        { K(3, 0, 10, 2, 0), K(3, 4, 10, 2, 0), K(3, 5, 10, 2, 0),
+          "MAIR_EL1", "MAIR_EL2", "MAIR_EL12" },
+        { K(3, 0, 10, 3, 0), K(3, 4, 10, 3, 0), K(3, 5, 10, 3, 0),
+          "AMAIR0", "AMAIR_EL2", "AMAIR_EL12" },
+        { K(3, 0, 12, 0, 0), K(3, 4, 12, 0, 0), K(3, 5, 12, 0, 0),
+          "VBAR", "VBAR_EL2", "VBAR_EL12" },
+        { K(3, 0, 13, 0, 1), K(3, 4, 13, 0, 1), K(3, 5, 13, 0, 1),
+          "CONTEXTIDR_EL1", "CONTEXTIDR_EL2", "CONTEXTIDR_EL12" },
+        { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
+          "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
+
+        /*
+         * Note that redirection of ZCR is mentioned in the description
+         * of ZCR_EL2, and aliasing in the description of ZCR_EL1, but
+         * not in the summary table.
+         */
+        { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
+          "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
+
+        /* TODO: ARMv8.2-SPE -- PMSCR_EL2 */
+        /* TODO: ARMv8.4-Trace -- TRFCR_EL2 */
+    };
+#undef K
+
+    size_t i;
+
+    for (i = 0; i < ARRAY_SIZE(aliases); i++) {
+        const struct E2HAlias *a = &aliases[i];
+        ARMCPRegInfo *src_reg, *dst_reg;
+
+        if (a->feature && !a->feature(&cpu->isar)) {
+            continue;
+        }
+
+        src_reg = g_hash_table_lookup(cpu->cp_regs, &a->src_key);
+        dst_reg = g_hash_table_lookup(cpu->cp_regs, &a->dst_key);
+        g_assert(src_reg != NULL);
+        g_assert(dst_reg != NULL);
+
+        /* Cross-compare names to detect typos in the keys.  */
+        g_assert(strcmp(src_reg->name, a->src_name) == 0);
+        g_assert(strcmp(dst_reg->name, a->dst_name) == 0);
+
+        /* None of the core system registers use opaque; we will.  */
+        g_assert(src_reg->opaque == NULL);
+
+        /* Create alias before redirection so we dup the right data. */
+        if (a->new_key) {
+            ARMCPRegInfo *new_reg = g_memdup(src_reg, sizeof(ARMCPRegInfo));
+            uint32_t *new_key = g_memdup(&a->new_key, sizeof(uint32_t));
+            bool ok;
+
+            new_reg->name = a->new_name;
+            new_reg->type |= ARM_CP_ALIAS;
+            /* Remove PL1/PL0 access, leaving PL2/PL3 R/W in place.  */
+            new_reg->access &= 0xf0;
+
+            ok = g_hash_table_insert(cpu->cp_regs, new_key, new_reg);
+            g_assert(ok);
+        }
+
+        src_reg->opaque = dst_reg;
+        src_reg->orig_readfn = src_reg->readfn ?: raw_read;
+        src_reg->orig_writefn = src_reg->writefn ?: raw_write;
+        if (!src_reg->raw_readfn) {
+            src_reg->raw_readfn = raw_read;
+        }
+        if (!src_reg->raw_writefn) {
+            src_reg->raw_writefn = raw_write;
+        }
+        src_reg->readfn = el2_e2h_read;
+        src_reg->writefn = el2_e2h_write;
+    }
+}
+#endif
+
 static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -7142,6 +7294,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         : cpu_isar_feature(aa32_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
+
+#ifndef CONFIG_USER_ONLY
+    /*
+     * Register redirections and aliases must be done last,
+     * after the registers from the other extensions have been defined.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
+        define_arm_vh_e2h_redirects_aliases(cpu);
+    }
+#endif
 }
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
-- 
2.17.1


