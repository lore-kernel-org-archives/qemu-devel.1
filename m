Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB533ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AB4207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AB4207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wFs-0000rp-SL
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDb-000742-Hs
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDU-0007mr-9u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:07 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34645)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDT-0007jy-1H; Wed, 11 Sep 2019 02:35:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.353627-0.00801203-0.638361; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01l07391; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRFPyr_1568183693; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRFPyr_1568183693)
 by smtp.aliyun-inc.com(10.147.40.233);
 Wed, 11 Sep 2019 14:34:54 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:31 +0800
Message-Id: <1568183141-67641-8-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 07/17] RISC-V: add vector extension atomic
 instructions
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |   18 +
 target/riscv/insn32.decode              |   21 +
 target/riscv/insn_trans/trans_rvv.inc.c |   36 +
 target/riscv/vector_helper.c            | 1467 +++++++++++++++++++++++++++++++
 4 files changed, 1542 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 973342f..c107925 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -121,5 +121,23 @@ DEF_HELPER_6(vector_vsuxb_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vsuxh_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vsuxw_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vsuxe_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoswapw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoswapd_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoaddw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoaddd_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoxorw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoxord_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoandw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoandd_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoorw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamoord_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamominw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamomind_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamomaxw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamomaxd_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamominuw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamominud_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamomaxuw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vamomaxud_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b286997..48e7661 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -63,6 +63,7 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
 @r_nfvm  nf:3 ... vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
 @r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
@@ -258,6 +259,26 @@ vsuxh_v    ... 111 . ..... ..... 101 ..... 0100111 @r_nfvm
 vsuxw_v    ... 111 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsuxe_v    ... 111 . ..... ..... 111 ..... 0100111 @r_nfvm
 
+#*** Vector AMO operations are encoded under the standard AMO major opcode.***
+vamoswapw_v     00001 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoswapd_v     00001 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoaddw_v      00000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoaddd_v      00000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoxorw_v      00100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoxord_v      00100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoandw_v      01100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoandd_v      01100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoorw_v       01000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoord_v       01000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamominw_v      10000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamomind_v      10000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamomaxw_v      10100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamomaxd_v      10100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamominuw_v     11000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamominud_v     11000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamomaxuw_v     11100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamomaxud_v     11100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+
 #*** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index bd83885..7bda378 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -47,6 +47,23 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
     return true;                                       \
 }
 
