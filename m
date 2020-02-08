Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80493C35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFE52082E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrCdzZKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFE52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0TRV-00006a-DZ
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 11:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPz-0005zQ-Ud
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPy-0001oN-NE
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:19 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPy-0001nh-HK; Sat, 08 Feb 2020 11:57:18 -0500
Received: by mail-wr1-x441.google.com with SMTP id g3so1410838wrs.12;
 Sat, 08 Feb 2020 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PQ9RCvZi2otUw1qqPfGvj8l91J+geLVqZwXKPaCPo0s=;
 b=RrCdzZKgivqN4loroP0+cRbq4EF4GhRSz9wlioUwMOOSwq6XSv5UiRkIajIUvmmVNL
 KO3nuaNJguzSguZBboF5p3EJezjoNoTbeFcQmfWZLfs0klS1iCxbalp4W4tYNg+X5Lk5
 WOqN9zvi27SjAoo/Gq0hjtxJVmvvh6CVEBvxY73wCT4TV2Be1jExfwafhmdpkcQMq7li
 OOtR/cSSD0QupAMyQUBeF0R2LPn/sMzd+yEcm8cGF9O9ckQ+qKQAMhDl6fiorrpHg6tj
 zskUu9QXFnTnyavp+MWLFuRRdEOtaeWIxkfl1bHFbAp8PHXYPoK5gUWA1OySI60WM8PW
 cQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PQ9RCvZi2otUw1qqPfGvj8l91J+geLVqZwXKPaCPo0s=;
 b=TY37oLExDmXw6w5KtV1XzeUFww1x/f+1c0NRgh3cz7NmAO7p5gtYei0u2UCLOTULc/
 9AULgLzukli/bvVCWG4t9ATBAqkQZmJRUt5ZvIaxBAE5e2gJbf0aD5G7YP52PgdoB9XS
 d5uLCxG0kgoiqcAuyZo4pp1UCSApBQf814MGA7WORl6HDGEuXEZ81HYxGDqtx5fvjrRw
 ybhbgu8dHl8yzYZFWKUE/iTPTI6Mw2dOJ+LZEcMYZ5E+LahOS9KDkaZDwd9l98GnsEfc
 Ha8ZuTJ4MvbKV73GUWvu+fp8W6I1ATPJx8kxdQJ+bNHAUt7nIjnksvPMbdpN7YieMr6Y
 9+pw==
X-Gm-Message-State: APjAAAWmI6uJ6P1manhZ7LFjyN221bFpAc4YDX5vvr91eXoZ9DOcW8QN
 cfu//Zlnx1yHqLtpqEVVOCb2iWcY
X-Google-Smtp-Source: APXvYqyKlXtuXAwDGb6exyGIf/dF/fcd8I7KUjuzu+55+nSUxtnnA1rNOZjb8roUdwJLQ+SW6NDVhA==
X-Received: by 2002:adf:b352:: with SMTP id k18mr6003393wrd.242.1581181037383; 
 Sat, 08 Feb 2020 08:57:17 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:57:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/13] hw/arm/raspi: Let class_init() directly call
 raspi_machine_init()
Date: Sat,  8 Feb 2020 17:56:41 +0100
Message-Id: <20200208165645.15657-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

raspi_machine_init() access to board_rev via RaspiMachineClass.
raspi2_init() and raspi3_init() do nothing. Call raspi_machine_init
directly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Squash with previous?
---
 hw/arm/raspi.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fbfcd29732..1628b0dda7 100644
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
2.21.1


