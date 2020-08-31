Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8905AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520562073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzXAKX5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520562073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmTE-00071G-EH
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKS-0004Yf-89
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:40382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKO-00060N-Hm
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:43 -0400
Received: by mail-pf1-x432.google.com with SMTP id c142so805536pfb.7
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uIKhTONsxJcHP4WPV5M1NnbEZDfvPYoEbwvp1GTDwH0=;
 b=UzXAKX5F9YVWp7VQ/tMXsH6+P2hNGccXa568aEytk+jOKR98GKzxAUU3xSv64u/hBo
 TYXuJcbVO6AmWwPEd8F9sa3QN2bOECLRh7MgemWiZrhbWjzL9TO97BVojY0eex3iW6Ve
 g4NL/BQ+aOce36GJipiw1QAsS1Ye5PvkMvXLbIEbegC7L/gVLzKHjLO1Yw5kAH+MSpGQ
 /GNOEDCuhrVezcjbR30lSYgfM3FOpQ06UJOgpGeqh6Zx0i1LKRMQYMACEkRJqY6COIjs
 hdsj6saRKHMY3ghlvfmYbyL1vnYSya8kBP+FUd67x1YQdYbFglsTuIcbmlPXfZA5qAro
 nc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uIKhTONsxJcHP4WPV5M1NnbEZDfvPYoEbwvp1GTDwH0=;
 b=hU3k3l0eo/XsBPlDA7lSb193381HCJYJGDpGu62qZl8+ltyWLDgVQoDQhB5crK0Igt
 ABhXrcFS7pjGzvQHnm6/4rsgbz8CUkcqQacstoW2p7Kv+N5+otQUAPn/mLI1ORiEFP6B
 Fgm7V8/bEdjKFkyfTs/lKIxXOQNNI5uxv/P4/ys7macGAYbQtzMlmsU4I1Wg0k98LeC0
 q0MuQ2SbI6d3KkKVmwvGqRFwiJbsTPD1/V6G72PTKg5MYnHKR4xkYHuMgCr0L8HDyjQD
 noiSoaJhpBCKfBlAvmoSPGkyOBrqCI6n8RVE7d6cDRhImgKngyNvrKC2ZJhyHq5r8c9K
 6xsA==
X-Gm-Message-State: AOAM532NmKTyILsBASpj0DaBQ4kxBigGrlN2soJgXXqOKAcALf0oGnl5
 ikQDNTXLm/vsS3Nu8FCqqEtjiJ9zCrCPmA==
X-Google-Smtp-Source: ABdhPJz3IoY5XMoh3olPx05xYnTHj2YaPGREHs+S1z6p6hHnckcuddD+g2CryCMyNdUuTZyKRyFvww==
X-Received: by 2002:a63:1b65:: with SMTP id b37mr1815154pgm.453.1598889998794; 
 Mon, 31 Aug 2020 09:06:38 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/76] target/microblaze: Use DISAS_NORETURN
Date: Mon, 31 Aug 2020 09:05:11 -0700
Message-Id: <20200831160601.833692-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both exceptions and gen_goto_tb do not return.  Use the
official DISAS_NORETURN enumerator for this case.
This eliminates all use of DISAS_TB_JUMP.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0c9b4ffa5a..53ca0bfb38 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -51,7 +51,6 @@
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
-#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
@@ -111,7 +110,7 @@ static void gen_raise_exception(DisasContext *dc, uint32_t index)
 
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    dc->is_jmp = DISAS_UPDATE;
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_raise_exception_sync(DisasContext *dc, uint32_t index)
@@ -149,6 +148,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
         tcg_gen_movi_i32(cpu_pc, dest);
         tcg_gen_exit_tb(NULL, 0);
     }
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 /*
@@ -1675,7 +1675,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                 } else if (dc->jmp == JMP_DIRECT) {
                     t_sync_flags(dc);
                     gen_goto_tb(dc, 0, dc->jmp_pc);
-                    dc->is_jmp = DISAS_TB_JUMP;
                 } else if (dc->jmp == JMP_DIRECT_CC) {
                     TCGLabel *l1 = gen_new_label();
                     t_sync_flags(dc);
@@ -1684,8 +1683,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                     gen_goto_tb(dc, 1, dc->pc);
                     gen_set_label(l1);
                     gen_goto_tb(dc, 0, dc->jmp_pc);
-
-                    dc->is_jmp = DISAS_TB_JUMP;
                 }
                 break;
             }
@@ -1717,7 +1714,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     }
     t_sync_flags(dc);
 
-    if (unlikely(cs->singlestep_enabled)) {
+    if (dc->is_jmp == DISAS_NORETURN) {
+        /* nothing more to generate */
+    } else if (unlikely(cs->singlestep_enabled)) {
         TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
 
         if (dc->is_jmp != DISAS_JUMP) {
@@ -1730,16 +1729,14 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
             case DISAS_NEXT:
                 gen_goto_tb(dc, 1, npc);
                 break;
-            default:
             case DISAS_JUMP:
             case DISAS_UPDATE:
                 /* indicate that the hash table must be used
                    to find the next TB */
                 tcg_gen_exit_tb(NULL, 0);
                 break;
-            case DISAS_TB_JUMP:
-                /* nothing more to generate */
-                break;
+            default:
+                g_assert_not_reached();
         }
     }
     gen_tb_end(tb, num_insns);
-- 
2.25.1


