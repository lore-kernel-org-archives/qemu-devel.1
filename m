Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5433C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3E6208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3E6208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHDD-00079l-Sv
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBHCO-0006Bk-QK
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBHCN-00072F-7D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:07:56 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42867)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBHCM-00070G-It; Mon, 09 Mar 2020 08:07:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0758598|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.136839-8.07347e-05-0.86308;
 FP=10277195263534367798|1|1|7|0|-1|-1|-1; HT=e01a16370;
 MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=10; RT=10; SR=0;
 TI=SMTPD_---.Gyaaf3X_1583755609; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Gyaaf3X_1583755609)
 by smtp.aliyun-inc.com(10.147.41.178);
 Mon, 09 Mar 2020 20:07:49 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 44/60] target/riscv: vector single-width integer reduction
 instructions
Date: Mon,  9 Mar 2020 20:05:28 +0800
Message-Id: <20200309120544.13503-45-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200309120544.13503-17-zhiwei_liu@c-sky.com>
References: <20200309120544.13503-17-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   | 33 +++++++++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 17 ++++++
 target/riscv/vector_helper.c            | 76 +++++++++++++++++++++++++
 4 files changed, 134 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 008c5b9868..cc1eb55404 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1021,3 +1021,36 @@ DEF_HELPER_5(vfncvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredsum_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmaxu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmaxu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmaxu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmaxu_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmax_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmax_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmax_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredminu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredminu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredminu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredminu_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmin_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredand_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredand_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredand_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredand_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredxor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredxor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredxor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vredxor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index ffc58698c6..2419ef97e7 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -523,6 +523,14 @@ vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
 vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
 vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
 vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
+vredsum_vs      000000 . ..... ..... 010 ..... 1010111 @r_vm
+vredand_vs      000001 . ..... ..... 010 ..... 1010111 @r_vm
+vredor_vs       000010 . ..... ..... 010 ..... 1010111 @r_vm
+vredxor_vs      000011 . ..... ..... 010 ..... 1010111 @r_vm
+vredminu_vs     000100 . ..... ..... 010 ..... 1010111 @r_vm
+vredmin_vs      000101 . ..... ..... 010 ..... 1010111 @r_vm
+vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
+vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index bdb765bf13..3f6951abd5 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2023,3 +2023,20 @@ GEN_OPFV_NARROW_TRANS(vfncvt_x_f_v)
 GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_v)
 GEN_OPFV_NARROW_TRANS(vfncvt_f_x_v)
 GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
+
+/*
+ *** Vector Reduction Operations
+ */
+/* Vector Single-Width Integer Reduction Instructions */
+static bool reduction_check(DisasContext *s, arg_rmrr *a)
+{
+    return vext_check_isa_ill(s, RVV) && vext_check_reg(s, a->rs2, false);
+}
+GEN_OPIVV_TRANS(vredsum_vs, reduction_check)
+GEN_OPIVV_TRANS(vredmaxu_vs, reduction_check)
+GEN_OPIVV_TRANS(vredmax_vs, reduction_check)
+GEN_OPIVV_TRANS(vredminu_vs, reduction_check)
+GEN_OPIVV_TRANS(vredmin_vs, reduction_check)
+GEN_OPIVV_TRANS(vredand_vs, reduction_check)
+GEN_OPIVV_TRANS(vredor_vs, reduction_check)
+GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bb143b9216..789be79b5a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4062,3 +4062,79 @@ RVVCALL(OPFVV1, vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
 RVVCALL(OPFVV1, vfncvt_f_f_v_w, NOP_UU_W, H4, H8, vfncvtffv32)
 GEN_VEXT_V_ENV(vfncvt_f_f_v_h, 2, 2, clearh)
 GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4, clearl)
