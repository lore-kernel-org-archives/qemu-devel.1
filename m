Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E7DECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC542064A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WI5AX+15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC542064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvL4-0007vD-RA
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvHt-0003d6-OL
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvHs-0003Nj-FC
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:57 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:34902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvHs-0003N4-Bb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:56 -0400
Received: by mail-yw1-xc43.google.com with SMTP id r134so3500984ywg.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=u6kz9NuK9Wp4TrtRthl3Manwia2sE3vhzut21VwbSSg=;
 b=WI5AX+15EMrGSqPRoSd9m1GVeMzKoIv+IbLNVd57Ti9Qhf7ii5bNn1Gr0f2BXh7JQl
 O3bciESry5V3pSdA4VExdKm+skOnrLcIUbyyicYjy/CDTGlZtPHtOi/VP+dtZXHFZDzo
 yp4+kzdHIPz7Nolj9N0l6DBQN+64oBISD+WYi4dFjrWzIwRz1JnLNt0Ad+92ivX/RJJl
 SVLqEL7c+XtZaeVDmUbwhtokaEdbB7oif71SrC862ricsdPbGh+PSLG4poKXOsFxafdN
 SbbpiO5sm1HCZiihBQNvVg8NZ1j00O3JJ5YLNotKJZaRBFhCRFrUH+aJ5tooe+s5nIQi
 dNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=u6kz9NuK9Wp4TrtRthl3Manwia2sE3vhzut21VwbSSg=;
 b=Llh2xJOj/N1dtfR2GTsXGXZ3HoVI66vhAilkH0omzGuuphEqTf7p7myoPcU/GgUmn+
 qxYDQeWppS9Tn14UvFmF7l+M0U9dEUVWOuD+iEt/Aljua8E3hL/lpzArjo/2YP45w/En
 AlBxgDLganAn6XqAI3hXTUomUV4Ee4afUv9cY3lqEp1zLAkq4bnHh5IxvJeKPtr2KfS2
 lhgTdt/1GiFg8UkDuNjFnDLPmqBA1RwlazUeTyoi3V0WzZlexwPDAdP6Nsg1mXT9xwmH
 pbQ1R6qC2dTQsIjjoG3QVYKbyemZYVrAMWbH+UE+SSbGMjpdLARpocCtl+KaerokEba8
 qpJg==
X-Gm-Message-State: APjAAAU+ira1unB6rrcPZ87Tuo5jLe1yEQ83qlNDEHUMwAVo7BlcEvEU
 BEJUBSNNgTGF0LUV6rvxfDVkgA80CqU=
X-Google-Smtp-Source: APXvYqxgi1QYTsnYYFYLKTE5F+bWDmWVVf+Ysti4uTmrE0Sz5iyQbcoeu6x2pQgl1KlEiiIqDRURnA==
X-Received: by 2002:a81:688a:: with SMTP id d132mr2314569ywc.452.1570801735166; 
 Fri, 11 Oct 2019 06:48:55 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:48:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/22] target/arm: Add MTE system registers
Date: Fri, 11 Oct 2019 09:47:25 -0400
Message-Id: <20191011134744.2477-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is TFSRE0_EL1, TFSR_EL1, TFSR_EL2, TFSR_EL3,
RGSR_EL1, GCR_EL1, GMID_EL1, and PSTATE.TCO.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Add GMID; add access_mte.
v4: Define only TCO at mte_insn_reg.
---
 target/arm/cpu.h           |  3 ++
 target/arm/internals.h     |  6 ++++
 target/arm/helper.c        | 73 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 11 ++++++
 4 files changed, 93 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 408d749b7a..d99bb5e956 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -486,6 +486,9 @@ typedef struct CPUARMState {
         uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
         uint64_t vpidr_el2; /* Virtualization Processor ID Register */
         uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register */
+        uint64_t tfsr_el[4]; /* tfsrel0_el1 is index 0.  */
+        uint64_t gcr_el1;
+        uint64_t rgsr_el1;
     } cp15;
 
     struct {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9486680b87..bfa243be06 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1079,4 +1079,10 @@ void arm_log_exception(int idx);
 
 #endif /* !CONFIG_USER_ONLY */
 
+/*
+ * The log2 of the words in the tag block, for GMID_EL1.BS.
+ * The is the maximum, 256 bytes, which manipulates 64-bits of tags.
+ */
+#define GMID_EL1_BS  6
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f9dee51ede..f435a8d8bd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5921,6 +5921,73 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
     REGINFO_SENTINEL
 };
+
+static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el < 2 &&
+        arm_feature(env, ARM_FEATURE_EL2) &&
+        !(arm_hcr_el2_eff(env) & HCR_ATA)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    if (el < 3 &&
+        arm_feature(env, ARM_FEATURE_EL3) &&
+        !(env->cp15.scr_el3 & SCR_ATA)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static uint64_t tco_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return env->pstate & PSTATE_TCO;
+}
+
+static void tco_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t val)
+{
+    env->pstate = (env->pstate & ~PSTATE_TCO) | (val & PSTATE_TCO);
+}
+
+static const ARMCPRegInfo mte_reginfo[] = {
+    { .name = "TFSRE0_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 6, .crm = 6, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[0]) },
+    { .name = "TFSR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 6, .crm = 5, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
+    { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 6, .crm = 5, .opc2 = 0,
+      .access = PL2_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[2]) },
+    { .name = "TFSR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 6, .crm = 6, .opc2 = 0,
+      .access = PL3_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[3]) },
+    { .name = "RGSR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 5,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.rgsr_el1) },
+    { .name = "GCR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 6,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcr_el1) },
+    { .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = GMID_EL1_BS },
+    REGINFO_SENTINEL
+};
+
+static const ARMCPRegInfo mte_tco_reginfo[] = {
+    { .name = "TCO", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 2, .opc2 = 7,
+      .type = ARM_CP_NO_RAW,
+      .access = PL0_RW, .readfn = tco_read, .writefn = tco_write },
+    REGINFO_SENTINEL
+};
 #endif
 
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6881,6 +6948,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rndr, cpu)) {
         define_arm_cp_regs(cpu, rndr_reginfo);
     }
+    if (cpu_isar_feature(aa64_mte_insn_reg, cpu)) {
+        define_arm_cp_regs(cpu, mte_tco_reginfo);
+    }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        define_arm_cp_regs(cpu, mte_reginfo);
+    }
 #endif
 
     /*
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c85db69db4..62bdf50796 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1611,6 +1611,17 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         s->base.is_jmp = DISAS_UPDATE;
         break;
 
+    case 0x1c: /* TCO */
+        if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        if (crm & 1) {
+            set_pstate_bits(PSTATE_TCO);
+        } else {
+            clear_pstate_bits(PSTATE_TCO);
+        }
+        break;
+
     default:
     do_unallocated:
         unallocated_encoding(s);
-- 
2.17.1


