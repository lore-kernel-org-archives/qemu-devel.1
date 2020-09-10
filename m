Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E675C07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89760207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dj1fZ+8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89760207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMT5-0000gb-HS
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMQ2-0004AN-4h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMPz-00069e-LF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id x14so6625908wrl.12
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g8PtmApH/K3qKSdHTvoF6QAOQMNnnFMaqVpih1ljmaA=;
 b=Dj1fZ+8UB9Yr5miY3MEhTd21OZlHc9inMaDL3muEm4Mf0kgLR1yZKFjWUXTL3kqIkr
 jjK7iFPyP8+DbUF2NvQZ033owFGmA2B4LoJ41bRfw3+hKkq18Y3FKQwiF6dcAKVmfvpW
 Qv3inujGLp/u6+cfKxNtWqBwgO8FMCcMwOKX0/CdTTkkzMGpiE8s+v1ALwi9CU8i1JXA
 VHZegFRrpXjTUsxY+CWZea52CL55+A/rdougOHozahigo03usyKSUcVoqeOaWOH6b5xx
 KleGoE89fyowVYG+iDJh2ba+nbZa/o+9MQvPXpEYURY06HWM0P92n+EHhc4JngZSa/S9
 BgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g8PtmApH/K3qKSdHTvoF6QAOQMNnnFMaqVpih1ljmaA=;
 b=m1KKMmHrct6N+JnEkqY2q1W9LcWKGh4Hxt7kABKZZ11pQ3olPpGX/XowZqPh5NrCBV
 BlGxYjkx0s+7rqF7kjgUGyOht6QVpx7V9bMxdoxTN5yLenvmc0jbjjz+BBGfFf/tG2+Q
 WHLOuHmmzukODhcD30outbs5fZAMFxXGITpcMgQ1iF0lggjf+0yZcqYBFl04TRhZ7nOW
 Mxhz8AtQd8BqjAU7RqSdpJGMNnrk6HJP3Sl4WwXFvu8i0ob6XlvMZjTt5Yupp+fr/v+O
 j4rZ3hwC5S41i4arO7z7Kbw4GVEwJ1OZUwg/b+nON/yZ7MJmkwofYypQjXAsepLDBLOo
 inqw==
X-Gm-Message-State: AOAM530s/pwcJFgPEeDeQjJWqDPYkS96q+nx/B07+siUtgQO1CK41kQq
 iIxdGa6LECVBbeSYaD48uwmrpg==
X-Google-Smtp-Source: ABdhPJzspMdjQovCSfYyyI+0EtsCQykl+yIl0/weVj+Q2vSDrCvlcm7BQJJEs2yu1YGEt9wDu4DzYA==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr9074836wrk.263.1599743714284; 
 Thu, 10 Sep 2020 06:15:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i3sm8896003wrs.4.2020.09.10.06.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:15:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BABD61FF90;
 Thu, 10 Sep 2020 14:15:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/10] target/mips: simplify gen_compute_imm_branch logic
Date: Thu, 10 Sep 2020 14:14:58 +0100
Message-Id: <20200910131504.11341-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910131504.11341-1-alex.bennee@linaro.org>
References: <20200910131504.11341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One of the Travis builds was complaining about:

  qemu/include/tcg/tcg.h:437:12: error: ‘cond’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
       return (TCGCond)(c ^ 1);
  ../target/mips/translate.c:20031:13: note: ‘cond’ was declared here
       TCGCond cond;

Rather than figure out exactly which one was causing the complaint I
just defaulted to TCG_COND_ALWAYS and allowed that state to double up
for the now defunct bcond_compute variable.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200909112742.25730-5-alex.bennee@linaro.org>

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 899b90ae0ff..398edf72898 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20028,8 +20028,7 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
                                    int rt, int32_t imm, int32_t offset)
 {
-    TCGCond cond;
-    int bcond_compute = 0;
+    TCGCond cond = TCG_COND_ALWAYS;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
@@ -20046,7 +20045,6 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
             /* Treat as NOP */
             goto out;
         } else {
-            bcond_compute = 1;
             cond = TCG_COND_EQ;
         }
         break;
@@ -20065,7 +20063,6 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
             tcg_gen_shri_tl(t0, t0, imm);
             tcg_gen_andi_tl(t0, t0, 1);
             tcg_gen_movi_tl(t1, 0);
-            bcond_compute = 1;
             if (opc == NM_BBEQZC) {
                 cond = TCG_COND_EQ;
             } else {
@@ -20080,7 +20077,6 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         } else if (rt == 0 && imm != 0) {
             /* Unconditional branch */
         } else {
-            bcond_compute = 1;
             cond = TCG_COND_NE;
         }
         break;
@@ -20088,24 +20084,20 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         if (rt == 0 && imm == 0) {
             /* Unconditional branch */
         } else  {
-            bcond_compute = 1;
             cond = TCG_COND_GE;
         }
         break;
     case NM_BLTIC:
-        bcond_compute = 1;
         cond = TCG_COND_LT;
         break;
     case NM_BGEIUC:
         if (rt == 0 && imm == 0) {
             /* Unconditional branch */
         } else  {
-            bcond_compute = 1;
             cond = TCG_COND_GEU;
         }
         break;
     case NM_BLTIUC:
-        bcond_compute = 1;
         cond = TCG_COND_LTU;
         break;
     default:
@@ -20118,7 +20110,7 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
     clear_branch_hflags(ctx);
     ctx->base.is_jmp = DISAS_NORETURN;
 
-    if (bcond_compute == 0) {
+    if (cond == TCG_COND_ALWAYS) {
         /* Uncoditional compact branch */
         gen_goto_tb(ctx, 0, ctx->btarget);
     } else {
-- 
2.20.1


