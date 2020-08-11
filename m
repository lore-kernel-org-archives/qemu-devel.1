Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4BFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B00206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMoSPJjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B00206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5IUH-0005In-IO
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 20:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Z-oxXwsKCgQlwomrriqsirksskpi.gsquiqy-hiziprsrkry.svk@flex--hskinnemoen.bounces.google.com>)
 id 1k5IR2-0007Rl-D8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 20:46:36 -0400
Received: from mail-qv1-xf49.google.com ([2607:f8b0:4864:20::f49]:52806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Z-oxXwsKCgQlwomrriqsirksskpi.gsquiqy-hiziprsrkry.svk@flex--hskinnemoen.bounces.google.com>)
 id 1k5IR0-0004kV-Aj
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 20:46:35 -0400
Received: by mail-qv1-xf49.google.com with SMTP id q12so8476106qvm.19
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=4Eootghw41FF5/0naKB9f8ImYTkEQZlCCgu9KyIHMes=;
 b=GMoSPJjD9Xt49lXgUfWRQtAxTorMunTCpKR9L/R2BqbO/5eCDW74/exIA6FASdqSc+
 aAZekkPu+/9+3MIp9ai5c5axLnGoUo19sRRvQAH6KWJLkJa72W9BfvLKbv6fuy28QrZF
 idEDGGJzpewQoIKLpHPSPbm296x9dNOa86tV5BDsbxpzrFRZ5F94cr14GGaAS8xhsJsv
 qmadgSU4G/IUs8dRDqEeanZufDcm8gjoMFYn1EYYkgWa8qzd4XpPVLvaJAqhfyaUyz/H
 8eUhGxkfli/jLBiO0Pjs6OERNQwluDUT65x1oGYyvEvo6fxaVlmINCLov2CbyMWfae4N
 WdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=4Eootghw41FF5/0naKB9f8ImYTkEQZlCCgu9KyIHMes=;
 b=YKkk75MSdZaZq2uYrhgSuzTaSDKCtPMRWiRDxQHXAlp4fRzMf3oTwbpgezlkXNI3DV
 Bk5YOa1cXSL47pP4L48b1L9Oqj2ypRYVpZUNFtMfXgBQosRfSLWCr/6BiYuhMu49DMQX
 euc7B9wyJFe2gAad5SONzZNdVL0rTSpbTCb2XlVFZSPuSb6/uksp1V61UPcnnn6EL8WK
 YK65cwnXPjt0KMe2aS3WBOkoOZvhvYMdoPDsVKbMdeapIX+Ew5RpJycTDxQm3aNmx4hb
 l2uCcM/7sNCpCragPvaF4sojYTScBDOVtHX172tlJl+hYfxzLirVAIgCkLbhhyMnMk8s
 3iXQ==
X-Gm-Message-State: AOAM533HUJmB1cl0PbvgHOp8mif5ycG/uSmBiGF4em1XXu49eI6V4S9j
 HeVj3n1Jo0WAomP4wvIwy++tNBeYFdnrBY+GYg==
X-Google-Smtp-Source: ABdhPJyUsyygpCdXP7Kr+d9VdyldSm6tfgHztxiprPjHC9Ah+en76/TRmq/iYZurZ5Sb7mFQIpgblYQ7nIS2yeVquQ==
X-Received: by 2002:ad4:5849:: with SMTP id de9mr29974528qvb.22.1597106791968; 
 Mon, 10 Aug 2020 17:46:31 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:46:05 +0000
In-Reply-To: <20200811004607.2133149-1-hskinnemoen@google.com>
Message-Id: <20200811004607.2133149-12-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200811004607.2133149-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v7 11/13] hw/arm: Wire up BMC boot flash for npcm750-evb and
 quanta-gsj
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, f4bug@amsat.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f49;
 envelope-from=3Z-oxXwsKCgQlwomrriqsirksskpi.gsquiqy-hiziprsrkry.svk@flex--hskinnemoen.bounces.google.com;
 helo=mail-qv1-xf49.google.com
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

IMAGE=3D${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
qemu-system-arm -machine quanta-gsj -nographic \
	-drive file=3D${IMAGE},if=3Dmtd,bus=3D0,unit=3D0,format=3Draw,snapshot=3Do=
n

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 26ea97072b..bd0b822907 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -19,6 +19,7 @@
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/units.h"
@@ -50,6 +51,22 @@ static void npcm7xx_load_bootrom(NPCM7xxState *soc)
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
@@ -87,6 +104,7 @@ static void npcm750_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0,=
 0));
     npcm7xx_load_kernel(machine, soc);
 }
=20
@@ -99,6 +117,8 @@ static void quanta_gsj_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
+                          drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
=20
--=20
2.28.0.236.gb10cc79966-goog