+
+/*
+ *** Vector Reduction Operations
+ */
+/* Vector Single-Width Integer Reduction Instructions */
+#define GEN_VEXT_RED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)\
+void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    uint32_t mlen = vext_mlen(desc);                      \
+    uint32_t vm = vext_vm(desc);                          \
+    uint32_t vl = env->vl;                                \
+    uint32_t i;                                           \
+    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;        \
+                                                          \
+    TD s1 =  *((TD *)vs1 + HD(0));                        \
+    for (i = 0; i < vl; i++) {                            \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
+            continue;                                     \
+        }                                                 \
+        s1 = OP(s1, (TD)s2);                              \
+    }                                                     \
+    if (i != 0) {                                         \
+        *((TD *)vd + HD(0)) = s1;                         \
+        CLEAR_FN(vd, 1, sizeof(TD), tot);                 \
+    }                                                     \
+}
+
+/* vd[0] = sum(vs1[0], vs2[*]) */
+GEN_VEXT_RED(vredsum_vs_b, int8_t, int8_t, H1, H1, DO_ADD, clearb)
+GEN_VEXT_RED(vredsum_vs_h, int16_t, int16_t, H2, H2, DO_ADD, clearh)
+GEN_VEXT_RED(vredsum_vs_w, int32_t, int32_t, H4, H4, DO_ADD, clearl)
+GEN_VEXT_RED(vredsum_vs_d, int64_t, int64_t, H8, H8, DO_ADD, clearq)
+
+/* vd[0] = maxu(vs1[0], vs2[*]) */
+GEN_VEXT_RED(vredmaxu_vs_b, uint8_t, uint8_t, H1, H1, DO_MAX, clearb)
+GEN_VEXT_RED(vredmaxu_vs_h, uint16_t, uint16_t, H2, H2, DO_MAX, clearh)
+GEN_VEXT_RED(vredmaxu_vs_w, uint32_t, uint32_t, H4, H4, DO_MAX, clearl)
+GEN_VEXT_RED(vredmaxu_vs_d, uint64_t, uint64_t, H8, H8, DO_MAX, clearq)
+
+/* vd[0] = max(vs1[0], vs2[*]) */
+GEN_VEXT_RED(vredmax_vs_b, int8_t, int8_t, H1, H1, DO_MAX, clearb)
+GEN_VEXT_RED(vredmax_vs_h, int16_t, int16_t, H2, H2, DO_MAX, clearh)
+GEN_VEXT_RED(vredmax_vs_w, int32_t, int32_t, H4, H4, DO_MAX, clearl)
+GEN_VEXT_RED(vredmax_vs_d, int64_t, int64_t, H8, H8, DO_MAX, clearq)
+
+/* vd[0] = minu(vs1[0], vs2[*]) */
+GEN_VEXT_RED(vredminu_vs_b, uint8_t, uint8_t, H1, H1, DO_MIN, clearb)
+GEN_VEXT_RED(vredminu_vs_h, uint16_t, uint16_t, H2, H2, DO_MIN, clearh)
+GEN_VEXT_RED(vredminu_vs_w, uint32_t, uint32_t, H4, H4, DO_MIN, clearl)
+GEN_VEXT_RED(vredminu_vs_d, uint64_t, uint64_t, H8, H8, DO_MIN, clearq)
+
+/* vd[0] = min(vs1[0], vs2[*]) */
+GEN_VEXT_RED(vredmin_vs_b, int8_t, int8_t, H1, H1, DO_MIN, clearb)
+GEN_VEXT_RED(vredmin_vs_h, int16_t, int16_t, H2, H2, DO_MIN, clearh)
+GEN_VEXT_RED(vredmin_vs_w, int32_t, int32_t, H4, H4, DO_MIN, clearl)
+GEN_VEXT_RED(vredmin_vs_d, int64_t, int64_t, H8, H8, DO_MIN, clearq)
+
+/* vd[0] = and(vs1[0], vs2[*]) */
+GEN_VEXT_RED(vredand_vs_b, int8_t, int8_t, H1, H1, DO_AND, clearb)
+GEN_VEXT_RED(vredand_vs_h, int16_t, int16_t, H2, H2, DO_AND, clearh)
+GEN_VEXT_RED(vredand_vs_w, int32_t, int32_t, H4, H4, DO_AND, clearl)
+GEN_VEXT_RED(vredand_vs_d, int64_t, int64_t, H8, H8, DO_AND, clearq)
+
+/* vd[0] = or(vs1[0], vs2[*]) */
+GEN_VEXT_RED(vredor_vs_b, int8_t, int8_t, H1, H1, DO_OR, clearb)
+GEN_VEXT_RED(vredor_vs_h, int16_t, int16_t, H2, H2, DO_OR, clearh)
+GEN_VEXT_RED(vredor_vs_w, int32_t, int32_t, H4, H4, DO_OR, clearl)
+GEN_VEXT_RED(vredor_vs_d, int64_t, int64_t, H8, H8, DO_OR, clearq)
+
+/* vd[0] = xor(vs1[0], vs2[*]) */
+GEN_VEXT_RED(vredxor_vs_b, int8_t, int8_t, H1, H1, DO_XOR, clearb)
+GEN_VEXT_RED(vredxor_vs_h, int16_t, int16_t, H2, H2, DO_XOR, clearh)
+GEN_VEXT_RED(vredxor_vs_w, int32_t, int32_t, H4, H4, DO_XOR, clearl)
+GEN_VEXT_RED(vredxor_vs_d, int64_t, int64_t, H8, H8, DO_XOR, clearq)
-- 
2.23.0


