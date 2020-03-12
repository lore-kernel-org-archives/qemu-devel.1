Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79BDC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9930C2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9930C2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQEl-0001XY-QV
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQDY-0000C5-Ed
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQDW-00064y-LW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:57:52 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCQDV-0005w3-Oq; Thu, 12 Mar 2020 11:57:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07631423|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.00758863-0.000132142-0.992279;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03297; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-PBXot_1584028661; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-PBXot_1584028661)
 by smtp.aliyun-inc.com(10.147.42.253);
 Thu, 12 Mar 2020 23:57:42 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 29/60] target/riscv: vector single-width floating-point
 add/subtract instructions
Date: Thu, 12 Mar 2020 22:58:29 +0800
Message-Id: <20200312145900.2054-30-zhiwei_liu@c-sky.com>
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  16 ++++
 target/riscv/insn32.decode              |   5 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 107 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            |  89 ++++++++++++++++++++
 4 files changed, 217 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4cad8679ec..6b46677eeb 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -785,3 +785,19 @@ DEF_HELPER_6(vnclipu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnclip_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnclip_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnclip_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vfadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfrsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfrsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfrsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c7d589566f..32918c4d11 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -438,6 +438,11 @@ vnclipu_vi      101110 . ..... ..... 011 ..... 1010111 @r_vm
 vnclip_vv       101111 . ..... ..... 000 ..... 1010111 @r_vm
 vnclip_vx       101111 . ..... ..... 100 ..... 1010111 @r_vm
 vnclip_vi       101111 . ..... ..... 011 ..... 1010111 @r_vm
+vfadd_vv        000000 . ..... ..... 001 ..... 1010111 @r_vm
+vfadd_vf        000000 . ..... ..... 101 ..... 1010111 @r_vm
+vfsub_vv        000010 . ..... ..... 001 ..... 1010111 @r_vm
+vfsub_vf        000010 . ..... ..... 101 ..... 1010111 @r_vm
+vfrsub_vf       100111 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 11b4887275..af4dcb96c6 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1557,3 +1557,110 @@ GEN_OPIVX_NARROW_TRANS(vnclipu_vx)
 GEN_OPIVX_NARROW_TRANS(vnclip_vx)
 GEN_OPIVI_NARROW_TRANS(vnclipu_vi, 1, vnclipu_vx)
 GEN_OPIVI_NARROW_TRANS(vnclip_vi, 1, vnclip_vx)
+
+/*
+ *** Vector Float Point Arithmetic Instructions
+ */
+/* Vector Single-Width Floating-Point Add/Subtract Instructions */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised.
+ */
+static bool opfvv_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            (s->sew != 0));
+}
+
+/* OPFVV without GVEC IR */
+#define GEN_OPFVV_TRANS(NAME, CHECK)                               \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (CHECK(s, a)) {                                             \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_4_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+            gen_helper_##NAME##_d,                                 \
+        };                                                         \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),              \
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew - 1]);       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+GEN_OPFVV_TRANS(vfadd_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfsub_vv, opfvv_check)
+
+typedef void (*gen_helper_opfvf)(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_ptr,
+        TCGv_env, TCGv_i32);
+
+static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
+        uint32_t data, gen_helper_opfvf fn, DisasContext *s)
+{
+    TCGv_ptr dest, src2, mask;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    src2 = tcg_temp_new_ptr();
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, cpu_fpr[rs1], src2, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free_ptr(src2);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool opfvf_check(DisasContext *s, arg_rmrr *a)
+{
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (s->sew != 0));
+}
+
+/* OPFVF without GVEC IR */
+#define GEN_OPFVF_TRANS(NAME, CHECK)                              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
+{                                                                 \
+    if (CHECK(s, a)) {                                            \
+        uint32_t data = 0;                                        \
+        static gen_helper_opfvf const fns[3] = {                  \
+            gen_helper_##NAME##_h,                                \
+            gen_helper_##NAME##_w,                                \
+            gen_helper_##NAME##_d,                                \
+        };                                                        \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);            \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);            \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,           \
+                fns[s->sew - 1], s);                              \
+    }                                                             \
+    return false;                                                 \
+}
+
+GEN_OPFVF_TRANS(vfadd_vf,  opfvf_check)
+GEN_OPFVF_TRANS(vfsub_vf,  opfvf_check)
+GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7f61d4c0c4..d49a7194f7 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -21,6 +21,7 @@
 #include "exec/memop.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
 #include <math.h>
 
