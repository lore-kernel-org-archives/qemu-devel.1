Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8F7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3709F2081A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZvgT98FR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3709F2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqN8-00032w-Fu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq45-0002KQ-7K
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq42-0006Nf-Jh
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id k6so9874705wrn.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=q/C+MrAv3LyX7kJ1UQY3ajkzOSlDbvl4DzAQHILGKWs=;
 b=ZvgT98FRViVwUHvkYrI1d0yeX/5/UdKdkavJGJGkeIcTykyLx0j0U1F9H3RJ6BVbaY
 49CBOsGd2nR0qANeNO0cU+Dd20b16a0kPxyIKVxubq3IQ4XiI3FJSjmcvsIfHwWLtuul
 UpiokMBKCRj0ZG2xr6UYiyjZSwENXNzZIKEGsSCKQIl7xiJJf+O/sQ68k2GMK5YIgRGE
 tm7ezg+qON03N2YnjRtmO9QtaoYQvVuB4YB72zPFDggHWTlroIJJ6hhFzJZZ8ek2Vpr/
 cXGyCu9f89Mx7DjwmReVF+JPj1wjjPhP723HOutFThc9UkmrUL/+4nJ+MOjNuXeJ9Qlh
 HZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q/C+MrAv3LyX7kJ1UQY3ajkzOSlDbvl4DzAQHILGKWs=;
 b=O8HFRrOrBrgD4e9fqf9W6nTY+2YxuuV2bM7i2xK7od6lh2t9imcsbTEawtl7xh0isw
 dOx2ZnoxnvB+8GpPuanMBuAQ+4nlUUGGlSnqotd5AeQekReQsG2SsMr4ws/dylKxS8y5
 cqmHKnnqkgQ6UYj6uG0IJX8BTEXrqzGPY4vaJlDKP2fwJRWavBo9vMHAGdgeo8z3hA9R
 38aHTincS8DDgxbf4nbUScPYUCcTlb/HMYavdMFV3CJ8JwpaU5TiRdy5Tx+9cpL289VF
 F6Fpo63IIopvAUdlk71Z80mZ/j0QF61bPERx9MgQOrPzyfxXi+30fRJqXRmwIEEJQW3h
 LKng==
X-Gm-Message-State: AOAM533hfrhpKVpqO5emYWLNTuOkzuRh75wrU1KFEfpVelvnJ3jaRrgy
 1fEbwfivLWks23qAoAc4H8kXiTKilIyL6A==
X-Google-Smtp-Source: ABdhPJzIxzMLKIRVr/tyncRd939tG6VdVy0IuFaK92NuCqPa8bEIbS+BjtpUEALz6E2qJCtDP9izlg==
X-Received: by 2002:a5d:4a01:: with SMTP id m1mr4275650wrq.250.1593184488783; 
 Fri, 26 Jun 2020 08:14:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/57] target/arm: Add MTE bits to tb_flags
Date: Fri, 26 Jun 2020 16:13:47 +0100
Message-Id: <20200626151424.30117-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Cache the composite ATA setting.

Cache when MTE is fully enabled, i.e. access to tags are enabled
and tag checks affect the PE.  Do this for both the normal context
and the UNPRIV context.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           | 12 ++++++++----
 target/arm/internals.h     | 18 +++++++++++++++++
 target/arm/translate.h     |  5 +++++
 target/arm/helper.c        | 40 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  4 ++++
 5 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0a98b6a06d6..cb4f6ba69f2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3187,10 +3187,10 @@ typedef ARMCPU ArchCPU;
  * |              |     |   TBFLAG_A32   |              |
  * |              |     +-----+----------+  TBFLAG_AM32 |
  * |  TBFLAG_ANY  |           |TBFLAG_M32|              |
- * |              |         +-+----------+--------------|
- * |              |         |         TBFLAG_A64        |
- * +--------------+---------+---------------------------+
- *  31          20        15                           0
+ * |              +-----------+----------+--------------|
+ * |              |            TBFLAG_A64               |
+ * +--------------+-------------------------------------+
+ *  31          20                                     0
  *
  * Unless otherwise noted, these bits are cached in env->hflags.
  */
@@ -3257,6 +3257,10 @@ FIELD(TBFLAG_A64, BT, 9, 1)
 FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
 FIELD(TBFLAG_A64, TBID, 12, 2)
 FIELD(TBFLAG_A64, UNPRIV, 14, 1)
