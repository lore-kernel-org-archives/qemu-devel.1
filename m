Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B24C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C18208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C18208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBto9-0004ja-4M
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 01:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBtd9-0006ss-VO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBtd8-0003CO-8K
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:10:07 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBtd6-000313-Jc; Wed, 11 Mar 2020 01:10:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08930521|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.727025-0.000620295-0.272354;
 FP=2802339062483756118|1|1|1|0|-1|-1|-1; HT=e02c03302; MF=zhiwei_liu@c-sky.com;
 NM=1; PH=DS; RN=10; RT=10; SR=0; TI=SMTPD_---.GzWV6Tg_1583903398; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GzWV6Tg_1583903398)
 by smtp.aliyun-inc.com(10.147.44.145);
 Wed, 11 Mar 2020 13:09:59 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v4 21/60] target/riscv: vector widening integer multiply-add
 instructions
Date: Wed, 11 Mar 2020 13:06:40 +0800
Message-Id: <20200311050719.15141-22-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   | 22 ++++++++++++
 target/riscv/insn32.decode              |  7 ++++
 target/riscv/insn_trans/trans_rvv.inc.c |  9 +++++
 target/riscv/vector_helper.c            | 45 +++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 098288df76..1f0d3d60e3 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -643,3 +643,25 @@ DEF_HELPER_6(vnmsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnmsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnmsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnmsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vwmaccu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 58de888afa..2a5b945139 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -392,6 +392,13 @@ vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
 vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
 vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
 vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
+vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
+vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 05f7ae0bc4..958737d097 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1472,3 +1472,12 @@ GEN_OPIVX_TRANS(vmacc_vx, opivx_check)
 GEN_OPIVX_TRANS(vnmsac_vx, opivx_check)
 GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
 GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
+
+/* Vector Widening Integer Multiply-Add Instructions */
+GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmacc_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e5082c8adc..5109654f9f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1910,3 +1910,48 @@ GEN_VEXT_VX(vnmsub_vx_b, 1, 1, clearb)
 GEN_VEXT_VX(vnmsub_vx_h, 2, 2, clearh)
 GEN_VEXT_VX(vnmsub_vx_w, 4, 4, clearl)
 GEN_VEXT_VX(vnmsub_vx_d, 8, 8, clearq)
+
+/* Vector Widening Integer Multiply-Add Instructions */
+RVVCALL(OPIVV3, vwmaccu_vv_b, WOP_UUU_B, H2, H1, H1, DO_MACC)
+RVVCALL(OPIVV3, vwmaccu_vv_h, WOP_UUU_H, H4, H2, H2, DO_MACC)
+RVVCALL(OPIVV3, vwmaccu_vv_w, WOP_UUU_W, H8, H4, H4, DO_MACC)
+RVVCALL(OPIVV3, vwmacc_vv_b, WOP_SSS_B, H2, H1, H1, DO_MACC)
+RVVCALL(OPIVV3, vwmacc_vv_h, WOP_SSS_H, H4, H2, H2, DO_MACC)
+RVVCALL(OPIVV3, vwmacc_vv_w, WOP_SSS_W, H8, H4, H4, DO_MACC)
+RVVCALL(OPIVV3, vwmaccsu_vv_b, WOP_SSU_B, H2, H1, H1, DO_MACC)
+RVVCALL(OPIVV3, vwmaccsu_vv_h, WOP_SSU_H, H4, H2, H2, DO_MACC)
+RVVCALL(OPIVV3, vwmaccsu_vv_w, WOP_SSU_W, H8, H4, H4, DO_MACC)
+GEN_VEXT_VV(vwmaccu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmaccu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmaccu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmacc_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmacc_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmacc_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmaccsu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmaccsu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmaccsu_vv_w, 4, 8, clearq)
+
+RVVCALL(OPIVX3, vwmaccu_vx_b, WOP_UUU_B, H2, H1, DO_MACC)
+RVVCALL(OPIVX3, vwmaccu_vx_h, WOP_UUU_H, H4, H2, DO_MACC)
+RVVCALL(OPIVX3, vwmaccu_vx_w, WOP_UUU_W, H8, H4, DO_MACC)
+RVVCALL(OPIVX3, vwmacc_vx_b, WOP_SSS_B, H2, H1, DO_MACC)
+RVVCALL(OPIVX3, vwmacc_vx_h, WOP_SSS_H, H4, H2, DO_MACC)
+RVVCALL(OPIVX3, vwmacc_vx_w, WOP_SSS_W, H8, H4, DO_MACC)
+RVVCALL(OPIVX3, vwmaccsu_vx_b, WOP_SSU_B, H2, H1, DO_MACC)
+RVVCALL(OPIVX3, vwmaccsu_vx_h, WOP_SSU_H, H4, H2, DO_MACC)
+RVVCALL(OPIVX3, vwmaccsu_vx_w, WOP_SSU_W, H8, H4, DO_MACC)
+RVVCALL(OPIVX3, vwmaccus_vx_b, WOP_SUS_B, H2, H1, DO_MACC)
+RVVCALL(OPIVX3, vwmaccus_vx_h, WOP_SUS_H, H4, H2, DO_MACC)
+RVVCALL(OPIVX3, vwmaccus_vx_w, WOP_SUS_W, H8, H4, DO_MACC)
+GEN_VEXT_VX(vwmaccu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmaccu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmaccu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmacc_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmacc_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmacc_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmaccsu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmaccsu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmaccsu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmaccus_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmaccus_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmaccus_vx_w, 4, 8, clearq)
-- 
2.23.0


