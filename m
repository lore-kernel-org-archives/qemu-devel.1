Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AD8C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F07620663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F07620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQdZ-0002Ud-8w
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQcv-00022o-V2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQcu-0007Gp-HK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:24:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49923)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCQcu-0007Bt-0R; Thu, 12 Mar 2020 12:24:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07800576|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.269585-0.000203051-0.730212;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03297; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-PYWCn_1584030235; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-PYWCn_1584030235)
 by smtp.aliyun-inc.com(10.147.42.241);
 Fri, 13 Mar 2020 00:23:56 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 42/60] target/riscv: widening floating-point/integer
 type-convert instructions
Date: Thu, 12 Mar 2020 22:58:42 +0800
Message-Id: <20200312145900.2054-43-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   | 11 ++++++
 target/riscv/insn32.decode              |  5 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 42 +++++++++++++++++++++++
 target/riscv/vector_helper.c            | 45 +++++++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a34157e277..90b4d50c62 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -999,3 +999,14 @@ DEF_HELPER_5(vfcvt_f_xu_v_d, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfcvt_f_x_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vfwcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6ca6f97323..247419937e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -513,6 +513,11 @@ vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
 vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
 vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
 vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
+vfwcvt_xu_f_v   100010 . ..... 01000 001 ..... 1010111 @r2_vm
+vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
+vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
+vfwcvt_f_x_v    100010 . ..... 01011 001 ..... 1010111 @r2_vm
+vfwcvt_f_f_v    100010 . ..... 01100 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index a61c7fdf32..0566132d4e 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1939,3 +1939,45 @@ GEN_OPFV_TRANS(vfcvt_xu_f_v, opfv_check)
 GEN_OPFV_TRANS(vfcvt_x_f_v, opfv_check)
 GEN_OPFV_TRANS(vfcvt_f_xu_v, opfv_check)
 GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
+
+/* Widening Floating-Point/Integer Type-Convert Instructions */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+static bool opfv_widen_check(DisasContext *s, arg_rmr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+#define GEN_OPFV_WIDEN_TRANS(NAME)                                 \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opfv_widen_check(s, a)) {                                  \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[2] = {            \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+        };                                                         \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+            vreg_ofs(s, a->rs2), cpu_env, 0,                       \
+            s->vlen / 8, data, fns[s->sew - 1]);                   \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+GEN_OPFV_WIDEN_TRANS(vfwcvt_xu_f_v)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_f_xu_v)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_f_x_v)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d032745e94..6454c54500 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3975,3 +3975,48 @@ RVVCALL(OPFVV1, vfcvt_f_x_v_d, OP_UU_D, H8, H8, int64_to_float64)
 GEN_VEXT_V_ENV(vfcvt_f_x_v_h, 2, 2, clearh)
 GEN_VEXT_V_ENV(vfcvt_f_x_v_w, 4, 4, clearl)
 GEN_VEXT_V_ENV(vfcvt_f_x_v_d, 8, 8, clearq)
+
+/* Widening Floating-Point/Integer Type-Convert Instructions */
+/* (TD, T2, TX2) */
+#define WOP_UU_H uint32_t, uint16_t, uint16_t
+#define WOP_UU_W uint64_t, uint32_t, uint32_t
+/* vfwcvt.xu.f.v vd, vs2, vm # Convert float to double-width unsigned integer.*/
+RVVCALL(OPFVV1, vfwcvt_xu_f_v_h, WOP_UU_H, H4, H2, float16_to_uint32)
+RVVCALL(OPFVV1, vfwcvt_xu_f_v_w, WOP_UU_W, H8, H4, float32_to_uint64)
+GEN_VEXT_V_ENV(vfwcvt_xu_f_v_h, 2, 4, clearl)
+GEN_VEXT_V_ENV(vfwcvt_xu_f_v_w, 4, 8, clearq)
+
+/* vfwcvt.x.f.v vd, vs2, vm # Convert float to double-width signed integer. */
+RVVCALL(OPFVV1, vfwcvt_x_f_v_h, WOP_UU_H, H4, H2, float16_to_int32)
+RVVCALL(OPFVV1, vfwcvt_x_f_v_w, WOP_UU_W, H8, H4, float32_to_int64)
+GEN_VEXT_V_ENV(vfwcvt_x_f_v_h, 2, 4, clearl)
+GEN_VEXT_V_ENV(vfwcvt_x_f_v_w, 4, 8, clearq)
+
+/* vfwcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to double-width float */
+RVVCALL(OPFVV1, vfwcvt_f_xu_v_h, WOP_UU_H, H4, H2, uint16_to_float32)
+RVVCALL(OPFVV1, vfwcvt_f_xu_v_w, WOP_UU_W, H8, H4, uint32_to_float64)
+GEN_VEXT_V_ENV(vfwcvt_f_xu_v_h, 2, 4, clearl)
+GEN_VEXT_V_ENV(vfwcvt_f_xu_v_w, 4, 8, clearq)
+
+/* vfwcvt.f.x.v vd, vs2, vm # Convert integer to double-width float. */
+RVVCALL(OPFVV1, vfwcvt_f_x_v_h, WOP_UU_H, H4, H2, int16_to_float32)
+RVVCALL(OPFVV1, vfwcvt_f_x_v_w, WOP_UU_W, H8, H4, int32_to_float64)
+GEN_VEXT_V_ENV(vfwcvt_f_x_v_h, 2, 4, clearl)
+GEN_VEXT_V_ENV(vfwcvt_f_x_v_w, 4, 8, clearq)
+
+/*
+ * vfwcvt.f.f.v vd, vs2, vm #
+ * Convert single-width float to double-width float.
+ */
+static uint32_t vfwcvtffv16(uint16_t a, float_status *s)
+{
+    return float16_to_float32(a, true, s);
+}
+static uint64_t vfwcvtffv32(uint32_t a, float_status *s)
+{
+    return float32_to_float64(a, s);
+}
+RVVCALL(OPFVV1, vfwcvt_f_f_v_h, WOP_UU_H, H4, H2, vfwcvtffv16)
+RVVCALL(OPFVV1, vfwcvt_f_f_v_w, WOP_UU_W, H8, H4, vfwcvtffv32)
+GEN_VEXT_V_ENV(vfwcvt_f_f_v_h, 2, 4, clearl)
+GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 4, 8, clearq)
-- 
2.23.0


