Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A54DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52C92073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiJULW20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52C92073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmZm-0003LW-1m
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKx-0005m9-Ly
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:15 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:46348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKv-00065f-BR
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:15 -0400
Received: by mail-pg1-x52f.google.com with SMTP id 31so821045pgy.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6UAW/LQVnNBBxfSRwX11wMrvT5qNSW3Igjwiwe99RIE=;
 b=EiJULW20SvMhyeruN+0+K4w63UPacbSAHPYsi4E+WLnH8BmlPXu19iH6R1ft1F9Lq2
 DdoW+xk7fBQEERNOkqnn4fekIOeJMS1lDZciOQzfVGOBNXNYgW/tSWmMrDwscUOYmr42
 syR0i8KCuaOH5pdUbBHx8l9/nxXVLZtAEzYJ6BH66Sq9Ow3DnOEfpgi429bzV2xUUI5H
 K1/O1Td8vbF0ccqsl7k+vGFh29WV1Ayv62rjyRecoBB1HaoxD+IKSGq2KDYXr0W1e3Ls
 bx4IbfMN2dseSIKGbjPmpEwbfKyGnoEgn0+AJPJnGTD6Fdr2JqBX5IoaurrwJ5fwPIT+
 /eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6UAW/LQVnNBBxfSRwX11wMrvT5qNSW3Igjwiwe99RIE=;
 b=Oqe3BaNIv2NPBjreHwr2eEUdvApaLBVS0/fNq9+br64t16KsoDQhTP/6hQ55kUwO/d
 y6Qul3VDm5YTb8T9KpVc0SCmOiAHCVqrXDBEhyCwevt15OD38OmkhQikZWXmtGHYB8nM
 h/7SBUWNDP+5H+z85SPaV1TAj3/OIuO29oQGVCau70VvIpwglzLTLVwVWRPJh8dOWswu
 KuPHv6Xn9LsI9Q2V6U4A5vZEAnUEYVuCU84IukGpCFLeeiqOV+rzHsussBb84SwdWjlC
 6OvWg1GdWpW5zyAa2cgUJ4a0nKFSYlDBQ7hMe8UcRjCyqdwvb3tMBAFjTh6sT06OX8l0
 ekzw==
X-Gm-Message-State: AOAM533ScXbPG3a0vPGzmcknSXwZV8s4JTHMk0jgqBCsk2hqEbCV/XY+
 J3TZc7J+d+lPaBy8RxV8aOfAFaDy/accow==
X-Google-Smtp-Source: ABdhPJwknj2YsWbOfIczvmeDnrWMjtaB/oTkn3wdSrKbDLf2+eBuYMLJkJ1bUYjZeLQRLnxzMXQwSQ==
X-Received: by 2002:a63:511a:: with SMTP id f26mr1783362pgb.15.1598890031449; 
 Mon, 31 Aug 2020 09:07:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/76] target/microblaze: Replace MSR_EE_FLAG with MSR_EE
Date: Mon, 31 Aug 2020 09:05:35 -0700
Message-Id: <20200831160601.833692-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

There's no reason to define MSR_EE_FLAG; we can just use the
original MSR_EE define.  Document the other flags copied into
tb_flags with iflag to reserve those bits.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 4 +++-
 target/microblaze/translate.c | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 013858b8e0..594501e4e7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -254,7 +254,9 @@ struct CPUMBState {
 
     /* Internal flags.  */
 #define IMM_FLAG	4
-#define MSR_EE_FLAG     (1 << 8)
+/* MSR_EE               (1 << 8)  */
+/* MSR_UM               (1 << 11) */
+/* MSR_VM               (1 << 13) */
 #define DRTI_FLAG	(1 << 16)
 #define DRTE_FLAG	(1 << 17)
 #define DRTB_FLAG	(1 << 18)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 72541905ec..1f6731e0af 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -162,7 +162,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
  */
 static bool trap_illegal(DisasContext *dc, bool cond)
 {
-    if (cond && (dc->tb_flags & MSR_EE_FLAG)
+    if (cond && (dc->tb_flags & MSR_EE)
         && dc->cpu->cfg.illegal_opcode_exception) {
         gen_raise_hw_excp(dc, ESR_EC_ILLEGAL_OP);
     }
@@ -178,7 +178,7 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     int mem_index = cpu_mmu_index(&dc->cpu->env, false);
     bool cond_user = cond && mem_index == MMU_USER_IDX;
 
-    if (cond_user && (dc->tb_flags & MSR_EE_FLAG)) {
+    if (cond_user && (dc->tb_flags & MSR_EE)) {
         gen_raise_hw_excp(dc, ESR_EC_PRIVINSN);
     }
     return cond_user;
-- 
2.25.1


