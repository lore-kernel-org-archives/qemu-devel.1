Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFC7C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FFE20674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FFE20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBDtl-0002Qe-C5
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDgC-00078Q-2G
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDg8-0007qc-6q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:27 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBDg7-0007WF-GX; Mon, 09 Mar 2020 04:22:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07608289|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.0284806-5.76426e-05-0.971462;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03311; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.GyTxIXp_1583742101; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GyTxIXp_1583742101)
 by smtp.aliyun-inc.com(10.147.41.137);
 Mon, 09 Mar 2020 16:21:57 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 30/60] target/riscv: vector widening floating-point
 add/subtract instructions
Date: Mon,  9 Mar 2020 16:20:12 +0800
Message-Id: <20200309082042.12967-31-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200309082042.12967-1-zhiwei_liu@c-sky.com>
References: <20200309082042.12967-1-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  17 +++
 target/riscv/insn32.decode              |   8 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 131 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            |  77 ++++++++++++++
 4 files changed, 233 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6b46677eeb..f242fa4e4b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -801,3 +801,20 @@ DEF_HELPER_6(vfsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfwadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 32918c4d11..5ec95541c6 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -443,6 +443,14 @@ vfadd_vf        000000 . ..... ..... 101 ..... 1010111 @r_vm
 vfsub_vv        000010 . ..... ..... 001 ..... 1010111 @r_vm
 vfsub_vf        000010 . ..... ..... 101 ..... 1010111 @r_vm
 vfrsub_vf       100111 . ..... ..... 101 ..... 1010111 @r_vm
+vfwadd_vv       110000 . ..... ..... 001 ..... 1010111 @r_vm
+vfwadd_vf       110000 . ..... ..... 101 ..... 1010111 @r_vm
+vfwadd_wv       110100 . ..... ..... 001 ..... 1010111 @r_vm
+vfwadd_wf       110100 . ..... ..... 101 ..... 1010111 @r_vm
+vfwsub_vv       110010 . ..... ..... 001 ..... 1010111 @r_vm
+vfwsub_vf       110010 . ..... ..... 101 ..... 1010111 @r_vm
+vfwsub_wv       110110 . ..... ..... 001 ..... 1010111 @r_vm
+vfwsub_wf       110110 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index af4dcb96c6..ab04f469af 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1664,3 +1664,134 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
 GEN_OPFVF_TRANS(vfadd_vf,  opfvf_check)
 GEN_OPFVF_TRANS(vfsub_vf,  opfvf_check)
 GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
+
+/* Vector Widening Floating-Point Add/Subtract Instructions */
+static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                1 << s->lmul) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* OPFVV with WIDEN */
+#define GEN_OPFVV_WIDEN_TRANS(NAME, CHECK)                       \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
+{                                                                \
+    if (CHECK(s, a)) {                                           \
+        uint32_t data = 0;                                       \
+        static gen_helper_gvec_4_ptr * const fns[2] = {          \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
+        };                                                       \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),   \
+            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),            \
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew - 1]);     \
+        return true;                                             \
+    }                                                            \
+    return false;                                                \
+}
+
+GEN_OPFVV_WIDEN_TRANS(vfwadd_vv, opfvv_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
+
+static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+/* OPFVF with WIDEN */
+#define GEN_OPFVF_WIDEN_TRANS(NAME)                              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
+{                                                                \
+    if (opfvf_widen_check(s, a)) {                               \
+        uint32_t data = 0;                                       \
+        static gen_helper_opfvf const fns[2] = {                 \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
+        };                                                       \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
+                fns[s->sew - 1], s);                             \
+    }                                                            \
+    return false;                                                \
+}
+GEN_OPFVF_WIDEN_TRANS(vfwadd_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
+
+static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* WIDEN OPFVV with WIDEN */
+#define GEN_OPFWV_WIDEN_TRANS(NAME)                                \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (opfwv_widen_check(s, a)) {                                 \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_4_ptr * const fns[2] = {            \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
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
+GEN_OPFWV_WIDEN_TRANS(vfwadd_wv)
+GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
+
+static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, true) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* WIDEN OPFVF with WIDEN */
+#define GEN_OPFWF_WIDEN_TRANS(NAME)                                      \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (opfwf_widen_check(s, a)) {                                       \
+        uint32_t data = 0;                                               \
+        static gen_helper_opfvf const fns[2] = {                         \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,                \
+        };                                                               \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);                   \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                       \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                   \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,                  \
+                fns[s->sew - 1], s);                                     \
+    }                                                                    \
+    return false;                                                        \
+}
+GEN_OPFWF_WIDEN_TRANS(vfwadd_wf)
+GEN_OPFWF_WIDEN_TRANS(vfwsub_wf)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d49a7194f7..0840c5d662 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3029,3 +3029,80 @@ RVVCALL(OPFVF2, vfrsub_vf_d, OP_UUU_D, H8, H8, float64_rsub)
 GEN_VEXT_VF(vfrsub_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfrsub_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfrsub_vf_d, 8, 8, clearq)
