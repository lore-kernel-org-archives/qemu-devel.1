Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B40C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8779520771
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8779520771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqgUi-00085b-QE
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqgTr-0007SZ-Am; Wed, 01 Jul 2020 13:25:07 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqgTm-0001yr-SO; Wed, 01 Jul 2020 13:25:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07623602|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.664654-0.00204451-0.333301;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03301; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.Hvxr3FS_1593624294; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hvxr3FS_1593624294)
 by smtp.aliyun-inc.com(10.147.41.143);
 Thu, 02 Jul 2020 01:24:54 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v12 59/61] target/riscv: vector register gather instruction
Date: Wed,  1 Jul 2020 23:25:47 +0800
Message-Id: <20200701152549.1218-60-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200701152549.1218-1-zhiwei_liu@c-sky.com>
References: <20200701152549.1218-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 11:22:02
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   |  9 +++
 target/riscv/insn32.decode              |  3 +
 target/riscv/insn_trans/trans_rvv.inc.c | 78 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 60 +++++++++++++++++++
 4 files changed, 150 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 29a5eb7049..eca1ab541b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1136,3 +1136,12 @@ DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vrgather_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgather_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgather_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgather_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgather_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrgather_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrgather_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrgather_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 36123f71b9..80d5ff74a9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -574,6 +574,9 @@ vslide1up_vx    001110 . ..... ..... 110 ..... 1010111 @r_vm
 vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
 vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
 vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
+vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
+vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
+vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 4ed6d1ee2e..c0b7745a63 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2776,3 +2776,81 @@ GEN_OPIVI_TRANS(vslideup_vi, 1, vslideup_vx, slideup_check)
 GEN_OPIVX_TRANS(vslidedown_vx, opivx_check)
 GEN_OPIVX_TRANS(vslide1down_vx, opivx_check)
 GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, opivx_check)
+
+/* Vector Register Gather Instruction */
+static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (a->rd != a->rs2) && (a->rd != a->rs1));
+}
+
+GEN_OPIVV_TRANS(vrgather_vv, vrgather_vv_check)
+
+static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (a->rd != a->rs2));
+}
+
+/* vrgather.vx vd, vs2, rs1, vm # vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
+static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
+{
+    if (!vrgather_vx_check(s, a)) {
+        return false;
+    }
+
+    if (a->vm && s->vl_eq_vlmax) {
+        int vlmax = s->vlen / s->mlen;
+        TCGv_i64 dest = tcg_temp_new_i64();
+
+        if (a->rs1 == 0) {
+            vec_element_loadi(s, dest, a->rs2, 0);
+        } else {
+            vec_element_loadx(s, dest, a->rs2, cpu_gpr[a->rs1], vlmax);
+        }
+
+        tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
+                             MAXSZ(s), MAXSZ(s), dest);
+        tcg_temp_free_i64(dest);
+    } else {
+        static gen_helper_opivx * const fns[4] = {
+            gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
+            gen_helper_vrgather_vx_w, gen_helper_vrgather_vx_d
+        };
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s);
+    }
+    return true;
+}
+
+/* vrgather.vi vd, vs2, imm, vm # vd[i] = (imm >= VLMAX) ? 0 : vs2[imm] */
+static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
+{
+    if (!vrgather_vx_check(s, a)) {
+        return false;
+    }
+
+    if (a->vm && s->vl_eq_vlmax) {
+        if (a->rs1 >= s->vlen / s->mlen) {
+            tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd),
+                                 MAXSZ(s), MAXSZ(s), 0);
+        } else {
+            tcg_gen_gvec_dup_mem(s->sew, vreg_ofs(s, a->rd),
+                                 endian_ofs(s, a->rs2, a->rs1),
+                                 MAXSZ(s), MAXSZ(s));
+        }
+    } else {
+        static gen_helper_opivx * const fns[4] = {
+            gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
+            gen_helper_vrgather_vx_w, gen_helper_vrgather_vx_d
+        };
+        return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s, 1);
+    }
+    return true;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 51c4bc5756..3179b1faef 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4811,3 +4811,63 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t, H1, clearb)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2, clearh)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4, clearl)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
+
+/* Vector Register Gather Instruction */
+#define GEN_VEXT_VRGATHER_VV(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t index, i;                                                    \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        index = *((ETYPE *)vs1 + H(i));                                   \
+        if (index >= vlmax) {                                             \
+            *((ETYPE *)vd + H(i)) = 0;                                    \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
+        }                                                                 \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
+GEN_VEXT_VRGATHER_VV(vrgather_vv_b, uint8_t, H1, clearb)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_h, uint16_t, H2, clearh)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_w, uint32_t, H4, clearl)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, H8, clearq)
+
+#define GEN_VEXT_VRGATHER_VX(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t index = s1, i;                                               \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        if (index >= vlmax) {                                             \
+            *((ETYPE *)vd + H(i)) = 0;                                    \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
+        }                                                                 \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
+GEN_VEXT_VRGATHER_VX(vrgather_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VRGATHER_VX(vrgather_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VRGATHER_VX(vrgather_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VRGATHER_VX(vrgather_vx_d, uint64_t, H8, clearq)
-- 
2.23.0


