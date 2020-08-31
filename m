Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25C9C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F3120719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eo0V4/Vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F3120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmhh-000538-SL
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKy-0005nh-GY
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:16 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:46350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKw-00065v-Mn
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:16 -0400
Received: by mail-pg1-x531.google.com with SMTP id 31so821100pgy.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pM4ivWigF6aGuCdn4jvlwQnVJrMGcBGI733lqrG0wt8=;
 b=eo0V4/VtOHM1WLUX8u1mPPtH4HcbQbO93GYkPjuc14JcxAKyPyGhWEnWE6Jg8m2lCe
 hzucK6vnsoY4UvHNCz0OBNTzuhqu3aUdAizlGcMdLUXHjsAcTv9ooOw6oZu6/WsR4DW5
 VLQ02C6BdUvf2Mr0vF+6xkhouKPOpTAA3iIZ23gjJs2+vFg1kYGbyqNWwAGgisH8YT7H
 94leYBUkLp96J/PfpmL9iy5YQTAtTwELumMYYrsXiDHItoiUp+49+kedSr6Pworb+A4T
 NvnhH2x6I+H3HGabPGsAWDm3fmJQ1Y4IqLQf0h78ztsrZQcUxlZWVtVPErBNjf6c5NtV
 oZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pM4ivWigF6aGuCdn4jvlwQnVJrMGcBGI733lqrG0wt8=;
 b=PNOgTakZbNg4Ay2cGrpSdZ/+e9CTrvraCjJ3yAk2ts9Hdhy+mna92Aw9TsQ0tEE+d6
 X38OK6sCD7mMxudwmY4c5fq46yKz180p/qPAnZwvp7ZVNuhReDfUfSWxfhr5KNSis4cs
 zWxRu5BYCh9YTlygmtF6jIjPmTm1QnismhFK626Hc1PKTnKyb0zcOaFjOMRFMIBNSuvs
 i/GDlVoqkuHZwXH/xakRvAkPDXTGoUjM17nA0svzYuCrgWj27nwvrdAFeqWcbKtvLs5A
 Y/kRRHJ8rQpTWpflrca+z/TtBPM+EbhzbQ7WzpvUMq/z/RY1mI4ynhKBovqW01/ziOsj
 YEuA==
X-Gm-Message-State: AOAM533EUwCC320kXcSeOhZsuHGrdnKwxdjsPZ9KcZRZeIEIQZdszT4D
 HPv7kdcLmoashw8mCDAs0jaTynZxvmoXbg==
X-Google-Smtp-Source: ABdhPJySy/52fa/mjP+R9XffyDmGbouX92CKqdSdx84pqgjMFx5A8jV09hupKEwCZEE8nTeQ+3rFfA==
X-Received: by 2002:a62:406:: with SMTP id 6mr1762033pfe.193.1598890032881;
 Mon, 31 Aug 2020 09:07:12 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/76] target/microblaze: Cache mem_index in DisasContext
Date: Mon, 31 Aug 2020 09:05:36 -0700
Message-Id: <20200831160601.833692-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Ideally, nothing outside the top-level of translation even
has access to env.  Cache the value in init_disas_context.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 1f6731e0af..a55e110171 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -73,6 +73,7 @@ typedef struct DisasContext {
     unsigned int delayed_branch;
     unsigned int tb_flags, synced_flags; /* tb dependent flags.  */
     unsigned int clear_imm;
+    int mem_index;
 
 #define JMP_NOJMP     0
 #define JMP_DIRECT    1
@@ -175,8 +176,7 @@ static bool trap_illegal(DisasContext *dc, bool cond)
  */
 static bool trap_userspace(DisasContext *dc, bool cond)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-    bool cond_user = cond && mem_index == MMU_USER_IDX;
+    bool cond_user = cond && dc->mem_index == MMU_USER_IDX;
 
     if (cond_user && (dc->tb_flags & MSR_EE)) {
         gen_raise_hw_excp(dc, ESR_EC_PRIVINSN);
@@ -968,7 +968,7 @@ static void dec_load(DisasContext *dc)
     TCGv addr;
     unsigned int size;
     bool rev = false, ex = false, ea = false;
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
+    int mem_index = dc->mem_index;
     MemOp mop;
 
     mop = dc->opcode & 3;
@@ -1077,7 +1077,7 @@ static void dec_store(DisasContext *dc)
     TCGLabel *swx_skip = NULL;
     unsigned int size;
     bool rev = false, ex = false, ea = false;
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
+    int mem_index = dc->mem_index;
     MemOp mop;
 
     mop = dc->opcode & 3;
@@ -1540,6 +1540,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
     dc->r0_set = false;
+    dc->mem_index = cpu_mmu_index(&cpu->env, false);
 
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
     dc->base.max_insns = MIN(dc->base.max_insns, bound);
-- 
2.25.1


