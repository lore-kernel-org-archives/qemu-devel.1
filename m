Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92819C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63066208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63066208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jova6-0004ro-L8
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovZR-0004RC-8Z; Fri, 26 Jun 2020 17:07:37 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovZP-0005iR-Hw; Fri, 26 Jun 2020 17:07:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07876534|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.011284-0.000636729-0.988079;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03267; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.Ht2CGB0_1593205648; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Ht2CGB0_1593205648)
 by smtp.aliyun-inc.com(10.147.44.129);
 Sat, 27 Jun 2020 05:07:28 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 4/6] target/riscv: check before allocating TCG temps
Date: Sat, 27 Jun 2020 04:59:15 +0800
Message-Id: <20200626205917.4545-5-zhiwei_liu@c-sky.com>
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
 target/riscv/insn_trans/trans_rvd.inc.c | 8 ++++----
 target/riscv/insn_trans/trans_rvf.inc.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index cd73a326f4..c0f4a0c789 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -20,10 +20,10 @@
 
 static bool trans_fld(DisasContext *ctx, arg_fld *a)
 {
-    TCGv t0 = tcg_temp_new();
-    gen_get_gpr(t0, a->rs1);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEQ);
@@ -35,10 +35,10 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
 
 static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 {
-    TCGv t0 = tcg_temp_new();
-    gen_get_gpr(t0, a->rs1);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEQ);
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index a3d74dd83d..04bc8e5cb5 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -25,10 +25,10 @@
 
 static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
-    TCGv t0 = tcg_temp_new();
-    gen_get_gpr(t0, a->rs1);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
@@ -41,11 +41,11 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 
 static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
 {
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVF);
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
 
-    REQUIRE_FPU;
-    REQUIRE_EXT(ctx, RVF);
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUL);
-- 
2.23.0


