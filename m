Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE21C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D42206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D42206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQC1-0004b8-UL
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQ5l-0006vM-FX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQ5k-00060I-6m
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:49:49 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCQ5j-0005rd-Ky; Thu, 12 Mar 2020 11:49:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07535314|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.377237-0.00028666-0.622476;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-OxxVH_1584028177; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-OxxVH_1584028177)
 by smtp.aliyun-inc.com(10.147.41.178);
 Thu, 12 Mar 2020 23:49:38 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 25/60] target/riscv: vector single-width fractional
 multiply with rounding and saturation
Date: Thu, 12 Mar 2020 22:58:25 +0800
Message-Id: <20200312145900.2054-26-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |   9 +++
 target/riscv/insn32.decode              |   2 +
 target/riscv/insn_trans/trans_rvv.inc.c |   4 +
 target/riscv/vector_helper.c            | 103 ++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d3837d2ca4..333eccca57 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -724,3 +724,12 @@ DEF_HELPER_6(vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
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
index 0227a16b16..99f70924d6 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -417,6 +417,8 @@ vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
 vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
 vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
 vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
+vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
+vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 9988fad2fe..60e1e63b7b 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1528,3 +1528,7 @@ GEN_OPIVV_TRANS(vasub_vv, opivv_check)
 GEN_OPIVX_TRANS(vaadd_vx,  opivx_check)
 GEN_OPIVX_TRANS(vasub_vx,  opivx_check)
 GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
+
+/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
+GEN_OPIVV_TRANS(vsmul_vv, opivv_check)
+GEN_OPIVX_TRANS(vsmul_vx,  opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b0a7a3b6e4..74ad07743c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2420,3 +2420,106 @@ GEN_VEXT_VX_ENV(vasub_vx_b, 1, 1, clearb)
 GEN_VEXT_VX_ENV(vasub_vx_h, 2, 2, clearh)
 GEN_VEXT_VX_ENV(vasub_vx_w, 4, 4, clearl)
 GEN_VEXT_VX_ENV(vasub_vx_d, 8, 8, clearq)
+
+/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
+static inline int8_t vsmul8(CPURISCVState *env, int8_t a, int8_t b)
+{
+    uint8_t round;
+    int16_t res;
+
+    res = (int16_t)a * (int16_t)b;
+    round = get_round(env, res, 7);
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
+static int16_t vsmul16(CPURISCVState *env, int16_t a, int16_t b)
+{
+    uint8_t round;
+    int32_t res;
+
+    res = (int32_t)a * (int32_t)b;
+    round = get_round(env, res, 15);
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
+static int32_t vsmul32(CPURISCVState *env, int32_t a, int32_t b)
+{
+    uint8_t round;
+    int64_t res;
+
+    res = (int64_t)a * (int64_t)b;
+    round = get_round(env, res, 31);
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
+static int64_t vsmul64(CPURISCVState *env, int64_t a, int64_t b)
+{
+    uint8_t round;
+    uint64_t hi_64, lo_64, Hi62;
+    uint8_t hi62, hi63, lo63;
+
+    muls64(&lo_64, &hi_64, a, b);
+    hi62 = extract64(hi_64, 62, 1);
+    lo63 = extract64(lo_64, 63, 1);
+    hi63 = extract64(hi_64, 63, 1);
+    Hi62 = extract64(hi_64, 0, 62);
+    if (hi62 != hi63) {
+        env->vxsat = 0x1;
+        return INT64_MAX;
+    }
+    round = get_round(env, lo_64, 63);
+    if (round && (Hi62 == 0x3fffffff) && lo63) {
+        env->vxsat = 0x1;
+        return hi62 ? INT64_MIN : INT64_MAX;
+    } else {
+        if (lo63 && round) {
+            return (hi_64 + 1) << 1;
+        } else {
+            return (hi_64 << 1) | lo63 | round;
+        }
+    }
+}
+RVVCALL(OPIVV2_ENV, vsmul_vv_b, OP_SSS_B, H1, H1, H1, vsmul8)
+RVVCALL(OPIVV2_ENV, vsmul_vv_h, OP_SSS_H, H2, H2, H2, vsmul16)
+RVVCALL(OPIVV2_ENV, vsmul_vv_w, OP_SSS_W, H4, H4, H4, vsmul32)
+RVVCALL(OPIVV2_ENV, vsmul_vv_d, OP_SSS_D, H8, H8, H8, vsmul64)
+GEN_VEXT_VV_ENV(vsmul_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_ENV(vsmul_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vsmul_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vsmul_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_ENV, vsmul_vx_b, OP_SSS_B, H1, H1, vsmul8)
+RVVCALL(OPIVX2_ENV, vsmul_vx_h, OP_SSS_H, H2, H2, vsmul16)
+RVVCALL(OPIVX2_ENV, vsmul_vx_w, OP_SSS_W, H4, H4, vsmul32)
+RVVCALL(OPIVX2_ENV, vsmul_vx_d, OP_SSS_D, H8, H8, vsmul64)
+GEN_VEXT_VX_ENV(vsmul_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_ENV(vsmul_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_ENV(vsmul_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_ENV(vsmul_vx_d, 8, 8, clearq)
-- 
2.23.0


