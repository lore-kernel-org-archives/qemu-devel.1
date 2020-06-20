Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C39C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 05:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EBB22204
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 05:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EBB22204
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmW5R-0007mV-Lm
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 01:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jmW4P-0007Ki-1J; Sat, 20 Jun 2020 01:29:37 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jmW4M-0006Im-AW; Sat, 20 Jun 2020 01:29:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07554039|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.13812-0.000813233-0.861067;
 FP=1064938294987136083|2|2|6|0|-1|-1|-1; HT=e02c03306; MF=zhiwei_liu@c-sky.com;
 NM=1; PH=DS; RN=9; RT=8; SR=0; TI=SMTPD_---.HpYbUgc_1592630967; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HpYbUgc_1592630967)
 by smtp.aliyun-inc.com(10.147.44.129);
 Sat, 20 Jun 2020 13:29:27 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v10 26/61] target/riscv: vector single-width fractional
 multiply with rounding and saturation
Date: Sat, 20 Jun 2020 12:36:26 +0800
Message-Id: <20200620043701.1323-27-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200620043701.1323-1-zhiwei_liu@c-sky.com>
References: <20200620043701.1323-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 21:09:48
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
 wenmeng_zhang@c-sky.com, Alistair Francis <alistair.francis@wdc.com>,
 palmer@dabbelt.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   |   9 ++
 target/riscv/insn32.decode              |   2 +
 target/riscv/insn_trans/trans_rvv.inc.c |   4 +
 target/riscv/vector_helper.c            | 107 ++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index db9e2024ae..b2fc71c2ea 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -742,3 +742,12 @@ DEF_HELPER_6(vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vsmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 57228242aa..1dfc5f7ca0 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -424,6 +424,8 @@ vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
 vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
 vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
 vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
+vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
+vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index ed1ee0f1b5..23714793df 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1754,3 +1754,7 @@ GEN_OPIVV_TRANS(vasub_vv, opivv_check)
 GEN_OPIVX_TRANS(vaadd_vx,  opivx_check)
 GEN_OPIVX_TRANS(vasub_vx,  opivx_check)
 GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
+
+/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
+GEN_OPIVV_TRANS(vsmul_vv, opivv_check)
+GEN_OPIVX_TRANS(vsmul_vx,  opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ada95ab1e7..dd3fc39016 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2597,3 +2597,110 @@ GEN_VEXT_VX_RM(vasub_vx_b, 1, 1, clearb)
 GEN_VEXT_VX_RM(vasub_vx_h, 2, 2, clearh)
 GEN_VEXT_VX_RM(vasub_vx_w, 4, 4, clearl)
 GEN_VEXT_VX_RM(vasub_vx_d, 8, 8, clearq)
+
+/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
+static inline int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+{
+    uint8_t round;
+    int16_t res;
+
+    res = (int16_t)a * (int16_t)b;
+    round = get_round(vxrm, res, 7);
+    res   = (res >> 7) + round;
+
+    if (res > INT8_MAX) {
+        env->vxsat = 0x1;
+        return INT8_MAX;
+    } else if (res < INT8_MIN) {
+        env->vxsat = 0x1;
+        return INT8_MIN;
+    } else {
+        return res;
+    }
+}
+
+static int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
+{
+    uint8_t round;
+    int32_t res;
+
+    res = (int32_t)a * (int32_t)b;
+    round = get_round(vxrm, res, 15);
+    res   = (res >> 15) + round;
+
+    if (res > INT16_MAX) {
+        env->vxsat = 0x1;
+        return INT16_MAX;
+    } else if (res < INT16_MIN) {
+        env->vxsat = 0x1;
+        return INT16_MIN;
+    } else {
+        return res;
+    }
+}
+
+static int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    uint8_t round;
+    int64_t res;
+
+    res = (int64_t)a * (int64_t)b;
+    round = get_round(vxrm, res, 31);
+    res   = (res >> 31) + round;
+
+    if (res > INT32_MAX) {
+        env->vxsat = 0x1;
+        return INT32_MAX;
+    } else if (res < INT32_MIN) {
+        env->vxsat = 0x1;
+        return INT32_MIN;
+    } else {
+        return res;
+    }
+}
+
+static int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+{
+    uint8_t round;
+    uint64_t hi_64, lo_64;
+    int64_t res;
+
+    if (a == INT64_MIN && b == INT64_MIN) {
+        env->vxsat = 1;
+        return INT64_MAX;
+    }
+
+    muls64(&lo_64, &hi_64, a, b);
+    round = get_round(vxrm, lo_64, 63);
+    /*
+     * Cannot overflow, as there are always
+     * 2 sign bits after multiply.
+     */
+    res = (hi_64 << 1) | (lo_64 >> 63);
+    if (round) {
+        if (res == INT64_MAX) {
+            env->vxsat = 1;
+        } else {
+            res += 1;
+        }
+    }
+    return res;
+}
+
+RVVCALL(OPIVV2_RM, vsmul_vv_b, OP_SSS_B, H1, H1, H1, vsmul8)
+RVVCALL(OPIVV2_RM, vsmul_vv_h, OP_SSS_H, H2, H2, H2, vsmul16)
+RVVCALL(OPIVV2_RM, vsmul_vv_w, OP_SSS_W, H4, H4, H4, vsmul32)
+RVVCALL(OPIVV2_RM, vsmul_vv_d, OP_SSS_D, H8, H8, H8, vsmul64)
+GEN_VEXT_VV_RM(vsmul_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vsmul_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vsmul_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vsmul_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vsmul_vx_b, OP_SSS_B, H1, H1, vsmul8)
+RVVCALL(OPIVX2_RM, vsmul_vx_h, OP_SSS_H, H2, H2, vsmul16)
+RVVCALL(OPIVX2_RM, vsmul_vx_w, OP_SSS_W, H4, H4, vsmul32)
+RVVCALL(OPIVX2_RM, vsmul_vx_d, OP_SSS_D, H8, H8, vsmul64)
+GEN_VEXT_VX_RM(vsmul_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vsmul_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vsmul_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vsmul_vx_d, 8, 8, clearq)
-- 
2.23.0


