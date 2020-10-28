Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E8C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2119A247A8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mDBiqayR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2119A247A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmrP-0003dA-SB
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpn-0001vm-BQ; Wed, 28 Oct 2020 10:53:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpk-00036U-VJ; Wed, 28 Oct 2020 10:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603896832; x=1635432832;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4fmhVEpyTKkxdBEGIbCbnfbyxKg1xJ3rFczT7p5RZD0=;
 b=mDBiqayRkAvwV984skf9YGIAsKpQY+XwW5iG5ancdC2QmBGaQBNIrR4U
 +O5XRtZ8heQiFOpn2wJVdjkLgD+uNViSKr6bpRLMNu+0+opIPN+Dd4Hwc
 JAAL7Hnl6Ff2OF0nX+y1w2DVz8noYU3IkAkNnncAxWIdJXBD4kdV3TbX8
 28Mnt8qFtJ7RNr5IHupl4knESYYbaIl1b49jOlG1v02q8icX4vyklNTWZ
 64m7EtATbEz7afVzHaZesR52+0lTzpaZdEQyoIu/e6MhCci4g12Rrt3TY
 cdeBNW6/Sphj/L3DE7sC3aaq1tFMvM5I+l4xGkcY9EMWurkhhy2pHXzl5 w==;
IronPort-SDR: 7zQjpusSfKj82xKdmhFsh7FyKFvPbRywvDuc8evXJ7j8GMmPR1XHQR3sXBEwZlIFRqYkRC8vzH
 7QC7NRkKnXxBTBiT+gLUQgIn5fRC+E4TPvx2c+YtKp962wsMErGHtcSoJuST1GMByqETy8F3+U
 YQU4wxKgNGYUjVYcGQOGwkDxaZWTtFGmZ0owQZjhm7g608HWGn48ZCKuxb2aFGep+J7tkPSk4p
 Rfv5Sndz+H4IyRppdRAczmp4idjq87BjMDubiSuAyCVlelsjY7NlVH+W/RcooassZ02vS9y/P/
 pRA=
X-IronPort-AV: E=Sophos;i="5.77,426,1596470400"; d="scan'208";a="151200395"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2020 22:53:51 +0800
IronPort-SDR: 9lcpNcthPH48wRakKWzjzZOs8DMiozI6ZpkE3OY5DwbA8/9Yad5V7W7Ombn7cgdY4/kTkwbZqZ
 DgKKpyeuB+LbJVUZr8i4F7aJnIot0Bk/R5vOnM2LJmeqFGO1hQvGOlPohTTOEe4EXjIf3CtsMC
 kR4CVi7GnvFhhq13GttPtJlb5ABQ1+R2yf7jvp2GC4LK5gas6r8eLOJcspBd3SBAoDNrcCOr+9
 c9PK8EiUx9cKm1uxgT7umwdIpcRuOArsEqMyX79qV4PT9wz+RsUkJSp0X7p4NxZ8yKHTxn1lyn
 bdqU/uEQSCB8+xF2F5kNw3ei
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2020 07:39:00 -0700
IronPort-SDR: zqwTBXQlofkXqsNQQNrt9fC1zLylX/o8qWTSv75CcodQXvmrFE3/TjE/lJ/DrYUcBQ85SshibP
 TiLgYJxIcRfY5HpTu87zF9Ol8PcTrQwzWgq+1x/DZ/2xlSUrboMD/7IA+bpm0h4RdYCEsT34kK
 ayJdlnB61R8agN2KbC+glkwKdjXltrMOgZGbBAk7i+bpFLG8m6hSMKEY1CsRcyvVXzFz1H+Ynn
 4HrU4Yh8aKYoylcBcXpbuj7506AvSvE+KZQRKLtAmethXrU7+LY2hUo6u8e1e2vVGAWSkR3EJO
 h5U=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 Oct 2020 07:53:51 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 3/5] target/riscv: Remove the HS_TWO_STAGE flag
Date: Wed, 28 Oct 2020 07:42:26 -0700
Message-Id: <93215b3e15ba7f908eae44885d466dd7e9378b59.1603896075.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603896075.git.alistair.francis@wdc.com>
References: <cover.1603896075.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=563b96974=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 10:53:43
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, richard.henderson@linaro.org, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The HS_TWO_STAGE flag is no longer required as the MMU index contains
the information if we are performing a two stage access.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  3 +-
 target/riscv/cpu_bits.h   |  1 -
 target/riscv/cpu_helper.c | 61 ++++++++++++++++-----------------------
 target/riscv/op_helper.c  | 12 --------
 4 files changed, 26 insertions(+), 51 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5d8e54c426..0cf48a1521 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -323,8 +323,7 @@ bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
 void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
-bool riscv_cpu_two_stage_lookup(CPURISCVState *env);
-void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable);
+bool riscv_cpu_two_stage_lookup(int mmu_idx);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index daedad8691..24b24c69c5 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -469,7 +469,6 @@
  * page table fault.
  */
 #define FORCE_HS_EXCEP      2
-#define HS_TWO_STAGE        4
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 453e4c6d8a..9edf7282d9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -211,22 +211,9 @@ void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
     env->virt = set_field(env->virt, FORCE_HS_EXCEP, enable);
 }
 
