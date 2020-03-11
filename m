Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF64C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3416820578
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3416820578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBtnq-0004A6-E6
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 01:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBtdB-0006wf-PR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBtd9-0003FX-Kr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:10:09 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46199)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBtd8-00036g-Re; Wed, 11 Mar 2020 01:10:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436295|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.377255-0.00325374-0.619491;
 FP=9693965973447181918|1|1|1|0|-1|-1|-1; HT=e02c03268; MF=zhiwei_liu@c-sky.com;
 NM=1; PH=DS; RN=10; RT=10; SR=0; TI=SMTPD_---.GzWV6Tg_1583903398; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GzWV6Tg_1583903398)
 by smtp.aliyun-inc.com(10.147.44.145);
 Wed, 11 Mar 2020 13:10:02 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v4 26/60] target/riscv: vector widening saturating scaled
 multiply-add
Date: Wed, 11 Mar 2020 13:06:45 +0800
Message-Id: <20200311050719.15141-27-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  22 +++
 target/riscv/insn32.decode              |   7 +
 target/riscv/insn_trans/trans_rvv.inc.c |   9 ++
 target/riscv/vector_helper.c            | 180 ++++++++++++++++++++++++
 4 files changed, 218 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 333eccca57..74c1c695e0 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -733,3 +733,25 @@ DEF_HELPER_6(vsmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vwsmaccu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 99f70924d6..8798919d3e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -419,6 +419,13 @@ vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
 vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
 vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
 vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmaccu_vv     111100 . ..... ..... 000 ..... 1010111 @r_vm
+vwsmaccu_vx     111100 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmacc_vv      111101 . ..... ..... 000 ..... 1010111 @r_vm
+vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
+vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 60e1e63b7b..68bebd3c37 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1532,3 +1532,12 @@ GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
 /* Vector Single-Width Fractional Multiply with Rounding and Saturation */
 GEN_OPIVV_TRANS(vsmul_vv, opivv_check)
 GEN_OPIVX_TRANS(vsmul_vx,  opivx_check)
+
+/* Vector Widening Saturating Scaled Multiply-Add */
+GEN_OPIVV_WIDEN_TRANS(vwsmaccu_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwsmacc_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwsmaccsu_vv, opivv_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwsmaccu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsmacc_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsmaccsu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsmaccus_vx)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 74ad07743c..90c19577fa 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2523,3 +2523,183 @@ GEN_VEXT_VX_ENV(vsmul_vx_b, 1, 1, clearb)
 GEN_VEXT_VX_ENV(vsmul_vx_h, 2, 2, clearh)
 GEN_VEXT_VX_ENV(vsmul_vx_w, 4, 4, clearl)
 GEN_VEXT_VX_ENV(vsmul_vx_d, 8, 8, clearq)
+
+/* Vector Widening Saturating Scaled Multiply-Add */
+static uint16_t vwsmaccu8(CPURISCVState *env, uint8_t a, uint8_t b,
+    uint16_t c)
+{
+    uint8_t round;
+    uint16_t res = (uint16_t)a * (uint16_t)b;
+
+    round = get_round(env, res, 4);
+    res   = (res >> 4) + round;
+    return saddu16(env, c, res);
+}
+static uint32_t vwsmaccu16(CPURISCVState *env, uint16_t a, uint16_t b,
+    uint32_t c)
+{
+    uint8_t round;
+    uint32_t res = (uint32_t)a * (uint32_t)b;
+
+    round = get_round(env, res, 8);
+    res   = (res >> 8) + round;
+    return saddu32(env, c, res);
+}
+static uint64_t vwsmaccu32(CPURISCVState *env, uint32_t a, uint32_t b,
+    uint64_t c)
+{
+    uint8_t round;
+    uint64_t res = (uint64_t)a * (uint64_t)b;
+
+    round = get_round(env, res, 16);
+    res   = (res >> 16) + round;
+    return saddu64(env, c, res);
+}
+
+#define OPIVV3_ENV(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i,       \
+        CPURISCVState *env)                                        \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(env, s2, s1, d);                      \
+}
+RVVCALL(OPIVV3_ENV, vwsmaccu_vv_b, WOP_UUU_B, H2, H1, H1, vwsmaccu8)
+RVVCALL(OPIVV3_ENV, vwsmaccu_vv_h, WOP_UUU_H, H4, H2, H2, vwsmaccu16)
+RVVCALL(OPIVV3_ENV, vwsmaccu_vv_w, WOP_UUU_W, H8, H4, H4, vwsmaccu32)
+GEN_VEXT_VV_ENV(vwsmaccu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV_ENV(vwsmaccu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vwsmaccu_vv_w, 4, 8, clearq)
+
+#define OPIVX3_ENV(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)            \
+static void do_##NAME(void *vd, target_ulong s1, void *vs2, int i,     \
+        CPURISCVState *env)                                            \
+{                                                                      \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                    \
+    TD d = *((TD *)vd + HD(i));                                        \
+    *((TD *)vd + HD(i)) = OP(env, s2, (TX1)(T1)(target_long)s1, d);    \
+}
+RVVCALL(OPIVX3_ENV, vwsmaccu_vx_b, WOP_UUU_B, H2, H1, vwsmaccu8)
+RVVCALL(OPIVX3_ENV, vwsmaccu_vx_h, WOP_UUU_H, H4, H2, vwsmaccu16)
+RVVCALL(OPIVX3_ENV, vwsmaccu_vx_w, WOP_UUU_W, H8, H4, vwsmaccu32)
+GEN_VEXT_VX_ENV(vwsmaccu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX_ENV(vwsmaccu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX_ENV(vwsmaccu_vx_w, 4, 8, clearq)
+
+static int16_t vwsmacc8(CPURISCVState *env, int8_t a, int8_t b, int16_t c)
+{
+    uint8_t round;
+    int16_t res = (int16_t)a * (int16_t)b;
+
+    round = get_round(env, res, 4);
+    res   = (res >> 4) + round;
+    return sadd16(env, c, res);
+}
+static int32_t vwsmacc16(CPURISCVState *env, int16_t a, int16_t b, int32_t c)
+{
+    uint8_t round;
+    int32_t res = (int32_t)a * (int32_t)b;
+
+    round = get_round(env, res, 8);
+    res   = (res >> 8) + round;
+    return sadd32(env, c, res);
+
+}
+static int64_t vwsmacc32(CPURISCVState *env, int32_t a, int32_t b, int64_t c)
+{
+    uint8_t round;
+    int64_t res = (int64_t)a * (int64_t)b;
+
+    round = get_round(env, res, 16);
+    res   = (res >> 16) + round;
+    return sadd64(env, c, res);
+}
+RVVCALL(OPIVV3_ENV, vwsmacc_vv_b, WOP_SSS_B, H2, H1, H1, vwsmacc8)
+RVVCALL(OPIVV3_ENV, vwsmacc_vv_h, WOP_SSS_H, H4, H2, H2, vwsmacc16)
+RVVCALL(OPIVV3_ENV, vwsmacc_vv_w, WOP_SSS_W, H8, H4, H4, vwsmacc32)
+GEN_VEXT_VV_ENV(vwsmacc_vv_b, 1, 2, clearh)
+GEN_VEXT_VV_ENV(vwsmacc_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vwsmacc_vv_w, 4, 8, clearq)
+RVVCALL(OPIVX3_ENV, vwsmacc_vx_b, WOP_SSS_B, H2, H1, vwsmacc8)
+RVVCALL(OPIVX3_ENV, vwsmacc_vx_h, WOP_SSS_H, H4, H2, vwsmacc16)
+RVVCALL(OPIVX3_ENV, vwsmacc_vx_w, WOP_SSS_W, H8, H4, vwsmacc32)
+GEN_VEXT_VX_ENV(vwsmacc_vx_b, 1, 2, clearh)
+GEN_VEXT_VX_ENV(vwsmacc_vx_h, 2, 4, clearl)
+GEN_VEXT_VX_ENV(vwsmacc_vx_w, 4, 8, clearq)
+
+static int16_t vwsmaccsu8(CPURISCVState *env, uint8_t a, int8_t b, int16_t c)
+{
+    uint8_t round;
+    int16_t res = (uint16_t)a * (int16_t)b;
+
+    round = get_round(env, res, 4);
+    res   = (res >> 4) + round;
+    return ssub16(env, c, res);
+}
+static int32_t vwsmaccsu16(CPURISCVState *env, uint16_t a, int16_t b,
+    uint32_t c)
+{
+    uint8_t round;
+    int32_t res = (uint32_t)a * (int32_t)b;
+
+    round = get_round(env, res, 8);
+    res   = (res >> 8) + round;
+    return ssub32(env, c, res);
+}
+static int64_t vwsmaccsu32(CPURISCVState *env, uint32_t a, int32_t b,
+    int64_t c)
+{
+    uint8_t round;
+    int64_t res = (uint64_t)a * (int64_t)b;
+
+    round = get_round(env, res, 16);
+    res   = (res >> 16) + round;
+    return ssub64(env, c, res);
+}
+RVVCALL(OPIVV3_ENV, vwsmaccsu_vv_b, WOP_SSU_B, H2, H1, H1, vwsmaccsu8)
+RVVCALL(OPIVV3_ENV, vwsmaccsu_vv_h, WOP_SSU_H, H4, H2, H2, vwsmaccsu16)
+RVVCALL(OPIVV3_ENV, vwsmaccsu_vv_w, WOP_SSU_W, H8, H4, H4, vwsmaccsu32)
+GEN_VEXT_VV_ENV(vwsmaccsu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV_ENV(vwsmaccsu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vwsmaccsu_vv_w, 4, 8, clearq)
+RVVCALL(OPIVX3_ENV, vwsmaccsu_vx_b, WOP_SSU_B, H2, H1, vwsmaccsu8)
+RVVCALL(OPIVX3_ENV, vwsmaccsu_vx_h, WOP_SSU_H, H4, H2, vwsmaccsu16)
+RVVCALL(OPIVX3_ENV, vwsmaccsu_vx_w, WOP_SSU_W, H8, H4, vwsmaccsu32)
+GEN_VEXT_VX_ENV(vwsmaccsu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX_ENV(vwsmaccsu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX_ENV(vwsmaccsu_vx_w, 4, 8, clearq)
+
+static int16_t vwsmaccus8(CPURISCVState *env, int8_t a, uint8_t b, int16_t c)
+{
+    uint8_t round;
+    int16_t res = (int16_t)a * (uint16_t)b;
+
+    round = get_round(env, res, 4);
+    res   = (res >> 4) + round;
+    return ssub16(env, c, res);
+}
+static int32_t vwsmaccus16(CPURISCVState *env, int16_t a, uint16_t b, int32_t c)
+{
+    uint8_t round;
+    int32_t res = (int32_t)a * (uint32_t)b;
+
+    round = get_round(env, res, 8);
+    res   = (res >> 8) + round;
+    return ssub32(env, c, res);
+}
+static int64_t vwsmaccus32(CPURISCVState *env, int32_t a, uint32_t b, int64_t c)
+{
+    uint8_t round;
+    int64_t res = (int64_t)a * (uint64_t)b;
+
+    round = get_round(env, res, 16);
+    res   = (res >> 16) + round;
+    return ssub64(env, c, res);
+}
+RVVCALL(OPIVX3_ENV, vwsmaccus_vx_b, WOP_SUS_B, H2, H1, vwsmaccus8)
+RVVCALL(OPIVX3_ENV, vwsmaccus_vx_h, WOP_SUS_H, H4, H2, vwsmaccus16)
+RVVCALL(OPIVX3_ENV, vwsmaccus_vx_w, WOP_SUS_W, H8, H4, vwsmaccus32)
+GEN_VEXT_VX_ENV(vwsmaccus_vx_b, 1, 2, clearh)
+GEN_VEXT_VX_ENV(vwsmaccus_vx_h, 2, 4, clearl)
+GEN_VEXT_VX_ENV(vwsmaccus_vx_w, 4, 8, clearq)
-- 
2.23.0


