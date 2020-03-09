Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627C3C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D458205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D458205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHP5-0001w6-4H
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBHJy-0002Kh-0i
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBHJu-00032v-1z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:15:45 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBHJt-0002c0-Bp; Mon, 09 Mar 2020 08:15:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436288|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.196625-0.000248577-0.803126;
 FP=1028362889771717734|1|1|7|0|-1|-1|-1; HT=e01l07447; MF=zhiwei_liu@c-sky.com;
 NM=1; PH=DS; RN=10; RT=10; SR=0; TI=SMTPD_---.GyaeXy8_1583756101; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GyaeXy8_1583756101)
 by smtp.aliyun-inc.com(10.147.41.199);
 Mon, 09 Mar 2020 20:15:16 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 28/60] target/riscv: vector narrowing fixed-point clip
 instructions
Date: Mon,  9 Mar 2020 20:14:25 +0800
Message-Id: <20200309121457.13719-29-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200309121457.13719-1-zhiwei_liu@c-sky.com>
References: <20200309121457.13719-1-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  13 +++
 target/riscv/insn32.decode              |   6 ++
 target/riscv/insn_trans/trans_rvv.inc.c |   8 ++
 target/riscv/vector_helper.c            | 128 ++++++++++++++++++++++++
 4 files changed, 155 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index efc84fbd79..4cad8679ec 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -772,3 +772,16 @@ DEF_HELPER_6(vssra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vnclip_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclip_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclip_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclipu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclipu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclipu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclipu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclipu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclipu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclip_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclip_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclip_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index d6d111e04a..c7d589566f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -432,6 +432,12 @@ vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
 vssra_vv        101011 . ..... ..... 000 ..... 1010111 @r_vm
 vssra_vx        101011 . ..... ..... 100 ..... 1010111 @r_vm
 vssra_vi        101011 . ..... ..... 011 ..... 1010111 @r_vm
+vnclipu_vv      101110 . ..... ..... 000 ..... 1010111 @r_vm
+vnclipu_vx      101110 . ..... ..... 100 ..... 1010111 @r_vm
+vnclipu_vi      101110 . ..... ..... 011 ..... 1010111 @r_vm
+vnclip_vv       101111 . ..... ..... 000 ..... 1010111 @r_vm
+vnclip_vx       101111 . ..... ..... 100 ..... 1010111 @r_vm
+vnclip_vi       101111 . ..... ..... 011 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 21f896ea26..11b4887275 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1549,3 +1549,11 @@ GEN_OPIVX_TRANS(vssrl_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssra_vx,  opivx_check)
 GEN_OPIVI_TRANS(vssrl_vi, 1, vssrl_vx, opivx_check)
 GEN_OPIVI_TRANS(vssra_vi, 0, vssra_vx, opivx_check)
+
+/* Vector Narrowing Fixed-Point Clip Instructions */
+GEN_OPIVV_NARROW_TRANS(vnclipu_vv)
+GEN_OPIVV_NARROW_TRANS(vnclip_vv)
+GEN_OPIVX_NARROW_TRANS(vnclipu_vx)
+GEN_OPIVX_NARROW_TRANS(vnclip_vx)
+GEN_OPIVI_NARROW_TRANS(vnclipu_vi, 1, vnclipu_vx)
+GEN_OPIVI_NARROW_TRANS(vnclip_vi, 1, vnclip_vx)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ec0f822fcf..7f61d4c0c4 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -869,6 +869,12 @@ GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
 #define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
 #define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
 #define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
+#define NOP_SSS_B int8_t, int8_t, int16_t, int8_t, int16_t
+#define NOP_SSS_H int16_t, int16_t, int32_t, int16_t, int32_t
+#define NOP_SSS_W int32_t, int32_t, int64_t, int32_t, int64_t
+#define NOP_UUU_B uint8_t, uint8_t, uint16_t, uint8_t, uint16_t
+#define NOP_UUU_H uint16_t, uint16_t, uint32_t, uint16_t, uint32_t
+#define NOP_UUU_W uint32_t, uint32_t, uint64_t, uint32_t, uint64_t
 
 /* operation of two vector elements */
 #define OPIVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)    \
@@ -2812,3 +2818,125 @@ GEN_VEXT_VX_ENV(vssra_vx_b, 1, 1, clearb)
 GEN_VEXT_VX_ENV(vssra_vx_h, 2, 2, clearh)
 GEN_VEXT_VX_ENV(vssra_vx_w, 4, 4, clearl)
 GEN_VEXT_VX_ENV(vssra_vx_d, 8, 8, clearq)
+
+/* Vector Narrowing Fixed-Point Clip Instructions */
+static int8_t vnclip8(CPURISCVState *env, int16_t a, int8_t b)
+{
+    uint8_t round, shift = b & 0xf;
+    int16_t res;
+
+    round = get_round(env, a, shift);
+    res   = (a >> shift)  + round;
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
+static int16_t vnclip16(CPURISCVState *env, int32_t a, int16_t b)
+{
+    uint8_t round, shift = b & 0x1f;
+    int32_t res;
+
+    round = get_round(env, a, shift);
+    res   = (a >> shift)  + round;
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
+static int32_t vnclip32(CPURISCVState *env, int64_t a, int32_t b)
+{
+    uint8_t round, shift = b & 0x3f;
+    int64_t res;
+
+    round = get_round(env, a, shift);
+    res   = (a >> shift)  + round;
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
+RVVCALL(OPIVV2_ENV, vnclip_vv_b, NOP_SSS_B, H1, H2, H1, vnclip8)
+RVVCALL(OPIVV2_ENV, vnclip_vv_h, NOP_SSS_H, H2, H4, H2, vnclip16)
+RVVCALL(OPIVV2_ENV, vnclip_vv_w, NOP_SSS_W, H4, H8, H4, vnclip32)
+GEN_VEXT_VV_ENV(vnclip_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_ENV(vnclip_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vnclip_vv_w, 4, 4, clearl)
+
+RVVCALL(OPIVX2_ENV, vnclip_vx_b, NOP_SSS_B, H1, H2, vnclip8)
+RVVCALL(OPIVX2_ENV, vnclip_vx_h, NOP_SSS_H, H2, H4, vnclip16)
+RVVCALL(OPIVX2_ENV, vnclip_vx_w, NOP_SSS_W, H4, H8, vnclip32)
+GEN_VEXT_VX_ENV(vnclip_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_ENV(vnclip_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_ENV(vnclip_vx_w, 4, 4, clearl)
+
+static uint8_t vnclipu8(CPURISCVState *env, uint16_t a, uint8_t b)
+{
+    uint8_t round, shift = b & 0xf;
+    uint16_t res;
+
+    round = get_round(env, a, shift);
+    res   = (a >> shift)  + round;
+    if (res > UINT8_MAX) {
+        env->vxsat = 0x1;
+        return UINT8_MAX;
+    } else {
+        return res;
+    }
+}
+static uint16_t vnclipu16(CPURISCVState *env, uint32_t a, uint16_t b)
+{
+    uint8_t round, shift = b & 0x1f;
+    uint32_t res;
+
+    round = get_round(env, a, shift);
+    res   = (a >> shift)  + round;
+    if (res > UINT16_MAX) {
+        env->vxsat = 0x1;
+        return UINT16_MAX;
+    } else {
+        return res;
+    }
+}
+static uint32_t vnclipu32(CPURISCVState *env, uint64_t a, uint32_t b)
+{
+    uint8_t round, shift = b & 0x3f;
+    int64_t res;
+
+    round = get_round(env, a, shift);
+    res   = (a >> shift)  + round;
+    if (res > UINT32_MAX) {
+        env->vxsat = 0x1;
+        return UINT32_MAX;
+    } else {
+        return res;
+    }
+}
+RVVCALL(OPIVV2_ENV, vnclipu_vv_b, NOP_UUU_B, H1, H2, H1, vnclipu8)
+RVVCALL(OPIVV2_ENV, vnclipu_vv_h, NOP_UUU_H, H2, H4, H2, vnclipu16)
+RVVCALL(OPIVV2_ENV, vnclipu_vv_w, NOP_UUU_W, H4, H8, H4, vnclipu32)
+GEN_VEXT_VV_ENV(vnclipu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_ENV(vnclipu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vnclipu_vv_w, 4, 4, clearl)
+
+RVVCALL(OPIVX2_ENV, vnclipu_vx_b, NOP_UUU_B, H1, H2, vnclipu8)
+RVVCALL(OPIVX2_ENV, vnclipu_vx_h, NOP_UUU_H, H2, H4, vnclipu16)
+RVVCALL(OPIVX2_ENV, vnclipu_vx_w, NOP_UUU_W, H4, H8, vnclipu32)
+GEN_VEXT_VX_ENV(vnclipu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_ENV(vnclipu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_ENV(vnclipu_vx_w, 4, 4, clearl)
-- 
2.23.0


