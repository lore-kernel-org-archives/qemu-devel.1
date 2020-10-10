Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32CCC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3595B22470
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRNurP37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3595B22470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIuV-0003D6-8y
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdz-0000iT-OJ
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdw-0003sf-TJ
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id x7so5082488wrl.3
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dmH1PdHA/1En+SEzSBgyyb1Sf53UufFVZ9n5a0/mMSE=;
 b=bRNurP37e66I9P1bx2It5L7GPBYBltasOd3VaM3lnpNyk5Aao6DCTyZ2FYq9PCMkYc
 kZVzBBZrEFFcYEAL/tv/f8gQlvDIRmiPJxbX1c7sMyh2wZkk4gln46xaZ0GU8x9Q7Ifo
 2Gy2ZGIi5Whxaw/Agdw65P5hBfP67QZmamp2W8/8AX7EDSaYxcar9Rwpm6sPnrwGa17i
 a881mE6L+9Fy5fUm8eQD4Z/DVIzvqtIO5oKkoy+x7/hMOIAH1h4ysPxq69wUM7v1VM1U
 GqFQU9wCV5HzhstQkvTsnZ/DkaEb3hSDbxqEFW9UTb6HMw8RGPZl7xoEu2OsRtY3/Dyj
 WkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dmH1PdHA/1En+SEzSBgyyb1Sf53UufFVZ9n5a0/mMSE=;
 b=pts5kQl0rEe1hNgq8KeHrjUe4tWVX4B3OMFC9JSezwoL8zsYPBfUEYBm2K17npFO0y
 8Ybs0R2+oIKk8x2j31F/5wnKX4aog92dWsElUlc+vs6lAIPaysGfqXGzDCYaEqfaBEAU
 8eTk7aH6QpzshEx7aU1Po+daKUcjIXOjZXqm6//LPSYGxAgWJjxHTm4hMl4mMYX/B2ok
 54KRVCX+8W772+Q8ZNHlRjxpjAoIht9Y+rqtcm7og+PH8wtJn98tBMefQwTtUL74MZQQ
 Fl7Y9vv/bKSgYAfb4T3Sg9jH8KwgUtiefPPwLisgk/QHI+hHLFpPBd+u0NV/WGiwIAe7
 wOtw==
X-Gm-Message-State: AOAM530tY8wwyZt+klP3zJLmoDLTZ3SyKaFWdhx2eItZT5peBBwJxZnS
 pZNB9dINBtMwiXKPgQjk/jsjZPssZAQ=
X-Google-Smtp-Source: ABdhPJxgDQLD8niyH1xw5l/wjfdv7zr3eFiwLwQgIJqfJ663DXZ8GN8Eo2GQRxxWoIno9DOw5VkFSw==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr20915934wrm.295.1602350804126; 
 Sat, 10 Oct 2020 10:26:44 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/20] hw/mips/malta: Set CPU frequency to 320 MHz
Date: Sat, 10 Oct 2020 19:26:15 +0200
Message-Id: <20201010172617.3079633-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

The CoreLV card with ID 0x420's CPU clocked at 320 MHz. Create
a 'cpuclk' output clock and connect it to the CPU input clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 4019c9dc1a8..c1e8fceeea7 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -57,6 +57,7 @@
 #include "sysemu/kvm.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/mips/cps.h"
+#include "hw/qdev-clock.h"
 
 #define ENVP_ADDR           0x80002000l
 #define ENVP_NB_ENTRIES     16
@@ -94,6 +95,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(MaltaState, MIPS_MALTA)
 struct MaltaState {
     SysBusDevice parent_obj;
 
+    Clock *cpuclk;
     MIPSCPSState cps;
     qemu_irq i8259[ISA_NUM_IRQS];
 };
@@ -1159,7 +1161,7 @@ static void main_cpu_reset(void *opaque)
     }
 }
 
-static void create_cpu_without_cps(MachineState *ms,
+static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
                                    qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     CPUMIPSState *env;
@@ -1167,7 +1169,9 @@ static void create_cpu_without_cps(MachineState *ms,
     int i;
 
     for (i = 0; i < ms->smp.cpus; i++) {
-        cpu = MIPS_CPU(cpu_create(ms->cpu_type));
+        cpu = MIPS_CPU(object_new(ms->cpu_type));
+        qdev_connect_clock_in(DEVICE(cpu), "clk", s->cpuclk);
+        qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -1189,6 +1193,7 @@ static void create_cps(MachineState *ms, MaltaState *s,
                             &error_fatal);
     object_property_set_int(OBJECT(&s->cps), "num-vp", ms->smp.cpus,
                             &error_fatal);
+    qdev_connect_clock_in(DEVICE(&s->cps), "clk", s->cpuclk);
     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
@@ -1203,7 +1208,7 @@ static void mips_create_cpu(MachineState *ms, MaltaState *s,
     if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(ms->cpu_type)) {
         create_cps(ms, s, cbus_irq, i8259_irq);
     } else {
-        create_cpu_without_cps(ms, cbus_irq, i8259_irq);
+        create_cpu_without_cps(ms, s, cbus_irq, i8259_irq);
     }
 }
 
@@ -1421,10 +1426,19 @@ void mips_malta_init(MachineState *machine)
     pci_vga_init(pci_bus);
 }
 
+static void mips_malta_instance_init(Object *obj)
+{
+    MaltaState *s = MIPS_MALTA(obj);
+
+    s->cpuclk = qdev_init_clock_out(DEVICE(obj), "cpuclk-out");
+    clock_set_hz(s->cpuclk, 320000000); /* 320 MHz */
+}
+
 static const TypeInfo mips_malta_device = {
     .name          = TYPE_MIPS_MALTA,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MaltaState),
+    .instance_init = mips_malta_instance_init,
 };
 
 static void mips_malta_machine_init(MachineClass *mc)
-- 
2.26.2


