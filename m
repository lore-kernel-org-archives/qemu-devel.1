Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73019C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4892420663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4892420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCPt8-0003ps-Hb
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCPsB-0003Hf-PM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCPsA-0002yj-9R
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:35:47 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCPs7-0002vE-RJ; Thu, 12 Mar 2020 11:35:46 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08664197|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.0397164-0.000385609-0.959898;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03309; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-OQ5D9_1584027330; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-OQ5D9_1584027330)
 by smtp.aliyun-inc.com(10.147.41.231);
 Thu, 12 Mar 2020 23:35:30 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 18/60] target/riscv: vector integer divide instructions
Date: Thu, 12 Mar 2020 22:58:18 +0800
Message-Id: <20200312145900.2054-19-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   | 33 +++++++++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 10 ++++
 target/riscv/vector_helper.c            | 74 +++++++++++++++++++++++++
 4 files changed, 125 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f42a12eef3..357f149198 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -558,3 +558,36 @@ DEF_HELPER_6(vmulhsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmulhsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmulhsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmulhsu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vdivu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index a8ac4e9e9d..2afe24dd34 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -370,6 +370,14 @@ vmulhu_vv       100100 . ..... ..... 010 ..... 1010111 @r_vm
 vmulhu_vx       100100 . ..... ..... 110 ..... 1010111 @r_vm
 vmulhsu_vv      100110 . ..... ..... 010 ..... 1010111 @r_vm
 vmulhsu_vx      100110 . ..... ..... 110 ..... 1010111 @r_vm
+vdivu_vv        100000 . ..... ..... 010 ..... 1010111 @r_vm
+vdivu_vx        100000 . ..... ..... 110 ..... 1010111 @r_vm
+vdiv_vv         100001 . ..... ..... 010 ..... 1010111 @r_vm
+vdiv_vx         100001 . ..... ..... 110 ..... 1010111 @r_vm
+vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
+vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
+vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
+vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index a1ecc9f52d..9f0645a92b 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1444,3 +1444,13 @@ GEN_OPIVX_GVEC_TRANS(vmul_vx,  muls)
 GEN_OPIVX_TRANS(vmulh_vx, opivx_check)
 GEN_OPIVX_TRANS(vmulhu_vx, opivx_check)
 GEN_OPIVX_TRANS(vmulhsu_vx, opivx_check)
+
+/* Vector Integer Divide Instructions */
+GEN_OPIVV_TRANS(vdivu_vv, opivv_check)
+GEN_OPIVV_TRANS(vdiv_vv, opivv_check)
+GEN_OPIVV_TRANS(vremu_vv, opivv_check)
+GEN_OPIVV_TRANS(vrem_vv, opivv_check)
+GEN_OPIVX_TRANS(vdivu_vx, opivx_check)
+GEN_OPIVX_TRANS(vdiv_vx, opivx_check)
+GEN_OPIVX_TRANS(vremu_vx, opivx_check)
+GEN_OPIVX_TRANS(vrem_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 93daafd5bd..6330f5882f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1697,3 +1697,77 @@ GEN_VEXT_VX(vmulhsu_vx_b, 1, 1, clearb)
 GEN_VEXT_VX(vmulhsu_vx_h, 2, 2, clearh)
 GEN_VEXT_VX(vmulhsu_vx_w, 4, 4, clearl)
 GEN_VEXT_VX(vmulhsu_vx_d, 8, 8, clearq)
+
+/* Vector Integer Divide Instructions */
+#define DO_DIVU(N, M) (unlikely(M == 0) ? (__typeof(N))(-1) : N / M)
+#define DO_REMU(N, M) (unlikely(M == 0) ? N : N % M)
+#define DO_DIV(N, M)  (unlikely(M == 0) ? (__typeof(N))(-1) :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
+#define DO_REM(N, M)  (unlikely(M == 0) ? N :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
+
+RVVCALL(OPIVV2, vdivu_vv_b, OP_UUU_B, H1, H1, H1, DO_DIVU)
+RVVCALL(OPIVV2, vdivu_vv_h, OP_UUU_H, H2, H2, H2, DO_DIVU)
+RVVCALL(OPIVV2, vdivu_vv_w, OP_UUU_W, H4, H4, H4, DO_DIVU)
+RVVCALL(OPIVV2, vdivu_vv_d, OP_UUU_D, H8, H8, H8, DO_DIVU)
+RVVCALL(OPIVV2, vdiv_vv_b, OP_SSS_B, H1, H1, H1, DO_DIV)
+RVVCALL(OPIVV2, vdiv_vv_h, OP_SSS_H, H2, H2, H2, DO_DIV)
+RVVCALL(OPIVV2, vdiv_vv_w, OP_SSS_W, H4, H4, H4, DO_DIV)
+RVVCALL(OPIVV2, vdiv_vv_d, OP_SSS_D, H8, H8, H8, DO_DIV)
+RVVCALL(OPIVV2, vremu_vv_b, OP_UUU_B, H1, H1, H1, DO_REMU)
+RVVCALL(OPIVV2, vremu_vv_h, OP_UUU_H, H2, H2, H2, DO_REMU)
+RVVCALL(OPIVV2, vremu_vv_w, OP_UUU_W, H4, H4, H4, DO_REMU)
+RVVCALL(OPIVV2, vremu_vv_d, OP_UUU_D, H8, H8, H8, DO_REMU)
+RVVCALL(OPIVV2, vrem_vv_b, OP_SSS_B, H1, H1, H1, DO_REM)
+RVVCALL(OPIVV2, vrem_vv_h, OP_SSS_H, H2, H2, H2, DO_REM)
+RVVCALL(OPIVV2, vrem_vv_w, OP_SSS_W, H4, H4, H4, DO_REM)
+RVVCALL(OPIVV2, vrem_vv_d, OP_SSS_D, H8, H8, H8, DO_REM)
+GEN_VEXT_VV(vdivu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vdivu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vdivu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vdivu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vdiv_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vdiv_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vdiv_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vdiv_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vremu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vremu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vremu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vremu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vrem_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vrem_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vrem_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vrem_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2, vdivu_vx_b, OP_UUU_B, H1, H1, DO_DIVU)
+RVVCALL(OPIVX2, vdivu_vx_h, OP_UUU_H, H2, H2, DO_DIVU)
+RVVCALL(OPIVX2, vdivu_vx_w, OP_UUU_W, H4, H4, DO_DIVU)
+RVVCALL(OPIVX2, vdivu_vx_d, OP_UUU_D, H8, H8, DO_DIVU)
+RVVCALL(OPIVX2, vdiv_vx_b, OP_SSS_B, H1, H1, DO_DIV)
+RVVCALL(OPIVX2, vdiv_vx_h, OP_SSS_H, H2, H2, DO_DIV)
+RVVCALL(OPIVX2, vdiv_vx_w, OP_SSS_W, H4, H4, DO_DIV)
+RVVCALL(OPIVX2, vdiv_vx_d, OP_SSS_D, H8, H8, DO_DIV)
+RVVCALL(OPIVX2, vremu_vx_b, OP_UUU_B, H1, H1, DO_REMU)
+RVVCALL(OPIVX2, vremu_vx_h, OP_UUU_H, H2, H2, DO_REMU)
+RVVCALL(OPIVX2, vremu_vx_w, OP_UUU_W, H4, H4, DO_REMU)
+RVVCALL(OPIVX2, vremu_vx_d, OP_UUU_D, H8, H8, DO_REMU)
+RVVCALL(OPIVX2, vrem_vx_b, OP_SSS_B, H1, H1, DO_REM)
+RVVCALL(OPIVX2, vrem_vx_h, OP_SSS_H, H2, H2, DO_REM)
+RVVCALL(OPIVX2, vrem_vx_w, OP_SSS_W, H4, H4, DO_REM)
+RVVCALL(OPIVX2, vrem_vx_d, OP_SSS_D, H8, H8, DO_REM)
+GEN_VEXT_VX(vdivu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vdivu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vdivu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vdivu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vdiv_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vdiv_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vdiv_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vdiv_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vremu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vremu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vremu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vremu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vrem_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vrem_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vrem_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vrem_vx_d, 8, 8, clearq)
-- 
2.23.0


