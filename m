Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A6B207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOmNf+rC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A6B207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLuh-0006SD-P8
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLia-0000sM-8Q
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiU-0007WG-C1
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id d3so13267541wma.4
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0r12VoVMUTuY3t4zO68E4z3Dus4xytIOTYR5/hVgU8s=;
 b=OOmNf+rCJsuY+oq6W29mMirFbIEhjXNPoadgfx2xZYsCkRPnoich8ikQFilhLEHyN3
 jFdsNfI/v3EFTG/rSCKIjxQFPjKsnkrWyCjUyPIEN7jfp+Xv3iY3wdSGw+rAiQLsx3L/
 0m5uelrWaTSWq3djm6f9qLKfnytoJfKcCaXZDRYD6ubg/lDFF4rqpJ1s1eKp4EJt22Zg
 Zf10ZTkxDS3FgmhYEqfBVwDHou23eG+I1Jtrj6CUscx6o1Q7LFqObF8lntiosgUlcJIp
 TyBEmOxQKKWz3d3yL8tMv/8/P0UDun7fzJCg+bWI5uuqc+NVU6xSUzT8UI/RPAeDXgUn
 SseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0r12VoVMUTuY3t4zO68E4z3Dus4xytIOTYR5/hVgU8s=;
 b=oFrjdRBuNQal8YzRHFn7Hlu7zjjuO3dtXD+IeFrKxBSZWRYQJM3EploIa/+idgxFsc
 NvhURvlVBEokI8LZHUJhSLi2/iAK6Z3S0EDcZtEcSl+u/p3ODxfZb6ja1pgU3KSgtedQ
 7MynJIGbNT3bxbTta0HvlOXr+sgcKJyRO0JyAOU7YwsJze8U7xBQAL82socU9yEGgUW3
 Sj0a8oE1fFLDGN1ke1cwoyZd2iDMzbh5DN/QxkWK9mN7AFyGy9l7ZgEJ1JE2q2sgVQDf
 1eEXiwKFnqF0Q+NmDxyyDOzu2Q0Rer8HDu0qdwAWrqd9IQssgJ4gCoFt/16C/tqLdM9h
 644w==
X-Gm-Message-State: AOAM533QWY66A9tE7ByONwCZxXfKq0Gal8InTtXM2YzPkqsjdrQqQqgL
 JhvTaLvCX+TufNYqnNKxWH+imywYY/w=
X-Google-Smtp-Source: ABdhPJxKRQc9S/7ZR4utn9z55DkplkzkYAI90A8n47/cv+NT0DAgKje7aYoYZ/BXTZkkfrFgvDzmVQ==
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr4238892wmh.152.1602362622384; 
 Sat, 10 Oct 2020 13:43:42 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/20] hw/mips/jazz: Correct CPU frequencies
Date: Sat, 10 Oct 2020 22:43:14 +0200
Message-Id: <20201010204319.3119239-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
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
index 47723093b63..e56e36cf3f7 100644
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
+    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
+    clock_set_hz(cpuclk,
+                 ext_clk[jazz_model].freq_hz * ext_clk[jazz_model].pll_mult);
+    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
-- 
2.26.2