+FIELD(TBFLAG_A64, ATA, 15, 1)
+FIELD(TBFLAG_A64, TCMA, 16, 2)
+FIELD(TBFLAG_A64, MTE_ACTIVE, 18, 1)
+FIELD(TBFLAG_A64, MTE0_ACTIVE, 19, 1)
 
 /**
  * cpu_mmu_index:
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 56b46726857..53e249687ba 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1198,6 +1198,24 @@ static inline int exception_target_el(CPUARMState *env)
     return target_el;
 }
 
+/* Determine if allocation tags are available.  */
+static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
+                                                 uint64_t sctlr)
+{
+    if (el < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_ATA)) {
+        return false;
+    }
+    if (el < 2
+        && arm_feature(env, ARM_FEATURE_EL2)
+        && !(arm_hcr_el2_eff(env) & HCR_ATA)) {
+        return false;
+    }
+    sctlr &= (el == 0 ? SCTLR_ATA0 : SCTLR_ATA);
+    return sctlr != 0;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /* Security attributes for an address, as returned by v8m_security_lookup. */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 6dfe24cedc0..98bcc37c479 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -30,6 +30,7 @@ typedef struct DisasContext {
     ARMMMUIdx mmu_idx; /* MMU index to use for normal loads/stores */
     uint8_t tbii;      /* TBI1|TBI0 for insns */
     uint8_t tbid;      /* TBI1|TBI0 for data */
+    uint8_t tcma;      /* TCMA1|TCMA0 for MTE */
     bool ns;        /* Use non-secure CPREG bank on access */
     int fp_excp_el; /* FP exception EL or 0 if enabled */
     int sve_excp_el; /* SVE exception EL or 0 if enabled */
@@ -77,6 +78,10 @@ typedef struct DisasContext {
     bool unpriv;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
+    /* True if v8.5-MTE access to tags is enabled.  */
+    bool ata;
+    /* True if v8.5-MTE tag checks affect the PE; index with is_unpriv.  */
+    bool mte_active[2];
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
     /* True if any CP15 access is trapped by HSTR_EL2 */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b4842ea23eb..2c6ec244af8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10655,6 +10655,16 @@ static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
     }
 }
 
+static int aa64_va_parameter_tcma(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 57, 2);
+    } else {
+        /* Replicate the single TCMA bit so we always have 2 bits.  */
+        return extract32(tcr, 30, 1) * 3;
+    }
+}
+
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data)
 {
@@ -12679,6 +12689,36 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    if (cpu_isar_feature(aa64_mte, env_archcpu(env))) {
+        /*
+         * Set MTE_ACTIVE if any access may be Checked, and leave clear
+         * if all accesses must be Unchecked:
+         * 1) If no TBI, then there are no tags in the address to check,
+         * 2) If Tag Check Override, then all accesses are Unchecked,
+         * 3) If Tag Check Fail == 0, then Checked access have no effect,
+         * 4) If no Allocation Tag Access, then all accesses are Unchecked.
+         */
+        if (allocation_tag_access_enabled(env, el, sctlr)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, ATA, 1);
+            if (tbid
+                && !(env->pstate & PSTATE_TCO)
+                && (sctlr & (el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
+                flags = FIELD_DP32(flags, TBFLAG_A64, MTE_ACTIVE, 1);
+            }
+        }
+        /* And again for unprivileged accesses, if required.  */
+        if (FIELD_EX32(flags, TBFLAG_A64, UNPRIV)
+            && tbid
+            && !(env->pstate & PSTATE_TCO)
+            && (sctlr & SCTLR_TCF0)
+            && allocation_tag_access_enabled(env, 0, sctlr)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, MTE0_ACTIVE, 1);
+        }
+        /* Cache TCMA as well as TBI. */
+        flags = FIELD_DP32(flags, TBFLAG_A64, TCMA,
+                           aa64_va_parameter_tcma(tcr, mmu_idx));
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d4793dd8fea..55f49585be4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14171,6 +14171,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->mmu_idx = core_to_aa64_mmu_idx(core_mmu_idx);
     dc->tbii = FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
     dc->tbid = FIELD_EX32(tb_flags, TBFLAG_A64, TBID);
+    dc->tcma = FIELD_EX32(tb_flags, TBFLAG_A64, TCMA);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
@@ -14182,6 +14183,9 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
     dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
     dc->unpriv = FIELD_EX32(tb_flags, TBFLAG_A64, UNPRIV);
+    dc->ata = FIELD_EX32(tb_flags, TBFLAG_A64, ATA);
+    dc->mte_active[0] = FIELD_EX32(tb_flags, TBFLAG_A64, MTE_ACTIVE);
+    dc->mte_active[1] = FIELD_EX32(tb_flags, TBFLAG_A64, MTE0_ACTIVE);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.20.1


