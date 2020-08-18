Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0362BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E50207BB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="g+djrO36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E50207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tE7-0006Bh-Tk
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6Z-0008RW-TX; Tue, 18 Aug 2020 00:20:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38105 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6Y-0006Ns-2n; Tue, 18 Aug 2020 00:20:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNd0klNz9sVd; Tue, 18 Aug 2020 14:19:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724369;
 bh=nH0H3yYyxaySTaqQiGqcwMUcDcqOkORK6NquiIdDaCM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g+djrO36YSuLMLelS7uwOuc2RKettH+rxDMS5zhHRM3oh76TV9V3SE8Z9ZGWvt3mR
 /07/vguUSb+HAmPGWYMwYwLgRmoLCpTrG3Bdc9jM9c92oR2WZV+ZfihxOkdJJjraVf
 l1CnYzFjvl6v+d6YsXPZZBNMqEUd05Pj/vHqWlIs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 21/40] target/ppc: Integrate icount to purr, vtb, and tbu40
Date: Tue, 18 Aug 2020 14:19:03 +1000
Message-Id: <20200818041922.251708-22-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 00:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gustavo Romero <gromero@linux.ibm.com>

Currently if option '-icount auto' is passed to the QEMU TCG to enable
counting instructions the VM crashes with the following error report when
Linux runs on it:

qemu-system-ppc64: Bad icount read

This happens because read/write access to the SPRs PURR, VTB, and TBU40
is not integrated to the icount framework.

This commit fixes that issue by making the read/write access of these
SPRs aware of icount framework, adding the proper gen_io_start() calls
before calling the helpers to load/store these SPRs in TCG and ensuring
that the associated TBs end immediately after, accordingly to what's in
docs/devel/tcg-icount.rst.

Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
Message-Id: <20200811153235.4527-1-gromero@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.inc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 5134123dd6..230a062d29 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -284,12 +284,24 @@ static void spr_write_atbu(DisasContext *ctx, int sprn, int gprn)
 ATTRIBUTE_UNUSED
 static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 static void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_store_purr(cpu_env, cpu_gpr[gprn]);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 /* HDECR */
@@ -319,17 +331,35 @@ static void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 
 static void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_load_vtb(cpu_gpr[gprn], cpu_env);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 static void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 static void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_store_tbu40(cpu_env, cpu_gpr[gprn]);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 #endif
-- 
2.26.2


