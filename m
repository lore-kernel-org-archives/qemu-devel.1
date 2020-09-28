Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F96C47423
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698A5214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/YdCGJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698A5214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwrB-0004JP-0S
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwku-0004Ej-A0
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkq-0006NS-Mp
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id q9so1916691wmj.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uhC23dUUPkQ40iTxJhxCRMNPOJybeztFMaD2OSBjyX4=;
 b=f/YdCGJM8NPUUFmvb5OuyUZZnIedN0v1eM3D7i4SIYDGqOeHJxdT+YXZReln6Bju2A
 nJ2ubmNYEDgKpQjvZ7inDY62XgJEZVYG+j9CShf+Gfsa5LXdQvG/sBaPZ5bjBvMpvd1Z
 He1oWXfHu2XE5Tx401bxB6MBrPeAkN63mqtxJtPzJIzoPLJW4Pw8o3A5gteucoRaNFis
 lC9sW9XqEIgaVJ5NEqX4qgekGCDFOfglWaJdOycEpcvuUsCOAXiaJ+0SSy3Oj9J/U9/J
 GQhU2NSB5E3BdeM6dADaI1iZlIIhcIPylU5256J+J12vzxJ9WNaLUiwcwCGnojb2435B
 qpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uhC23dUUPkQ40iTxJhxCRMNPOJybeztFMaD2OSBjyX4=;
 b=I7HqAFX5fRm+4W/rlgAn7W+BjHBeUBXmpG6Oto/Hs0GbF2tGJgvo/BcV/FDEuYlmwb
 DLEMpGiTiQdvfGcd8lA5dDFu7syn4W5dTHfFHx4p5FvqTyz9bnLmnLnxEtCEY3mFS5xI
 BN4h4JjthTZbzHaOC0m3VCGqL3aKsck7bJdrfrQpnvqJYlWuFNSgqiaNh76XTJ2suAiq
 uOP/PEjeH8l5N15fvFJB2yHmn8NdZfUJjMrBQkKP/vFnSWh5lNs5FWyMHqxveuWLT63t
 hsqV6aiAfwB0tt7zmgxyHESp9XzxFCpG35AvI77cBtWflPynxtFHcQYWKe49dyddcrRY
 bt9w==
X-Gm-Message-State: AOAM530dIRvltnkrpE3r0xkGdutM++FjeZtsESNyihkAx8K1nXWFw8AY
 sUrMt15/yeCw7mDungsUknJyRbGiD28=
X-Google-Smtp-Source: ABdhPJzdqd/3Wb0bQQFh6lPttthbvdh9Qb4V4OgLT0LlbuKoDPyXoXclmNlZtFh0ZZIGBLMhBIEuGw==
X-Received: by 2002:a05:600c:220f:: with SMTP id
 z15mr184723wml.87.1601313358915; 
 Mon, 28 Sep 2020 10:15:58 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/16] hw/mips/jazz: Correct CPU frequencies
Date: Mon, 28 Sep 2020 19:15:33 +0200
Message-Id: <20200928171539.788309-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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
index 47723093b63..eee79d5b47d 100644
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
+    cpuclk = qdev_init_clock_out(DEVICE(cpu), "cpuclk");
+    clock_set_hz(cpuclk,
+                 ext_clk[jazz_model].freq_hz * ext_clk[jazz_model].pll_mult);
+    qdev_connect_clock_in(DEVICE(cpu), "clk", cpuclk);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
-- 
2.26.2


