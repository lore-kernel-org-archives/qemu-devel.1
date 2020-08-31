Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCBEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B3120719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GejGOa5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B3120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmnH-0007ew-Q6
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLC-0006Ej-8k
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:30 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL8-00068V-LT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:29 -0400
Received: by mail-pg1-x544.google.com with SMTP id g29so843674pgl.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HE8Wik9vttKTZZENz5zVdtMEhiCJ7C/1UlGJaVpED9U=;
 b=GejGOa5tD4nNLq3MjRuxcqGWZynkrKKlL80BiRBXfkwhCByzj9HYKafVw5HDHneVKo
 m1Ndq/hTKE0ouNYm1JaPFF9WwZYSfKdXDktSMHREzWgIiQ/VllYm/mLS8kiCuXHZeRtj
 Ne8W+RgwkYmVO/Dqqx9otxn+gfhVT6ZuReBqYQ+QBVSjbFWIy/ZF8lK3zs/CE0a++nx8
 qZsfLTflRIvAlWrK37g2RJO3hLe0YxDqGDPTy6tPH1eeee9iHpTJ6HjkBYO1PCkY18cH
 WWzi2kVU5/xSeeI0+VZ1lV4R5PllF+QGkFhbwC0XYP1H3GDK9S9ZmiX71d6c6Mi+vWqG
 zLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HE8Wik9vttKTZZENz5zVdtMEhiCJ7C/1UlGJaVpED9U=;
 b=q4oas1AkJT2/DXTZsCOfHbrQ1bR2k9j6dlBj5FiHxfX6/NPvhyIbSnmSYW8C2n4h2i
 19YgPD3GHzP1JxEva07Gl94euN+ewFuKe7LJyMQ4LLkfRqNuoPNTdqkbSeHFs2TSrSCi
 BgB06MOiUxJqYQr/6pryituqDKoDrkAEd7x6tcsvEDabkAJgH201XBWjm3h9qbNePOP1
 5mVLhoXwgJSEniv52M9dQZSG3ijktlTmF20CU0GCkCwmIdj9Q/bDwzKQliVLmbNdAoDC
 oqDC1dnD4RjPV+Wrs4zlZWzf1XUsREg3qzrkmEMn4rRYg7t7in10+E7L7E2ngEjZ9mOH
 +SCw==
X-Gm-Message-State: AOAM533c6rRrplICqO5gfI7th2icvizO2/LfAn5fbPeh34dL9eWz+FVv
 PiA/73DTZfsT5p7Ldeb3ollnPKcOHvPVkQ==
X-Google-Smtp-Source: ABdhPJwYXNtqG/e9oHJlCU0Uh6lnOONfCNWV2CZyVPYdnoEJs+/k0UW2URkyKMlpDDGM9tG7E+LJ5w==
X-Received: by 2002:a63:b24b:: with SMTP id t11mr1747404pgo.233.1598890044938; 
 Mon, 31 Aug 2020 09:07:24 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/76] target/microblaze: Replace clear_imm with tb_flags_to_set
Date: Mon, 31 Aug 2020 09:05:45 -0700
Message-Id: <20200831160601.833692-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This more general update variable will be able to handle
delay slots as well.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 597b96ffb3..c0b586f467 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -75,7 +75,7 @@ typedef struct DisasContext {
     unsigned int cpustate_changed;
     unsigned int delayed_branch;
     unsigned int tb_flags;
-    unsigned int clear_imm;
+    unsigned int tb_flags_to_set;
     int mem_index;
 
 #define JMP_NOJMP     0
@@ -535,8 +535,7 @@ static bool trans_imm(DisasContext *dc, arg_imm *arg)
 {
     dc->ext_imm = arg->imm << 16;
     tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
-    dc->tb_flags |= IMM_FLAG;
-    dc->clear_imm = 0;
+    dc->tb_flags_to_set = IMM_FLAG;
     return true;
 }
 
@@ -1688,7 +1687,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
                   (uint32_t)dc->base.pc_next);
     }
 
-    dc->clear_imm = 1;
+    dc->tb_flags_to_set = 0;
+
     ir = cpu_ldl_code(env, dc->base.pc_next);
     if (!decode(dc, ir)) {
         old_decode(dc, ir);
@@ -1700,10 +1700,13 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         dc->r0_set = false;
     }
 
-    if (dc->clear_imm && (dc->tb_flags & IMM_FLAG)) {
-        dc->tb_flags &= ~IMM_FLAG;
+    /* Discard the imm global when its contents cannot be used. */
+    if ((dc->tb_flags & ~dc->tb_flags_to_set) & IMM_FLAG) {
         tcg_gen_discard_i32(cpu_imm);
     }
+
+    dc->tb_flags &= ~IMM_FLAG;
+    dc->tb_flags |= dc->tb_flags_to_set;
     dc->base.pc_next += 4;
 
     if (dc->delayed_branch && --dc->delayed_branch == 0) {
-- 
2.25.1


