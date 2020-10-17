Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951FAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6F12072C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOGUa/GV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6F12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmtb-0000Bj-AK
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoh-0002Kg-JH
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoe-0003mc-64
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id h5so6577179wrv.7
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EoLM8gvWk7ZVJDk5Ugq+9PdMiF3+TcSdw5xHGqfrZN8=;
 b=rOGUa/GVpWMOcktgSkuB/yxzdAsyiHmH8WeRr+G42/91mqh/buduQj09nZvxup5et1
 u/qTkDklO+uWDOA1MhcvHXo4gAo4TSZmQtgFYVcP1faOWampFErDr4Yga1mBdyUj3l1o
 GXa7Nn3Q6DsWux6hfvKDwuCF7feok3AUiLxLQoW7jFS25wnlVordSOa/o5PRkUC73+fN
 jA4Mpcf0WK3hFb6yEvtnbQYlEELkn2NxCdKiJWY7yozxppBcrpFtAShVTq5UwIu+ptyR
 ZuXDZMPsq2k8pK8ZeXkLOqjL8tsRiq0/lRXd7EvTXWqrsvN5ofEVKBQpNkt5xkTHSDnB
 MEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EoLM8gvWk7ZVJDk5Ugq+9PdMiF3+TcSdw5xHGqfrZN8=;
 b=pCPOWJEB5ZLZxSGdTcfjVWjrIrVre5/16geY/81sJfRBrimTuixFXLAg51EnM5ir5H
 hzLQZUQEykk6anjc56SuvylBUQbeNeWl8XFCytgSp/w9nP1goTPrXIa8hN7LDq2KvjY3
 vHk9XSH8FG0e9UjKBQk1BiqsfJlbxrSaARDNAIImOjlPnc/Hdxk7aZF7RxI9TLuhE5jw
 pOJq3yih6ryMFw5LFWe0xJ3tgKjX4e6YEUzVEJ7s7KFbK9NbWn+569a4wI8yig5pfiNK
 /EHNbqAVWf1SAq0IDUo38hI2jcJQOdk6ZNFSwhjA4BkSg8G3TE8Fccm3ISUidLWUBLCO
 fEaA==
X-Gm-Message-State: AOAM533W/iFdd+bajT/AcCfzRswCY/lVx1KXxrQ/T+rmV7fTmTOLMtx3
 BR5LskSLO05FzUYUkMkdQDg9B9o3OJk=
X-Google-Smtp-Source: ABdhPJxwfyxk+TXFvJ3itVfPw2N+gSVgFd4s6tmT4v7nboGFj6/glGu27R2NZAZZuC37M5cJK+kqQw==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr10140558wrn.35.1602943450064; 
 Sat, 17 Oct 2020 07:04:10 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id b63sm7974074wme.9.2020.10.17.07.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/44] target/mips/cpu: Calculate the CP0 timer period using
 the CPU frequency
Date: Sat, 17 Oct 2020 16:02:17 +0200
Message-Id: <20201017140243.1078718-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CP0 timer period is a function of the CPU frequency.
Start using the default values, which will be replaced by
properties in the next commits.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20201012095804.3335117-10-f4bug@amsat.org>
---
 target/mips/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 84b727fefa8..46188139b7b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -144,13 +144,13 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
  */
 #define CPU_FREQ_HZ_DEFAULT     200000000
 #define CP0_COUNT_RATE_DEFAULT  2
-#define TIMER_PERIOD_DEFAULT    10  /* 1 / (CPU_FREQ_HZ / CP0_COUNT_RATE) */
 
 static void mips_cp0_period_set(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
 
-    env->cp0_count_ns = TIMER_PERIOD_DEFAULT;
+    env->cp0_count_ns = muldiv64(NANOSECONDS_PER_SECOND, CP0_COUNT_RATE_DEFAULT,
+                                 CPU_FREQ_HZ_DEFAULT);
 }
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.26.2


