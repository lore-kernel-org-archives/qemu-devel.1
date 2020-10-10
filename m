Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951D4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312F02245F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6UP6D8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312F02245F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIlf-0000wA-AJ
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdu-0000fi-PZ
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdl-0003sI-Ve
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so13707948wre.4
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mo8sozT8Ds0POWKsTkBJwfxWCnr4o7uZvZTyjWCRQog=;
 b=D6UP6D8r6vRazkg7klsfufRkeM+Vep60YGqMMbJzfN8xXqq3iMdERCUbUOq7uWg90X
 gTldD0WM4YWdXqdzlXdX8IFKfizEIMZyn7nMYd4Sp7CxlvoGLtKhtmuqa5pkzzDFw56v
 4TChsldDL/4QEU0qendgau6cYKgjJ/gXF35YbFjI1dZezhyzefG6ADJy5TgQQ0KA2jAP
 qVfCO7DIBTITNMCKG2m84NnRbtByQosxgYZkFi7sEFpk+MUVnwr2OZasNKLn8bjNqJR1
 BV8XU9VJWKUDfkP4qcHXcMzNtHc6aqblWOsKsTwEJZZAU3uODhfiiM5Q55PsPk5IFSut
 10yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Mo8sozT8Ds0POWKsTkBJwfxWCnr4o7uZvZTyjWCRQog=;
 b=WNfB2TZF4p21EbZtC46F7HMw7CfmyKN29PK72VQWqRb2M6KYuvleGbJ/SkqIxDBIWb
 SRxNbukN30estleVJ4Ze4h9a0kVTbZvgBMkKaVak+0sxW0VKAbge39FxEXWzmxHmqLCo
 DQS0KM22CkarACLp9pKvOl+GK2Q/LPpF1/NgdjQnq7DsgJCjEHMI3/eKjVsSpnjxGBL1
 qLbri5TE3TZTb6kQWuIKq2YKNJRxFnlJlOhse83AAZTG6jhkdacOUEJtzlNjykfsSpCD
 bOZAikhnpXM9FTVaUa6HRVA4g3ZhvPFn26PUyUQ4KW6uGXvcFv5okR20nQ15Ih/lDSHg
 3OBA==
X-Gm-Message-State: AOAM532tDkoL7/MEBzE8PW5/F2RHzIJQoF+RjzUL/nQaX3R96t01YlVz
 QLI0qZO9aZ90qriaK0V+uz7mLW0YlEU=
X-Google-Smtp-Source: ABdhPJw//C9ZEgL09JdhvBjlMYTCXXIcq+twNW00ByTKaN/V5tdaamNFbv2tahDokYLhWsOUPSK+lg==
X-Received: by 2002:adf:bacc:: with SMTP id w12mr11548881wrg.66.1602350800614; 
 Sat, 10 Oct 2020 10:26:40 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/20] hw/mips/jazz: Correct CPU frequencies
Date: Sat, 10 Oct 2020 19:26:12 +0200
Message-Id: <20201010172617.3079633-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Magnum 4000PC CPU runs at 100 MHz, and the Acer PICA-61
CPU at ~134 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/jazz.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 47723093b63..a506cacd5a7 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -45,6 +45,7 @@
 #include "hw/audio/pcspk.h"
 #include "hw/input/i8042.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-clock.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
@@ -145,6 +146,7 @@ static void mips_jazz_init(MachineState *machine,
     MIPSCPU *cpu;
     CPUClass *cc;
     CPUMIPSState *env;
+    Clock *cpuclk;
     qemu_irq *i8259;
     rc4030_dma *dmas;
     IOMMUMemoryRegion *rc4030_dma_mr;
@@ -163,6 +165,13 @@ static void mips_jazz_init(MachineState *machine,
     MemoryRegion *bios2 = g_new(MemoryRegion, 1);
     SysBusESPState *sysbus_esp;
     ESPState *esp;
+    static const struct {
+        unsigned freq_hz;
+        unsigned pll_mult;
+    } ext_clk[] = {
+        [JAZZ_MAGNUM] = {50000000, 2},
+        [JAZZ_PICA61] = {33333333, 4},
+    };
 
     if (machine->ram_size > 256 * MiB) {
         error_report("RAM size more than 256Mb is not supported");
@@ -170,7 +179,12 @@ static void mips_jazz_init(MachineState *machine,
     }
 
     /* init CPUs */
-    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+    cpu = MIPS_CPU(object_new(machine->cpu_type));
+    cpuclk = clock_new(OBJECT(machine), "cpuclk-out");
+    clock_set_hz(cpuclk,
+                 ext_clk[jazz_model].freq_hz * ext_clk[jazz_model].pll_mult);
+    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
-- 
2.26.2


