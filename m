Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0012C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D520207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfSXBCwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D520207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLxb-0002bf-Hf
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLib-0000wS-M4
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiZ-0007Wn-VG
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id n6so13858133wrm.13
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XRaXNqZj1/ZpqBQYjItAcS8COgAJ0fcoH+Bv4m/WMkU=;
 b=DfSXBCwFkm7AU7OIi7r40sbkp4c8IHjKeJz3mLwgCHcEg4QkLnvmP9w3p7ojnyc0IF
 uSLy2EnaZqFrfPO6NdT2TW2g/V3S5yCtaWUaEBMix6Q/LY+M0DmbYfZIMeA4m0sLImW4
 bkYJ0afEBKuFcvcDq6wjY4zxxHbO+/7UPpLM5IuAAMJqridqqaEsoHFal5as0mU8fMl3
 KXqOIqEBsOqyqzM7CJoID2PGLZ6PeJk6zFzGmMaljuKUiECRKJMX6D+JSBdaabG01jRS
 s9DxeTEW9mrWpiphdkcveHQbDNyqp14GsUvHrUlFAqExDzOJOvBDn4wJAkXxgsj6d0Aj
 +IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XRaXNqZj1/ZpqBQYjItAcS8COgAJ0fcoH+Bv4m/WMkU=;
 b=eBcYGE5x22M4B5ZGVaRHyCbvdKVjigDlmWuDc3+XRacC1Q5XKveQuGOYV3XnQSk1dp
 7SaOb2x9SA8akiIjWKv87WCCB5/acqtI81zBzkqyZYwNDal6P+xpccfSxxaATbG6izC1
 Df5kbBRHK0g6CCwNdnf7R/Nz8xXTNF43MdUQYukshITPmlxv+u7Z+T1Qk+w5FjtGNKNz
 VYlLyYoTANGsDbUZZ17chv09t+PYvRK1wNoSbK0pjwu8+a4YRUaDHyW0SY1PAw/xzgFU
 LhtyLwNqLeCzRmQNyTXSa2FbIpCo+WoGnxZG+r5ddo3VEwMJo0255iTQOR5/tcuyxnT3
 ZOtQ==
X-Gm-Message-State: AOAM5312e/1B48lW03+VrwlX2isxSigkq+hJJz4fWaom6LpEC8XJLlSO
 IybU0ogObdgQC1IchgOexL9TMfg5oCw=
X-Google-Smtp-Source: ABdhPJzOPmowwrrFrF0ni31Rg4i9HMU+72MjO99S0VhBrQd1mcONSnqTS/nJgkF5mveE/g1UOcrnkA==
X-Received: by 2002:adf:f709:: with SMTP id r9mr21974258wrp.266.1602362626564; 
 Sat, 10 Oct 2020 13:43:46 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/20] hw/mips/malta: Set CPU frequency to 320 MHz
Date: Sat, 10 Oct 2020 22:43:17 +0200
Message-Id: <20201010204319.3119239-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

The CoreLV card with ID 0x420's CPU clocked at 320 MHz. Create
a 'cpuclk' output clock and connect it to the CPU input clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 4019c9dc1a8..357e269e088 100644
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
+        qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->cpuclk);
+        qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -1189,6 +1193,7 @@ static void create_cps(MachineState *ms, MaltaState *s,
                             &error_fatal);
     object_property_set_int(OBJECT(&s->cps), "num-vp", ms->smp.cpus,
                             &error_fatal);
+    qdev_connect_clock_in(DEVICE(&s->cps), "clk-in", s->cpuclk);
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
+    s->cpuclk = qdev_init_clock_out(DEVICE(obj), "cpu-refclk");
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


