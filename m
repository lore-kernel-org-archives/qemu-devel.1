Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2708C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 03:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF2621D56
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 03:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF2621D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inDkA-0006Mg-Kz
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 22:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1inDj0-000519-Vx
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 22:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1inDiy-000378-QQ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 22:34:10 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50815)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1inDiy-0002xJ-7k
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 22:34:08 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.652223-0.0139949-0.333782; DS=||;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16370; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GV9YvOJ_1578022440; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GV9YvOJ_1578022440)
 by smtp.aliyun-inc.com(10.147.42.16); Fri, 03 Jan 2020 11:34:02 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: alistair23@gmail.com, richard.henderson@linaro.org,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 4/4] RISC-V: add vector extension configure instruction
Date: Fri,  3 Jan 2020 11:33:47 +0800
Message-Id: <20200103033347.20909-5-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
References: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vsetvl and vsetvli are two configure instructions for vl, vtype. TB flags
should update after configure instructions. The (ill, lmul, sew ) of vtype
and the bit of (VSTART == 0 && VL == VLMAX) will be placed within tb_flags.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/Makefile.objs              |  2 +-
 target/riscv/cpu.c                      |  1 +
 target/riscv/cpu.h                      | 55 ++++++++++++++++++++-----
 target/riscv/helper.h                   |  2 +
 target/riscv/insn32.decode              |  5 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 52 +++++++++++++++++++++++
 target/riscv/translate.c                | 17 +++++++-
 target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++
 8 files changed, 172 insertions(+), 13 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
 create mode 100644 target/riscv/vector_helper.c

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index b1c79bc1d1..d577cef9e0 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o pmp.o
+obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o vector_helper.o gdbstub.o pmp.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c2370a0a57..3ff7b50bff 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -347,6 +347,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         }
     }
     if (cpu->cfg.vext_spec) {
+        env->vext.vtype = ~((target_ulong)-1 >> 1);
         if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
             vext_version = VEXT_VERSION_0_07_1;
         } else {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d0b106583a..152a96f1fa 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -23,6 +23,7 @@
 #include "qom/cpu.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat.h"
+#include "hw/registerfields.h"
 
 #define TCG_GUEST_DEFAULT_MO 0
 
@@ -98,6 +99,20 @@ typedef struct CPURISCVState CPURISCVState;
 
 #define RV_VLEN_MAX 4096
 
+struct VTYPE {
+#ifdef HOST_WORDS_BIGENDIAN
+    target_ulong vill:1;
+    target_ulong reserved:sizeof(target_ulong) * 8 - 7;
+    target_ulong sew:3;
+    target_ulong lmul:2;
+#else
+    target_ulong lmul:2;
+    target_ulong sew:3;
+    target_ulong reserved:sizeof(target_ulong) * 8 - 7;
+    target_ulong vill:1;
+#endif
+};
+
 struct CPURISCVState {
     target_ulong gpr[32];
     uint64_t fpr[32]; /* assume both F and D extensions */
@@ -309,19 +324,44 @@ void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
-#define TB_FLAGS_MMU_MASK   3
-#define TB_FLAGS_MSTATUS_FS MSTATUS_FS
+typedef CPURISCVState CPUArchState;
+typedef RISCVCPU ArchCPU;
+#include "exec/cpu-all.h"
+
+FIELD(TB_FLAGS, MMU, 0, 2)
+FIELD(TB_FLAGS, FS, 13, 2)
+FIELD(TB_FLAGS, VL_EQ_VLMAX, 16, 1)
+FIELD(TB_FLAGS, LMUL, 17, 2)
+FIELD(TB_FLAGS, SEW, 19, 3)
+FIELD(TB_FLAGS, VILL, 22, 1)
 
 static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+                                        target_ulong *cs_base, uint32_t *pflags)
 {
+    RISCVCPU *cpu = env_archcpu(env);
+    struct VTYPE *vtype = (struct VTYPE *)&env->vext.vtype;
+    uint32_t vlmax;
+    uint8_t vl_eq_vlmax;
+    uint32_t flags = 0;
+
     *pc = env->pc;
     *cs_base = 0;
+    vlmax = (1 << vtype->lmul) * cpu->cfg.vlen / (8 * (1 << vtype->sew));
+    vl_eq_vlmax = (env->vext.vstart == 0) && (vlmax == env->vext.vl);
+
+    flags = FIELD_DP32(flags, TB_FLAGS, VILL, vtype->vill);
+    flags = FIELD_DP32(flags, TB_FLAGS, SEW, vtype->sew);
+    flags = FIELD_DP32(flags, TB_FLAGS, LMUL, vtype->lmul);
+    flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
+
 #ifdef CONFIG_USER_ONLY
-    *flags = TB_FLAGS_MSTATUS_FS;
+    flags = FIELD_DP32(flags, TB_FLAGS, FS, MSTATUS_FS);
 #else
-    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
+    flags = FIELD_DP32(flags, TB_FLAGS, MMU, cpu_mmu_index(env, 0));
+    flags = FIELD_DP32(flags, TB_FLAGS, FS, (env->mstatus & MSTATUS_FS));
 #endif
+    *pflags = flags;
+    *cs_base = 0;
 }
 
 int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
@@ -362,9 +402,4 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
-typedef CPURISCVState CPUArchState;
-typedef RISCVCPU ArchCPU;
-
-#include "exec/cpu-all.h"
-
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index debb22a480..000b5aa3d1 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -76,3 +76,5 @@ DEF_HELPER_2(mret, tl, env, tl)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 #endif
+/* Vector functions */
+DEF_HELPER_3(vector_vsetvli, tl, env, tl, tl)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 77f794ed70..5dc009c3cd 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -62,6 +62,7 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
 @sfence_vm  ....... ..... .....   ... ..... ....... %rs1
@@ -203,3 +204,7 @@ fcvt_w_d   1100001  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_wu_d  1100001  00001 ..... ... ..... 1010011 @r2_rm
 fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
+
+# *** RV32V Extension ***
+vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
+vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
new file mode 100644
index 0000000000..5d80144502
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -0,0 +1,52 @@
+/*
+ * RISC-V translation routines for the RVV Standard Extension.
+ *
+ * Copyright (c) 2019 C-SKY Limited. All rights reserved.
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
+    TCGv s1, s2, d;
+    d = tcg_temp_new();
+    s1 = tcg_temp_new();
+    s2 = tcg_temp_new();
+    gen_get_gpr(s1, a->rs1);
+    gen_get_gpr(s2, a->rs2);
+    gen_helper_vector_vsetvli(d, cpu_env, s1, s2);
+    tcg_gen_st_tl(d, cpu_env, offsetof(CPURISCVState, vext.vl));
+    exit_tb(ctx);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    tcg_temp_free(s1);
+    tcg_temp_free(s2);
+    tcg_temp_free(d);
+    return true;
+}
+
+static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
+{
+    TCGv s1, s2, d;
+    d = tcg_temp_new();
+    s1 = tcg_temp_new();
+    s2 = tcg_const_tl(a->zimm);
+    gen_get_gpr(s1, a->rs1);
+    gen_helper_vector_vsetvli(d, cpu_env, s1, s2);
+    tcg_gen_st_tl(d, cpu_env, offsetof(CPURISCVState, vext.vl));
+    exit_tb(ctx);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    tcg_temp_free(s1);
+    tcg_temp_free(s2);
+    tcg_temp_free(d);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8d6ab73258..beb283b735 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -55,6 +55,12 @@ typedef struct DisasContext {
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
@@ -706,6 +712,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rva.inc.c"
 #include "insn_trans/trans_rvf.inc.c"
 #include "insn_trans/trans_rvd.inc.c"
+#include "insn_trans/trans_rvv.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
 /*
@@ -754,14 +761,20 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cs->env_ptr;
     RISCVCPU *cpu = RISCV_CPU(cs);
+    uint32_t tb_flags = ctx->base.tb->flags;
 
     ctx->pc_succ_insn = ctx->base.pc_first;
-    ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
-    ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
+    ctx->mem_idx = FIELD_EX32(tb_flags, TB_FLAGS, MMU);
+    ctx->mstatus_fs = FIELD_EX32(tb_flags, TB_FLAGS, FS);
     ctx->priv_ver = env->priv_ver;
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
index 0000000000..4e394207ce
--- /dev/null
+++ b/target/riscv/vector_helper.c
@@ -0,0 +1,51 @@
+/*
+ * RISC-V Vectore Extension Helpers for QEMU.
+ *
+ * Copyright (c) 2019 C-SKY Limited. All rights reserved.
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
+#define VECTOR_HELPER(name) HELPER(glue(vector_, name))
+
+target_ulong VECTOR_HELPER(vsetvli)(CPURISCVState *env, target_ulong s1,
+    target_ulong s2)
+{
+    int vlmax, vl;
+    RISCVCPU *cpu = env_archcpu(env);
+    struct VTYPE *vtype = (struct VTYPE *)&s2;
+
+    if (vtype->sew > cpu->cfg.elen) { /* only set vill bit. */
+        env->vext.vtype = ~((target_ulong)-1 >> 1);
+        return 0;
+    }
+
+    vlmax = (1 << vtype->lmul) * cpu->cfg.vlen / (8 * (1 << vtype->sew));
+    if (s1 == 0) {
+        vl = vlmax;
+    } else if (s1 <= vlmax) {
+        vl = s1;
+    } else {
+        vl = vlmax;
+    }
+    env->vext.vl = vl;
+    env->vext.vtype = s2;
+    env->vext.vstart = 0;
+    return vl;
+}
-- 
2.23.0


