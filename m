Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A085C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364AA20781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364AA20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfZT-0003be-H2
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqfVW-0005NW-PE; Wed, 01 Jul 2020 12:22:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqfVS-00005s-8g; Wed, 01 Jul 2020 12:22:46 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.074365|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.124647-0.000653911-0.874699;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16378; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=8; SR=0; TI=SMTPD_---.HvvysNR_1593620550; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HvvysNR_1593620550)
 by smtp.aliyun-inc.com(10.147.42.253);
 Thu, 02 Jul 2020 00:22:31 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v12 28/61] target/riscv: vector single-width scaling shift
 instructions
Date: Wed,  1 Jul 2020 23:25:16 +0800
Message-Id: <20200701152549.1218-29-zhiwei_liu@c-sky.com>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  17 ++++
 target/riscv/insn32.decode              |   6 ++
 target/riscv/insn_trans/trans_rvv.inc.c |   8 ++
 target/riscv/vector_helper.c            | 117 ++++++++++++++++++++++++
 4 files changed, 148 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f123302b82..78438f1ad6 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -773,3 +773,20 @@ DEF_HELPER_6(vwsmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwsmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwsmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwsmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vssrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssrl_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssra_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vssrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssrl_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vssra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 8cc2bf4864..7d5dfeb5c7 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -433,6 +433,12 @@ vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
 vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
 vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
 vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
+vssrl_vv        101010 . ..... ..... 000 ..... 1010111 @r_vm
+vssrl_vx        101010 . ..... ..... 100 ..... 1010111 @r_vm
+vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
+vssra_vv        101011 . ..... ..... 000 ..... 1010111 @r_vm
+vssra_vx        101011 . ..... ..... 100 ..... 1010111 @r_vm
+vssra_vi        101011 . ..... ..... 011 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 5e36ee8de5..31be40f4ba 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1767,3 +1767,11 @@ GEN_OPIVX_WIDEN_TRANS(vwsmaccu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwsmacc_vx)
 GEN_OPIVX_WIDEN_TRANS(vwsmaccsu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwsmaccus_vx)
+
+/* Vector Single-Width Scaling Shift Instructions */
+GEN_OPIVV_TRANS(vssrl_vv, opivv_check)
+GEN_OPIVV_TRANS(vssra_vv, opivv_check)
+GEN_OPIVX_TRANS(vssrl_vx,  opivx_check)
+GEN_OPIVX_TRANS(vssra_vx,  opivx_check)
+GEN_OPIVI_TRANS(vssrl_vi, 1, vssrl_vx, opivx_check)
+GEN_OPIVI_TRANS(vssra_vi, 0, vssra_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d818c32d97..acd44599ba 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2909,3 +2909,120 @@ RVVCALL(OPIVX3_RM, vwsmaccus_vx_w, WOP_SUS_W, H8, H4, vwsmaccus32)
 GEN_VEXT_VX_RM(vwsmaccus_vx_b, 1, 2, clearh)
 GEN_VEXT_VX_RM(vwsmaccus_vx_h, 2, 4, clearl)
 GEN_VEXT_VX_RM(vwsmaccus_vx_w, 4, 8, clearq)
+
+/* Vector Single-Width Scaling Shift Instructions */
+static inline uint8_t
+vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
+{
+    uint8_t round, shift = b & 0x7;
+    uint8_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline uint16_t
+vssrl16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b)
+{
+    uint8_t round, shift = b & 0xf;
+    uint16_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline uint32_t
+vssrl32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b)
+{
+    uint8_t round, shift = b & 0x1f;
+    uint32_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline uint64_t
+vssrl64(CPURISCVState *env, int vxrm, uint64_t a, uint64_t b)
+{
+    uint8_t round, shift = b & 0x3f;
+    uint64_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+RVVCALL(OPIVV2_RM, vssrl_vv_b, OP_UUU_B, H1, H1, H1, vssrl8)
+RVVCALL(OPIVV2_RM, vssrl_vv_h, OP_UUU_H, H2, H2, H2, vssrl16)
+RVVCALL(OPIVV2_RM, vssrl_vv_w, OP_UUU_W, H4, H4, H4, vssrl32)
+RVVCALL(OPIVV2_RM, vssrl_vv_d, OP_UUU_D, H8, H8, H8, vssrl64)
+GEN_VEXT_VV_RM(vssrl_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vssrl_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vssrl_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vssrl_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vssrl_vx_b, OP_UUU_B, H1, H1, vssrl8)
+RVVCALL(OPIVX2_RM, vssrl_vx_h, OP_UUU_H, H2, H2, vssrl16)
+RVVCALL(OPIVX2_RM, vssrl_vx_w, OP_UUU_W, H4, H4, vssrl32)
+RVVCALL(OPIVX2_RM, vssrl_vx_d, OP_UUU_D, H8, H8, vssrl64)
+GEN_VEXT_VX_RM(vssrl_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vssrl_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vssrl_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vssrl_vx_d, 8, 8, clearq)
+
+static inline int8_t
+vssra8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+{
+    uint8_t round, shift = b & 0x7;
+    int8_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline int16_t
+vssra16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
+{
+    uint8_t round, shift = b & 0xf;
+    int16_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline int32_t
+vssra32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    uint8_t round, shift = b & 0x1f;
+    int32_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+static inline int64_t
+vssra64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+{
+    uint8_t round, shift = b & 0x3f;
+    int64_t res;
+
+    round = get_round(vxrm, a, shift);
+    res   = (a >> shift)  + round;
+    return res;
+}
+RVVCALL(OPIVV2_RM, vssra_vv_b, OP_SSS_B, H1, H1, H1, vssra8)
+RVVCALL(OPIVV2_RM, vssra_vv_h, OP_SSS_H, H2, H2, H2, vssra16)
+RVVCALL(OPIVV2_RM, vssra_vv_w, OP_SSS_W, H4, H4, H4, vssra32)
+RVVCALL(OPIVV2_RM, vssra_vv_d, OP_SSS_D, H8, H8, H8, vssra64)
+GEN_VEXT_VV_RM(vssra_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vssra_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vssra_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vssra_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vssra_vx_b, OP_SSS_B, H1, H1, vssra8)
+RVVCALL(OPIVX2_RM, vssra_vx_h, OP_SSS_H, H2, H2, vssra16)
+RVVCALL(OPIVX2_RM, vssra_vx_w, OP_SSS_W, H4, H4, vssra32)
+RVVCALL(OPIVX2_RM, vssra_vx_d, OP_SSS_D, H8, H8, vssra64)
+GEN_VEXT_VX_RM(vssra_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vssra_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vssra_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vssra_vx_d, 8, 8, clearq)
-- 
2.23.0


