Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861CFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 22:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A47B20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 22:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A47B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnr5m-0008Fk-Jf
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 18:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnr5E-0007ks-62; Tue, 23 Jun 2020 18:08:00 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnr5B-00040d-Pi; Tue, 23 Jun 2020 18:07:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.134728-0.00237387-0.862898;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03299; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=8; SR=0; TI=SMTPD_---.HrRYorK_1592950073; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HrRYorK_1592950073)
 by smtp.aliyun-inc.com(10.147.41.121);
 Wed, 24 Jun 2020 06:07:53 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v11 04/61] target/riscv: add vector configure instruction
Date: Wed, 24 Jun 2020 05:58:23 +0800
Message-Id: <20200623215920.2594-5-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
References: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 17:32:41
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, Alistair Francis <alistair.francis@wdc.com>,
 palmer@dabbelt.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vsetvl and vsetvli are two configure instructions for vl, vtype. TB flags
should update after configure instructions. The (ill, lmul, sew ) of vtype
and the bit of (VSTART == 0 && VL == VLMAX) will be placed within tb_flags.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/Makefile.objs              |  2 +-
 target/riscv/cpu.h                      | 63 +++++++++++++++++---
 target/riscv/helper.h                   |  3 +
 target/riscv/insn32.decode              |  5 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 79 +++++++++++++++++++++++++
 target/riscv/translate.c                | 17 +++++-
 target/riscv/vector_helper.c            | 53 +++++++++++++++++
 7 files changed, 210 insertions(+), 12 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
 create mode 100644 target/riscv/vector_helper.c

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index ff651f69f6..ff38df6219 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o
+obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o vector_helper.o gdbstub.o
 obj-$(CONFIG_SOFTMMU) += pmp.o
 
 ifeq ($(CONFIG_SOFTMMU),y)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 302e0859a0..0ad51c6580 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -21,6 +21,7 @@
 #define RISCV_CPU_H
 
 #include "hw/core/cpu.h"
+#include "hw/registerfields.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat-types.h"
 
@@ -93,6 +94,12 @@ typedef struct CPURISCVState CPURISCVState;
 
 #define RV_VLEN_MAX 512
 
+FIELD(VTYPE, VLMUL, 0, 2)
+FIELD(VTYPE, VSEW, 2, 3)
+FIELD(VTYPE, VEDIV, 5, 2)
+FIELD(VTYPE, RESERVED, 7, sizeof(target_ulong) * 8 - 9)
+FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 2, 1)
+
 struct CPURISCVState {
     target_ulong gpr[32];
     uint64_t fpr[32]; /* assume both F and D extensions */
@@ -352,19 +359,62 @@ void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 #define TB_FLAGS_MMU_MASK   3
 #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
 
+typedef CPURISCVState CPUArchState;
+typedef RISCVCPU ArchCPU;
+#include "exec/cpu-all.h"
+
+FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
+FIELD(TB_FLAGS, LMUL, 3, 2)
+FIELD(TB_FLAGS, SEW, 5, 3)
+FIELD(TB_FLAGS, VILL, 8, 1)
+
+/*
+ * A simplification for VLMAX
+ * = (1 << LMUL) * VLEN / (8 * (1 << SEW))
+ * = (VLEN << LMUL) / (8 << SEW)
+ * = (VLEN << LMUL) >> (SEW + 3)
+ * = VLEN >> (SEW + 3 - LMUL)
+ */
+static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
+{
+    uint8_t sew, lmul;
+
+    sew = FIELD_EX64(vtype, VTYPE, VSEW);
+    lmul = FIELD_EX64(vtype, VTYPE, VLMUL);
+    return cpu->cfg.vlen >> (sew + 3 - lmul);
+}
+
 static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+                                        target_ulong *cs_base, uint32_t *pflags)
 {
+    uint32_t flags = 0;
+
     *pc = env->pc;
     *cs_base = 0;
+
+    if (riscv_has_ext(env, RVV)) {
+        uint32_t vlmax = vext_get_vlmax(env_archcpu(env), env->vtype);
+        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl);
+        flags = FIELD_DP32(flags, TB_FLAGS, VILL,
+                    FIELD_EX64(env->vtype, VTYPE, VILL));
+        flags = FIELD_DP32(flags, TB_FLAGS, SEW,
+                    FIELD_EX64(env->vtype, VTYPE, VSEW));
+        flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
+                    FIELD_EX64(env->vtype, VTYPE, VLMUL));
+        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
+    } else {
+        flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
+    }
+
 #ifdef CONFIG_USER_ONLY
-    *flags = TB_FLAGS_MSTATUS_FS;
+    flags |= TB_FLAGS_MSTATUS_FS;
 #else
-    *flags = cpu_mmu_index(env, 0);
+    flags |= cpu_mmu_index(env, 0);
     if (riscv_cpu_fp_enabled(env)) {
-        *flags |= env->mstatus & MSTATUS_FS;
+        flags |= env->mstatus & MSTATUS_FS;
     }
 #endif
+    *pflags = flags;
 }
 
 int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
@@ -405,9 +455,4 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
-typedef CPURISCVState CPUArchState;
-typedef RISCVCPU ArchCPU;
-
-#include "exec/cpu-all.h"
-
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b36be978d5..8e81ff440b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -81,3 +81,6 @@ DEF_HELPER_1(tlb_flush, void, env)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(hyp_tlb_flush, void, env)
 #endif
