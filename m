Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B87EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47C621D81
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jE2aiTlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47C621D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGbZr-0007ag-T3
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 01:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3UwlbXwsKCtI5G86BB2AC2B4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--hskinnemoen.bounces.google.com>)
 id 1kGbV1-0006Tw-3o
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:27 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:45551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3UwlbXwsKCtI5G86BB2AC2B4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--hskinnemoen.bounces.google.com>)
 id 1kGbUz-0002Nt-8q
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:26 -0400
Received: by mail-pg1-x54a.google.com with SMTP id r2so5300592pga.12
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc:content-transfer-encoding;
 bh=3jDWACyK/zOqzUOXXLdjkBMSd4R2+fDPo6ekFqcl1u0=;
 b=jE2aiTlzAeisrTlk061apG4pcwwBA0c4tYBlVG3rDnQxMfn3qSE9Gt0BUkoJGrVbzj
 tZuYXSfrt7sKQ4kaQZJqB4dag9mafjNbzh7dczZ6zje3UtTXUO8tGN5gGGnUNO+RBiXc
 aDjaewl6G05YXXrEKWRj40hbPTh/1sMt7EWICJfr2DE3woDhu85lq5f0UEUgdt7oxCdk
 PPx0Xu3UfrN5LqYTZmrqK6GGmDLKGb/mIsOQj8kJh31Cz4KhpKbjs+heAetceOTpf6Ys
 U8q9QoI2BjO52hYgW4xRnordVrnoVCrL/3F5SmgI31mSa8JIUiwprGibHiW2PsCGYkET
 Yp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=3jDWACyK/zOqzUOXXLdjkBMSd4R2+fDPo6ekFqcl1u0=;
 b=AIxtPkkBciDWM1dHrEsxYaF1caGzq2XErgLKiXlk8AF2l0SRgJc3i3GjrzXOGzmJFC
 SHNNedLhWHeG2Lk8UdM/9T8/5IukwbjU8z5g9USeamahJipKAsa5I5BByPLPkZAbe5jN
 iLLhxpO75IyZ13DZgeoh4eOOuja5MGXT8OD3HVPTYY6taGgqcyeFBkAVOUUuvCtgxGXV
 FHjYf2wh+ZH6gvlQc9ZMb9Vl2MgBlXO/O48JtiTa66/tqSli1AtlPTLf9kFwMr9p2lW8
 SOT7bqOPyCuAEH2Folif3/jpwcHIAUKZuR8hqOjJp6MH04lTqcwibvzZBJd4VtJYwxIm
 1rug==
X-Gm-Message-State: AOAM530BCSWeA+T44QaH1nWEIVWahWeplbDB7Zwnfdj7hZAzZdRbgPaX
 p1P/WxjKigL5ZZLun8uhW09yF+gIM+vYROuvtQ==
X-Google-Smtp-Source: ABdhPJxaDGq5xfwyqgFVquIhDJyMHme1tuBzmzcOSoJflQHzY5bm1FNs/WszvoqYq+nSL4pyNuXK/cyNBAlpSjjVYA==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by
 2002:a17:902:fe0b:b029:d1:9bd3:6e20 with
 SMTP id g11-20020a170902fe0bb02900d19bd36e20mr683762plj.31.1599801683638;
 Thu, 10 Sep 2020 22:21:23 -0700 (PDT)
Date: Thu, 10 Sep 2020 22:20:54 -0700
In-Reply-To: <20200911052101.2602693-1-hskinnemoen@google.com>
Message-Id: <20200911052101.2602693-8-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200911052101.2602693-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v9 07/14] hw/arm: Load -bios image as a boot ROM for npcm7xx
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3UwlbXwsKCtI5G86BB2AC2B4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

If a -bios option is specified on the command line, load the image into
the internal ROM memory region, which contains the first instructions
run by the CPU after reset.

If -bios is not specified, the vbootrom included with qemu is loaded by
default.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 939391c3a3..b4c772d6b5 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -19,12 +19,42 @@
 #include "exec/address-spaces.h"
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
+static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState *soc)
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
+        if (!machine->kernel_filename) {
+            /* We can't boot without a bootrom or a kernel image. */
+            exit(1);
+        }
+        return;
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
@@ -61,6 +91,7 @@ static void npcm750_evb_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
+    npcm7xx_load_bootrom(machine, soc);
     npcm7xx_load_kernel(machine, soc);
 }
=20
@@ -72,6 +103,7 @@ static void quanta_gsj_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
+    npcm7xx_load_bootrom(machine, soc);
     npcm7xx_load_kernel(machine, soc);
 }
=20
--=20
2.28.0.526.ge36021eeef-goog


