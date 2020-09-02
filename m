Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7D6C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850D5206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7VV1PxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850D5206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVmW-0004Rd-MI
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk2-0000AY-3U
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:10 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVjy-00056G-EM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:09 -0400
Received: by mail-pj1-x1041.google.com with SMTP id o16so67628pjr.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EnR4zcNTy4dNI32aFY/vKIxejJwT5sHjfw2kYtr9Qvc=;
 b=M7VV1PxJojvS6r2zhMgMRHrrUn2M6T7S2+5FW0wfa8sRqeC7FatuR8nHloGAljMyTg
 WiTqNRABzJXj2BdKAk/OmjUDepSQgLdTrzpfXxnfRiECdRoPtI465Aovp/8U4RmHlsWc
 iQnfuZEp6n3g/K9yyQRcgajs42HY1HmTaYcoJbWmMe3mZjx7R7Xm+4nZ4B2fvpNGkqpO
 2txFjUcDOeGuGyYey604D6M7RQy9GxsjPruoCatJWDAlBhomKhU2mMjLUYHW0ohP0pab
 UAJkNlL15krwWNWvQjSP7gV8mZ+K1jy/XtxgAqp/hI5qhEhxMzjw9810cbLRJ1CFJKi0
 zEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EnR4zcNTy4dNI32aFY/vKIxejJwT5sHjfw2kYtr9Qvc=;
 b=Cu5/4wT5JerwJLxmKt8ffHAkl/UWgGj6VqnfMf+EUqqiveUgibcfyeHzwgpmX+c91D
 BQyk66ICs4WN9gFZRD/rEjIfBSiBL71jrGYwlXLI/6JEZ7hxwi3ZhlnvWxk8A15lgzSK
 099qw52LQBhwWViJzga7bC9XVYoN+CIXgj05bYmdWLrTLeHuBiBBqQ+KYYkVupeGt38n
 6ZHTF0lJvVy/o7qh8UJuTJmxPV8uhpRQEGvx9N+i9QLpAcpXZ2vLx8Rm2+PS7n2Q71fd
 XpM1pi8BZtstPIKFAVEnVI8TPN3iySRZNy7F+hGyPTI9viWIsziIA65XFGnnLuS8lNt9
 z3Hw==
X-Gm-Message-State: AOAM5319KkCaY1+mVX3JYDPSZo5DZwf+GCIgPrWucABbNnPYvU9+OWxO
 erI8jdQPE6tF1Du+dk5ndEhtJ7XhQAAeVQ==
X-Google-Smtp-Source: ABdhPJw3fCUe7nJxid2Iz7esm2HiYS49ofm+eAiS5n405XWJdCLW5GODe1j+fCcHzj5j2YLb9Dl42w==
X-Received: by 2002:a17:90a:1910:: with SMTP id
 16mr2953852pjg.76.1599064563674; 
 Wed, 02 Sep 2020 09:36:03 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm4955441pjz.33.2020.09.02.09.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 09:36:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] target/microblaze: Introduce DISAS_EXIT_NEXT,
 DISAS_EXIT_JUMP
Date: Wed,  2 Sep 2020 09:35:54 -0700
Message-Id: <20200902163559.1077728-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902163559.1077728-1-richard.henderson@linaro.org>
References: <20200902163559.1077728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like DISAS_EXIT, except we need to update cpu_pc,
either to pc_next or to btarget respectively.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 03fc653ce2..0733728794 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -39,6 +39,11 @@
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
 #define DISAS_EXIT    DISAS_TARGET_1 /* all cpu state modified dynamically */
 
+/* cpu state besides pc was modified dynamically; update pc to next */
+#define DISAS_EXIT_NEXT DISAS_TARGET_2
+/* cpu state besides pc was modified dynamically; update pc to btarget */
+#define DISAS_EXIT_JUMP DISAS_TARGET_3
+
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
@@ -1712,8 +1717,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     /* Force an exit if the per-tb cpu state has changed.  */
     if (dc->base.is_jmp == DISAS_NEXT && dc->cpustate_changed) {
-        dc->base.is_jmp = DISAS_EXIT;
-        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
+        dc->base.is_jmp = DISAS_EXIT_NEXT;
     }
 }
 
@@ -1734,12 +1738,14 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         return;
 
     case DISAS_EXIT:
-        if (unlikely(cs->singlestep_enabled)) {
-            gen_raise_exception(dc, EXCP_DEBUG);
-        } else {
-            tcg_gen_exit_tb(NULL, 0);
-        }
-        return;
+        break;
+    case DISAS_EXIT_NEXT:
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
+        break;
+    case DISAS_EXIT_JUMP:
+        tcg_gen_mov_i32(cpu_pc, cpu_btarget);
+        tcg_gen_discard_i32(cpu_btarget);
+        break;
 
     case DISAS_JUMP:
         if (dc->jmp_dest != -1 && !cs->singlestep_enabled) {
@@ -1781,6 +1787,13 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
     default:
         g_assert_not_reached();
     }
+
+    /* Finish DISAS_EXIT_* */
+    if (unlikely(cs->singlestep_enabled)) {
+        gen_raise_exception(dc, EXCP_DEBUG);
+    } else {
+        tcg_gen_exit_tb(NULL, 0);
+    }
 }
 
 static void mb_tr_disas_log(const DisasContextBase *dcb, CPUState *cs)
-- 
2.25.1


