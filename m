Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B669C2BC11
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1278C2087C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bYlqILVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1278C2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGbcl-0004HC-89
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 01:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WglbXwsKCtkCNFDII9HJ9IBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--hskinnemoen.bounces.google.com>)
 id 1kGbV8-0006qI-Sg
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:34 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a]:54254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WglbXwsKCtkCNFDII9HJ9IBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--hskinnemoen.bounces.google.com>)
 id 1kGbV5-0002PM-SQ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:34 -0400
Received: by mail-pf1-x44a.google.com with SMTP id 82so6130493pfz.20
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 22:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc:content-transfer-encoding;
 bh=lvAKurUSN33i9vygYzOobBU58zXgdvVYtnal8a/1X6g=;
 b=bYlqILVqfNdUQUJS9iK2YSaPwoMmEC30GbtQy2iD8E0GwTVDOSyMENjh5ICqww8j6N
 CYF6/Ku78lZ5kQ6wPDsVBoPuAkaGWgsyr51keNRX3nVU0qpO0FE7DDq3SD1DX760qLFt
 KMc4X0MXOf4JC8V9dKYS8v6iJp18VAf4K3j+aprEqiYryoz6HZ3xbNTog5Sf0l92bxO/
 AhjeDxRu/jTqwuS6dMt0ff3SZwsjdTgIlz0eGcCCCItai3D9nt3BlAvc+JQzdWwy/MJ7
 2H6qzAw/szOYNNqUHrRnnZWh813q5CqOQbG7i69Lc6hKETQv+kyZwduwJRTgmvdIL3Js
 Y7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=lvAKurUSN33i9vygYzOobBU58zXgdvVYtnal8a/1X6g=;
 b=jt6szlZyBkMpCHRpTHfr26BDV8dHhbDa6Q9piPxIGnLR+7qGCya3xYglQYC/08pVes
 r2pYbNTQ/FzweNSWf27m3C3/HBROm/FtKA+PJuk0f5b4zPr0YcwLVwPYNrJ2pBITen58
 7rBxrpTcvlxJAwqwEfuKSKwilLxlUaAm1WMcaBbI921M8SlH4+rh48Pkfeeflyv94YT/
 I/hLVn5jD9971FQSG3J3Ds5Wfw8g1VoRFBOAoRx74RDS1aOtMUjMmCJEiv8ttqErzIe7
 ZaRrzGrvCouNcOOzkkYBI79rmlGmd3TztRE3jJ1kbzgj4z9Ox/Mq5lqSVk/qfUwcojRN
 cwOQ==
X-Gm-Message-State: AOAM531gQ9Xqkh2hbJaq0yQ6mnGkNhQ40F0VorTr+NojnYvAwvmCvrCR
 yMmqB8u5kx2955RgtAXIcnnuDGyerqGJH/Q+XA==
X-Google-Smtp-Source: ABdhPJzVgUFr84SCzJGvrX42JHj2FuAlPUFlTxe8DsqzoxKKcbiB2OZEQOKR15XdwDrphA4xGuWgfaouDc3wPc+mPA==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by
 2002:a62:6dc3:0:b029:13c:1611:658d with
 SMTP id i186-20020a626dc30000b029013c1611658dmr620781pfc.10.1599801690052;
 Thu, 10 Sep 2020 22:21:30 -0700 (PDT)
Date: Thu, 10 Sep 2020 22:20:58 -0700
In-Reply-To: <20200911052101.2602693-1-hskinnemoen@google.com>
Message-Id: <20200911052101.2602693-12-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200911052101.2602693-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v9 11/14] hw/arm: Wire up BMC boot flash for npcm750-evb and
 quanta-gsj
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3WglbXwsKCtkCNFDII9HJ9IBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--hskinnemoen.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This allows these NPCM7xx-based boards to boot from a flash image, e.g.
one built with OpenBMC. For example like this:

IMAGE=3D${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
qemu-system-arm -machine quanta-gsj -nographic \
	-drive file=3D${IMAGE},if=3Dmtd,bus=3D0,unit=3D0,format=3Draw,snapshot=3Do=
n

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index b4c772d6b5..79e2e2744c 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -20,6 +20,7 @@
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/units.h"
@@ -55,6 +56,22 @@ static void npcm7xx_load_bootrom(MachineState *machine, =
NPCM7xxState *soc)
     }
 }
=20
+static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
+                                  const char *flash_type, DriveInfo *dinfo=
)
+{
+    DeviceState *flash;
+    qemu_irq flash_cs;
+
+    flash =3D qdev_new(flash_type);
+    if (dinfo) {
+        qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+    }
+    qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
+
+    flash_cs =3D qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    qdev_connect_gpio_out_named(DEVICE(fiu), "cs", cs_no, flash_cs);
+}
+
 static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
 {
     memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram=
);
@@ -92,6 +109,7 @@ static void npcm750_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
     npcm7xx_load_bootrom(machine, soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0,=
 0));
     npcm7xx_load_kernel(machine, soc);
 }
=20
@@ -104,6 +122,8 @@ static void quanta_gsj_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
     npcm7xx_load_bootrom(machine, soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
+                          drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
=20
--=20
2.28.0.526.ge36021eeef-goog


