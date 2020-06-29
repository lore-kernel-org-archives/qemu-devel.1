Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2E423D4D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2E423D4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptZH-0004JI-PT
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jptVk-0008EH-0F; Mon, 29 Jun 2020 09:07:48 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jptVf-0003Y9-Ts; Mon, 29 Jun 2020 09:07:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07438486|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.0520955-0.00143157-0.946473;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03305; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.HucVN.U_1593436054; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HucVN.U_1593436054)
 by smtp.aliyun-inc.com(10.147.44.145);
 Mon, 29 Jun 2020 21:07:35 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 2/2] target/riscv: Do amo*.w insns operate with 32 bits
Date: Mon, 29 Jun 2020 21:07:31 +0800
Message-Id: <20200629130731.1080-3-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200629130731.1080-1-zhiwei_liu@c-sky.com>
References: <20200629130731.1080-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 09:07:36
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
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For amo*.w insns, we should only calculate on the 32 bits data either from the
register or the memory.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/insn_trans/trans_rva.inc.c | 60 +++++++++++++++++++------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
index be8a9f06dd..6b3fc14436 100644
--- a/target/riscv/insn_trans/trans_rva.inc.c
+++ b/target/riscv/insn_trans/trans_rva.inc.c
@@ -81,19 +81,26 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     return true;
 }
 
-static bool gen_amo(DisasContext *ctx, arg_atomic *a,
-                    void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
-                    MemOp mop)
+static bool
+gen_amo_w(DisasContext *ctx, arg_atomic *a,
+          void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
+          MemOp mop, bool sign)
 {
     TCGv src1 = tcg_temp_new();
     TCGv src2 = tcg_temp_new();
 
     gen_get_gpr(src1, a->rs1);
     gen_get_gpr(src2, a->rs2);
+    if (sign) {
+        tcg_gen_ext32s_tl(src2, src2);
+    } else {
+        tcg_gen_ext32u_tl(src2, src2);
+    }
 
     (*func)(src2, src1, src2, ctx->mem_idx, mop);
-
+    tcg_gen_ext32s_tl(src2, src2);
     gen_set_gpr(a->rd, src2);
+
     tcg_temp_free(src1);
     tcg_temp_free(src2);
     return true;
@@ -114,59 +121,86 @@ static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_EXT(ctx, RVA);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo_w(ctx, a, &tcg_gen_atomic_xchg_tl,
+                     (MO_ALIGN | MO_TESL), true);
 }
 
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_EXT(ctx, RVA);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo_w(ctx, a, &tcg_gen_atomic_fetch_add_tl,
+                     (MO_ALIGN | MO_TESL), true);
 }
 
 static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
     REQUIRE_EXT(ctx, RVA);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo_w(ctx, a, &tcg_gen_atomic_fetch_xor_tl,
+                     (MO_ALIGN | MO_TESL), true);
 }
 
 static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
     REQUIRE_EXT(ctx, RVA);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo_w(ctx, a, &tcg_gen_atomic_fetch_and_tl,
+                     (MO_ALIGN | MO_TESL), true);
 }
 
 static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
     REQUIRE_EXT(ctx, RVA);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo_w(ctx, a, &tcg_gen_atomic_fetch_or_tl,
+                     (MO_ALIGN | MO_TESL), true);
 }
 
 static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
     REQUIRE_EXT(ctx, RVA);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo_w(ctx, a, &tcg_gen_atomic_fetch_smin_tl,
+                     (MO_ALIGN | MO_TESL), true);
 }
 
 static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
     REQUIRE_EXT(ctx, RVA);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo_w(ctx, a, &tcg_gen_atomic_fetch_smax_tl,
+                     (MO_ALIGN | MO_TESL), true);
 }
 
 static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
     REQUIRE_EXT(ctx, RVA);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo_w(ctx, a, &tcg_gen_atomic_fetch_umin_tl,
+                     (MO_ALIGN | MO_TEUL), false);
 }
 
 static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
     REQUIRE_EXT(ctx, RVA);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo_w(ctx, a, &tcg_gen_atomic_fetch_umax_tl,
+                     (MO_ALIGN | MO_TEUL), false);
 }
 
 #ifdef TARGET_RISCV64
 
+static bool gen_amo(DisasContext *ctx, arg_atomic *a,
+                    void(*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, MemOp),
+                    MemOp mop)
+{
+    TCGv src1 = tcg_temp_new();
+    TCGv src2 = tcg_temp_new();
+
+    gen_get_gpr(src1, a->rs1);
+    gen_get_gpr(src2, a->rs2);
+
+    (*func)(src2, src1, src2, ctx->mem_idx, mop);
+
+    gen_set_gpr(a->rd, src2);
+    tcg_temp_free(src1);
+    tcg_temp_free(src2);
+    return true;
+}
+
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
     return gen_lr(ctx, a, MO_ALIGN | MO_TEQ);
-- 
2.23.0