+#define GEN_VECTOR_R_WDVM(INSN) \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
+{                                                      \
+    TCGv_i32 s1 = tcg_const_i32(a->rs1);               \
+    TCGv_i32 s2 = tcg_const_i32(a->rs2);               \
+    TCGv_i32 d  = tcg_const_i32(a->rd);                \
+    TCGv_i32 wd  = tcg_const_i32(a->wd);               \
+    TCGv_i32 vm = tcg_const_i32(a->vm);                \
+    gen_helper_vector_##INSN(cpu_env, wd, vm, s1, s2, d);\
+    tcg_temp_free_i32(s1);                             \
+    tcg_temp_free_i32(s2);                             \
+    tcg_temp_free_i32(d);                              \
+    tcg_temp_free_i32(wd);                             \
+    tcg_temp_free_i32(vm);                             \
+    return true;                                       \
+}
+
 #define GEN_VECTOR_R(INSN) \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
 {                                                      \
@@ -119,5 +136,24 @@ GEN_VECTOR_R_NFVM(vsuxh_v)
 GEN_VECTOR_R_NFVM(vsuxw_v)
 GEN_VECTOR_R_NFVM(vsuxe_v)
 
+GEN_VECTOR_R_WDVM(vamoswapw_v)
+GEN_VECTOR_R_WDVM(vamoswapd_v)
+GEN_VECTOR_R_WDVM(vamoaddw_v)
+GEN_VECTOR_R_WDVM(vamoaddd_v)
+GEN_VECTOR_R_WDVM(vamoxorw_v)
+GEN_VECTOR_R_WDVM(vamoxord_v)
+GEN_VECTOR_R_WDVM(vamoandw_v)
+GEN_VECTOR_R_WDVM(vamoandd_v)
+GEN_VECTOR_R_WDVM(vamoorw_v)
+GEN_VECTOR_R_WDVM(vamoord_v)
+GEN_VECTOR_R_WDVM(vamominw_v)
+GEN_VECTOR_R_WDVM(vamomind_v)
+GEN_VECTOR_R_WDVM(vamomaxw_v)
+GEN_VECTOR_R_WDVM(vamomaxd_v)
+GEN_VECTOR_R_WDVM(vamominuw_v)
+GEN_VECTOR_R_WDVM(vamominud_v)
+GEN_VECTOR_R_WDVM(vamomaxuw_v)
+GEN_VECTOR_R_WDVM(vamomaxud_v)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 0ac8c74..9ebf70d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -136,6 +136,21 @@ static bool  vector_lmul_check_reg(CPURISCVState *env, uint32_t lmul,
     return true;
 }
 
+static void vector_tail_amo(CPURISCVState *env, int vreg, int index, int width)
+{
+    switch (width) {
+    case 32:
+        env->vfp.vreg[vreg].u32[index] = 0;
+        break;
+    case 64:
+        env->vfp.vreg[vreg].u64[index] = 0;
+        break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return;
+    }
+}
+
 static void vector_tail_segment(CPURISCVState *env, int vreg, int index,
     int width, int nf, int lmul)
 {
@@ -3329,3 +3344,1455 @@ void VECTOR_HELPER(vleff_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
     env->vfp.vl = vl;
     env->vfp.vstart = 0;
 }
+
+void VECTOR_HELPER(vamoswapw_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 32 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_xchgl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_xchgl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = (int64_t)(int32_t)helper_atomic_xchgl_le(env, addr,
+                        env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = (int64_t)(int32_t)helper_atomic_xchgl_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamoswapd_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TEQ;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 64 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_xchgq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_xchgq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamoaddw_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 32 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_addl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_addl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_addl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_addl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vamoaddd_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TEQ;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 64 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_addq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_addq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamoxorw_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 32 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_xorl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_xorl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_xorl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_xorl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamoxord_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 64 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_xorq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_xorq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamoandw_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 32 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_andl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_andl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_andl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_andl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamoandd_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TEQ;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 64 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_andq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_andq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamoorw_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 32 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_orl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_orl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_orl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_orl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamoord_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TEQ;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 64 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_orq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_orq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamominw_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 32 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_sminl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_sminl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_sminl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_sminl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamomind_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TEQ;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 64 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_sminq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_sminq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamomaxw_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 32 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_smaxl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_smaxl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_smaxl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_smaxl_le(env,
+                        addr, env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamomaxd_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TEQ;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 64 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    int64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_smaxq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_smaxq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+                if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamominuw_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 32 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    uint32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_uminl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_uminl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    uint64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_uminl_le(
+                        env, addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_uminl_le(
+                        env, addr, env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamominud_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 64 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    uint32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_uminl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_uminl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    uint64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_uminq_le(
+                        env, addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_uminq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vamomaxuw_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TESL;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 32 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    uint32_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s32[j];
+                    addr   = idx + env->gpr[rs1];
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_umaxl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_umaxl_le(env, addr,
+                        env->vfp.vreg[src3].s32[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s32[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    uint64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_umaxl_le(
+                        env, addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = (int64_t)(int32_t)helper_atomic_fetch_umaxl_le(
+                        env, addr, env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vamomaxud_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
+    uint32_t rs1, uint32_t vs2, uint32_t vs3)
+{
+    int i, j, vl;
+    target_long idx;
+    uint32_t lmul, width, src2, src3, vlmax;
+    target_ulong addr;
+#ifdef CONFIG_SOFTMMU
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOp memop = MO_ALIGN | MO_TEQ;
+#endif
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    /* MEM <= SEW <= XLEN */
+    if (width < 64 || (width > sizeof(target_ulong) * 8)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* if wd, rd is writen the old value */
+    if (vector_vtype_ill(env) ||
+        (vector_overlap_vm_common(lmul, vm, vs3) && wd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, vs2, false);
+    vector_lmul_check_reg(env, lmul, vs3, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = vs2 + (i / (VLEN / width));
+        src3 = vs3 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    uint64_t tmp;
+                    idx    = (target_long)env->vfp.vreg[src2].s64[j];
+                    addr   = idx + env->gpr[rs1];
+
+#ifdef CONFIG_SOFTMMU
+                    tmp = helper_atomic_fetch_umaxq_le(
+                        env, addr, env->vfp.vreg[src3].s64[j],
+                        make_memop_idx(memop & ~MO_SIGN, mem_idx));
+#else
+                    tmp = helper_atomic_fetch_umaxq_le(env, addr,
+                        env->vfp.vreg[src3].s64[j]);
+#endif
+                    if (wd) {
+                        env->vfp.vreg[src3].s64[j] = tmp;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_amo(env, src3, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
-- 
2.7.4


