Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60FEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8577C206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DX+LxUVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8577C206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igodM-0005eO-3C
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFr-000816-8W
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFp-0008Vc-PZ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFp-0008Sm-IY
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:33 -0500
Received: by mail-wm1-x32a.google.com with SMTP id p17so6238579wmb.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9nM3iGNTG1qevbyU7U0Hu0NpGxKKU4DdwS7KMIMwwQ0=;
 b=DX+LxUVlsv/JRD8WKNvdcKZeYua0buyjqCjhmRjzvDhjfUXNa0f3a8NSdidPaO1V/1
 dAKizpij9zECadcjWT7q6tVaRgaboThF33MGYYuwfOZFlrafIughggQ6epb7iCwdIdTo
 d5iUJdUr6Mbsf6SU1v2l1NYQzDFRk5XS8aKXg9iLKPX1yhfiQC/GYnQcR2phBOLmlF87
 PLDuUnfr1/27mSMUFL0EgQb6OO4BMV1il6b5DewlQf9az88hTiliKuZLo+jCuSviCUCG
 iU4Dy/a3tXhs9sSSAXEHIcXkiLRHSddmpd4OxLZS9/huyTE4smoo1yJmrWbbxuetXsof
 3TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9nM3iGNTG1qevbyU7U0Hu0NpGxKKU4DdwS7KMIMwwQ0=;
 b=Suh+zES2rvU6F0SNqrS+KEM9ztRIhRHs923kF5XsGqQv5t+d5UbVNoKR5McCzOMUjO
 FrCck8kP3RFw2AoSq25VnPmVvHt6Fag7pRahin98vXO1tcR5oRXgW0hYM/znscDzGyl2
 w6gyY3dcfmVy6SUU8b3zcb/mLyZCyaLHUYfqnLXtUvPWzlZHH5xrEnCmfkw8y/xE8kdp
 lLJvYUDF2JYY9DKE2Xs3ozhnYrtPgDzZAo1hfAhU5hNYR+bK/dzPIXVMPJ4D9tFGwvgS
 L6qpiSe6Gj0tgh5P8roYAQyCPcyw3mWl3Gz1QS4qHJaXD0O9Bb/C8naOhBv9DZGuVtA6
 NGtA==
X-Gm-Message-State: APjAAAVqRPK7+bTDVy83LFTTJM26ECVBJywXNhsq6A5o9JceahaF2lvD
 wQiUBFp6wyNF6xEXQb0/Jd6tz7mfUmnceQ==
X-Google-Smtp-Source: APXvYqzJ4mjqgzMZted+YKrtLZEF3TCl0WrBefwa1/WVpiHLwdYXbPvUKkSzFib1rTX5zHMX8HOukA==
X-Received: by 2002:a1c:7e13:: with SMTP id z19mr29502082wmc.67.1576494572199; 
 Mon, 16 Dec 2019 03:09:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/34] target/arm: Handle AArch32 CP15 trapping via HSTR_EL2
Date: Mon, 16 Dec 2019 11:08:53 +0000
Message-Id: <20191216110904.30815-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

From: Marc Zyngier <maz@kernel.org>

HSTR_EL2 offers a way to trap ranges of CP15 system register
accesses to EL2, and it looks like this register is completely
ignored by QEMU.

To avoid adding extra .accessfn filters all over the place (which
would have a direct performance impact), let's add a new TB flag
that gets set whenever HSTR_EL2 is non-zero and that QEMU translates
a context where this trap has a chance to apply, and only generate
the extra access check if the hypervisor is actively using this feature.

Tested with a hand-crafted KVM guest accessing CBAR.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191201122018.25808-5-maz@kernel.org
[PMM: use is_a64(); fix comment syntax]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  2 ++
 target/arm/translate.h |  2 ++
 target/arm/helper.c    |  6 ++++++
 target/arm/op_helper.c | 22 ++++++++++++++++++++++
 target/arm/translate.c |  3 ++-
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d4bac..cebb3511a51 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3215,6 +3215,8 @@ FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC. */
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
+FIELD(TBFLAG_A32, HSTR_ACTIVE, 17, 1)
+
 /* For M profile only, set if FPCCR.LSPACT is set */
 FIELD(TBFLAG_A32, LSPACT, 18, 1)        /* Not cached. */
 /* For M profile only, set if we must create a new FP context */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index dd24f91f265..b837b7fcbf1 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -77,6 +77,8 @@ typedef struct DisasContext {
     bool pauth_active;
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
+    /* True if any CP15 access is trapped by HSTR_EL2 */
+    bool hstr_active;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 93ecab27c0c..0ba08d550aa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11283,6 +11283,12 @@ static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
     if (arm_el_is_aa64(env, 1)) {
         flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
     }
+
+    if (arm_current_el(env) < 2 && env->cp15.hstr_el2 &&
+        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, HSTR_ACTIVE, 1);
+    }
+
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index b529d6c1bf7..e5a346cb87a 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -603,6 +603,27 @@ void HELPER(access_check_cp_reg)(CPUARMState *env, void *rip, uint32_t syndrome,
         raise_exception(env, EXCP_UDEF, syndrome, exception_target_el(env));
     }
 
+    /*
+     * Check for an EL2 trap due to HSTR_EL2. We expect EL0 accesses
+     * to sysregs non accessible at EL0 to have UNDEF-ed already.
+     */
+    if (!is_a64(env) && arm_current_el(env) < 2 && ri->cp == 15 &&
+        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+        uint32_t mask = 1 << ri->crn;
+
+        if (ri->type & ARM_CP_64BIT) {
+            mask = 1 << ri->crm;
+        }
+
+        /* T4 and T14 are RES0 */
+        mask &= ~((1 << 4) | (1 << 14));
+
+        if (env->cp15.hstr_el2 & mask) {
+            target_el = 2;
+            goto exept;
+        }
+    }
+
     if (!ri->accessfn) {
         return;
     }
@@ -652,6 +673,7 @@ void HELPER(access_check_cp_reg)(CPUARMState *env, void *rip, uint32_t syndrome,
         g_assert_not_reached();
     }
 
+exept:
     raise_exception(env, EXCP_UDEF, syndrome, target_el);
 }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4d5d4bd8886..f162be8434f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6897,7 +6897,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
 
-        if (ri->accessfn ||
+        if (s->hstr_active || ri->accessfn ||
             (arm_dc_feature(s, ARM_FEATURE_XSCALE) && cpnum < 14)) {
             /* Emit code to perform further access permissions checks at
              * runtime; this may result in an exception.
@@ -10843,6 +10843,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
                                !arm_el_is_aa64(env, 3);
     dc->thumb = FIELD_EX32(tb_flags, TBFLAG_A32, THUMB);
     dc->sctlr_b = FIELD_EX32(tb_flags, TBFLAG_A32, SCTLR_B);
+    dc->hstr_active = FIELD_EX32(tb_flags, TBFLAG_A32, HSTR_ACTIVE);
     dc->be_data = FIELD_EX32(tb_flags, TBFLAG_ANY, BE_DATA) ? MO_BE : MO_LE;
     condexec = FIELD_EX32(tb_flags, TBFLAG_A32, CONDEXEC);
     dc->condexec_mask = (condexec & 0xf) << 1;
-- 
2.20.1


