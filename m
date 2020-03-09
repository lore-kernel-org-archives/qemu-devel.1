Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8FBC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C4B20674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C4B20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBDjy-0006hI-9y
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDg4-0006uL-AU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDg2-0007ka-EP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:20 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37921)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBDg1-0007Qv-Oy; Mon, 09 Mar 2020 04:22:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1422099|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.466062-0.0104836-0.523454;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03312; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.GyTxIXp_1583742101; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GyTxIXp_1583742101)
 by smtp.aliyun-inc.com(10.147.41.137);
 Mon, 09 Mar 2020 16:21:52 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 20/60] target/riscv: vector single-width integer
 multiply-add instructions
Date: Mon,  9 Mar 2020 16:20:02 +0800
Message-Id: <20200309082042.12967-21-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   | 33 ++++++++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 10 +++
 target/riscv/vector_helper.c            | 88 +++++++++++++++++++++++++
 4 files changed, 139 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1704b8c512..098288df76 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -610,3 +610,36 @@ DEF_HELPER_6(vwmulu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmulsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmulsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmulsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index ceddfe4b6c..58de888afa 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -384,6 +384,14 @@ vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
 vwmulsu_vx      111010 . ..... ..... 110 ..... 1010111 @r_vm
 vwmul_vv        111011 . ..... ..... 010 ..... 1010111 @r_vm
 vwmul_vx        111011 . ..... ..... 110 ..... 1010111 @r_vm
+vmacc_vv        101101 . ..... ..... 010 ..... 1010111 @r_vm
+vmacc_vx        101101 . ..... ..... 110 ..... 1010111 @r_vm
+vnmsac_vv       101111 . ..... ..... 010 ..... 1010111 @r_vm
+vnmsac_vx       101111 . ..... ..... 110 ..... 1010111 @r_vm
+vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
+vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
+vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
+vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 990433f866..05f7ae0bc4 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1462,3 +1462,13 @@ GEN_OPIVV_WIDEN_TRANS(vwmulsu_vv, opivv_widen_check)
 GEN_OPIVX_WIDEN_TRANS(vwmul_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmulu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmulsu_vx)
+
+/* Vector Single-Width Integer Multiply-Add Instructions */
+GEN_OPIVV_TRANS(vmacc_vv, opivv_check)
+GEN_OPIVV_TRANS(vnmsac_vv, opivv_check)
+GEN_OPIVV_TRANS(vmadd_vv, opivv_check)
+GEN_OPIVV_TRANS(vnmsub_vv, opivv_check)
+GEN_OPIVX_TRANS(vmacc_vx, opivx_check)
+GEN_OPIVX_TRANS(vnmsac_vx, opivx_check)
+GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
+GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index beb84f9674..e5082c8adc 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1822,3 +1822,91 @@ GEN_VEXT_VX(vwmulu_vx_w, 4, 8, clearq)
 GEN_VEXT_VX(vwmulsu_vx_b, 1, 2, clearh)
 GEN_VEXT_VX(vwmulsu_vx_h, 2, 4, clearl)
 GEN_VEXT_VX(vwmulsu_vx_w, 4, 8, clearq)
+
+/* Vector Single-Width Integer Multiply-Add Instructions */
+#define OPIVV3(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)       \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(s2, s1, d);                           \
+}
+
+#define DO_MACC(N, M, D) (M * N + D)
+#define DO_NMSAC(N, M, D) (-(M * N) + D)
+#define DO_MADD(N, M, D) (M * D + N)
+#define DO_NMSUB(N, M, D) (-(M * D) + N)
+RVVCALL(OPIVV3, vmacc_vv_b, OP_SSS_B, H1, H1, H1, DO_MACC)
+RVVCALL(OPIVV3, vmacc_vv_h, OP_SSS_H, H2, H2, H2, DO_MACC)
+RVVCALL(OPIVV3, vmacc_vv_w, OP_SSS_W, H4, H4, H4, DO_MACC)
+RVVCALL(OPIVV3, vmacc_vv_d, OP_SSS_D, H8, H8, H8, DO_MACC)
+RVVCALL(OPIVV3, vnmsac_vv_b, OP_SSS_B, H1, H1, H1, DO_NMSAC)
+RVVCALL(OPIVV3, vnmsac_vv_h, OP_SSS_H, H2, H2, H2, DO_NMSAC)
+RVVCALL(OPIVV3, vnmsac_vv_w, OP_SSS_W, H4, H4, H4, DO_NMSAC)
+RVVCALL(OPIVV3, vnmsac_vv_d, OP_SSS_D, H8, H8, H8, DO_NMSAC)
+RVVCALL(OPIVV3, vmadd_vv_b, OP_SSS_B, H1, H1, H1, DO_MADD)
+RVVCALL(OPIVV3, vmadd_vv_h, OP_SSS_H, H2, H2, H2, DO_MADD)
+RVVCALL(OPIVV3, vmadd_vv_w, OP_SSS_W, H4, H4, H4, DO_MADD)
+RVVCALL(OPIVV3, vmadd_vv_d, OP_SSS_D, H8, H8, H8, DO_MADD)
+RVVCALL(OPIVV3, vnmsub_vv_b, OP_SSS_B, H1, H1, H1, DO_NMSUB)
+RVVCALL(OPIVV3, vnmsub_vv_h, OP_SSS_H, H2, H2, H2, DO_NMSUB)
+RVVCALL(OPIVV3, vnmsub_vv_w, OP_SSS_W, H4, H4, H4, DO_NMSUB)
+RVVCALL(OPIVV3, vnmsub_vv_d, OP_SSS_D, H8, H8, H8, DO_NMSUB)
+GEN_VEXT_VV(vmacc_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmacc_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmacc_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmacc_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vnmsac_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vnmsac_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vnmsac_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vnmsac_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmadd_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmadd_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vnmsub_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vnmsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vnmsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vnmsub_vv_d, 8, 8, clearq)
+
+#define OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)         \
+static void do_##NAME(void *vd, target_ulong s1, void *vs2, int i)  \
+{                                                                   \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
+    TD d = *((TD *)vd + HD(i));                                     \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)(target_long)s1, d);      \
+}
+
+RVVCALL(OPIVX3, vmacc_vx_b, OP_SSS_B, H1, H1, DO_MACC)
+RVVCALL(OPIVX3, vmacc_vx_h, OP_SSS_H, H2, H2, DO_MACC)
+RVVCALL(OPIVX3, vmacc_vx_w, OP_SSS_W, H4, H4, DO_MACC)
+RVVCALL(OPIVX3, vmacc_vx_d, OP_SSS_D, H8, H8, DO_MACC)
+RVVCALL(OPIVX3, vnmsac_vx_b, OP_SSS_B, H1, H1, DO_NMSAC)
+RVVCALL(OPIVX3, vnmsac_vx_h, OP_SSS_H, H2, H2, DO_NMSAC)
+RVVCALL(OPIVX3, vnmsac_vx_w, OP_SSS_W, H4, H4, DO_NMSAC)
+RVVCALL(OPIVX3, vnmsac_vx_d, OP_SSS_D, H8, H8, DO_NMSAC)
+RVVCALL(OPIVX3, vmadd_vx_b, OP_SSS_B, H1, H1, DO_MADD)
+RVVCALL(OPIVX3, vmadd_vx_h, OP_SSS_H, H2, H2, DO_MADD)
+RVVCALL(OPIVX3, vmadd_vx_w, OP_SSS_W, H4, H4, DO_MADD)
+RVVCALL(OPIVX3, vmadd_vx_d, OP_SSS_D, H8, H8, DO_MADD)
+RVVCALL(OPIVX3, vnmsub_vx_b, OP_SSS_B, H1, H1, DO_NMSUB)
+RVVCALL(OPIVX3, vnmsub_vx_h, OP_SSS_H, H2, H2, DO_NMSUB)
+RVVCALL(OPIVX3, vnmsub_vx_w, OP_SSS_W, H4, H4, DO_NMSUB)
+RVVCALL(OPIVX3, vnmsub_vx_d, OP_SSS_D, H8, H8, DO_NMSUB)
+GEN_VEXT_VX(vmacc_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmacc_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmacc_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmacc_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vnmsac_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vnmsac_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vnmsac_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vnmsac_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmadd_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmadd_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmadd_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmadd_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vnmsub_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vnmsub_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vnmsub_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vnmsub_vx_d, 8, 8, clearq)
-- 
2.23.0


