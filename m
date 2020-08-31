Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79491C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3836D20719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1UuJNZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3836D20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmhq-00059n-9t
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL4-00061q-4U
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:22 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL2-00067k-9r
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id b124so794988pfg.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9yukNREp9KLx7ngPQjIPDt7zSrwG6GvjIbptJAOWSaU=;
 b=S1UuJNZgcEJpKE9BCCMllrjEz+ym5UOpgwvm0aohS/w+SqoiWqqSDj1lZHKM0XlTHh
 1tHf2Zm1IJryROZkrjHsqmcKW4ZCc9NkUfZJI8AGi6KgnbEOd/5SXXGDyCSNwNhZ3ydO
 zR5OjdQHiB2m6kU5aRcllqRJVtEEXKk/xXluyCuS/YOeNb2+s1+7zGBzfp2hUZQDRrm8
 52hxWsTRjM4z/lwcJXSxI2ZkDYRjcRtdMAzYUgEYJLn73RB2xUh5xwWZ/7AnR/o0Ov+L
 xpjzufxA1LYso56u/9Zdg1aItJfvPb4PpaotgssZK+1+Ya5EjbiBiGAry8IdjNriftQv
 PKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9yukNREp9KLx7ngPQjIPDt7zSrwG6GvjIbptJAOWSaU=;
 b=JKte2rFEe+M1RZaeYerptUFtTkgH0IwE7GkTnMRNHUQEmMcBp8roUqDBk+18tnx+4N
 HGyT/Burv5f0U1qshFJ/1mtJKQ60/r4DfJpMmJtRnm2jvdVZNlVj6azju+EvbFnZXCvV
 xvY1Ib4JMZ49d/BqrDumEPwecWg6BWYUzdOncR3elbTzDoufy3GWMe0YHXhZOmJeXCac
 kUQCwqV9bUnC1/+xzTOQHM7dtHs/OsFlwzx9p1jAP8DpGQ4rRkMZcrEV7S+7X8KqX0mv
 /4dtfgSxdwW/KwmBUC0czjeYeYpGqJ+m9AQuMUtDePita1crSlNA43EQ/pbjjc9s78Uc
 n63w==
X-Gm-Message-State: AOAM533Z+BUsLt3frszq9GETDhyAzszjXSD3w2ugEvJfUrU5Uufe+nno
 NA2xFUe745ZOnjrc3HUhDyqauW7u775unQ==
X-Google-Smtp-Source: ABdhPJyCIl2//S1sme32PHVoesqNPnzRJdjlq9iLxNofGGl6XXcxT0a6Km984/SoLWkOuqzFmxGuyw==
X-Received: by 2002:aa7:96b0:: with SMTP id g16mr1875113pfk.46.1598890038007; 
 Mon, 31 Aug 2020 09:07:18 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/76] target/microblaze: Move bimm to BIMM_FLAG
Date: Mon, 31 Aug 2020 09:05:40 -0700
Message-Id: <20200831160601.833692-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

It makes sense to keep BIMM with D_FLAG, as they can be written
back to iflags at the same time.  BIMM_FLAG does not need to be
added to IFLAGS_TB_MASK because it does not affect the next TB,
only the exception path out of the current TB.  Renumber IMM_FLAG,
as the value 4 holds no particular significance; pack these two
flags at the bottom of the bitfield.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  4 ++--
 target/microblaze/helper.c    |  2 +-
 target/microblaze/translate.c | 12 +++++-------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 2fc7cf26f1..a5df1fa28f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -231,7 +231,6 @@ typedef struct CPUMBState CPUMBState;
 struct CPUMBState {
     uint32_t btaken;
     uint32_t btarget;
-    uint32_t bimm;
 
     uint32_t imm;
     uint32_t regs[32];
@@ -253,7 +252,8 @@ struct CPUMBState {
     uint32_t res_val;
 
     /* Internal flags.  */
-#define IMM_FLAG	4
+#define IMM_FLAG        (1 << 0)
+#define BIMM_FLAG       (1 << 1)
 /* MSR_EE               (1 << 8)  */
 /* MSR_UM               (1 << 11) */
 /* MSR_VM               (1 << 13) */
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index f8e2ca12a9..06f4322e09 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -166,7 +166,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
                 /* Reexecute the branch.  */
                 env->regs[17] -= 4;
                 /* was the branch immprefixed?.  */
-                if (env->bimm) {
+                if (env->iflags & BIMM_FLAG) {
                     env->regs[17] -= 4;
                     log_cpu_state_mask(CPU_LOG_INT, cs, 0);
                 }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index d2baa7db0e..97a436c8d5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1351,13 +1351,11 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
 
 static void dec_setup_dslot(DisasContext *dc)
 {
-        TCGv_i32 tmp = tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG));
-
-        dc->delayed_branch = 2;
-        dc->tb_flags |= D_FLAG;
-
-        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUMBState, bimm));
-        tcg_temp_free_i32(tmp);
+    dc->delayed_branch = 2;
+    dc->tb_flags |= D_FLAG;
+    if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
+        dc->tb_flags |= BIMM_FLAG;
+    }
 }
 
 static void dec_bcc(DisasContext *dc)
-- 
2.25.1


