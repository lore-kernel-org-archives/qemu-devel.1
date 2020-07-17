Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7F1C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6C720739
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5E5x+EO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6C720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJa7-00072c-I8
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Nj8RXwsKCvcgrjhmmdlndmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--hskinnemoen.bounces.google.com>)
 id 1jwJT7-0003s6-PR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:37 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:46291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Nj8RXwsKCvcgrjhmmdlndmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--hskinnemoen.bounces.google.com>)
 id 1jwJT5-0005JB-EJ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:37 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id u64so10003664ybf.13
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=PjXLdj2cihq5uXhjGbzoxvHE0ecuRwdA46uT+Gv/ofM=;
 b=U5E5x+EOSE/8ywjo1Ovd65pvoosOvCUIsqsf8issRPni+uTW1XoDut4cjqkto/hCX1
 2oKXZlL3HXa6ipC3etHj9xuCb2Yxd9HXR/EnJ2xiM1pcAZtR9r6OMfMYeeyZcY4bhA6m
 fugH59VDatn+rzoFzRXEzjOpKggBjyqNQihK5C78wgfSVJ1VqNBWNDZNK59iff0xSYrV
 mot3MIs8YFf3OIN+74LCM+dsSdadgjYxuuPt/EU5ydaQQocZsat2hiY7DOSVpOlhFQcy
 LQ2eEZQ7XuCEh0djEhbQR/BdBkNK5IZM7E+IrT3+Plk603jarFT2SI8j3YMEKHySdHfS
 rNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=PjXLdj2cihq5uXhjGbzoxvHE0ecuRwdA46uT+Gv/ofM=;
 b=FppInfN30MCYqQ9c/Ou4slmqsEsuMNirH2DDZQnWXbZtmTvp9yUkoBAYIz8alTZ6Hl
 i5HaFSW5F7vl5YjDIpZkW9DQrnmy7NcdughPqtyfL0U13NHcQMNFnliZQu01zSXVu/3a
 W0KmUMGUrM74diO1JkOVhW9+qtyUduoeHFf/E8MN9nbq3qQwMCCSBXm6fLzoz+9o4kdg
 4Odu6Mb/57SvsIBief9H/UqyknYS67JLsnVxqTZx4iByu0qRBqtS+ARkAX0DUQLwCOrs
 aJX0E+tpdWvWNvCGyhJ8EfQmYnO9VeqDT8qDBIMZYedn7I333gY7YShdVHn0Fs5ep1Q6
 Yi5A==
X-Gm-Message-State: AOAM533tyoHd50xeW/kakCqbFDg2nic5PpBo6RhF/3k8u1pLVoySgp7h
 LX3peMm6htd3jnUQpc2NY7LkHfpC46GZYMPgan2A0LXnDPxdh2IvmhsbKZRioGjD4GarIGBJSOV
 7UoHDE+XSgjTNrAqdPUHSaDoX3nrPIipzWvth9zvGlKlyuQMElzk07mtKBUQnWWAVZj9jrFOnzg
 ==
X-Google-Smtp-Source: ABdhPJxanI8jzYLHes88d4C/JneKvjZOOotpEs+1yzg3Ud1x/iYIz3PHCcaHJFFtI80ve6YN+iYNKVAu3NV+RoalEQ==
X-Received: by 2002:a25:aba9:: with SMTP id v38mr12183884ybi.54.1594965814164; 
 Thu, 16 Jul 2020 23:03:34 -0700 (PDT)
Date: Thu, 16 Jul 2020 23:02:56 -0700
In-Reply-To: <20200717060258.1602319-1-hskinnemoen@google.com>
Message-Id: <20200717060258.1602319-12-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v6 11/13] hw/arm: Wire up BMC boot flash for npcm750-evb and
 quanta-gsj
From: Havard Skinnemoen <hskinnemoen@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3Nj8RXwsKCvcgrjhmmdlndmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
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
index f32557e0e1..565ee6f671 100644
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
@@ -53,6 +54,22 @@ static void npcm7xx_load_bootrom(NPCM7xxState *soc)
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
@@ -90,6 +107,7 @@ static void npcm750_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0,=
 0));
     npcm7xx_load_kernel(machine, soc);
 }
=20
@@ -102,6 +120,8 @@ static void quanta_gsj_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
+                          drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
=20
--=20
2.28.0.rc0.105.gf9edc3c819-goog


