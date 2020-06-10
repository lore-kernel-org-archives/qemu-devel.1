Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B74C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC2020734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC2020734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizqp-0004ZF-Qn
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jiziV-0004Mc-0Q; Wed, 10 Jun 2020 08:20:27 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jiziS-0007to-K7; Wed, 10 Jun 2020 08:20:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1304254|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.466062-0.0104836-0.523454;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16378; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=8; SR=0; TI=SMTPD_---.HkaBj23_1591791615; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HkaBj23_1591791615)
 by smtp.aliyun-inc.com(10.147.41.143);
 Wed, 10 Jun 2020 20:20:15 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v9 21/61] target/riscv: vector single-width integer
 multiply-add instructions
Date: Wed, 10 Jun 2020 19:37:08 +0800
Message-Id: <20200610113748.4754-22-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200610113748.4754-1-zhiwei_liu@c-sky.com>
References: <20200610113748.4754-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 07:37:52
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
 target/riscv/helper.h                   | 33 ++++++++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 10 +++
 target/riscv/vector_helper.c            | 88 +++++++++++++++++++++++++
 4 files changed, 139 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e5c3a66903..08c2544b20 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -614,3 +614,36 @@ DEF_HELPER_6(vwmulu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
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
index ae7cfa3e28..b49b60aea1 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -385,6 +385,14 @@ vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
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
index fbdd1b43d6..dc122eb2e5 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1599,3 +1599,13 @@ GEN_OPIVV_WIDEN_TRANS(vwmulsu_vv, opivv_widen_check)
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
index 116cc9f092..e787e00b01 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1891,3 +1891,91 @@ GEN_VEXT_VX(vwmulu_vx_w, 4, 8, clearq)
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
+#define OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
+static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
+{                                                                   \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
+    TD d = *((TD *)vd + HD(i));                                     \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, d);                   \
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


