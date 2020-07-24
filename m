Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE913C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9811F2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FScUEfH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9811F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jylhG-0007xL-Ue
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 20:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZV-0000ML-5y
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:21 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:46606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZT-0008GF-KL
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:20 -0400
Received: by mail-pf1-x431.google.com with SMTP id a23so4051334pfk.13
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jQCpNdFJsrF3Bpi0rRRCXqsUrN96754LDnpff+tQIzo=;
 b=FScUEfH+7aJujA9JSdolRAFuUDhHsshCEERdH9W9YZSRKL/KK/ZQsHZL+zn+iNOTsk
 FJAmFC0hc3hPsj3xkJEUkQpUG+TS1RPZDrhIKySvy2ApU0W9w1NYKkALTK+ONPCTrpws
 J5WH6aOhDU6jrfUwYLZzk61TkcUHDnAIydTHzdvoZZrhHZWiVNAiQSmrVqUttLZRRhAl
 ClcKyQDVEaI+Wd5IGe+Iw5wV86HJ93TnaHhInjRwCOprPbSMmozOxl6ya3bfaiKuhYWa
 HHVGd4ETYkVEfcJ0DoY5nr2ydDGeVVDSvZrfda7/wc32U8Znms5Kzw9GBjsb8Eb7q8fQ
 b5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jQCpNdFJsrF3Bpi0rRRCXqsUrN96754LDnpff+tQIzo=;
 b=Jcwk7SqWzBQtYjjJOD6MU8w3oYMnqsmyfXiIfyjGy1TcdERh6B1psLH89gS4lUob9A
 5QT9BJ1OblU99K2llyQEdIbV4W/x+a2cGr4D7QhxowDcxxGDJ8qEBibnj0X9Li1qFD8O
 r+M+cnFgjEbSqJz1GCkmJjuFOYihhmT4Q7EXpdR7FzEihfOpIpJhCACFyGWkv8dXdDFM
 ZnsLpJYBnJPe6bgOY3dD2iy76zBezhAkjN9qKxqzUpYRjVPQAUaUtqC6TNtn/w2m0fqY
 tqi6J8AiAQzf4QmGCf2zbDEVLmGZxl7gl+3hQzjCGTKQR3tRhe5Q8xgeT7QirMSPbUL0
 fZ4g==
X-Gm-Message-State: AOAM5323H2cHOT5Xe0aNuJmRxnsObgv/ifB4ARMOH0VALLOU33hZKu/r
 fsGC7pSgHZB6dXImaK8DJc/tz0tF8dw=
X-Google-Smtp-Source: ABdhPJwJpM0IToCX7H1EapTXmYY8AmBjtWlS0t+IfEhdMMHDFQjM4DNvrOefl4ODTNMaCzGEDy0FNA==
X-Received: by 2002:a65:6416:: with SMTP id a22mr6212003pgv.392.1595550497983; 
 Thu, 23 Jul 2020 17:28:17 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id q20sm4224635pfn.111.2020.07.23.17.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 17:28:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] target/riscv: check before allocating TCG temps
Date: Thu, 23 Jul 2020 17:28:07 -0700
Message-Id: <20200724002807.441147-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724002807.441147-1-richard.henderson@linaro.org>
References: <20200724002807.441147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org,
 zhiwei_liu@c-sky.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-Id: <20200626205917.4545-5-zhiwei_liu@c-sky.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvd.inc.c | 8 ++++----
 target/riscv/insn_trans/trans_rvf.inc.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index ea1044f13b..4f832637fa 100644
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
index 0d04677a02..16df9c5ee2 100644
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
2.25.1


