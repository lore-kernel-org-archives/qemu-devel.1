Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D39DECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6D6206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qU3xCe+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6D6206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxlZ-0006RP-RC
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxH1-0002jl-2A
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxH0-0007qu-29
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:10 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:36711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGz-0007qT-Ul
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:10 -0400
Received: by mail-yw1-xc43.google.com with SMTP id x64so3651906ywg.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0kUXqC720LILsCV2g+/0quuhAdJiaFyOvoOqO9J/BUY=;
 b=qU3xCe+rTvxtcdUGZdLBjsDDrxtB0ERic7bACzJDH3nvPWQCgZ8IPfp3NJjpuHnjGS
 z9irNej9DIL1eMEMbJNRvVgDZFygYAAw4rKA6yP72Ku40VmNgLBEOsimqRLauFKI6icg
 1540DitB4QwfHSRdu5294JNAWRg0aHJzbwZvnwcE+iWPovstFudWJ/GusjkHJ9kQeZ4Q
 l4oYB+CjGlbCgD3XaZb8v8UfsFyz6429JfK+1U6Q/nWWkT9Ptc/tMfvnOquEhbfrP5cP
 x45f4Cznm8KjDPFV/8p/7Ee4/KN36IDHkY3P+BbE03+EcPVM6r/Fx3LZZ2+BxsSaFenC
 74fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0kUXqC720LILsCV2g+/0quuhAdJiaFyOvoOqO9J/BUY=;
 b=cqLQMgkR1jV/ObjnqpDyi2TypaKL5/iDmFL27vFJ3mmiTiyDNTCbHp6vMYn7+cqBsg
 dhyjYeuiuAAxuakd4dQvHfBDveClhflO0bJdm5O5WwlpuwpIghyli//sLpkVk55+BOLm
 Ate+j6yMMr6b7u8LHoZAgQI6ERcfPaUHeGkFTGXDAmHRiPwbR5HGBFbCxDqOsQBHBNGy
 a6fvyRVgifjnWUmRU5ugTzaCQ+et6uVva4e1CzQaOS2+yNOoE+ijPQXo7FcPCnPxmsGl
 rBubtqG4P9/0IgBdeGGmqNeSblP64scCpCwKy8Er8VBbOaViiejjS4sroyVe6wAv42rq
 z9nw==
X-Gm-Message-State: APjAAAUqubeuqToTha9ozUnQnm++2AthaX0d0zNk5eL+GC/i7BrWNF0P
 /wDQWrMGFe10IxSaondfD2CJ2Kf7DeE=
X-Google-Smtp-Source: APXvYqz2mDccZd7OdJUzY7+c2+UUgjPxfc/jkJ1PF1Vi6uohBO+kPb3hJowce7ERp1aaUROqzSIF/A==
X-Received: by 2002:a0d:c646:: with SMTP id i67mr2985197ywd.499.1570809369038; 
 Fri, 11 Oct 2019 08:56:09 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:56:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 18/20] target/arm: Rebuild hflags at CPSR writes
Date: Fri, 11 Oct 2019 11:55:44 -0400
Message-Id: <20191011155546.14342-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index ccc2cecb46..b529d6c1bf 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -224,6 +224,7 @@ uint32_t HELPER(usat16)(CPUARMState *env, uint32_t x, uint32_t shift)
 void HELPER(setend)(CPUARMState *env)
 {
     env->uncached_cpsr ^= CPSR_E;
+    arm_rebuild_hflags(env);
 }
 
 /* Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
@@ -387,6 +388,8 @@ uint32_t HELPER(cpsr_read)(CPUARMState *env)
 void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     cpsr_write(env, val, mask, CPSRWriteByInstr);
+    /* TODO: Not all cpsr bits are relevant to hflags.  */
+    arm_rebuild_hflags(env);
 }
 
 /* Write the CPSR for a 32-bit exception return */
-- 
2.17.1


