Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC04C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E36206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9oArRZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E36206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5IV0-0006Ri-UY
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 20:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YeoxXwsKCvwlwomrriqsirksskpi.gsquiqy-hiziprsrkry.svk@flex--hskinnemoen.bounces.google.com>)
 id 1k5IQv-0007EV-N2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 20:46:29 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449]:49406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YeoxXwsKCvwlwomrriqsirksskpi.gsquiqy-hiziprsrkry.svk@flex--hskinnemoen.bounces.google.com>)
 id 1k5IQt-0004i5-SJ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 20:46:29 -0400
Received: by mail-pf1-x449.google.com with SMTP id y17so9160417pff.16
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=cJ+kY4MqdpbUXLCMTfKhuudli9xfKAZEj3Kh1+n1es4=;
 b=G9oArRZzmpHYXqYueTZtvTbuGTFHLcgwuoDWm1Q7/cktdvNAdUL/PLTh7yFINS0yPj
 RxbNYYLCDeehzoXngMhTT6voZM7tsCwNxN0vm08aeNk1PrIU1Sn/4gN/Mba37lnjVCRY
 lqoTOW9sHFftRWmRjrC9RZwfRBJzmoz18OdOJItjJkukNCKZNK5BgBPPQqW/y1FZ3270
 CcRGZnKcdV4CoS6od2JOOngfEj5LKpRXqmp1gzR3yTMfVTKtHHNpxZY6PagaIiIUOxl0
 Kq8kY0RYRuiMA9iF8dU5rxvPgXQjPnWHDwUh1XJHUkdVrAydmHdEichv7G+VSLvIv0gc
 CmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=cJ+kY4MqdpbUXLCMTfKhuudli9xfKAZEj3Kh1+n1es4=;
 b=Dzb9RFTHkkq2RsA5zMT7wvzXw2D/FXmeiUXw+SKRZLKKwbA00n+SBIskFy0eaikW9D
 MmH5fg/GVoCD8CuiVMuDNyYc5hgHzh8eDRiB+yNmV7N75mK3DOl9MIrMIk1I1+dDgSKa
 TDOhjh4HuGDoqF1DRhkjyj4w8alMy6K5WI1GMMUWFcdBKa08D1NZ9CEtWbkyoI/O7CLb
 NjbHOFRYHQwoezsq44LfRQEHcknNkSNWmVpj2ob6tO+l2YtxP3E5XrCHtYOK/s/VH60e
 B+o9221Fr89UfjNsrdBFDLxkyCHswuEjzrklqRJi0vRmr+mrDaqw2LFH4tLEyL66lpMn
 WsIQ==
X-Gm-Message-State: AOAM530jCGcStg06wL0hcWZ66d+kbN69EU3tVrZwag0LKni4W72tZvlZ
 Ac9EsK+HgPgB2LCzkwRh+cibTG4C8UwkgH8lvA==
X-Google-Smtp-Source: ABdhPJwsVkfdI7YTm9ZSYi9RIsUhiKI+naRmD0iCFwh5mTYfeIxEOuB/JwXMq08PtRNVUVrPaRZaCi6qhznqohD7Sg==
X-Received: by 2002:a17:90a:f014:: with SMTP id
 bt20mr284070pjb.0.1597106785160; 
 Mon, 10 Aug 2020 17:46:25 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:46:01 +0000
In-Reply-To: <20200811004607.2133149-1-hskinnemoen@google.com>
Message-Id: <20200811004607.2133149-8-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200811004607.2133149-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v7 07/13] hw/arm: Load -bios image as a boot ROM for npcm7xx
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, f4bug@amsat.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3YeoxXwsKCvwlwomrriqsirksskpi.gsquiqy-hiziprsrkry.svk@flex--hskinnemoen.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

If a -bios option is specified on the command line, load the image into
the internal ROM memory region, which contains the first instructions
run by the CPU after reset.

If -bios is not specified, the vbootrom included with qemu is loaded by
default.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 0b9dce2b35..26ea97072b 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -18,12 +18,38 @@
=20
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
+#include "hw/loader.h"
 #include "qapi/error.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
+#include "sysemu/sysemu.h"
=20
 #define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
 #define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
=20
+static const char npcm7xx_default_bootrom[] =3D "npcm7xx_bootrom.bin";
+
+static void npcm7xx_load_bootrom(NPCM7xxState *soc)
+{
+    g_autofree char *filename =3D NULL;
+    int ret;
+
+    if (!bios_name) {
+        bios_name =3D npcm7xx_default_bootrom;
+    }
+
+    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_report("Could not find ROM image '%s'", bios_name);
+        exit(1);
+    }
+    ret =3D load_image_mr(filename, &soc->irom);
+    if (ret < 0) {
+        error_report("Failed to load ROM image '%s'", filename);
+        exit(1);
+    }
+}
+
 static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
 {
     memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram=
);
@@ -60,6 +86,7 @@ static void npcm750_evb_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
+    npcm7xx_load_bootrom(soc);
     npcm7xx_load_kernel(machine, soc);
 }
=20
@@ -71,6 +98,7 @@ static void quanta_gsj_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
+    npcm7xx_load_bootrom(soc);
     npcm7xx_load_kernel(machine, soc);
 }
=20
--=20
2.28.0.236.gb10cc79966-goog


