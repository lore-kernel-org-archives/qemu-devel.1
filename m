Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7D4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4A620B80
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4A620B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jovc5-0006UT-3N
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovbO-0005is-0c; Fri, 26 Jun 2020 17:09:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovbL-0005wL-5N; Fri, 26 Jun 2020 17:09:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00971263-0.00105046-0.989237;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03297; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.Ht2PVnK_1593205769; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Ht2PVnK_1593205769)
 by smtp.aliyun-inc.com(10.147.42.198);
 Sat, 27 Jun 2020 05:09:29 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 5/6] target/riscv: Flush not valid NaN-boxing input to
 canonical NaN
Date: Sat, 27 Jun 2020 04:59:16 +0800
Message-Id: <20200626205917.4545-6-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 16:59:26
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
 wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>, ianjiang.ict@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/insn_trans/trans_rvd.inc.c |   7 +-
 target/riscv/insn_trans/trans_rvf.inc.c | 272 ++++++++++++++++++++----
 2 files changed, 235 insertions(+), 44 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index c0f4a0c789..16947ea6da 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -241,10 +241,15 @@ static bool trans_fcvt_d_s(DisasContext *ctx, arg_fcvt_d_s *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    check_nanboxed(ctx, 1, t1);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fcvt_d_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+    gen_helper_fcvt_d_s(cpu_fpr[a->rd], cpu_env, t1);
 
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
     return true;
 }
 
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 04bc8e5cb5..b0379b9d1f 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -58,11 +58,23 @@ static bool trans_fmadd_s(DisasContext *ctx, arg_fmadd_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    TCGv_i64 t3 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
+    check_nanboxed(ctx, 3, t1, t2, t3);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
-                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    gen_helper_fmadd_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t3);
     return true;
 }
 
@@ -70,11 +82,23 @@ static bool trans_fmsub_s(DisasContext *ctx, arg_fmsub_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    TCGv_i64 t3 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
+    check_nanboxed(ctx, 3, t1, t2, t3);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
-                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    gen_helper_fmsub_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t3);
     return true;
 }
 
@@ -82,11 +106,23 @@ static bool trans_fnmsub_s(DisasContext *ctx, arg_fnmsub_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    TCGv_i64 t3 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
+    check_nanboxed(ctx, 3, t1, t2, t3);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fnmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
-                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    gen_helper_fnmsub_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t3);
     return true;
 }
 
@@ -94,11 +130,23 @@ static bool trans_fnmadd_s(DisasContext *ctx, arg_fnmadd_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    TCGv_i64 t3 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
+    check_nanboxed(ctx, 3, t1, t2, t3);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fnmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
-                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
-    mark_fs_dirty(ctx);
+    gen_helper_fnmadd_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
     gen_nanbox_fpr(ctx, a->rd);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t3);
     return true;
 }
 
@@ -107,11 +155,19 @@ static bool trans_fadd_s(DisasContext *ctx, arg_fadd_s *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fadd_s(cpu_fpr[a->rd], cpu_env,
-                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_helper_fadd_s(cpu_fpr[a->rd], cpu_env, t1, t2);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -120,11 +176,19 @@ static bool trans_fsub_s(DisasContext *ctx, arg_fsub_s *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fsub_s(cpu_fpr[a->rd], cpu_env,
-                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_helper_fsub_s(cpu_fpr[a->rd], cpu_env, t1, t2);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -133,11 +197,19 @@ static bool trans_fmul_s(DisasContext *ctx, arg_fmul_s *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fmul_s(cpu_fpr[a->rd], cpu_env,
-                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_helper_fmul_s(cpu_fpr[a->rd], cpu_env, t1, t2);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -146,11 +218,19 @@ static bool trans_fdiv_s(DisasContext *ctx, arg_fdiv_s *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fdiv_s(cpu_fpr[a->rd], cpu_env,
-                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_helper_fdiv_s(cpu_fpr[a->rd], cpu_env, t1, t2);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -159,10 +239,16 @@ static bool trans_fsqrt_s(DisasContext *ctx, arg_fsqrt_s *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    check_nanboxed(ctx, 1, t1);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fsqrt_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+    gen_helper_fsqrt_s(cpu_fpr[a->rd], cpu_env, t1);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
     return true;
 }
 
@@ -170,14 +256,23 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
     if (a->rs1 == a->rs2) { /* FMOV */
-        tcg_gen_mov_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
+        tcg_gen_mov_i64(cpu_fpr[a->rd], t1);
     } else { /* FSGNJ */
-        tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2], cpu_fpr[a->rs1],
-                            0, 31);
+        tcg_gen_deposit_i64(cpu_fpr[a->rd], t2, t1, 0, 31);
     }
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -185,16 +280,26 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
     if (a->rs1 == a->rs2) { /* FNEG */
-        tcg_gen_xori_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], INT32_MIN);
+        tcg_gen_xori_i64(cpu_fpr[a->rd], t1, INT32_MIN);
     } else {
         TCGv_i64 t0 = tcg_temp_new_i64();
-        tcg_gen_not_i64(t0, cpu_fpr[a->rs2]);
-        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
+        tcg_gen_not_i64(t0, t2);
+        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, t1, 0, 31);
         tcg_temp_free_i64(t0);
     }
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -202,16 +307,26 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
     if (a->rs1 == a->rs2) { /* FABS */
-        tcg_gen_andi_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], ~INT32_MIN);
+        tcg_gen_andi_i64(cpu_fpr[a->rd], t1, ~INT32_MIN);
     } else {
         TCGv_i64 t0 = tcg_temp_new_i64();
-        tcg_gen_andi_i64(t0, cpu_fpr[a->rs2], INT32_MIN);
-        tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
+        tcg_gen_andi_i64(t0, t2, INT32_MIN);
+        tcg_gen_xor_i64(cpu_fpr[a->rd], t1, t0);
         tcg_temp_free_i64(t0);
     }
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -220,10 +335,18 @@ static bool trans_fmin_s(DisasContext *ctx, arg_fmin_s *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    gen_helper_fmin_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
-                      cpu_fpr[a->rs2]);
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
+    gen_helper_fmin_s(cpu_fpr[a->rd], cpu_env, t1, t2);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -232,10 +355,18 @@ static bool trans_fmax_s(DisasContext *ctx, arg_fmax_s *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    gen_helper_fmax_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
-                      cpu_fpr[a->rs2]);
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
+    gen_helper_fmax_s(cpu_fpr[a->rd], cpu_env, t1, t2);
     gen_nanbox_fpr(ctx, a->rd);
+
     mark_fs_dirty(ctx);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -245,11 +376,16 @@ static bool trans_fcvt_w_s(DisasContext *ctx, arg_fcvt_w_s *a)
     REQUIRE_EXT(ctx, RVF);
 
     TCGv t0 = tcg_temp_new();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    check_nanboxed(ctx, 1, t1);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fcvt_w_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_helper_fcvt_w_s(t0, cpu_env, t1);
     gen_set_gpr(a->rd, t0);
-    tcg_temp_free(t0);
 
+    tcg_temp_free(t0);
+    tcg_temp_free_i64(t1);
     return true;
 }
 