+
+/* Vector Widening Floating-Point Add/Subtract Instructions */
+static uint32_t vfwadd16(uint16_t a, uint16_t b, float_status *s)
+{
+    return float32_add(float16_to_float32(a, true, s),
+            float16_to_float32(b, true, s), s);
+}
+static uint64_t vfwadd32(uint32_t a, uint32_t b, float_status *s)
+{
+    return float64_add(float32_to_float64(a, s),
+            float32_to_float64(b, s), s);
+
+}
+RVVCALL(OPFVV2, vfwadd_vv_h, WOP_UUU_H, H4, H2, H2, vfwadd16)
+RVVCALL(OPFVV2, vfwadd_vv_w, WOP_UUU_W, H8, H4, H4, vfwadd32)
+GEN_VEXT_VV_ENV(vfwadd_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwadd_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwadd_vf_h, WOP_UUU_H, H4, H2, vfwadd16)
+RVVCALL(OPFVF2, vfwadd_vf_w, WOP_UUU_W, H8, H4, vfwadd32)
+GEN_VEXT_VF(vfwadd_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwadd_vf_w, 4, 8, clearq)
+
+static uint32_t vfwsub16(uint16_t a, uint16_t b, float_status *s)
+{
+    return float32_sub(float16_to_float32(a, true, s),
+            float16_to_float32(b, true, s), s);
+}
+
+static uint64_t vfwsub32(uint32_t a, uint32_t b, float_status *s)
+{
+    return float64_sub(float32_to_float64(a, s),
+            float32_to_float64(b, s), s);
+
+}
+RVVCALL(OPFVV2, vfwsub_vv_h, WOP_UUU_H, H4, H2, H2, vfwsub16)
+RVVCALL(OPFVV2, vfwsub_vv_w, WOP_UUU_W, H8, H4, H4, vfwsub32)
+GEN_VEXT_VV_ENV(vfwsub_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwsub_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwsub_vf_h, WOP_UUU_H, H4, H2, vfwsub16)
+RVVCALL(OPFVF2, vfwsub_vf_w, WOP_UUU_W, H8, H4, vfwsub32)
+GEN_VEXT_VF(vfwsub_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwsub_vf_w, 4, 8, clearq)
+
+static uint32_t vfwaddw16(uint32_t a, uint16_t b, float_status *s)
+{
+    return float32_add(a, float16_to_float32(b, true, s), s);
+}
+static uint64_t vfwaddw32(uint64_t a, uint32_t b, float_status *s)
+{
+    return float64_add(a, float32_to_float64(b, s), s);
+}
+RVVCALL(OPFVV2, vfwadd_wv_h, WOP_WUUU_H, H4, H2, H2, vfwaddw16)
+RVVCALL(OPFVV2, vfwadd_wv_w, WOP_WUUU_W, H8, H4, H4, vfwaddw32)
+GEN_VEXT_VV_ENV(vfwadd_wv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwadd_wv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwadd_wf_h, WOP_WUUU_H, H4, H2, vfwaddw16)
+RVVCALL(OPFVF2, vfwadd_wf_w, WOP_WUUU_W, H8, H4, vfwaddw32)
+GEN_VEXT_VF(vfwadd_wf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwadd_wf_w, 4, 8, clearq)
+
+static uint32_t vfwsubw16(uint32_t a, uint16_t b, float_status *s)
+{
+    return float32_sub(a, float16_to_float32(b, true, s), s);
+}
+
+static uint64_t vfwsubw32(uint64_t a, uint32_t b, float_status *s)
+{
+    return float64_sub(a, float32_to_float64(b, s), s);
+}
+RVVCALL(OPFVV2, vfwsub_wv_h, WOP_WUUU_H, H4, H2, H2, vfwsubw16)
+RVVCALL(OPFVV2, vfwsub_wv_w, WOP_WUUU_W, H8, H4, H4, vfwsubw32)
+GEN_VEXT_VV_ENV(vfwsub_wv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwsub_wv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwsub_wf_h, WOP_WUUU_H, H4, H2, vfwsubw16)
+RVVCALL(OPFVF2, vfwsub_wf_w, WOP_WUUU_W, H8, H4, vfwsubw32)
+GEN_VEXT_VF(vfwsub_wf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwsub_wf_w, 4, 8, clearq)
-- 
2.23.0


