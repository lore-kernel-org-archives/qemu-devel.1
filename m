Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2343BC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6D62067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6D62067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCPRY-0006JC-3N
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCPQq-0005q0-B1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCPQo-0004MQ-4x
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:07:32 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCPQm-0004Et-6S; Thu, 12 Mar 2020 11:07:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_alarm|0.143894-0.00238041-0.853725; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03305; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=10; RT=10; SR=0;
 TI=SMTPD_---.H-NV6tB_1584025637; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-NV6tB_1584025637)
 by smtp.aliyun-inc.com(10.147.42.241);
 Thu, 12 Mar 2020 23:07:17 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 04/60] target/riscv: add vector configure instruction
Date: Thu, 12 Mar 2020 22:58:04 +0800
Message-Id: <20200312145900.2054-5-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vsetvl and vsetvli are two configure instructions for vl, vtype. TB flags
should update after configure instructions. The (ill, lmul, sew ) of vtype
and the bit of (VSTART == 0 && VL == VLMAX) will be placed within tb_flags.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/Makefile.objs              |  2 +-
 target/riscv/cpu.h                      | 63 ++++++++++++++++++----
 target/riscv/helper.h                   |  2 +
 target/riscv/insn32.decode              |  5 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 69 +++++++++++++++++++++++++
 target/riscv/translate.c                | 17 +++++-
 target/riscv/vector_helper.c            | 53 +++++++++++++++++++
 7 files changed, 199 insertions(+), 12 deletions(-)
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
index 603715f849..505d1a8515 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -21,6 +21,7 @@
 #define RISCV_CPU_H
 
 #include "hw/core/cpu.h"
+#include "hw/registerfields.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat-types.h"
 
@@ -99,6 +100,12 @@ typedef struct CPURISCVState CPURISCVState;
 
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
@@ -358,19 +365,62 @@ void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
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
+    if (env->misa & RVV) {
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
@@ -411,9 +461,4 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
-typedef CPURISCVState CPUArchState;
-typedef RISCVCPU ArchCPU;
-
-#include "exec/cpu-all.h"
-
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index debb22a480..3c28c7e407 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -76,3 +76,5 @@ DEF_HELPER_2(mret, tl, env, tl)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 #endif
+/* Vector functions */
+DEF_HELPER_3(vsetvl, tl, env, tl, tl)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b883672e63..53340bdbc4 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -62,6 +62,7 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
 @hfence_bvma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -207,3 +208,7 @@ fcvt_w_d   1100001  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_wu_d  1100001  00001 ..... ... ..... 1010011 @r2_rm
 fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
+
+# *** RV32V Extension ***
+vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
+vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
new file mode 100644
index 0000000000..da82c72bbf
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -0,0 +1,69 @@
+/*
+ * RISC-V translation routines for the RVV Standard Extension.
+ *
+ * Copyright (c) 2020 C-SKY Limited. All rights reserved.
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
+static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
+{
+    TCGv s1, s2, dst;
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
+    exit_tb(ctx);
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    tcg_temp_free(s1);
+    tcg_temp_free(s2);
+    tcg_temp_free(dst);
+    return true;
+}
+
+static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
+{
+    TCGv s1, s2, dst;
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
index 43bf7e39a6..af07ac4160 100644
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
@@ -711,6 +717,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rva.inc.c"
 #include "insn_trans/trans_rvf.inc.c"
 #include "insn_trans/trans_rvd.inc.c"
+#include "insn_trans/trans_rvv.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
 /* Include the auto-generated decoder for 16 bit insn */
@@ -745,10 +752,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
@@ -772,6 +780,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
index 0000000000..2afe716f2a
--- /dev/null
+++ b/target/riscv/vector_helper.c
@@ -0,0 +1,53 @@
+/*
+ * RISC-V Vector Extension Helpers for QEMU.
+ *
+ * Copyright (c) 2020 C-SKY Limited. All rights reserved.
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
+    target_ulong s2)
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


