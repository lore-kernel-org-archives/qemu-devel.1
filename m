Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA05C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CF420663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CF420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEER4-0003zZ-Ol
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEEBf-0007Uu-1j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEEBc-00030l-Nc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:31:22 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47595)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEEBb-0002ht-NU; Tue, 17 Mar 2020 11:31:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07608247|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.577342-0.00014803-0.42251;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03311; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1-9UCY_1584459070; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1-9UCY_1584459070)
 by smtp.aliyun-inc.com(10.147.43.230);
 Tue, 17 Mar 2020 23:31:10 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 12/61] target/riscv: vector integer add-with-carry /
 subtract-with-borrow instructions
Date: Tue, 17 Mar 2020 23:06:04 +0800
Message-Id: <20200317150653.9008-13-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  33 ++++++
 target/riscv/insn32.decode              |  11 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  78 +++++++++++++
 target/riscv/vector_helper.c            | 148 ++++++++++++++++++++++++
 4 files changed, 270 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1256defb6c..72c733bf49 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -339,3 +339,36 @@ DEF_HELPER_6(vwadd_wx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwsub_wx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwsub_wx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwsub_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vadc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsbc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsbc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsbc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsbc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsbc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsbc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsbc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsbc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4bdbfd16fa..022c8ea18b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -70,6 +70,7 @@
 @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
+@r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
@@ -300,6 +301,16 @@ vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
 vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
 vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
 vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
+vadc_vvm        010000 1 ..... ..... 000 ..... 1010111 @r_vm_1
+vadc_vxm        010000 1 ..... ..... 100 ..... 1010111 @r_vm_1
+vadc_vim        010000 1 ..... ..... 011 ..... 1010111 @r_vm_1
+vmadc_vvm       010001 1 ..... ..... 000 ..... 1010111 @r_vm_1
+vmadc_vxm       010001 1 ..... ..... 100 ..... 1010111 @r_vm_1
+vmadc_vim       010001 1 ..... ..... 011 ..... 1010111 @r_vm_1
+vsbc_vvm        010010 1 ..... ..... 000 ..... 1010111 @r_vm_1
+vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r_vm_1
+vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r_vm_1
+vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r_vm_1
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 8f17faa3f3..4562d5f14f 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1169,3 +1169,81 @@ GEN_OPIWX_WIDEN_TRANS(vwaddu_wx)
 GEN_OPIWX_WIDEN_TRANS(vwadd_wx)
 GEN_OPIWX_WIDEN_TRANS(vwsubu_wx)
 GEN_OPIWX_WIDEN_TRANS(vwsub_wx)
+
+/* Vector Integer Add-with-Carry / Subtract-with-Borrow Instructions */
+/* OPIVV without GVEC IR */
+#define GEN_OPIVV_TRANS(NAME, CHECK)                               \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (CHECK(s, a)) {                                             \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_4_ptr * const fns[4] = {            \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,          \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,          \
+        };                                                         \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),              \
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);           \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+/*
+ * For vadc and vsbc, an illegal instruction exception is raised if the
+ * destination vector register is v0 and LMUL > 1. (Section 12.3)
+ */
+static bool opivv_vadc_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            ((a->rd != 0) || (s->lmul == 0)));
+}
+
+GEN_OPIVV_TRANS(vadc_vvm, opivv_vadc_check)
+GEN_OPIVV_TRANS(vsbc_vvm, opivv_vadc_check)
+
+/*
+ * For vmadc and vmsbc, an illegal instruction exception is raised if the
+ * destination vector register overlaps a source vector register group.
+ */
+static bool opivv_vmadc_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
+            vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul));
+}
+
+GEN_OPIVV_TRANS(vmadc_vvm, opivv_vmadc_check)
+GEN_OPIVV_TRANS(vmsbc_vvm, opivv_vmadc_check)
+
+static bool opivx_vadc_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            ((a->rd != 0) || (s->lmul == 0)));
+}
+
+GEN_OPIVX_TRANS(vadc_vxm, opivx_vadc_check)
+GEN_OPIVX_TRANS(vsbc_vxm, opivx_vadc_check)
+
+static bool opivx_vmadc_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul));
+}
+
+GEN_OPIVX_TRANS(vmadc_vxm, opivx_vmadc_check)
+GEN_OPIVX_TRANS(vmsbc_vxm, opivx_vmadc_check)
+
+GEN_OPIVI_TRANS(vadc_vim, 0, vadc_vxm, opivx_vadc_check)
+GEN_OPIVI_TRANS(vmadc_vim, 0, vmadc_vxm, opivx_vmadc_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d0e6f12f43..9913dcbea2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -186,6 +186,14 @@ static void clearq(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
     vext_clear(cur, cnt, tot);
 }
 
+static inline void vext_set_elem_mask(void *v0, int mlen, int index,
+        uint8_t value)
+{
+    int idx = (index * mlen) / 64;
+    int pos = (index * mlen) % 64;
+    uint64_t old = ((uint64_t *)v0)[idx];
+    ((uint64_t *)v0)[idx] = deposit64(old, pos, mlen, value);
+}
 
 static inline int vext_elem_mask(void *v0, int mlen, int index)
 {
@@ -1087,3 +1095,143 @@ GEN_VEXT_VX(vwadd_wx_w, 4, 8, clearq)
 GEN_VEXT_VX(vwsub_wx_b, 1, 2, clearh)
 GEN_VEXT_VX(vwsub_wx_h, 2, 4, clearl)
 GEN_VEXT_VX(vwsub_wx_w, 4, 8, clearq)
+
+#define DO_VADC(N, M, C) (N + M + C)
+#define DO_VSBC(N, M, C) (N - M - C)
+
+#define GEN_VEXT_VADC_VVM(NAME, ETYPE, H, DO_OP, CLEAR_FN)    \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vl = env->vl;                                    \
+    uint32_t esz = sizeof(ETYPE);                             \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t i;                                               \
+                                                              \
+    if (vl == 0) {                                            \
+        return;                                               \
+    }                                                         \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        uint8_t carry = vext_elem_mask(v0, mlen, i);          \
+                                                              \
+        *((ETYPE *)vd + H(i)) = DO_OP(s2, s1, carry);         \
+    }                                                         \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
+}
+
+GEN_VEXT_VADC_VVM(vadc_vvm_b, uint8_t,  H1, DO_VADC, clearb)
+GEN_VEXT_VADC_VVM(vadc_vvm_h, uint16_t, H2, DO_VADC, clearh)
+GEN_VEXT_VADC_VVM(vadc_vvm_w, uint32_t, H4, DO_VADC, clearl)
+GEN_VEXT_VADC_VVM(vadc_vvm_d, uint64_t, H8, DO_VADC, clearq)
+
+GEN_VEXT_VADC_VVM(vsbc_vvm_b, uint8_t,  H1, DO_VSBC, clearb)
+GEN_VEXT_VADC_VVM(vsbc_vvm_h, uint16_t, H2, DO_VSBC, clearh)
+GEN_VEXT_VADC_VVM(vsbc_vvm_w, uint32_t, H4, DO_VSBC, clearl)
+GEN_VEXT_VADC_VVM(vsbc_vvm_d, uint64_t, H8, DO_VSBC, clearq)
+
+#define GEN_VEXT_VADC_VXM(NAME, ETYPE, H, DO_OP, CLEAR_FN)               \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
+                  CPURISCVState *env, uint32_t desc)                     \
+{                                                                        \
+    uint32_t mlen = vext_mlen(desc);                                     \
+    uint32_t vl = env->vl;                                               \
+    uint32_t esz = sizeof(ETYPE);                                        \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                             \
+    uint32_t i;                                                          \
+                                                                         \
+    if (vl == 0) {                                                       \
+        return;                                                          \
+    }                                                                    \
+    for (i = 0; i < vl; i++) {                                           \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
+        uint8_t carry = vext_elem_mask(v0, mlen, i);                     \
+                                                                         \
+        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
+    }                                                                    \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                             \
+}
+
+GEN_VEXT_VADC_VXM(vadc_vxm_b, uint8_t,  H1, DO_VADC, clearb)
+GEN_VEXT_VADC_VXM(vadc_vxm_h, uint16_t, H2, DO_VADC, clearh)
+GEN_VEXT_VADC_VXM(vadc_vxm_w, uint32_t, H4, DO_VADC, clearl)
+GEN_VEXT_VADC_VXM(vadc_vxm_d, uint64_t, H8, DO_VADC, clearq)
+
+GEN_VEXT_VADC_VXM(vsbc_vxm_b, uint8_t,  H1, DO_VSBC, clearb)
+GEN_VEXT_VADC_VXM(vsbc_vxm_h, uint16_t, H2, DO_VSBC, clearh)
+GEN_VEXT_VADC_VXM(vsbc_vxm_w, uint32_t, H4, DO_VSBC, clearl)
+GEN_VEXT_VADC_VXM(vsbc_vxm_d, uint64_t, H8, DO_VSBC, clearq)
+
+#define DO_MADC(N, M, C) (C ? (__typeof(N))(N + M + 1) <= N :           \
+                          (__typeof(N))(N + M) < N)
+#define DO_MSBC(N, M, C) (C ? N <= M : N < M)
+
+#define GEN_VEXT_VMADC_VVM(NAME, ETYPE, H, DO_OP)             \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vl = env->vl;                                    \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
+    uint32_t i;                                               \
+                                                              \
+    if (vl == 0) {                                            \
+        return;                                               \
+    }                                                         \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        uint8_t carry = vext_elem_mask(v0, mlen, i);          \
+                                                              \
+        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, s1, carry));\
+    }                                                         \
+    for (; i < vlmax; i++) {                                  \
+        vext_set_elem_mask(vd, mlen, i, 0);                   \
+    }                                                         \
+}
+
+GEN_VEXT_VMADC_VVM(vmadc_vvm_b, uint8_t,  H1, DO_MADC)
+GEN_VEXT_VMADC_VVM(vmadc_vvm_h, uint16_t, H2, DO_MADC)
+GEN_VEXT_VMADC_VVM(vmadc_vvm_w, uint32_t, H4, DO_MADC)
+GEN_VEXT_VMADC_VVM(vmadc_vvm_d, uint64_t, H8, DO_MADC)
+
+GEN_VEXT_VMADC_VVM(vmsbc_vvm_b, uint8_t,  H1, DO_MSBC)
+GEN_VEXT_VMADC_VVM(vmsbc_vvm_h, uint16_t, H2, DO_MSBC)
+GEN_VEXT_VMADC_VVM(vmsbc_vvm_w, uint32_t, H4, DO_MSBC)
+GEN_VEXT_VMADC_VVM(vmsbc_vvm_d, uint64_t, H8, DO_MSBC)
+
+#define GEN_VEXT_VMADC_VXM(NAME, ETYPE, H, DO_OP)               \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
+                  void *vs2, CPURISCVState *env, uint32_t desc) \
+{                                                               \
+    uint32_t mlen = vext_mlen(desc);                            \
+    uint32_t vl = env->vl;                                      \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);          \
+    uint32_t i;                                                 \
+                                                                \
+    if (vl == 0) {                                              \
+        return;                                                 \
+    }                                                           \
+    for (i = 0; i < vl; i++) {                                  \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
+        uint8_t carry = vext_elem_mask(v0, mlen, i);            \
+                                                                \
+        vext_set_elem_mask(vd, mlen, i,                         \
+                DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
+    }                                                           \
+    for (; i < vlmax; i++) {                                    \
+        vext_set_elem_mask(vd, mlen, i, 0);                     \
+    }                                                           \
+}
+
+GEN_VEXT_VMADC_VXM(vmadc_vxm_b, uint8_t,  H1, DO_MADC)
+GEN_VEXT_VMADC_VXM(vmadc_vxm_h, uint16_t, H2, DO_MADC)
+GEN_VEXT_VMADC_VXM(vmadc_vxm_w, uint32_t, H4, DO_MADC)
+GEN_VEXT_VMADC_VXM(vmadc_vxm_d, uint64_t, H8, DO_MADC)
+
+GEN_VEXT_VMADC_VXM(vmsbc_vxm_b, uint8_t,  H1, DO_MSBC)
+GEN_VEXT_VMADC_VXM(vmsbc_vxm_h, uint16_t, H2, DO_MSBC)
+GEN_VEXT_VMADC_VXM(vmsbc_vxm_w, uint32_t, H4, DO_MSBC)
+GEN_VEXT_VMADC_VXM(vmsbc_vxm_d, uint64_t, H8, DO_MSBC)
-- 
2.23.0