+
+/* Vector functions */
+DEF_HELPER_3(vsetvl, tl, env, tl, tl)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4c8d1215ce..1916cf331d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -62,6 +62,7 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
 @hfence_vvma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -209,3 +210,7 @@ fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
 # *** RV32H Base Instruction Set ***
 hfence_gvma 0110001  .....  ..... 000 00000 1110011 @hfence_gvma
 hfence_vvma 0010001  .....  ..... 000 00000 1110011 @hfence_vvma
+
+# *** RV32V Extension ***
+vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
+vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
new file mode 100644
index 0000000000..c82fdf013e
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -0,0 +1,79 @@
+/*
+ * RISC-V translation routines for the RVV Standard Extension.
+ *
+ * Copyright (c) 2020 T-Head Semiconductor Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
+{
+    TCGv s1, s2, dst;
+
+    if (!has_ext(ctx, RVV)) {
+        return false;
+    }
+
+    s2 = tcg_temp_new();
+    dst = tcg_temp_new();
+
+    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
+    if (a->rs1 == 0) {
+        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
+        s1 = tcg_const_tl(RV_VLEN_MAX);
+    } else {
+        s1 = tcg_temp_new();
+        gen_get_gpr(s1, a->rs1);
+    }
+    gen_get_gpr(s2, a->rs2);
+    gen_helper_vsetvl(dst, cpu_env, s1, s2);
+    gen_set_gpr(a->rd, dst);
+    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
+    lookup_and_goto_ptr(ctx);
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    tcg_temp_free(s1);
+    tcg_temp_free(s2);
+    tcg_temp_free(dst);
+    return true;
+}
+
+static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
+{
+    TCGv s1, s2, dst;
+
+    if (!has_ext(ctx, RVV)) {
+        return false;
+    }
+
+    s2 = tcg_const_tl(a->zimm);
+    dst = tcg_temp_new();
+
+    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
+    if (a->rs1 == 0) {
+        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
+        s1 = tcg_const_tl(RV_VLEN_MAX);
+    } else {
+        s1 = tcg_temp_new();
+        gen_get_gpr(s1, a->rs1);
+    }
+    gen_helper_vsetvl(dst, cpu_env, s1, s2);
+    gen_set_gpr(a->rd, dst);
+    gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    tcg_temp_free(s1);
+    tcg_temp_free(s2);
+    tcg_temp_free(dst);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b269f15920..cacb9b9cd3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -56,6 +56,12 @@ typedef struct DisasContext {
        to reset this known value.  */
     int frm;
     bool ext_ifencei;
+    /* vector extension */
+    bool vill;
+    uint8_t lmul;
+    uint8_t sew;
+    uint16_t vlen;
+    bool vl_eq_vlmax;
 } DisasContext;
 
 #ifdef TARGET_RISCV64
@@ -712,6 +718,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rvf.inc.c"
 #include "insn_trans/trans_rvd.inc.c"
 #include "insn_trans/trans_rvh.inc.c"
+#include "insn_trans/trans_rvv.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
 /* Include the auto-generated decoder for 16 bit insn */
@@ -746,10 +753,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cs->env_ptr;
     RISCVCPU *cpu = RISCV_CPU(cs);
+    uint32_t tb_flags = ctx->base.tb->flags;
 
     ctx->pc_succ_insn = ctx->base.pc_first;
-    ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
-    ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
+    ctx->mem_idx = tb_flags & TB_FLAGS_MMU_MASK;
+    ctx->mstatus_fs = tb_flags & TB_FLAGS_MSTATUS_FS;
     ctx->priv_ver = env->priv_ver;
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVH)) {
@@ -773,6 +781,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->misa = env->misa;
     ctx->frm = -1;  /* unknown rounding mode */
     ctx->ext_ifencei = cpu->cfg.ext_ifencei;
+    ctx->vlen = cpu->cfg.vlen;
+    ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
+    ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
+    ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
+    ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
new file mode 100644
index 0000000000..40ed0d55e7
--- /dev/null
+++ b/target/riscv/vector_helper.c
@@ -0,0 +1,53 @@
+/*
+ * RISC-V Vector Extension Helpers for QEMU.
+ *
+ * Copyright (c) 2020 T-Head Semiconductor Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include <math.h>
+
+target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
+                            target_ulong s2)
+{
+    int vlmax, vl;
+    RISCVCPU *cpu = env_archcpu(env);
+    uint16_t sew = 8 << FIELD_EX64(s2, VTYPE, VSEW);
+    uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
+    bool vill = FIELD_EX64(s2, VTYPE, VILL);
+    target_ulong reserved = FIELD_EX64(s2, VTYPE, RESERVED);
+
+    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
+        /* only set vill bit. */
+        env->vtype = FIELD_DP64(0, VTYPE, VILL, 1);
+        env->vl = 0;
+        env->vstart = 0;
+        return 0;
+    }
+
+    vlmax = vext_get_vlmax(cpu, s2);
+    if (s1 <= vlmax) {
+        vl = s1;
+    } else {
+        vl = vlmax;
+    }
+    env->vl = vl;
+    env->vtype = s2;
+    env->vstart = 0;
+    return vl;
+}
-- 
2.23.0


