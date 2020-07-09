Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B46C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EED20708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dC4x0L5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EED20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKiA-0002Qh-49
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nWYGXwsKCoInyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com>)
 id 1jtKYT-0006qO-4u
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:36:49 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:33639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nWYGXwsKCoInyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com>)
 id 1jtKYQ-00013l-Kd
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:36:48 -0400
Received: by mail-yb1-xb49.google.com with SMTP id g10so807729ybd.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=66PpJSiQbPbYGb1w141zWioPCpD9KVyXHJd+V0/BDS8=;
 b=dC4x0L5klf8D6cz5MiMhEuSUB/vbqCDRLLInigXUckzFEnx0OV0TZDtPSglPFtKVlw
 8rboMOmC9GnQcb727mV7UZ8944KMV0JVE3IR2Xbhvc5hNnudGqLEZEpQbiPvxY8+S7da
 W0mIK51vKGBublsdPtkAnsxVlrDgyeWohSJKiMw4Q+s0A53D2TNVFa2tPpWtgPr0+4/R
 5B5K8HIxpAFG8PHApTKxEDqXk49ag8if/aU0NoTC/S3JoKkuz8KcBd6anoAFo1XRogHC
 q0ja3zIdR/1pmpFv9R+pC/vXGL47NHNXokr2oNxSlrX73Nk9p//FiBdlTBfQYWG+m3mI
 Wo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=66PpJSiQbPbYGb1w141zWioPCpD9KVyXHJd+V0/BDS8=;
 b=CMu73cnA25y17bxCSncmciwYmZ+P8WVrHqcwJnwSY7DS0PmpjH18VsCK7KrALlsbvh
 hPUPri9qRLT0qp06Umy2nONhP4LAziLX47lXBvBB7645+47r4oBKkFdnkHzM/CV3fClB
 ay3uwEdQQXM4nAF46GLlPj9eP/r07C11L2SX4skMLhByrAownaw0z8Q2F2sWQ814VkJo
 q8xRUzsk7bZJR8lSn12LdcCZ6gloGKiivl3Mv1oW7mQcNMQOLEPwaPZTh/mqSsBEt/Ln
 vIF4yTMpvaR7sCnfER9pDHSIvtnaG8t/M71bL642Tn6EWIjicb0Gr9n6gg4aITtkjv37
 UDNw==
X-Gm-Message-State: AOAM530+Mv2uRn53k4aL8a5g0KnFSr3rMRfWbiV9wzxc5nB6FVQcxG3V
 unIZaqFJAUZS48OwIE2QGPsTZl3aBI/IkKue5g==
X-Google-Smtp-Source: ABdhPJzUTg0UAbKZ7UExzEGdP8KfFvZwgGQ6NWLEFrO2yrFYxn15CQoDdnDDEB19Vs516jdxj6tNVQbGjf8FJRYSew==
X-Received: by 2002:a25:a301:: with SMTP id d1mr5259997ybi.449.1594255005229; 
 Wed, 08 Jul 2020 17:36:45 -0700 (PDT)
Date: Wed,  8 Jul 2020 17:36:07 -0700
In-Reply-To: <20200709003608.3834629-1-hskinnemoen@google.com>
Message-Id: <20200709003608.3834629-11-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb and
 quanta-gsj
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3nWYGXwsKCoInyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This allows these NPCM7xx-based boards to boot from a flash image, e.g.
one built with OpenBMC. For example like this:

IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
qemu-system-arm -machine quanta-gsj -nographic \
	-bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
	-drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 80cf1535f1..cfb31ce6f5 100644
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
@@ -66,6 +67,22 @@ static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
     arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
 }
 
+static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
+                                  const char *flash_type, DriveInfo *dinfo)
+{
+    DeviceState *flash;
+    qemu_irq flash_cs;
+
+    flash = qdev_new(flash_type);
+    if (dinfo) {
+        qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+    }
+    qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
+
+    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    sysbus_connect_irq(SYS_BUS_DEVICE(fiu), cs_no, flash_cs);
+}
+
 static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
 {
     memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram);
@@ -96,6 +113,7 @@ static void npcm750_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_abort);
 
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -108,6 +126,8 @@ static void quanta_gsj_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_abort);
 
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
+                          drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
 
-- 
2.27.0.383.g050319c2ae-goog