@@ -259,11 +395,16 @@ static bool trans_fcvt_wu_s(DisasContext *ctx, arg_fcvt_wu_s *a)
     REQUIRE_EXT(ctx, RVF);
 
     TCGv t0 = tcg_temp_new();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    check_nanboxed(ctx, 1, t1);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fcvt_wu_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_helper_fcvt_wu_s(t0, cpu_env, t1);
     gen_set_gpr(a->rd, t0);
-    tcg_temp_free(t0);
 
+    tcg_temp_free(t0);
+    tcg_temp_free_i64(t1);
     return true;
 }
 
@@ -291,10 +432,20 @@ static bool trans_feq_s(DisasContext *ctx, arg_feq_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
     TCGv t0 = tcg_temp_new();
-    gen_helper_feq_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
+    gen_helper_feq_s(t0, cpu_env, t1, t2);
     gen_set_gpr(a->rd, t0);
+
     tcg_temp_free(t0);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -302,10 +453,20 @@ static bool trans_flt_s(DisasContext *ctx, arg_flt_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
     TCGv t0 = tcg_temp_new();
-    gen_helper_flt_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
+    gen_helper_flt_s(t0, cpu_env, t1, t2);
     gen_set_gpr(a->rd, t0);
+
     tcg_temp_free(t0);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -313,10 +474,20 @@ static bool trans_fle_s(DisasContext *ctx, arg_fle_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
     TCGv t0 = tcg_temp_new();
-    gen_helper_fle_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
+    check_nanboxed(ctx, 2, t1, t2);
+
+    gen_helper_fle_s(t0, cpu_env, t1, t2);
     gen_set_gpr(a->rd, t0);
+
     tcg_temp_free(t0);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
     return true;
 }
 
@@ -326,12 +497,15 @@ static bool trans_fclass_s(DisasContext *ctx, arg_fclass_s *a)
     REQUIRE_EXT(ctx, RVF);
 
     TCGv t0 = tcg_temp_new();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    check_nanboxed(ctx, 1, t1);
 
-    gen_helper_fclass_s(t0, cpu_fpr[a->rs1]);
-
+    gen_helper_fclass_s(t0, t1);
     gen_set_gpr(a->rd, t0);
-    tcg_temp_free(t0);
 
+    tcg_temp_free(t0);
+    tcg_temp_free_i64(t1);
     return true;
 }
 
@@ -400,10 +574,16 @@ static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a)
     REQUIRE_EXT(ctx, RVF);
 
     TCGv t0 = tcg_temp_new();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    check_nanboxed(ctx, 1, t1);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_helper_fcvt_l_s(t0, cpu_env, t1);
     gen_set_gpr(a->rd, t0);
+
     tcg_temp_free(t0);
+    tcg_temp_free_i64(t1);
     return true;
 }
 
@@ -413,10 +593,16 @@ static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a)
     REQUIRE_EXT(ctx, RVF);
 
     TCGv t0 = tcg_temp_new();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+    check_nanboxed(ctx, 1, t1);
+
     gen_set_rm(ctx, a->rm);
-    gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_helper_fcvt_lu_s(t0, cpu_env, t1);
     gen_set_gpr(a->rd, t0);
+
     tcg_temp_free(t0);
+    tcg_temp_free_i64(t1);
     return true;
 }
 
-- 
2.23.0


