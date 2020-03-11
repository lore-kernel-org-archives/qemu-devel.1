Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C9C10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CF9208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CF9208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBteB-0008Gf-Vq
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 01:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBtan-0002Xa-AS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBtak-00080H-Ic
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:07:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43099)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBtaj-0007v9-Nu; Wed, 11 Mar 2020 01:07:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07608248|-1; BR=01201311R161ec; CH=green;
 DM=||false|; DS=SPAM|spam_porn|0.96361-0.000343908-0.0360465;
 FP=1053816043233419062|1|1|1|0|-1|-1|-1; HT=e02c03305; MF=zhiwei_liu@c-sky.com;
 NM=1; PH=DS; RN=10; RT=10; SR=0; TI=SMTPD_---.GzWPNs6_1583903247; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GzWPNs6_1583903247)
 by smtp.aliyun-inc.com(10.147.44.118);
 Wed, 11 Mar 2020 13:07:33 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v4 09/60] target/riscv: vector single-width integer add and
 subtract
Date: Wed, 11 Mar 2020 13:06:28 +0800
Message-Id: <20200311050719.15141-10-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200311050719.15141-1-zhiwei_liu@c-sky.com>
References: <20200311050719.15141-1-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  21 +++
 target/riscv/insn32.decode              |  10 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 220 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 122 +++++++++++++
 4 files changed, 373 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 70a4b05f75..e73701d4bb 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -269,3 +269,24 @@ DEF_HELPER_6(vamominw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamomaxw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamominuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamomaxuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1330703720..d1034a0e61 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -44,6 +44,7 @@
 &u    imm rd
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
+&rmrr      vm rd rs1 rs2
 &rwdvm     vm wd rd rs1 rs2
 &r2nfvm    vm rd rs1 nf
 &rnfvm     vm rd rs1 rs2 nf
@@ -68,6 +69,7 @@
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
+@r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
@@ -275,5 +277,13 @@ vamominuw_v     11000 . . ..... ..... 110 ..... 0101111 @r_wdvm
 vamomaxuw_v     11100 . . ..... ..... 110 ..... 0101111 @r_wdvm
 
 # *** new major opcode OP-V ***
+vadd_vv         000000 . ..... ..... 000 ..... 1010111 @r_vm
+vadd_vx         000000 . ..... ..... 100 ..... 1010111 @r_vm
+vadd_vi         000000 . ..... ..... 011 ..... 1010111 @r_vm
+vsub_vv         000010 . ..... ..... 000 ..... 1010111 @r_vm
+vsub_vx         000010 . ..... ..... 100 ..... 1010111 @r_vm
+vrsub_vx        000011 . ..... ..... 100 ..... 1010111 @r_vm
+vrsub_vi        000011 . ..... ..... 011 ..... 1010111 @r_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 3c677160c5..00c7ec976f 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -730,3 +730,223 @@ GEN_VEXT_TRANS(vamomaxd_v, 15, rwdvm, amo_op, amo_check)
 GEN_VEXT_TRANS(vamominud_v, 16, rwdvm, amo_op, amo_check)
 GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
 #endif
+
+/*
+ *** Vector Integer Arithmetic Instructions
+ */
+#define MAXSZ(s) (s->vlen >> (3 - s->lmul))
+
+static bool opivv_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false));
+}
+
+/* OPIVV with GVEC IR */
+#define GEN_OPIVV_GVEC_TRANS(NAME, GVSUF)                          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (!opivv_check(s, a)) {                                      \
+        return false;                                              \
+    }                                                              \
+                                                                   \
+    if (a->vm && s->vl_eq_vlmax) {                                 \
+        tcg_gen_gvec_##GVSUF(8 << s->sew, vreg_ofs(s, a->rd),      \
+            vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),              \
+            MAXSZ(s), MAXSZ(s));                                   \
+    } else {                                                       \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_4_ptr * const fns[4] = {            \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,          \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,          \
+        };                                                         \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),              \
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);           \
+    }                                                              \
+    return true;                                                   \
+}
+GEN_OPIVV_GVEC_TRANS(vadd_vv, add)
+GEN_OPIVV_GVEC_TRANS(vsub_vv, sub)
+
+typedef void (*gen_helper_opivx)(TCGv_ptr, TCGv_ptr, TCGv, TCGv_ptr,
+        TCGv_env, TCGv_i32);
+
+static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
+        uint32_t data, gen_helper_opivx fn, DisasContext *s)
+{
+    TCGv_ptr dest, src2, mask;
+    TCGv src1;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    src2 = tcg_temp_new_ptr();
+    src1 = tcg_temp_new();
+    gen_get_gpr(src1, rs1);
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, src1, src2, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free_ptr(src2);
+    tcg_temp_free(src1);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool opivx_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false));
+}
+/* OPIVX with GVEC IR */
+#define GEN_OPIVX_GVEC_TRANS(NAME, GVSUF)                                     \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                        \
+{                                                                             \
+    if (!opivx_check(s, a)) {                                                 \
+        return false;                                                         \
+    }                                                                         \
+                                                                              \
+    if (a->vm && s->vl_eq_vlmax) {                                            \
+        TCGv_i64 src1 = tcg_temp_new_i64();                                   \
+        TCGv tmp = tcg_temp_new();                                            \
+        gen_get_gpr(tmp, a->rs1);                                             \
+        tcg_gen_ext_tl_i64(src1, tmp);                                        \
+        tcg_gen_gvec_##GVSUF(8 << s->sew, vreg_ofs(s, a->rd),                 \
+            vreg_ofs(s, a->rs2), src1, MAXSZ(s), MAXSZ(s));                   \
+        tcg_temp_free_i64(src1);                                              \
+        tcg_temp_free(tmp);                                                   \
+        return true;                                                          \
+    } else {                                                                  \
+        uint32_t data = 0;                                                    \
+        static gen_helper_opivx const fns[4] = {                              \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                     \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,                     \
+        };                                                                    \
+                                                                              \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                            \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                        \
+        return opivx_trans(a->rd, a->rs1, a->rs2, data, fns[s->sew], s);      \
+    }                                                                         \
+    return true;                                                              \
+}
+GEN_OPIVX_GVEC_TRANS(vadd_vx, adds)
+GEN_OPIVX_GVEC_TRANS(vsub_vx, subs)
+
+/* OPIVX without GVEC IR */
+#define GEN_OPIVX_TRANS(NAME, CHECK)                                     \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (CHECK(s, a)) {                                                   \
+        uint32_t data = 0;                                               \
+        static gen_helper_opivx const fns[4] = {                         \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,                \
+        };                                                               \
+                                                                         \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);                   \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                       \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                   \
+        return opivx_trans(a->rd, a->rs1, a->rs2, data, fns[s->sew], s); \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVX_TRANS(vrsub_vx, opivx_check)
+
+static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2,
+        uint32_t data, gen_helper_opivx fn, DisasContext *s, int zx)
+{
+    TCGv_ptr dest, src2, mask;
+    TCGv src1;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    src2 = tcg_temp_new_ptr();
+    if (zx) {
+        src1 = tcg_const_tl(imm);
+    } else {
+        src1 = tcg_const_tl(sextract64(imm, 0, 5));
+    }
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, src1, src2, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free_ptr(src2);
+    tcg_temp_free(src1);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+/* OPIVI with GVEC IR */
+#define GEN_OPIVI_GVEC_TRANS(NAME, ZX, OPIVX, GVSUF)                 \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)               \
+{                                                                    \
+    if (!opivx_check(s, a)) {                                        \
+        return false;                                                \
+    }                                                                \
+                                                                     \
+    if (a->vm && s->vl_eq_vlmax) {                                   \
+        tcg_gen_gvec_##GVSUF(8 << s->sew, vreg_ofs(s, a->rd),        \
+            vreg_ofs(s, a->rs2), sextract64(a->rs1, 0, 5),           \
+            MAXSZ(s), MAXSZ(s));                                     \
+        return true;                                                 \
+    } else {                                                         \
+        uint32_t data = 0;                                           \
+        static gen_helper_opivx const fns[4] = {                     \
+            gen_helper_##OPIVX##_b, gen_helper_##OPIVX##_h,          \
+            gen_helper_##OPIVX##_w, gen_helper_##OPIVX##_d,          \
+        };                                                           \
+                                                                     \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);               \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                   \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);               \
+        return opivi_trans(a->rd, a->rs1, a->rs2, data,              \
+                fns[s->sew], s, ZX);                                 \
+    }                                                                \
+    return true;                                                     \
+}
+GEN_OPIVI_GVEC_TRANS(vadd_vi, 0, vadd_vx, addi)
+
+/* OPIVI without GVEC IR */
+#define GEN_OPIVI_TRANS(NAME, ZX, OPIVX, CHECK)                          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (CHECK(s, a)) {                                                   \
+        uint32_t data = 0;                                               \
+        static gen_helper_opivx const fns[4] = {                         \
+            gen_helper_##OPIVX##_b, gen_helper_##OPIVX##_h,              \
+            gen_helper_##OPIVX##_w, gen_helper_##OPIVX##_d,              \
+        };                                                               \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);                   \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                       \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                   \
+        return opivi_trans(a->rd, a->rs1, a->rs2, data,                  \
+                fns[s->sew], s, ZX);                                     \
+    }                                                                    \
+    return false;                                                        \
+}
+GEN_OPIVI_TRANS(vrsub_vi, 0, vrsub_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f9b409b169..abdf3b82a8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -828,3 +828,125 @@ GEN_VEXT_AMO(vamominw_v_w,  int32_t,  int32_t,  idx_w, clearl)
 GEN_VEXT_AMO(vamomaxw_v_w,  int32_t,  int32_t,  idx_w, clearl)
 GEN_VEXT_AMO(vamominuw_v_w, uint32_t, uint32_t, idx_w, clearl)
 GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
+
+/*
+ *** Vector Integer Arithmetic Instructions
+ */
+
+/* expand macro args before macro */
+#define RVVCALL(macro, ...)  macro(__VA_ARGS__)
+
+/* (TD, T1, T2, TX1, TX2) */
+#define OP_SSS_B int8_t, int8_t, int8_t, int8_t, int8_t
+#define OP_SSS_H int16_t, int16_t, int16_t, int16_t, int16_t
+#define OP_SSS_W int32_t, int32_t, int32_t, int32_t, int32_t
+#define OP_SSS_D int64_t, int64_t, int64_t, int64_t, int64_t
+
+/* operation of two vector elements */
+#define OPIVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)    \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)    \
+{                                                               \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                             \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                             \
+    *((TD *)vd + HD(i)) = OP(s2, s1);                           \
+}
+#define DO_SUB(N, M) (N - M)
+#define DO_RSUB(N, M) (M - N)
+
+RVVCALL(OPIVV2, vadd_vv_b, OP_SSS_B, H1, H1, H1, DO_ADD)
+RVVCALL(OPIVV2, vadd_vv_h, OP_SSS_H, H2, H2, H2, DO_ADD)
+RVVCALL(OPIVV2, vadd_vv_w, OP_SSS_W, H4, H4, H4, DO_ADD)
+RVVCALL(OPIVV2, vadd_vv_d, OP_SSS_D, H8, H8, H8, DO_ADD)
+RVVCALL(OPIVV2, vsub_vv_b, OP_SSS_B, H1, H1, H1, DO_SUB)
+RVVCALL(OPIVV2, vsub_vv_h, OP_SSS_H, H2, H2, H2, DO_SUB)
+RVVCALL(OPIVV2, vsub_vv_w, OP_SSS_W, H4, H4, H4, DO_SUB)
+RVVCALL(OPIVV2, vsub_vv_d, OP_SSS_D, H8, H8, H8, DO_SUB)
+
+/* generate the helpers for OPIVV */
+#define GEN_VEXT_VV(NAME, ESZ, DSZ, CLEAR_FN)             \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t mlen = vext_mlen(desc);                      \
+    uint32_t vm = vext_vm(desc);                          \
+    uint32_t vl = env->vl;                                \
+    uint32_t i;                                           \
+    for (i = 0; i < vl; i++) {                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
+            continue;                                     \
+        }                                                 \
+        do_##NAME(vd, vs1, vs2, i);                       \
+    }                                                     \
+    if (i != 0) {                                         \
+        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);         \
+    }                                                     \
+}
+
+GEN_VEXT_VV(vadd_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vadd_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vsub_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vsub_vv_d, 8, 8, clearq)
+
+/*
+ * If XLEN < SEW, the value from the x register is sign-extended to SEW bits.
+ * So (target_long)s1 is need. (T1)(target_long)s1 gives the real operator type.
+ * (TX1)(T1)(target_long)s1 expands the operator type of widen operations
+ * or narrow operations
+ */
+#define OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
+static void do_##NAME(void *vd, target_ulong s1, void *vs2, int i)  \
+{                                                                   \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)(target_long)s1);         \
+}
+RVVCALL(OPIVX2, vadd_vx_b, OP_SSS_B, H1, H1, DO_ADD)
+RVVCALL(OPIVX2, vadd_vx_h, OP_SSS_H, H2, H2, DO_ADD)
+RVVCALL(OPIVX2, vadd_vx_w, OP_SSS_W, H4, H4, DO_ADD)
+RVVCALL(OPIVX2, vadd_vx_d, OP_SSS_D, H8, H8, DO_ADD)
+RVVCALL(OPIVX2, vsub_vx_b, OP_SSS_B, H1, H1, DO_SUB)
+RVVCALL(OPIVX2, vsub_vx_h, OP_SSS_H, H2, H2, DO_SUB)
+RVVCALL(OPIVX2, vsub_vx_w, OP_SSS_W, H4, H4, DO_SUB)
+RVVCALL(OPIVX2, vsub_vx_d, OP_SSS_D, H8, H8, DO_SUB)
+RVVCALL(OPIVX2, vrsub_vx_b, OP_SSS_B, H1, H1, DO_RSUB)
+RVVCALL(OPIVX2, vrsub_vx_h, OP_SSS_H, H2, H2, DO_RSUB)
+RVVCALL(OPIVX2, vrsub_vx_w, OP_SSS_W, H4, H4, DO_RSUB)
+RVVCALL(OPIVX2, vrsub_vx_d, OP_SSS_D, H8, H8, DO_RSUB)
+
+/* generate the helpers for instructions with one vector and one sclar */
+#define GEN_VEXT_VX(NAME, ESZ, DSZ, CLEAR_FN)             \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
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
+        do_##NAME(vd, s1, vs2, i);                        \
+    }                                                     \
+    if (i != 0) {                                         \
+        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);         \
+    }                                                     \
+}
+GEN_VEXT_VX(vadd_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vadd_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vadd_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vadd_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vsub_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vsub_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vsub_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vsub_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vrsub_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vrsub_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vrsub_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vrsub_vx_d, 8, 8, clearq)
-- 
2.23.0


