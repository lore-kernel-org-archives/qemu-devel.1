Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ED3C04E84
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AD920833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AD920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZNw-0005Tz-29
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:42:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZM0-0004IP-Tc
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZLz-00022i-Mm
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:40 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:55350
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLz-0001xp-F8
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:39 -0400
Received: from host109-146-247-8.range109-146.btcentralplus.com
	([109.146.247.8] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLD-00018L-NP; Fri, 17 May 2019 10:39:52 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri, 17 May 2019 10:40:23 +0100
Message-Id: <20190517094029.7667-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
References: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 109.146.247.8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PULL 2/8] leon3: fix the error message when no bios
 are provided
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

The leon3 board is looking for u-boot.bin by default (LEON3_PROM_FILENAME)..
But in the case this file is not found and no other file are given on the
command line we get the following error:

  $ ./qemu-system-sparc -M leon3_generic
  qemu-system-sparc: Can't read bios image (null)

So use LEON3_PROM_FILENAME instead of filename in case it is NULL to get a
less cryptic message:

  $ ./qemu-system-sparc -M leon3_generic
  qemu-system-sparc: Can't read bios image 'u-boot.bin'

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/leon3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 0383b17c29..f438718794 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -1,7 +1,7 @@
 /*
  * QEMU Leon3 System Emulator
  *
- * Copyright (c) 2010-2011 AdaCore
+ * Copyright (c) 2010-2019 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -43,7 +43,7 @@
 /* Default system clock.  */
 #define CPU_CLK (40 * 1000 * 1000)
 
-#define PROM_FILENAME        "u-boot.bin"
+#define LEON3_PROM_FILENAME "u-boot.bin"
 
 #define MAX_PILS 16
 
@@ -158,7 +158,7 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Load boot prom */
     if (bios_name == NULL) {
-        bios_name = PROM_FILENAME;
+        bios_name = LEON3_PROM_FILENAME;
     }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
 
@@ -180,7 +180,9 @@ static void leon3_generic_hw_init(MachineState *machine)
             exit(1);
         }
     } else if (kernel_filename == NULL && !qtest_enabled()) {
-        error_report("Can't read bios image %s", filename);
+        error_report("Can't read bios image '%s'", filename
+                                                   ? filename
+                                                   : LEON3_PROM_FILENAME);
         exit(1);
     }
     g_free(filename);
-- 
2.11.0


