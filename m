Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E0C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 12:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B09207BB
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 12:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B09207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU7RF-0008WC-RF
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 08:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <georg.kotheimer@kernkonzept.com>)
 id 1kU7PS-00081Z-FQ; Sun, 18 Oct 2020 08:03:34 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]:45575
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <georg.kotheimer@kernkonzept.com>)
 id 1kU7PP-0003UH-2o; Sun, 18 Oct 2020 08:03:34 -0400
Received: from [89.16.142.204] (helo=george-laptop.lan)
 by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) id 1kU7PK-000089-AN; Sun, 18 Oct 2020 14:03:26 +0200
From: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH] target/riscv: Adjust privilege level for HLV(X)/HSV
 instructions
Date: Sun, 18 Oct 2020 14:03:08 +0200
Message-Id: <20201018120308.1712054-1-georg.kotheimer@kernkonzept.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=2a01:4f8:1c1c:b490::2;
 envelope-from=georg.kotheimer@kernkonzept.com; helo=mx.kernkonzept.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.399,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the specification the "field SPVP of hstatus controls the
privilege level of the access" for the hypervisor virtual-machine load
and store instructions HLV, HLVX and HSV.

We introduce the new virtualization register field HS_HYP_LD_ST,
similar to HS_TWO_STAGE, which tracks whether we are currently
executing a hypervisor virtual-macine load or store instruction.

Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 60 ++++++++++++++++++++++++++++++---------
 target/riscv/op_helper.c  |  7 +++++
 4 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de275782e6..a39674a84d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -323,6 +323,8 @@ bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
 void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
 bool riscv_cpu_two_stage_lookup(CPURISCVState *env);
 void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable);
+bool riscv_cpu_hyp_load_store_inst(CPURISCVState *env);
+void riscv_cpu_set_hyp_load_store_inst(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index bd36062877..0983ec6471 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -481,6 +481,7 @@
  */
 #define FORCE_HS_EXCEP      2
 #define HS_TWO_STAGE        4
+#define HS_HYP_LD_ST        8
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 904899054d..58d1fa2675 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -238,6 +238,24 @@ void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable)
     env->virt = set_field(env->virt, HS_TWO_STAGE, enable);
 }
 
+bool riscv_cpu_hyp_load_store_inst(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, HS_HYP_LD_ST);
+}
+
+void riscv_cpu_set_hyp_load_store_inst(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, HS_HYP_LD_ST, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
@@ -346,7 +364,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         use_background = true;
     }
 
-    if (mode == PRV_M && access_type != MMU_INST_FETCH) {
+    /* MPRV does not affect the virtual-machine load/store
+       instructions, HLV, HLVX, and HSV. */
+    if (riscv_cpu_hyp_load_store_inst(env)) {
+        mode = get_field(env->hstatus, HSTATUS_SPVP);
+    } else if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
         }
@@ -711,17 +733,21 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    if (mode == PRV_M && access_type != MMU_INST_FETCH) {
+    /* MPRV does not affect the virtual-machine load/store
+       instructions, HLV, HLVX, and HSV. */
+    if (riscv_cpu_hyp_load_store_inst(env)) {
+        mode = get_field(env->hstatus, HSTATUS_SPVP);
+    } else if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
         }
-    }
 
-    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
-        access_type != MMU_INST_FETCH &&
-        get_field(env->mstatus, MSTATUS_MPRV) &&
-        MSTATUS_MPV_ISSET(env)) {
-        riscv_cpu_set_two_stage_lookup(env, true);
+        if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
+            access_type != MMU_INST_FETCH &&
+            get_field(env->mstatus, MSTATUS_MPRV) &&
+            MSTATUS_MPV_ISSET(env)) {
+            riscv_cpu_set_two_stage_lookup(env, true);
+        }
     }
 
     if (riscv_cpu_virt_enabled(env) ||
@@ -777,12 +803,16 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
     }
 
-    /* We did the two stage lookup based on MPRV, unset the lookup */
-    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
-        access_type != MMU_INST_FETCH &&
-        get_field(env->mstatus, MSTATUS_MPRV) &&
-        MSTATUS_MPV_ISSET(env)) {
-        riscv_cpu_set_two_stage_lookup(env, false);
+    /* MPRV does not affect the virtual-machine load/store
+       instructions, HLV, HLVX, and HSV. */
+    if (!riscv_cpu_hyp_load_store_inst(env)) {
+        /* We did the two stage lookup based on MPRV, unset the lookup */
+        if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
+            access_type != MMU_INST_FETCH &&
+            get_field(env->mstatus, MSTATUS_MPRV) &&
+            MSTATUS_MPV_ISSET(env)) {
+            riscv_cpu_set_two_stage_lookup(env, false);
+        }
     }
 
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
@@ -949,6 +979,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 riscv_cpu_set_two_stage_lookup(env, false);
                 htval = env->guest_phys_fault_addr;
             }
+
+            riscv_cpu_set_hyp_load_store_inst(env, false);
         }
 
         s = env->mstatus;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 9b9ada45a9..905a924255 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -240,6 +240,7 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
             get_field(env->hstatus, HSTATUS_HU))) {
         target_ulong pte;
 
+        riscv_cpu_set_hyp_load_store_inst(env, true);
         riscv_cpu_set_two_stage_lookup(env, true);
 
         switch (memop) {
@@ -269,6 +270,7 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
         }
 
         riscv_cpu_set_two_stage_lookup(env, false);
+        riscv_cpu_set_hyp_load_store_inst(env, false);
 
         return pte;
     }
@@ -288,6 +290,8 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
         (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
         (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
             get_field(env->hstatus, HSTATUS_HU))) {
+
+        riscv_cpu_set_hyp_load_store_inst(env, true);
         riscv_cpu_set_two_stage_lookup(env, true);
 
         switch (memop) {
@@ -311,6 +315,7 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
         }
 
         riscv_cpu_set_two_stage_lookup(env, false);
+        riscv_cpu_set_hyp_load_store_inst(env, false);
 
         return;
     }
@@ -331,6 +336,7 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
             get_field(env->hstatus, HSTATUS_HU))) {
         target_ulong pte;
 
+        riscv_cpu_set_hyp_load_store_inst(env, true);
         riscv_cpu_set_two_stage_lookup(env, true);
 
         switch (memop) {
@@ -345,6 +351,7 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
         }
 
         riscv_cpu_set_two_stage_lookup(env, false);
+        riscv_cpu_set_hyp_load_store_inst(env, false);
 
         return pte;
     }
-- 
2.25.1


