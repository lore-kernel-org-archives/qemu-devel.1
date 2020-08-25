Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C1DC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C7E206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8Z2qsY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C7E206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgeh-0005dn-3m
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3w-0008WE-Am
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3t-0001zE-K8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id g33so7674069pgb.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=urcrD5NFXjwPKRscyzfCPuOFRd/yp7ofBRVH50uRonY=;
 b=C8Z2qsY7W3DgCrnXVzJA/tfYQkzOcZeSEpPy41F9NWTcSPTev5vDi2zhq0qOhfe6Xs
 PR35XOX2hkzwqiEmIwFLrsJLOj/RUZ21J+vB3Bjf9K6e6KMIAqMsq3bLAtQAVs+v8W+L
 uY8d1RPT2Cq6VvsjFSejeWPDHwjve2uJ5osmWRQPpzUDO0JpStlyDFedCBsaWXupXjxg
 9GYQoKM06FRokkE7NT6csaUJzP2dM6dAGahD0/W5SaMFevMc4C/C1AxE4zueIxffc5up
 7km7ruN4p69L8B1ezsTp9K4PPQQujEq4Vos+8M0L2O+OyGys7wdxsPyioNK1Tqb15GsS
 lpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=urcrD5NFXjwPKRscyzfCPuOFRd/yp7ofBRVH50uRonY=;
 b=VrkQ6lC3hKwCVdKLM2LZbGjJ1c7AguIHExKrkPKjxVHfUACfVM74JgCTKOfi15AzmA
 G4dDzbZTISsg0d+JLvB2n2HlQ5Ty2hXstYAv7WCKg/DKqgbu/RjHaAiP1B592sioXzWS
 WO4ImrRu6INb92d8vkC9cxGw6JH0XigojZTDQ25YnyMkNPgxqOMzjSRr/i66LS/8OeAs
 Bp6FTg0kxlZpU6u8JD2HtyyxPzkvrdhORIwNSBoZh1kaQXfj9KpIlXnHO8L7bSoLxewy
 vJvB8yXc23wWZZZ9j513/QiCyMfXUISiOd1WyktppFLSZZ868ircl6GWkU0ZAvn4Ll1O
 wTJQ==
X-Gm-Message-State: AOAM531HTfxdJFqYo+T7zHKYZ3+iW9ZgLDtezNhSww/6+MFYPvhoUM4H
 6me9EzutTG9fuWW/lhq4lH+oNxFFstZjOA==
X-Google-Smtp-Source: ABdhPJzkS8ll7HUSMh7X1UvTsWjO0CC5Mo4f5iANobusin1PDJXHqmItsDBPXF6Kbbinitczc1/Hsw==
X-Received: by 2002:a63:a119:: with SMTP id b25mr7908105pgf.10.1598389255978; 
 Tue, 25 Aug 2020 14:00:55 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 51/77] target/microblaze: Cache mem_index in DisasContext
Date: Tue, 25 Aug 2020 13:59:24 -0700
Message-Id: <20200825205950.730499-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ideally, nothing outside the top-level of translation even
has access to env.  Cache the value in init_disas_context.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index cb490488a6..8a251b35d9 100644
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
@@ -954,7 +954,7 @@ static void dec_load(DisasContext *dc)
     TCGv addr;
     unsigned int size;
     bool rev = false, ex = false, ea = false;
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
+    int mem_index = dc->mem_index;
     MemOp mop;
 
     mop = dc->opcode & 3;
@@ -1063,7 +1063,7 @@ static void dec_store(DisasContext *dc)
     TCGLabel *swx_skip = NULL;
     unsigned int size;
     bool rev = false, ex = false, ea = false;
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
+    int mem_index = dc->mem_index;
     MemOp mop;
 
     mop = dc->opcode & 3;
@@ -1532,6 +1532,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
     dc->r0_set = false;
+    dc->mem_index = cpu_mmu_index(&cpu->env, false);
 
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
     dc->base.max_insns = MIN(dc->base.max_insns, bound);
-- 
2.25.1


