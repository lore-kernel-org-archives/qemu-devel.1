Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D75C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3919320714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3919320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEya-000432-AC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEEXK-0008V0-Pg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEEXJ-0008NZ-20
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:53:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEEXH-000747-KO; Tue, 17 Mar 2020 11:53:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07608369|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.0775195-0.00181646-0.920664;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03295; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1-ORVR_1584460400; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1-ORVR_1584460400)
 by smtp.aliyun-inc.com(10.147.44.145);
 Tue, 17 Mar 2020 23:53:21 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 23/61] target/riscv: vector integer merge and move
 instructions
Date: Tue, 17 Mar 2020 23:06:15 +0800
Message-Id: <20200317150653.9008-24-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  17 ++++
 target/riscv/insn32.decode              |   7 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 121 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 100 ++++++++++++++++++++
 4 files changed, 245 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1f0d3d60e3..f378db9cbf 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -665,3 +665,20 @@ DEF_HELPER_6(vwmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vmerge_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_4(vmv_v_v_b, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv_v_v_h, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv_v_v_w, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv_v_v_d, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv_v_x_b, void, ptr, i64, env, i32)
+DEF_HELPER_4(vmv_v_x_h, void, ptr, i64, env, i32)
+DEF_HELPER_4(vmv_v_x_w, void, ptr, i64, env, i32)
+DEF_HELPER_4(vmv_v_x_d, void, ptr, i64, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 9735ac3565..adb76956c9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -71,6 +71,7 @@
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
+@r_vm_0  ...... . ..... ..... ... ..... .......    &rmrr vm=0 %rs2 %rs1 %rd
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
@@ -400,6 +401,12 @@ vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
 vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
 vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
 vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+vmv_v_v         010111 1 00000 ..... 000 ..... 1010111 @r2
+vmv_v_x         010111 1 00000 ..... 100 ..... 1010111 @r2
+vmv_v_i         010111 1 00000 ..... 011 ..... 1010111 @r2
+vmerge_vvm      010111 0 ..... ..... 000 ..... 1010111 @r_vm_0
+vmerge_vxm      010111 0 ..... ..... 100 ..... 1010111 @r_vm_0
+vmerge_vim      010111 0 ..... ..... 011 ..... 1010111 @r_vm_0
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 269d04c7fb..42ef59364f 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1499,3 +1499,124 @@ GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmacc_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx)
+
+/* Vector Integer Merge and Move Instructions */
+static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false) &&
+        vext_check_reg(s, a->rs1, false)) {
+
+        if (s->vl_eq_vlmax) {
+            tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),
+                             vreg_ofs(s, a->rs1),
+                             MAXSZ(s), MAXSZ(s));
+        } else {
+            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            static gen_helper_gvec_2_ptr * const fns[4] = {
+                gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
+                gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
+            };
+
+            tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
+                               cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+        }
+        return true;
+    }
+    return false;
+}
+
+typedef void gen_helper_vmv_vx(TCGv_ptr, TCGv_i64, TCGv_env, TCGv_i32);
+static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false)) {
+
+        TCGv s1 = tcg_temp_new();
+        gen_get_gpr(s1, a->rs1);
+
+        if (s->vl_eq_vlmax) {
+#ifdef TARGET_RISCV64
+            tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
+                                 MAXSZ(s), MAXSZ(s), s1);
+#else
+            tcg_gen_gvec_dup_i32(s->sew, vreg_ofs(s, a->rd),
+                                 MAXSZ(s), MAXSZ(s), s1);
+#endif
+        } else {
+            TCGv_i32 desc;
+            TCGv_i64 s1_i64 = tcg_temp_new_i64();
+            TCGv_ptr dest = tcg_temp_new_ptr();
+            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            static gen_helper_vmv_vx * const fns[4] = {
+                gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
+                gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
+            };
+
+            tcg_gen_ext_tl_i64(s1_i64, s1);
+            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+            fns[s->sew](dest, s1_i64, cpu_env, desc);
+
+            tcg_temp_free_ptr(dest);
+            tcg_temp_free_i32(desc);
+            tcg_temp_free_i64(s1_i64);
+        }
+
+        tcg_temp_free(s1);
+        return true;
+    }
+    return false;
+}
+
+static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false)) {
+
+        int64_t simm = sextract64(a->rs1, 0, 5);
+        if (s->vl_eq_vlmax) {
+            switch (s->sew) {
+            case 0:
+                tcg_gen_gvec_dup8i(vreg_ofs(s, a->rd),
+                                   MAXSZ(s), MAXSZ(s), simm);
+                break;
+            case 1:
+                tcg_gen_gvec_dup16i(vreg_ofs(s, a->rd),
+                                    MAXSZ(s), MAXSZ(s), simm);
+                break;
+            case 2:
+                tcg_gen_gvec_dup32i(vreg_ofs(s, a->rd),
+                                    MAXSZ(s), MAXSZ(s), simm);
+                break;
+            default:
+                tcg_gen_gvec_dup64i(vreg_ofs(s, a->rd),
+                                    MAXSZ(s), MAXSZ(s), simm);
+                break;
+            }
+        } else {
+            TCGv_i32 desc;
+            TCGv_i64 s1 = tcg_const_i64(simm);
+            TCGv_ptr dest = tcg_temp_new_ptr();
+            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            static gen_helper_vmv_vx * const fns[4] = {
+                gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
+                gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
+            };
+
+            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+            fns[s->sew](dest, s1, cpu_env, desc);
+
+            tcg_temp_free_ptr(dest);
+            tcg_temp_free_i32(desc);
+            tcg_temp_free_i64(s1);
+        }
+        return true;
+    }
+    return false;
+}
+
+GEN_OPIVV_TRANS(vmerge_vvm, opivv_vadc_check)
+GEN_OPIVX_TRANS(vmerge_vxm, opivx_vadc_check)
+GEN_OPIVI_TRANS(vmerge_vim, 0, vmerge_vxm, opivx_vadc_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5adce9e0a3..e52a556484 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1999,3 +1999,103 @@ GEN_VEXT_VX(vwmaccsu_vx_w, 4, 8, clearq)
 GEN_VEXT_VX(vwmaccus_vx_b, 1, 2, clearh)
 GEN_VEXT_VX(vwmaccus_vx_h, 2, 4, clearl)
 GEN_VEXT_VX(vwmaccus_vx_w, 4, 8, clearq)
+
+/* Vector Integer Merge and Move Instructions */
+#define GEN_VEXT_VMV_VV(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
+                  uint32_t desc)                                     \
+{                                                                    \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    if (vl == 0) {                                                   \
+        return;                                                      \
+    }                                                                \
+    for (i = 0; i < vl; i++) {                                       \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
+        *((ETYPE *)vd + H(i)) = s1;                                  \
+    }                                                                \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_VEXT_VMV_VV(vmv_v_v_b, int8_t,  H1, clearb)
+GEN_VEXT_VMV_VV(vmv_v_v_h, int16_t, H2, clearh)
+GEN_VEXT_VMV_VV(vmv_v_v_w, int32_t, H4, clearl)
+GEN_VEXT_VMV_VV(vmv_v_v_d, int64_t, H8, clearq)
+
+#define GEN_VEXT_VMV_VX(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
+                  uint32_t desc)                                     \
+{                                                                    \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    if (vl == 0) {                                                   \
+        return;                                                      \
+    }                                                                \
+    for (i = 0; i < vl; i++) {                                       \
+        *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
+    }                                                                \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_VEXT_VMV_VX(vmv_v_x_b, int8_t,  H1, clearb)
+GEN_VEXT_VMV_VX(vmv_v_x_h, int16_t, H2, clearh)
+GEN_VEXT_VMV_VX(vmv_v_x_w, int32_t, H4, clearl)
+GEN_VEXT_VMV_VX(vmv_v_x_d, int64_t, H8, clearq)
+
+#define GEN_VEXT_VMERGE_VV(NAME, ETYPE, H, CLEAR_FN)                 \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
+                  CPURISCVState *env, uint32_t desc)                 \
+{                                                                    \
+    uint32_t mlen = vext_mlen(desc);                                 \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    if (vl == 0) {                                                   \
+        return;                                                      \
+    }                                                                \
+    for (i = 0; i < vl; i++) {                                       \
+        ETYPE *vt = (!vext_elem_mask(v0, mlen, i) ? vs2 : vs1);      \
+        *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
+    }                                                                \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_VEXT_VMERGE_VV(vmerge_vvm_b, int8_t,  H1, clearb)
+GEN_VEXT_VMERGE_VV(vmerge_vvm_h, int16_t, H2, clearh)
+GEN_VEXT_VMERGE_VV(vmerge_vvm_w, int32_t, H4, clearl)
+GEN_VEXT_VMERGE_VV(vmerge_vvm_d, int64_t, H8, clearq)
+
+#define GEN_VEXT_VMERGE_VX(NAME, ETYPE, H, CLEAR_FN)                 \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
+                  void *vs2, CPURISCVState *env, uint32_t desc)      \
+{                                                                    \
+    uint32_t mlen = vext_mlen(desc);                                 \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    if (vl == 0) {                                                   \
+        return;                                                      \
+    }                                                                \
+    for (i = 0; i < vl; i++) {                                       \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
+        ETYPE d = (!vext_elem_mask(v0, mlen, i) ? s2 :               \
+                   (ETYPE)(target_long)s1);                          \
+        *((ETYPE *)vd + H(i)) = d;                                   \
+    }                                                                \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_VEXT_VMERGE_VX(vmerge_vxm_b, int8_t,  H1, clearb)
+GEN_VEXT_VMERGE_VX(vmerge_vxm_h, int16_t, H2, clearh)
+GEN_VEXT_VMERGE_VX(vmerge_vxm_w, int32_t, H4, clearl)
+GEN_VEXT_VMERGE_VX(vmerge_vxm_d, int64_t, H8, clearq)
-- 
2.23.0