-bool riscv_cpu_two_stage_lookup(CPURISCVState *env)
+bool riscv_cpu_two_stage_lookup(int mmu_idx)
 {
-    if (!riscv_has_ext(env, RVH)) {
-        return false;
-    }
-
-    return get_field(env->virt, HS_TWO_STAGE);
-}
-
-void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return;
-    }
-
-    env->virt = set_field(env->virt, HS_TWO_STAGE, enable);
+    return mmu_idx & TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 }
 
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
@@ -337,7 +324,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * was called. Background registers will be used if the guest has
      * forced a two stage translation to be on (in HS or M mode).
      */
-    if (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH) {
+    if ((!riscv_cpu_virt_enabled(env) && riscv_cpu_two_stage_lookup(mmu_idx))
+        && access_type != MMU_INST_FETCH) {
         use_background = true;
     }
 
@@ -576,7 +564,7 @@ restart:
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
                                 MMUAccessType access_type, bool pmp_violation,
-                                bool first_stage)
+                                bool first_stage, bool two_stage)
 {
     CPUState *cs = env_cpu(env);
     int page_fault_exceptions;
@@ -599,8 +587,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_LOAD:
-        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
-            !first_stage) {
+        if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -608,8 +595,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_STORE:
-        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
-            !first_stage) {
+        if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -700,6 +686,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int prot, prot2;
     bool pmp_violation = false;
     bool first_stage_error = true;
+    bool two_stage_lookup = false;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
     target_ulong tlb_size = 0;
@@ -719,11 +706,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         access_type != MMU_INST_FETCH &&
         get_field(env->mstatus, MSTATUS_MPRV) &&
         get_field(env->mstatus, MSTATUS_MPV)) {
-        riscv_cpu_set_two_stage_lookup(env, true);
+        two_stage_lookup = true;
     }
 
     if (riscv_cpu_virt_enabled(env) ||
-        (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH)) {
+        ((riscv_cpu_two_stage_lookup(mmu_idx) || two_stage_lookup) &&
+         access_type != MMU_INST_FETCH)) {
         /* Two stage lookup */
         ret = get_physical_address(env, &pa, &prot, address,
                                    &env->guest_phys_fault_addr, access_type,
@@ -786,14 +774,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
     }
 
-    /* We did the two stage lookup based on MPRV, unset the lookup */
-    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
-        access_type != MMU_INST_FETCH &&
-        get_field(env->mstatus, MSTATUS_MPRV) &&
-        get_field(env->mstatus, MSTATUS_MPV)) {
-        riscv_cpu_set_two_stage_lookup(env, false);
-    }
-
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
@@ -815,7 +795,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type, pmp_violation, first_stage_error);
+        raise_mmu_exception(env, address, access_type, pmp_violation,
+                            first_stage_error,
+                            riscv_cpu_virt_enabled(env) ||
+                                riscv_cpu_two_stage_lookup(mmu_idx));
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 
@@ -919,9 +902,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* handle the trap in S-mode */
         if (riscv_has_ext(env, RVH)) {
             target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
+            bool two_stage_lookup = false;
+
+            if (env->priv == PRV_M ||
+                (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+                (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
+                    get_field(env->hstatus, HSTATUS_HU))) {
+                    two_stage_lookup = true;
+            }
 
-            if ((riscv_cpu_virt_enabled(env) ||
-                 riscv_cpu_two_stage_lookup(env)) && write_tval) {
+            if ((riscv_cpu_virt_enabled(env) || two_stage_lookup) && write_tval) {
                 /*
                  * If we are writing a guest virtual address to stval, set
                  * this to 1. If we are trapping to VS we will set this to 0
@@ -959,11 +949,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 riscv_cpu_set_force_hs_excep(env, 0);
             } else {
                 /* Trap into HS mode */
-                if (!riscv_cpu_two_stage_lookup(env)) {
+                if (!two_stage_lookup) {
                     env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                              riscv_cpu_virt_enabled(env));
                 }
-                riscv_cpu_set_two_stage_lookup(env, false);
                 htval = env->guest_phys_fault_addr;
             }
         }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 548c5851ec..5759850e69 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -237,8 +237,6 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
         target_ulong pte;
         int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        riscv_cpu_set_two_stage_lookup(env, true);
-
         switch (memop) {
         case MO_SB:
             pte = cpu_ldsb_mmuidx_ra(env, address, mmu_idx, GETPC());
@@ -265,8 +263,6 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
             g_assert_not_reached();
         }
 
-        riscv_cpu_set_two_stage_lookup(env, false);
-
         return pte;
     }
 
@@ -287,8 +283,6 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
             get_field(env->hstatus, HSTATUS_HU))) {
         int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        riscv_cpu_set_two_stage_lookup(env, true);
-
         switch (memop) {
         case MO_SB:
         case MO_UB:
@@ -309,8 +303,6 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
             g_assert_not_reached();
         }
 
-        riscv_cpu_set_two_stage_lookup(env, false);
-
         return;
     }
 
@@ -331,8 +323,6 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
         target_ulong pte;
         int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        riscv_cpu_set_two_stage_lookup(env, true);
-
         switch (memop) {
         case MO_TEUW:
             pte = cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
@@ -344,8 +334,6 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
             g_assert_not_reached();
         }
 
-        riscv_cpu_set_two_stage_lookup(env, false);
-
         return pte;
     }
 
-- 
2.28.0


