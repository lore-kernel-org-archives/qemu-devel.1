Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1581C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A7C20719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3CV60jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A7C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmoe-0001t0-Gd
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLC-0006Ez-UA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:30 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:39893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLA-00068a-5v
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:30 -0400
Received: by mail-pj1-x1032.google.com with SMTP id s2so22775pjr.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jA1f7A7ZHCufkuLSHghiR/JDH1zZqdVgsEJ9cK+3ePA=;
 b=F3CV60jvtEZM5+2d1lMfu24xJ7UAKLp7iODShEc2mjfDtMZ9+TM64wAsRHCsB3TT1g
 aMjpFspBop/OVnI4KyIjDQLYlKGHFG/Dv4xP6mKnjra/QWtJBDBg81WHrqezc+vCozEM
 EBLUvAdbD+Gi7PmJa74ISCGhYkk4MBcYIfCLRSZCLMvAB/RD3ARVpCM33JR3AzeebmoX
 UbIeAzD/xM4GMtNjsTsNKfP75lE+atGdQLJHeVQ8Uhx/f23/jjSIL5Q5VgB9Ymeu/zem
 qHICHkzSoxbBc6rgVaf49KtbeBKqgAJzNdz8TtWDDfdjrdevDTwC1HMtJ7c+6WpXjhBd
 +GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jA1f7A7ZHCufkuLSHghiR/JDH1zZqdVgsEJ9cK+3ePA=;
 b=V3ID0m8sqeyHwfe+plQ2GN5pauM5IseRQYuQ+Wm+CQy9rCLjbxSU+PwJZF0GpMxpja
 qhY+kygjnhBKCBaQQT39RYXVAMeB7qZu1fJkFjTQnCryWp41c+NsomO1kw2WkLFJtZVc
 8cHH6s0VptIlsAFA+9UFZGQy8k+dnQ6KkAAJv/ccLRRQKFttDM7eH57hWkmcW46+afc9
 V0AzAeLAFtSfDcdCl64xGnE4TInF+wtH+kK43C1+gtRBqyIF3L3m0KPVBZ/0X5wrdRmo
 oM+ta8IaF68l3JVUh27JW31jNLl1YpYoIhLTgH9yHxjKnOmnlDhNk45UQ/0ZZy6ol6vN
 gjpA==
X-Gm-Message-State: AOAM531JZ5joeIbKU+JMapjwO4DRklJjS8WL3W8nuznmcDplq74hId4T
 8iJVnPeglxmm0rQvjCDum/YdPdh1KtMRYA==
X-Google-Smtp-Source: ABdhPJystK+ptJud0yiveY2s7xJVY+x2ZL/CTJIlsck7onWH4DAFEHoldub4+kHQcYVMddh/7u41bA==
X-Received: by 2002:a17:90a:9b14:: with SMTP id
 f20mr87758pjp.214.1598890046306; 
 Mon, 31 Aug 2020 09:07:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/76] target/microblaze: Replace delayed_branch with
 tb_flags_to_set
Date: Mon, 31 Aug 2020 09:05:46 -0700
Message-Id: <20200831160601.833692-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

The multi-stage counter can be replaced by clearing D_FLAG,
the or'ing in tb_flags_to_set.  The jump then happens when
D_FLAG is finally cleared.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c0b586f467..811c92d23b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -73,7 +73,6 @@ typedef struct DisasContext {
     uint16_t imm;
 
     unsigned int cpustate_changed;
-    unsigned int delayed_branch;
     unsigned int tb_flags;
     unsigned int tb_flags_to_set;
     int mem_index;
@@ -1328,10 +1327,9 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
 
 static void dec_setup_dslot(DisasContext *dc)
 {
-    dc->delayed_branch = 2;
-    dc->tb_flags |= D_FLAG;
+    dc->tb_flags_to_set |= D_FLAG;
     if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
-        dc->tb_flags |= BIMM_FLAG;
+        dc->tb_flags_to_set |= BIMM_FLAG;
     }
 }
 
@@ -1343,7 +1341,6 @@ static void dec_bcc(DisasContext *dc)
     cc = EXTRACT_FIELD(dc->ir, 21, 23);
     dslot = dc->ir & (1 << 25);
 
-    dc->delayed_branch = 1;
     if (dslot) {
         dec_setup_dslot(dc);
     }
@@ -1419,7 +1416,6 @@ static void dec_br(DisasContext *dc)
         }
     }
 
-    dc->delayed_branch = 1;
     if (dslot) {
         dec_setup_dslot(dc);
     }
@@ -1633,8 +1629,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 
     dc->cpu = cpu;
     dc->tb_flags = dc->base.tb->flags;
-    dc->delayed_branch = !!(dc->tb_flags & D_FLAG);
-    dc->jmp = dc->delayed_branch ? JMP_INDIRECT : JMP_NOJMP;
+    dc->jmp = dc->tb_flags & D_FLAG ? JMP_INDIRECT : JMP_NOJMP;
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
     dc->ext_imm = dc->base.tb->cs_base;
@@ -1705,11 +1700,11 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         tcg_gen_discard_i32(cpu_imm);
     }
 
-    dc->tb_flags &= ~IMM_FLAG;
+    dc->tb_flags &= ~(IMM_FLAG | BIMM_FLAG | D_FLAG);
     dc->tb_flags |= dc->tb_flags_to_set;
     dc->base.pc_next += 4;
 
-    if (dc->delayed_branch && --dc->delayed_branch == 0) {
+    if (dc->jmp != JMP_NOJMP && !(dc->tb_flags & D_FLAG)) {
         if (dc->tb_flags & DRTI_FLAG) {
             do_rti(dc);
         }
@@ -1719,8 +1714,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         if (dc->tb_flags & DRTE_FLAG) {
             do_rte(dc);
         }
-        /* Clear the delay slot flag.  */
-        dc->tb_flags &= ~D_FLAG;
         dc->base.is_jmp = DISAS_JUMP;
     }
 
-- 
2.25.1


