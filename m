Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B6DC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD1B205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD1B205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42027 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHKy-0003RK-Kh
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBHIH-0007YH-PG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBHIG-0001bV-Ca
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:14:01 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36985)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBHIF-0001Wg-Q7; Mon, 09 Mar 2020 08:14:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07954461|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.146651-0.000331899-0.853017;
 FP=764458034101132543|1|1|7|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com;
 NM=1; PH=DS; RN=10; RT=10; SR=0; TI=SMTPD_---.Gyap3GW_1583756030; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Gyap3GW_1583756030) by smtp.aliyun-inc.com(10.147.40.2);
 Mon, 09 Mar 2020 20:13:50 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 43/60] target/riscv: narrowing floating-point/integer
 type-convert instructions
Date: Mon,  9 Mar 2020 20:12:58 +0800
Message-Id: <20200309121315.13611-44-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
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
 target/riscv/helper.h                   | 11 +++++++
 target/riscv/insn32.decode              |  5 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 42 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 42 +++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 90b4d50c62..008c5b9868 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1010,3 +1010,14 @@ DEF_HELPER_5(vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vfncvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 247419937e..ffc58698c6 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -518,6 +518,11 @@ vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
 vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
 vfwcvt_f_x_v    100010 . ..... 01011 001 ..... 1010111 @r2_vm
 vfwcvt_f_f_v    100010 . ..... 01100 001 ..... 1010111 @r2_vm
+vfncvt_xu_f_v   100010 . ..... 10000 001 ..... 1010111 @r2_vm
+vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
+vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
+vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
+vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 0566132d4e..bdb765bf13 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1981,3 +1981,45 @@ GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_f_xu_v)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_f_x_v)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
+
+/* Narrowing Floating-Point/Integer Type-Convert Instructions */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+static bool opfv_narrow_check(DisasContext *s, arg_rmr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
+                2 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+#define GEN_OPFV_NARROW_TRANS(NAME)                                \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opfv_narrow_check(s, a)) {                                 \
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
+GEN_OPFV_NARROW_TRANS(vfncvt_xu_f_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_x_f_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_x_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6454c54500..bb143b9216 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4020,3 +4020,45 @@ RVVCALL(OPFVV1, vfwcvt_f_f_v_h, WOP_UU_H, H4, H2, vfwcvtffv16)
 RVVCALL(OPFVV1, vfwcvt_f_f_v_w, WOP_UU_W, H8, H4, vfwcvtffv32)
 GEN_VEXT_V_ENV(vfwcvt_f_f_v_h, 2, 4, clearl)
 GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 4, 8, clearq)
+
+/* Narrowing Floating-Point/Integer Type-Convert Instructions */
+/* (TD, T2, TX2) */
+#define NOP_UU_H uint16_t, uint32_t, uint32_t
+#define NOP_UU_W uint32_t, uint64_t, uint64_t
+/* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
+RVVCALL(OPFVV1, vfncvt_xu_f_v_h, NOP_UU_H, H2, H4, float32_to_uint16)
+RVVCALL(OPFVV1, vfncvt_xu_f_v_w, NOP_UU_W, H4, H8, float64_to_uint32)
+GEN_VEXT_V_ENV(vfncvt_xu_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_xu_f_v_w, 4, 4, clearl)
+
+/* vfncvt.x.f.v vd, vs2, vm # Convert double-width float to signed integer. */
+RVVCALL(OPFVV1, vfncvt_x_f_v_h, NOP_UU_H, H2, H4, float32_to_int16)
+RVVCALL(OPFVV1, vfncvt_x_f_v_w, NOP_UU_W, H4, H8, float64_to_int32)
+GEN_VEXT_V_ENV(vfncvt_x_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_x_f_v_w, 4, 4, clearl)
+
+/* vfncvt.f.xu.v vd, vs2, vm # Convert double-width unsigned integer to float */
+RVVCALL(OPFVV1, vfncvt_f_xu_v_h, NOP_UU_H, H2, H4, uint32_to_float16)
+RVVCALL(OPFVV1, vfncvt_f_xu_v_w, NOP_UU_W, H4, H8, uint64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_xu_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_f_xu_v_w, 4, 4, clearl)
+
+/* vfncvt.f.x.v vd, vs2, vm # Convert double-width integer to float. */
+RVVCALL(OPFVV1, vfncvt_f_x_v_h, NOP_UU_H, H2, H4, int32_to_float16)
+RVVCALL(OPFVV1, vfncvt_f_x_v_w, NOP_UU_W, H4, H8, int64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_x_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_f_x_v_w, 4, 4, clearl)
+
+/* vfncvt.f.f.v vd, vs2, vm # Convert double float to single-width float. */
+static uint16_t vfncvtffv16(uint32_t a, float_status *s)
+{
+    return float32_to_float16(a, true, s);
+}
+static uint32_t vfncvtffv32(uint64_t a, float_status *s)
+{
+    return float64_to_float32(a, s);
+}
+RVVCALL(OPFVV1, vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
+RVVCALL(OPFVV1, vfncvt_f_f_v_w, NOP_UU_W, H4, H8, vfncvtffv32)
+GEN_VEXT_V_ENV(vfncvt_f_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4, clearl)
-- 
2.23.0


