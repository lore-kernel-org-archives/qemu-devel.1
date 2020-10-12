Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C92C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E78120776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K00OKLsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E78120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRul3-0004GU-Gy
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucH-0001wn-KM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:41 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRucG-0002ut-5Z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id z22so13424897wmi.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tuhwN9e0WSQZgRYxEuwcxUwJNzQu5uaCHtzj/pF8FV8=;
 b=K00OKLsVEh7JKNf/vxVOR7F0IHOUw92ZkCnel3He04y3LY6OsB/tU3zfZUGT1VvWM2
 jRZAbk7RJ6WFSsIjkYprq7gsNZnxUlqCBs5MWVoZwRdwxULTfwKD/ykqdSTMxzSawQXH
 SZrA5AIyRTBF8GjR5yCmRf9bhyy74dbvr/+C3khr9H59j3T+rjPN9IhiPSfFL47eEjeL
 XupeMF1/CfDBQ/NV6FOb9Ip/30/Y7xXBqJdkioYC3YTEDY+6I/9Eaiov/ElzUoSn1al5
 RZ/7/bBWM0cqCnILw0a79mKfMmPK+bHSZzfbc3+zFdRZJBmxxipRWiHeB1/MCwVf2G0r
 JM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tuhwN9e0WSQZgRYxEuwcxUwJNzQu5uaCHtzj/pF8FV8=;
 b=FIAsucjo400KsbxmKu99vvIo++m7GgSESuCvm6vuZvwtOeaBONwDgh0uFxHUO54lMg
 NLfHyY6g/XI8QAc2ug18L4q0ZZnkqg4ZFlhHK8xTxv9hL9JRJvnMnF4g4wynt6wXDSel
 +VJs0j0wsRlKSRQAMbMFLTzvNwgVPPKc5HvWAK5fYfO6IIABmRiOWbAIJ2dEY/BoqrY2
 s7g9PbMI6c82JfQ2yeZ1vq0GBOqfYjiaT3g3Q0AhVd0K4ir5ccUXpEirPrcM30EjxYmq
 tYy47UurqN4IA4/h/Y1mH8AOFpGfe6w1q2Oymtdu3XZDC9wHRKzoDZKmGfKxqGk7xnEA
 9Zjg==
X-Gm-Message-State: AOAM531NOBrrZLP/uctCmaHz67V4gDe/LOBedwZ3VAPBeMLPKJJZWd2Y
 HS6Ct8jc5Zg8+tmix9YY5+/ktpFhraI=
X-Google-Smtp-Source: ABdhPJwkXJccCPa7quihKjGssh3yroMqDtdoV9/fNdCEdEAPs+oEWz+mYf5If/PXn1UkZY+PuclWbA==
X-Received: by 2002:a1c:e045:: with SMTP id x66mr10146371wmg.104.1602496778424; 
 Mon, 12 Oct 2020 02:59:38 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h7sm1388024wrt.45.2020.10.12.02.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/21] hw/mips/boston: Set CPU frequency to 1 GHz
Date: Mon, 12 Oct 2020 11:58:01 +0200
Message-Id: <20201012095804.3335117-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The I6400 can run at 1 GHz or more. Create a 'cpuclk'
output clock and connect it to the CPU input clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/boston.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1b3f69e949c..cf2296f4488 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -30,6 +30,7 @@
 #include "hw/mips/cps.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci-host/xilinx-pcie.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -54,6 +55,7 @@ struct BostonState {
     MachineState *mach;
     MIPSCPSState cps;
     SerialMM *uart;
+    Clock *cpuclk;
 
     CharBackend lcd_display;
     char lcd_content[8];
@@ -251,10 +253,19 @@ static const MemoryRegionOps boston_platreg_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void mips_boston_instance_init(Object *obj)
+{
+    BostonState *s = BOSTON(obj);
+
+    s->cpuclk = qdev_init_clock_out(DEVICE(obj), "cpu-refclk");
+    clock_set_hz(s->cpuclk, 1000000000); /* 1 GHz */
+}
+
 static const TypeInfo boston_device = {
     .name          = TYPE_MIPS_BOSTON,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(BostonState),
+    .instance_init = mips_boston_instance_init,
 };
 
 static void boston_register_types(void)
@@ -462,6 +473,8 @@ static void boston_mach_init(MachineState *machine)
                             &error_fatal);
     object_property_set_int(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
                             &error_fatal);
+    qdev_connect_clock_in(DEVICE(&s->cps), "clk-in",
+                          qdev_get_clock_out(dev, "cpu-refclk"));
     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
-- 
2.26.2