@@ -2940,3 +2941,91 @@ RVVCALL(OPIVX2_ENV, vnclipu_vx_w, NOP_UUU_W, H4, H8, vnclipu32)
 GEN_VEXT_VX_ENV(vnclipu_vx_b, 1, 1, clearb)
 GEN_VEXT_VX_ENV(vnclipu_vx_h, 2, 2, clearh)
 GEN_VEXT_VX_ENV(vnclipu_vx_w, 4, 4, clearl)
+
+/*
+ *** Vector Float Point Arithmetic Instructions
+ */
+/* Vector Single-Width Floating-Point Add/Subtract Instructions */
+#define OPFVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i,   \
+        CPURISCVState *env)                                    \
+{                                                              \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                            \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                            \
+    *((TD *)vd + HD(i)) = OP(s2, s1, &env->fp_status);         \
+}
+RVVCALL(OPFVV2, vfadd_vv_h, OP_UUU_H, H2, H2, H2, float16_add)
+RVVCALL(OPFVV2, vfadd_vv_w, OP_UUU_W, H4, H4, H4, float32_add)
+RVVCALL(OPFVV2, vfadd_vv_d, OP_UUU_D, H8, H8, H8, float64_add)
+GEN_VEXT_VV_ENV(vfadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfadd_vv_d, 8, 8, clearq)
+
+#define OPFVF2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)        \
+static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i, \
+        CPURISCVState *env)                                    \
+{                                                              \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                            \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, &env->fp_status);\
+}
+
+#define GEN_VEXT_VF(NAME, ESZ, DSZ, CLEAR_FN)             \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t mlen = vext_mlen(desc);                      \
+    uint32_t vm = vext_vm(desc);                          \
+    uint32_t vl = env->vl;                                \
+    uint32_t i;                                           \
+                                                          \
+    for (i = 0; i < vl; i++) {                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
+            continue;                                     \
+        }                                                 \
+        do_##NAME(vd, s1, vs2, i, env);                   \
+    }                                                     \
+    if (i != 0) {                                         \
+        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);         \
+    }                                                     \
+}
+RVVCALL(OPFVF2, vfadd_vf_h, OP_UUU_H, H2, H2, float16_add)
+RVVCALL(OPFVF2, vfadd_vf_w, OP_UUU_W, H4, H4, float32_add)
+RVVCALL(OPFVF2, vfadd_vf_d, OP_UUU_D, H8, H8, float64_add)
+GEN_VEXT_VF(vfadd_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfadd_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfadd_vf_d, 8, 8, clearq)
+
+RVVCALL(OPFVV2, vfsub_vv_h, OP_UUU_H, H2, H2, H2, float16_sub)
+RVVCALL(OPFVV2, vfsub_vv_w, OP_UUU_W, H4, H4, H4, float32_sub)
+RVVCALL(OPFVV2, vfsub_vv_d, OP_UUU_D, H8, H8, H8, float64_sub)
+GEN_VEXT_VV_ENV(vfsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfsub_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfsub_vf_h, OP_UUU_H, H2, H2, float16_sub)
+RVVCALL(OPFVF2, vfsub_vf_w, OP_UUU_W, H4, H4, float32_sub)
+RVVCALL(OPFVF2, vfsub_vf_d, OP_UUU_D, H8, H8, float64_sub)
+GEN_VEXT_VF(vfsub_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfsub_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfsub_vf_d, 8, 8, clearq)
+
+static uint16_t float16_rsub(uint16_t a, uint16_t b, float_status *s)
+{
+    return float16_sub(b, a, s);
+}
+
+static uint32_t float32_rsub(uint32_t a, uint32_t b, float_status *s)
+{
+    return float32_sub(b, a, s);
+}
+
+static uint64_t float64_rsub(uint64_t a, uint64_t b, float_status *s)
+{
+    return float64_sub(b, a, s);
+}
+RVVCALL(OPFVF2, vfrsub_vf_h, OP_UUU_H, H2, H2, float16_rsub)
+RVVCALL(OPFVF2, vfrsub_vf_w, OP_UUU_W, H4, H4, float32_rsub)
+RVVCALL(OPFVF2, vfrsub_vf_d, OP_UUU_D, H8, H8, float64_rsub)
+GEN_VEXT_VF(vfrsub_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfrsub_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfrsub_vf_d, 8, 8, clearq)
-- 
2.23.0


