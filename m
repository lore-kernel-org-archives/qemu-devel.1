Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B010FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B85206C9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iT4Oc585"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B85206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpVV-00085t-Bw
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8Z-0003Gq-I4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8X-0007dG-Ih
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id z1so18906150wrt.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yZ2vEdJlPjbyI8ww8U5qoJzqvDc0/HAFhSNTRittaEw=;
 b=iT4Oc585nLTP5yjyKnHF2qX5XOr076vBm5yx6xeJajd+OGP2DYKfvo+COC3N8fCorH
 xtTuMBGlcohhTDpOqJliSxqsL761Vpq+fT8V4gq/Q/ykgB+eM1WDgF1SOs/FeaZoo30L
 NzAJX9/oUKWWLf350FLz59/RC2Y44fNUEx0t/psSr20JhFMwylVAVLJ2CVPXJ9zYc9/H
 B6XBuVYWc2XyMqEDxD5e+Cuixol9ko0bXWTpTXq+9/OuIwczkCGmRH2vXZj+oCuiz8m9
 /M91LciLW91hoG6aZGx3wpARD67XC9DuHQCY1kcKy1aaxRsQRGTDupk7lbpvN/ZzSYat
 epHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yZ2vEdJlPjbyI8ww8U5qoJzqvDc0/HAFhSNTRittaEw=;
 b=aTujUke7K8DAoHqoaDsL4GqUtk00LkfLiweAvrJdCyj68W3MHaKE7P3rE2rdx39jKq
 8j4fn16rl6KS330WQHhWKA8JGZxsZ8naTLygi+y3Vanh7PojGCzcfRPq0q2j4tSuvgUj
 TyLb9EfvpUa0/IjWtGtbAyxanf3A6RRUYUCqA2olsuG+8Zd33q4k1hxTEr2Xgo1SevlC
 Z6SDc9VExKuhnBMbHC3nCvNnb4BihVyoH1C6gGHvoXxMXN6DL8z1CIjfEm8G1S/KD+Kn
 ykAepUGiPFn1e9VsyIIzCMqYhCE7VC83FQPeFRJ6d8N2ruP/ruPk3UuSs9B7dw3D+OeQ
 SYpQ==
X-Gm-Message-State: AOAM531/i+W7t8ordqrp3XzrlkQNuI3JEseODDDBblzqSBNOikekuza4
 fzJuFjLO/nw6eauhxw7XSSM+KypG77vZ46UN
X-Google-Smtp-Source: ABdhPJxgRyw8i6ktQA6bZJRLBpOlmYTs106Uj2JFF3+3Eu753DmjYm/XjQpb8lArmJ8jxy1Wfo60kQ==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr16900327wru.423.1600092435913; 
 Mon, 14 Sep 2020 07:07:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/36] hw/arm: Wire up BMC boot flash for npcm750-evb and
 quanta-gsj
Date: Mon, 14 Sep 2020 15:06:34 +0100
Message-Id: <20200914140641.21369-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Havard Skinnemoen <hskinnemoen@google.com>

This allows these NPCM7xx-based boards to boot from a flash image, e.g.
one built with OpenBMC. For example like this:

IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
qemu-system-arm -machine quanta-gsj -nographic \
	-drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200911052101.2602693-12-hskinnemoen@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm7xx_boards.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index b4c772d6b52..79e2e2744ca 100644
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
@@ -55,6 +56,22 @@ static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState *soc)
     }
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
+    qdev_connect_gpio_out_named(DEVICE(fiu), "cs", cs_no, flash_cs);
+}
+
 static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
 {
     memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram);
@@ -92,6 +109,7 @@ static void npcm750_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -104,6 +122,8 @@ static void quanta_gsj_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
+                          drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
 
-- 
2.20.1


