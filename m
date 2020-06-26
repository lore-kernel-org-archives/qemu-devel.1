Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5A0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEEA206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEEA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jovY5-0003x2-NE
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovXS-0003OO-2g; Fri, 26 Jun 2020 17:05:34 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovXQ-0004iU-BA; Fri, 26 Jun 2020 17:05:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.3410022|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.00804734-0.00154471-0.990408; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=9; RT=9; SR=0;
 TI=SMTPD_---.Ht24-94_1593205527; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Ht24-94_1593205527)
 by smtp.aliyun-inc.com(10.147.42.22); Sat, 27 Jun 2020 05:05:28 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 3/6] target/riscv: Check for LEGAL NaN-boxing
Date: Sat, 27 Jun 2020 04:59:14 +0800
Message-Id: <20200626205917.4545-4-zhiwei_liu@c-sky.com>
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

A narrow n-bit operation, where n < FLEN, checks that input operands
are correctly NaN-boxed, i.e., all upper FLEN - n bits are 1.
If so, the n least-significant bits of the input are used as the input value,
otherwise the input value is treated as an n-bit canonical NaN.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/translate.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 4b1534c9a6..1c9b809d4a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -104,6 +104,35 @@ static void gen_nanbox_fpr(DisasContext *ctx, int regno)
     }
 }
 
+/*
+ * A narrow n-bit operation, where n < FLEN, checks that input operands
+ * are correctly NaN-boxed, i.e., all upper FLEN - n bits are 1.
+ * If so, the n least-signicant bits of the input are used as the input value,
+ * otherwise the input value is treated as an n-bit canonical NaN.
+ * (riscv-spec-v2.2 Section 9.2).
+ */
+static void check_nanboxed(DisasContext *ctx, int num, ...)
+{
+    if (has_ext(ctx, RVD)) {
+        int i;
+        TCGv_i64 cond1 = tcg_temp_new_i64();
+        TCGv_i64 t_nan = tcg_const_i64(0x7fc00000);
+        TCGv_i64 t_max = tcg_const_i64(MAKE_64BIT_MASK(32, 32));
+        va_list valist;
+        va_start(valist, num);
+
+        for (i = 0; i < num; i++) {
+            TCGv_i64 t = va_arg(valist, TCGv_i64);
+            tcg_gen_movcond_i64(TCG_COND_GEU, t, t, t_max, t, t_nan);
+        }
+
+        va_end(valist);
+        tcg_temp_free_i64(cond1);
+        tcg_temp_free_i64(t_nan);
+        tcg_temp_free_i64(t_max);
+    }
+}
+
 static void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-- 
2.23.0


