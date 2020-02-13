Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C93DC3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCCF2168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZN9DECh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCCF2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GGJ-0001Rq-74
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhP-0004pt-8W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhN-0002Q9-OA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhN-0002OW-GZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:37 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so6962250wrl.13
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LcvOsRN9irC06rZFCwrPFiUgmlJPc+Ym4MUDwz07cFg=;
 b=PZN9DEChKF9Djha+F6I6Dr7Sp4hdEyPGzAc0OGIOOywqQv8r0kp6yfHvF8oFwVE7G7
 LB8Vf8RSvBBLtG5ib/TdeOJ0lvvTw/YdGccUhv3VFTKi4KQyumryK+WaQWceRK0J+Dy6
 AumLcD/y/uxxPJGrFJrExIqjXDIs9gmhZY2xf0E52QRztNWmrfe4kKmHKJjAaw5+SHQp
 zwBtNXmohrFmzcPungfMJv/MFB8cA7snsFVLvtOF5cinhAiVprAJFv1LG7kwtPQ5RlOg
 +rVesvtIZmw+bDSKtQOo21XspQQFXWDJumxjPIr8kM4Pv19zg9Tih1Wy39PD6kB3TjUc
 twPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LcvOsRN9irC06rZFCwrPFiUgmlJPc+Ym4MUDwz07cFg=;
 b=lIRC8aXHj7ce8qx36o+1rBjgvOW8W6rj7MZkW/GZ1a6T0cbmyX0M6/ikEk8os//vvK
 a3Q5xqIW+9CUhEcwCTNgqiJhJi0OJFgadcW1SG2kp4e/nzSm/DO5+dp0wq2LZ6nPkuKW
 YHnX6OUIzeaKkusWmryI1RWrj8c4wFOMgyGVBiTCvWa9/2FUvsgbm6I+2zx2B/E/zFdl
 2CBagjRtxtd4wK3UE+c4Qkfcc43jvtHEqtgmqSzMaQnxWtABjUyDOtMCQvkfBHuI5Ky/
 8UVgLhldIXUz6NBhX4t+wswHanWwAS8+5Pfty31UAKDcbZ3rFpEwLl6o/W53Rg+Z+lhe
 7RTw==
X-Gm-Message-State: APjAAAU2wk0NpqPEpLf75SH4FZjjdZ2x2fYAT50FWpb2k3RYovBvdG89
 oth46hpJk6G4x0HaVIBMvAEPD5Bmkx0=
X-Google-Smtp-Source: APXvYqwvbx+L6yGiaJ/KaxUe2hQ4NrvQDJlUNR/AFoT+dyFuyi53c62p7ML30D8yGtJrs5d8MAIjvQ==
X-Received: by 2002:adf:e610:: with SMTP id p16mr23568814wrm.81.1581604956349; 
 Thu, 13 Feb 2020 06:42:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/46] hw/arm/raspi: Use a unique raspi_machine_class_init()
 method
Date: Thu, 13 Feb 2020 14:41:43 +0000
Message-Id: <20200213144145.818-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

With the exception of the ignore_memory_transaction_failures
flag set for the raspi2, both machine_class_init() methods
are now identical. Merge them to keep a unique method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200208165645.15657-13-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 0537fc0a2d1..bee6ca0a086 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -294,7 +294,7 @@ static void raspi_machine_init(MachineState *machine)
     setup_boot(machine, version, machine->ram_size - vcram_size);
 }
 
-static void raspi2_machine_class_init(ObjectClass *oc, void *data)
+static void raspi_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
@@ -311,41 +311,22 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
     mc->default_ram_size = board_ram_size(board_rev);
-    mc->ignore_memory_transaction_failures = true;
+    if (board_version(board_rev) == 2) {
+        mc->ignore_memory_transaction_failures = true;
+    }
 };
 
-#ifdef TARGET_AARCH64
-static void raspi3_machine_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
-    uint32_t board_rev = (uint32_t)(uintptr_t)data;
-
-    rmc->board_rev = board_rev;
-    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
-    mc->init = raspi_machine_init;
-    mc->block_default_type = IF_SD;
-    mc->no_parallel = 1;
-    mc->no_floppy = 1;
-    mc->no_cdrom = 1;
-    mc->max_cpus = BCM283X_NCPUS;
-    mc->min_cpus = BCM283X_NCPUS;
-    mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = board_ram_size(board_rev);
-}
-#endif
-
 static const TypeInfo raspi_machine_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("raspi2"),
         .parent         = TYPE_RASPI_MACHINE,
-        .class_init     = raspi2_machine_class_init,
+        .class_init     = raspi_machine_class_init,
         .class_data     = (void *)0xa21041,
 #ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3"),
         .parent         = TYPE_RASPI_MACHINE,
-        .class_init     = raspi3_machine_class_init,
+        .class_init     = raspi_machine_class_init,
         .class_data     = (void *)0xa02082,
 #endif
     }, {
-- 
2.20.1


