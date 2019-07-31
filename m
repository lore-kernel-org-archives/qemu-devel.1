Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3870C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37CE2171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FnckERwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37CE2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvVS-0000OX-T4
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMw-000564-WF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMv-0003bd-Jx
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMv-0003au-EL
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:41 -0400
Received: by mail-pf1-x441.google.com with SMTP id t16so32483842pfe.11
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=trlNGPogxXBK9OHHkWCBGsx/W/Lwzy6lbLUgzLGbb4A=;
 b=FnckERwDmDIWWSq+DLNZGvLiUHOrNRx2cZ9VfPjMtiB92cIz1roDmLiFD7HvVwmpkW
 6qGkDMkHKnGBjfzEa206YBOv4NGezzn1SePqNbJkbPIU9d8rG/iiVO5GFHVbmA2/bLFG
 0MHopL3QvcgO73DQaOTvXlIBrareISyUWIBuzMOnoqJzKgLC8YYCWgHvH+QnSuMNZmv1
 pzH/ujw2eO/6r/ECClBwZdPCSXk36wpchu3lKwwHPuKtSMfA2tp+UNYinFK+xdoAH6re
 JWS17iGGpWNTUr9JrE4bam+5vDoqSp6I6gMqRe2/5HbYitTCuRlgwW+bgR1Q03M84F0O
 7Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=trlNGPogxXBK9OHHkWCBGsx/W/Lwzy6lbLUgzLGbb4A=;
 b=S2EIHWYqhU+Wo8v8/DglYh+K58mHiv2cosLF3ylFDG/vTtf/R9ocQrd7zlvtxFpDsR
 el3yEOdtgvkMYN3oZFJlwR62/0+GRNijPlUe9sfmoQKOim+ZYjgGLKLvgMg0wVF7zw3s
 eItRpzB4Uci3xdGtt6J3NYXow6Bs9GvEHiC7BLsooUtkMwPSPoUB7SQtJFM6Me4jxfHh
 UeH8S9KItWAktADbNi0C+NYetNQrQCVACjvHG3otIfB4A8ss6gMfL42wJjK76fw95S+x
 q1DpUWXgpUxzGAUHyAt7qNaEm2VZL4DkC+mIQFtykmVtIJzJZ+so6ngnVFEVe9F7EFmA
 kZIQ==
X-Gm-Message-State: APjAAAUik39XS0TNhXeUbj3mf96D0VBS9k5nYHeTJSuhaSDcL2SG21ZV
 xadYcPaEqjBOMNwp/sQt87BsJvxDrpY=
X-Google-Smtp-Source: APXvYqxWjZ7IxLToKxY6I3CKj5IZHVw8vuKJNV16ChWEFEdhM+8u4ipR5eI3r7dsp0t7YQiaQyYb+A==
X-Received: by 2002:a65:5202:: with SMTP id o2mr90826501pgp.29.1564605520120; 
 Wed, 31 Jul 2019 13:38:40 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:01 -0700
Message-Id: <20190731203813.30765-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 20/32] target/arm: Rename ARMMMUIdx_S1E2 to
 ARMMMUIdx_E2
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

This is part of a reorganization to the set of mmu_idx.
The non-secure EL2 regime only has a single stage translation;
there is no point in pointing out that the idx is for stage1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       |  4 ++--
 target/arm/internals.h |  2 +-
 target/arm/helper.c    | 24 ++++++++++++------------
 target/arm/translate.c |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94337b2fb0..552269daad 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2852,7 +2852,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 typedef enum ARMMMUIdx {
     ARMMMUIdx_EL10_0 = 0 | ARM_MMU_IDX_A,
     ARMMMUIdx_EL10_1 = 1 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E2 = 2 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE1 = 5 | ARM_MMU_IDX_A,
@@ -2878,7 +2878,7 @@ typedef enum ARMMMUIdx {
 typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_EL10_0 = 1 << 0,
     ARMMMUIdxBit_EL10_1 = 1 << 1,
-    ARMMMUIdxBit_S1E2 = 1 << 2,
+    ARMMMUIdxBit_E2 = 1 << 2,
     ARMMMUIdxBit_SE3 = 1 << 3,
     ARMMMUIdxBit_SE0 = 1 << 4,
     ARMMMUIdxBit_SE1 = 1 << 5,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index dbb46da549..027878516f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -812,7 +812,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_EL10_1:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_S1E2:
+    case ARMMMUIdx_E2:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e5b07b4770..69c913d824 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -740,7 +740,7 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -748,7 +748,7 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -757,7 +757,7 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
 }
 
 static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -767,7 +767,7 @@ static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S1E2);
+                                             ARMMMUIdxBit_E2);
 }
 
 static const ARMCPRegInfo cp_reginfo[] = {
@@ -3167,7 +3167,7 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
     MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t par64;
 
-    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_S1E2);
+    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 }
@@ -3195,7 +3195,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
             mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
             break;
         case 4: /* AT S1E2R, AT S1E2W */
-            mmu_idx = ARMMMUIdx_S1E2;
+            mmu_idx = ARMMMUIdx_E2;
             break;
         case 6: /* AT S1E3R, AT S1E3W */
             mmu_idx = ARMMMUIdx_SE3;
@@ -3958,7 +3958,7 @@ static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3984,7 +3984,7 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4006,7 +4006,7 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4059,7 +4059,7 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S1E2);
+                                             ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4375,7 +4375,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "AT_S12E0W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 7,
       .access = PL2_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
-    /* AT S1E2* are elsewhere as they UNDEF from EL3 if EL2 is not present */
+    /* AT E2* are elsewhere as they UNDEF from EL3 if EL2 is not present */
     { .name = "AT_S1E3R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 0,
       .access = PL3_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
@@ -8691,7 +8691,7 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_Stage2:
-    case ARMMMUIdx_S1E2:
+    case ARMMMUIdx_E2:
         return 2;
     case ARMMMUIdx_SE3:
         return 3;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5372947e47..4e79dbbdfc 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -152,7 +152,7 @@ static inline int get_a32_user_mem_index(DisasContext *s)
      *  otherwise, access as if at PL0.
      */
     switch (s->mmu_idx) {
-    case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
+    case ARMMMUIdx_E2:        /* this one is UNPREDICTABLE */
     case ARMMMUIdx_EL10_0:
     case ARMMMUIdx_EL10_1:
         return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);
-- 
2.17.1


