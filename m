Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C14C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD23206F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZwf/mDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD23206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasrv-0000VO-Kc
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSP-0005wQ-Ch
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:33 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSG-0007JW-Rg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:33 -0500
Received: by mail-pf1-x443.google.com with SMTP id e7so25638pfn.12
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WPMt5y9/CEVXiVdd1wzKuw7r3/x04DmCpdWE8TQ6bV4=;
 b=xZwf/mDVFouqeHdv+1LY9G1u3LtHP1Bcyu4guksK8BHCmTBq0AwoGcgRykjPC2a1Wt
 rf5FqVYUB3jK2kp/5eEOW8gQMUigOCVA3ndcroxuPuTHB6Y4ORu/qmy701DR2K7jxNBM
 WF7FV5rG4cskB6h6vSyAYIBpPr6j5GvHvGEXi3X6bRPwN/2BJ7Om/MbuhRm4U9cw8la3
 g3cFytK/aVWxmgi2hho/TqWyTaiE2vPiSMyvaWo/lYaZT2Ce/fob5SqTFhlBzAzfu8CF
 dqP9IO0TyyZF0tU+AeB8V1/6miHwZ03Dsb9W6h+bD9BVb+y12drXG1WK8A2XHMmLO/Mv
 yDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WPMt5y9/CEVXiVdd1wzKuw7r3/x04DmCpdWE8TQ6bV4=;
 b=VqNN7dbD2auXTi/OgUIn/ixUhsmTpBNDqZpxFAC7R9lmxk7qw+vd9Ov2Du9YLiuKy1
 ybDX/a2rcTETgJc0YP2xoASKIF/Nj9wm6feoWWKwwQOkEps/K3gt9PGrZ+Wc2gRXvrD4
 C4lHD3vwog+nFvhmZeUpIirGLAzLuAA1dfoYEaco9F9lPhMQtklBw9DRBudmZI5SrXqd
 j1vO/MNq6llWJ7TdJAMX5AWA5NoQUi79H4iNlmR6jFfN0TCUOzMG+drX8r+R3QvOZlzj
 rubU24+Wgf8zfULSmTXC8ufeuBF5nQnrssKyj9fauRHRidWRJVV7435GjTn34Uzwuzqs
 VmFA==
X-Gm-Message-State: AOAM532y/K7pmXMaqTsBs/QlkmRUkFi+/XqNKRli9e2DLX58EPrPqnwj
 kUugUUuGaz5zZGT4nvI4Ef0SmwWCeXQIVg==
X-Google-Smtp-Source: ABdhPJxyOXgOgRLzaAlxA++Uok3g7eRFIKPVSKjJkrADyGQ42zdrlbI4We2V/PxVT6Zk753d5po+cw==
X-Received: by 2002:a63:cb51:: with SMTP id m17mr5215435pgi.337.1604633422959; 
 Thu, 05 Nov 2020 19:30:22 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 40/41] tcg: Constify tcg_code_gen_epilogue
Date: Thu,  5 Nov 2020 19:29:20 -0800
Message-Id: <20201106032921.600200-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that all native tcg hosts support splitwx,
make this pointer const.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            | 2 +-
 tcg/tcg.c                    | 2 +-
 tcg/aarch64/tcg-target.c.inc | 3 +--
 tcg/arm/tcg-target.c.inc     | 3 +--
 tcg/i386/tcg-target.c.inc    | 3 +--
 tcg/mips/tcg-target.c.inc    | 3 +--
 tcg/ppc/tcg-target.c.inc     | 3 +--
 tcg/riscv/tcg-target.c.inc   | 3 +--
 tcg/s390/tcg-target.c.inc    | 3 +--
 tcg/sparc/tcg-target.c.inc   | 3 +--
 10 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 90ec7c1445..477919aeb6 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -677,7 +677,7 @@ struct TCGContext {
 
 extern TCGContext tcg_init_ctx;
 extern __thread TCGContext *tcg_ctx;
-extern void *tcg_code_gen_epilogue;
+extern const void *tcg_code_gen_epilogue;
 extern uintptr_t tcg_splitwx_diff;
 extern TCGv_env cpu_env;
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 07a4bd2c57..5c19b1e6b3 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -160,7 +160,7 @@ static int tcg_out_ldst_finalize(TCGContext *s);
 static TCGContext **tcg_ctxs;
 static unsigned int n_tcg_ctxs;
 TCGv_env cpu_env = 0;
-void *tcg_code_gen_epilogue;
+const void *tcg_code_gen_epilogue;
 uintptr_t tcg_splitwx_diff;
 
 #ifndef CONFIG_TCG_INTERPRETER
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index e398913c0c..32a60eba5e 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2900,8 +2900,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    /* TODO: Cast goes away when all hosts converted */
-    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
+    tcg_code_gen_epilogue = tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_X0, 0);
 
     /* TB epilogue */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 3d2717aeb0..d6cb19ca9f 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2301,8 +2301,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    /* TODO: Cast goes away when all hosts converted */
-    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
+    tcg_code_gen_epilogue = tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
     tcg_out_epilogue(s);
 }
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 23c7a8a383..be57d2330a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3826,8 +3826,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    /* TODO: Cast goes away when all hosts converted */
-    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
+    tcg_code_gen_epilogue = tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_EAX, 0);
 
     /* TB epilogue */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index a2201bd1dd..18fd474593 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2473,8 +2473,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    /* TODO: Cast goes away when all hosts converted */
-    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
+    tcg_code_gen_epilogue = tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_V0, TCG_REG_ZERO);
 
     /* TB epilogue */
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index fe33687787..3580bbabc1 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2346,8 +2346,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out32(s, BCCTR | BO_ALWAYS);
 
     /* Epilogue */
-    /* TODO: Cast goes away when all hosts converted */
-    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
+    tcg_code_gen_epilogue = tcg_splitwx_to_rx(s->code_ptr);
 
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_REG_R1, FRAME_SIZE+LR_OFFSET);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); ++i) {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 5c1e0f8fc1..7b4ee4a084 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1784,8 +1784,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, tcg_target_call_iarg_regs[1], 0);
 
     /* Return path for goto_ptr. Set return value to 0 */
-    /* TODO: Cast goes away when all hosts converted */
-    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
+    tcg_code_gen_epilogue = tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_A0, TCG_REG_ZERO);
 
     /* TB epilogue */
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index 582a8ef941..b3660ffedf 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -2551,8 +2551,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    /* TODO: Cast goes away when all hosts converted */
-    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
+    tcg_code_gen_epilogue = tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R2, 0);
 
     /* TB epilogue */
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 182124b96c..922ae96481 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -1039,8 +1039,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_nop(s);
 
     /* Epilogue for goto_ptr.  */
-    /* TODO: Cast goes away when all hosts converted */
-    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
+    tcg_code_gen_epilogue = tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I7, 8, RETURN);
     /* delay slot */
     tcg_out_movi_imm13(s, TCG_REG_O0, 0);
-- 
2.25.1


