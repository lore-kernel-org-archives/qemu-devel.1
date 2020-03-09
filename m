Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541DBC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18AE92083E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AE92083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBE0b-0006zp-8R
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDgM-0007Xs-F0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDgJ-00082F-A7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBDgI-0007Zq-HR; Mon, 09 Mar 2020 04:22:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.0121004-9.12865e-05-0.987808;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.GyTxIXp_1583742101; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GyTxIXp_1583742101)
 by smtp.aliyun-inc.com(10.147.41.137);
 Mon, 09 Mar 2020 16:21:59 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 33/60] target/riscv: vector single-width floating-point
 fused multiply-add instructions
Date: Mon,  9 Mar 2020 16:20:15 +0800
Message-Id: <20200309082042.12967-34-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  49 +++++
 target/riscv/insn32.decode              |  16 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  18 ++
 target/riscv/vector_helper.c            | 228 ++++++++++++++++++++++++
 4 files changed, 311 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3ec2dcadd4..3b6dd96918 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -839,3 +839,52 @@ DEF_HELPER_6(vfwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e0ee8f5a7c..9834091a86 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -458,6 +458,22 @@ vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
 vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
 vfwmul_vv       111000 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmul_vf       111000 . ..... ..... 101 ..... 1010111 @r_vm
+vfmacc_vv       101100 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmacc_vv      101101 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmacc_vf      101101 . ..... ..... 101 ..... 1010111 @r_vm
+vfmacc_vf       101100 . ..... ..... 101 ..... 1010111 @r_vm
+vfmsac_vv       101110 . ..... ..... 001 ..... 1010111 @r_vm
+vfmsac_vf       101110 . ..... ..... 101 ..... 1010111 @r_vm
+vfnmsac_vv      101111 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmsac_vf      101111 . ..... ..... 101 ..... 1010111 @r_vm
+vfmadd_vv       101000 . ..... ..... 001 ..... 1010111 @r_vm
+vfmadd_vf       101000 . ..... ..... 101 ..... 1010111 @r_vm
+vfnmadd_vv      101001 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmadd_vf      101001 . ..... ..... 101 ..... 1010111 @r_vm
+vfmsub_vv       101010 . ..... ..... 001 ..... 1010111 @r_vm
+vfmsub_vf       101010 . ..... ..... 101 ..... 1010111 @r_vm
+vfnmsub_vv      101011 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmsub_vf      101011 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b4d3797685..172de867ea 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1806,3 +1806,21 @@ GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
 /* Vector Widening Floating-Point Multiply */
 GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
 GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
+
+/* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
+GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfnmacc_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfmsac_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfnmsac_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfmadd_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfnmadd_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfmsub_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfnmsub_vv, opfvv_check)
+GEN_OPFVF_TRANS(vfmacc_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfnmacc_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfmsac_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfnmsac_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfmadd_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfnmadd_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfnmsub_vf, opfvf_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8bb6ac158f..2e0341adb0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3176,3 +3176,231 @@ RVVCALL(OPFVF2, vfwmul_vf_h, WOP_UUU_H, H4, H2, vfwmul16)
 RVVCALL(OPFVF2, vfwmul_vf_w, WOP_UUU_W, H8, H4, vfwmul32)
 GEN_VEXT_VF(vfwmul_vf_h, 2, 4, clearl)
 GEN_VEXT_VF(vfwmul_vf_w, 4, 8, clearq)
+
+/* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
+#define OPFVV3(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)       \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i,       \
+        CPURISCVState *env)                                        \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(s2, s1, d, &env->fp_status);          \
+}
+static uint16_t fmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(a, b, d, 0, s);
+}
+
+static uint32_t fmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(a, b, d, 0, s);
+}
+
+static uint64_t fmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(a, b, d, 0, s);
+}
+RVVCALL(OPFVV3, vfmacc_vv_h, OP_UUU_H, H2, H2, H2, fmacc16)
+RVVCALL(OPFVV3, vfmacc_vv_w, OP_UUU_W, H4, H4, H4, fmacc32)
+RVVCALL(OPFVV3, vfmacc_vv_d, OP_UUU_D, H8, H8, H8, fmacc64)
+GEN_VEXT_VV_ENV(vfmacc_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmacc_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmacc_vv_d, 8, 8, clearq)
+
+#define OPFVF3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)           \
+static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i,    \
+        CPURISCVState *env)                                       \
+{                                                                 \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                               \
+    TD d = *((TD *)vd + HD(i));                                   \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, d, &env->fp_status);\
+}
+RVVCALL(OPFVF3, vfmacc_vf_h, OP_UUU_H, H2, H2, fmacc16)
+RVVCALL(OPFVF3, vfmacc_vf_w, OP_UUU_W, H4, H4, fmacc32)
+RVVCALL(OPFVF3, vfmacc_vf_d, OP_UUU_D, H8, H8, fmacc64)
+GEN_VEXT_VF(vfmacc_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmacc_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmacc_vf_d, 8, 8, clearq)
+
+static uint16_t fnmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(a, b, d,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+static uint32_t fnmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(a, b, d,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+static uint64_t fnmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(a, b, d,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+RVVCALL(OPFVV3, vfnmacc_vv_h, OP_UUU_H, H2, H2, H2, fnmacc16)
+RVVCALL(OPFVV3, vfnmacc_vv_w, OP_UUU_W, H4, H4, H4, fnmacc32)
+RVVCALL(OPFVV3, vfnmacc_vv_d, OP_UUU_D, H8, H8, H8, fnmacc64)
+GEN_VEXT_VV_ENV(vfnmacc_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfnmacc_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfnmacc_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfnmacc_vf_h, OP_UUU_H, H2, H2, fnmacc16)
+RVVCALL(OPFVF3, vfnmacc_vf_w, OP_UUU_W, H4, H4, fnmacc32)
+RVVCALL(OPFVF3, vfnmacc_vf_d, OP_UUU_D, H8, H8, fnmacc64)
+GEN_VEXT_VF(vfnmacc_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfnmacc_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfnmacc_vf_d, 8, 8, clearq)
+
+static uint16_t fmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(a, b, d, float_muladd_negate_c, s);
+}
+static uint32_t fmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(a, b, d, float_muladd_negate_c, s);
+}
+static uint64_t fmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(a, b, d, float_muladd_negate_c, s);
+}
+RVVCALL(OPFVV3, vfmsac_vv_h, OP_UUU_H, H2, H2, H2, fmsac16)
+RVVCALL(OPFVV3, vfmsac_vv_w, OP_UUU_W, H4, H4, H4, fmsac32)
+RVVCALL(OPFVV3, vfmsac_vv_d, OP_UUU_D, H8, H8, H8, fmsac64)
+GEN_VEXT_VV_ENV(vfmsac_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmsac_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmsac_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfmsac_vf_h, OP_UUU_H, H2, H2, fmsac16)
+RVVCALL(OPFVF3, vfmsac_vf_w, OP_UUU_W, H4, H4, fmsac32)
+RVVCALL(OPFVF3, vfmsac_vf_d, OP_UUU_D, H8, H8, fmsac64)
+GEN_VEXT_VF(vfmsac_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmsac_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmsac_vf_d, 8, 8, clearq)
+
+static uint16_t fnmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(a, b, d, float_muladd_negate_product, s);
+}
+static uint32_t fnmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(a, b, d, float_muladd_negate_product, s);
+}
+static uint64_t fnmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(a, b, d, float_muladd_negate_product, s);
+}
+RVVCALL(OPFVV3, vfnmsac_vv_h, OP_UUU_H, H2, H2, H2, fnmsac16)
+RVVCALL(OPFVV3, vfnmsac_vv_w, OP_UUU_W, H4, H4, H4, fnmsac32)
+RVVCALL(OPFVV3, vfnmsac_vv_d, OP_UUU_D, H8, H8, H8, fnmsac64)
+GEN_VEXT_VV_ENV(vfnmsac_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfnmsac_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfnmsac_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfnmsac_vf_h, OP_UUU_H, H2, H2, fnmsac16)
+RVVCALL(OPFVF3, vfnmsac_vf_w, OP_UUU_W, H4, H4, fnmsac32)
+RVVCALL(OPFVF3, vfnmsac_vf_d, OP_UUU_D, H8, H8, fnmsac64)
+GEN_VEXT_VF(vfnmsac_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfnmsac_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfnmsac_vf_d, 8, 8, clearq)
+
+static uint16_t fmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(d, b, a, 0, s);
+}
+static uint32_t fmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(d, b, a, 0, s);
+}
+static uint64_t fmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(d, b, a, 0, s);
+}
+RVVCALL(OPFVV3, vfmadd_vv_h, OP_UUU_H, H2, H2, H2, fmadd16)
+RVVCALL(OPFVV3, vfmadd_vv_w, OP_UUU_W, H4, H4, H4, fmadd32)
+RVVCALL(OPFVV3, vfmadd_vv_d, OP_UUU_D, H8, H8, H8, fmadd64)
+GEN_VEXT_VV_ENV(vfmadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmadd_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfmadd_vf_h, OP_UUU_H, H2, H2, fmadd16)
+RVVCALL(OPFVF3, vfmadd_vf_w, OP_UUU_W, H4, H4, fmadd32)
+RVVCALL(OPFVF3, vfmadd_vf_d, OP_UUU_D, H8, H8, fmadd64)
+GEN_VEXT_VF(vfmadd_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmadd_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmadd_vf_d, 8, 8, clearq)
+
+static uint16_t fnmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(d, b, a,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+static uint32_t fnmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(d, b, a,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+static uint64_t fnmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(d, b, a,
+            float_muladd_negate_c | float_muladd_negate_product, s);
+}
+
+RVVCALL(OPFVV3, vfnmadd_vv_h, OP_UUU_H, H2, H2, H2, fnmadd16)
+RVVCALL(OPFVV3, vfnmadd_vv_w, OP_UUU_W, H4, H4, H4, fnmadd32)
+RVVCALL(OPFVV3, vfnmadd_vv_d, OP_UUU_D, H8, H8, H8, fnmadd64)
+GEN_VEXT_VV_ENV(vfnmadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfnmadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfnmadd_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfnmadd_vf_h, OP_UUU_H, H2, H2, fnmadd16)
+RVVCALL(OPFVF3, vfnmadd_vf_w, OP_UUU_W, H4, H4, fnmadd32)
+RVVCALL(OPFVF3, vfnmadd_vf_d, OP_UUU_D, H8, H8, fnmadd64)
+GEN_VEXT_VF(vfnmadd_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfnmadd_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfnmadd_vf_d, 8, 8, clearq)
+
+static uint16_t fmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(d, b, a, float_muladd_negate_c, s);
+}
+static uint32_t fmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(d, b, a, float_muladd_negate_c, s);
+}
+static uint64_t fmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(d, b, a, float_muladd_negate_c, s);
+}
+RVVCALL(OPFVV3, vfmsub_vv_h, OP_UUU_H, H2, H2, H2, fmsub16)
+RVVCALL(OPFVV3, vfmsub_vv_w, OP_UUU_W, H4, H4, H4, fmsub32)
+RVVCALL(OPFVV3, vfmsub_vv_d, OP_UUU_D, H8, H8, H8, fmsub64)
+GEN_VEXT_VV_ENV(vfmsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmsub_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfmsub_vf_h, OP_UUU_H, H2, H2, fmsub16)
+RVVCALL(OPFVF3, vfmsub_vf_w, OP_UUU_W, H4, H4, fmsub32)
+RVVCALL(OPFVF3, vfmsub_vf_d, OP_UUU_D, H8, H8, fmsub64)
+GEN_VEXT_VF(vfmsub_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmsub_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmsub_vf_d, 8, 8, clearq)
+
+static uint16_t fnmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
+{
+    return float16_muladd(d, b, a, float_muladd_negate_product, s);
+}
+static uint32_t fnmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(d, b, a, float_muladd_negate_product, s);
+}
+static uint64_t fnmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
+{
+    return float64_muladd(d, b, a, float_muladd_negate_product, s);
+}
+RVVCALL(OPFVV3, vfnmsub_vv_h, OP_UUU_H, H2, H2, H2, fnmsub16)
+RVVCALL(OPFVV3, vfnmsub_vv_w, OP_UUU_W, H4, H4, H4, fnmsub32)
+RVVCALL(OPFVV3, vfnmsub_vv_d, OP_UUU_D, H8, H8, H8, fnmsub64)
+GEN_VEXT_VV_ENV(vfnmsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfnmsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfnmsub_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF3, vfnmsub_vf_h, OP_UUU_H, H2, H2, fnmsub16)
+RVVCALL(OPFVF3, vfnmsub_vf_w, OP_UUU_W, H4, H4, fnmsub32)
+RVVCALL(OPFVF3, vfnmsub_vf_d, OP_UUU_D, H8, H8, fnmsub64)
+GEN_VEXT_VF(vfnmsub_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfnmsub_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfnmsub_vf_d, 8, 8, clearq)
-- 
2.23.0


