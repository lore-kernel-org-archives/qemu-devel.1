Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7BCC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174222168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mw+QBuyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174222168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GFT-0008To-7X
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhP-0004qy-Ke
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhO-0002Qx-0j
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhN-0002M7-OM
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id p9so6543264wmc.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uzVG4rPZtI9QEgU8YI9WvM2Scl3ZA8+l5Ifz+hNMkdM=;
 b=Mw+QBuyDSWMLGHyUZGFJWyXB0b1/fz4xhmQJIKU2a+q3avfb2rF3voCPHkGkF7qJiY
 tniBTLu8OG5bMrT7qrsEF9d1fDUJbSrtN6TUtiLpse5WqLaZ6EBkMP6F4JONTJgTtyRl
 iBsOEkYXffm7VmJeqC0GBB9OW8r3jLYdWSZm2L4eMgldzw0fGzZwqLixwvLWV2/GjdD1
 P7sbivq6L48iHVIPziHNvkwA5AX213O33oVdOBB6eaqDFB0/ooZgTLv5TYIUBUKjcYZu
 4ZRWhHHt0OgNYk6i+S7/01iujJsVl72XgyNcLWFNVihnPmYtN/jLxBwpUGD0I5PwuhpM
 C28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uzVG4rPZtI9QEgU8YI9WvM2Scl3ZA8+l5Ifz+hNMkdM=;
 b=gzJtKR10VK63g1zHN/ERmHpd6P7mf+rNfQhWBiY9tnIKVDvuKnk0lHuaJ2b9mg9suu
 jzDcWsNUx/87baaE8jUjHW0yJ/fR4lKrFCP7wI6YHmYeIYDHVrFBaolfB7LJoNzowO/d
 ronKe0lcRwEvn9AbI/htOSdPJtAqjm916zn4zQD7HYxv9Nc9LBuvRAAOubS592+t9ALo
 X+ezXwNqIMPaw8U4UZIMRFs3Tm4ZclCuD2a98B9qkh8hiJS4/ogPq5lfX67GocdN0z1m
 ZDg/sHDDeHLQLBLbb6tBj9hZbOIqhIldD0t0ugPydUwafHnXFCQmFQrrlOSSP7WrIzq3
 rAFw==
X-Gm-Message-State: APjAAAWJ6z5pJ+O3mJlR+k+//se/iuCF+Pl3GxZzdQ6PL4ULbd0TwV3k
 l+A8Elkilor4kdQMCB1rSNXTuyEJ1Z4=
X-Google-Smtp-Source: APXvYqxgqLZkAGbM27b9E+u2gvPYWMVxCiL0lgbjWwAgz8PxFqRZ/xF6Jxn5CFpfuzX6RAJrPmTK4Q==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr6624815wmc.168.1581604953549; 
 Thu, 13 Feb 2020 06:42:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/46] hw/arm/raspi: Let class_init() directly call
 raspi_machine_init()
Date: Thu, 13 Feb 2020 14:41:40 +0000
Message-Id: <20200213144145.818-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

raspi_machine_init() access to board_rev via RaspiMachineClass.
raspi2_init() and raspi3_init() do nothing. Call raspi_machine_init
directly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200208165645.15657-10-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fbfcd297326..1628b0dda7c 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -228,7 +228,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
 }
 
-static void raspi_init(MachineState *machine)
+static void raspi_machine_init(MachineState *machine)
 {
     RaspiMachineClass *mc = RASPI_MACHINE_GET_CLASS(machine);
     RaspiMachineState *s = RASPI_MACHINE(machine);
@@ -280,11 +280,6 @@ static void raspi_init(MachineState *machine)
     setup_boot(machine, version, machine->ram_size - vcram_size);
 }
 
-static void raspi2_init(MachineState *machine)
-{
-    raspi_init(machine);
-}
-
 static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -293,7 +288,7 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 
     rmc->board_rev = board_rev;
     mc->desc = "Raspberry Pi 2B";
-    mc->init = raspi2_init;
+    mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
     mc->no_floppy = 1;
@@ -306,11 +301,6 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 };
 
 #ifdef TARGET_AARCH64
-static void raspi3_init(MachineState *machine)
-{
-    raspi_init(machine);
-}
-
 static void raspi3_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -319,7 +309,7 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
 
     rmc->board_rev = board_rev;
     mc->desc = "Raspberry Pi 3B";
-    mc->init = raspi3_init;
+    mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
     mc->no_floppy = 1;
-- 
2.20.1


