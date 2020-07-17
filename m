Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA91C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434632071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1puZXUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434632071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJb8-0000iE-9h
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LT8RXwsKCu4XiaYddUceUdWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--hskinnemoen.bounces.google.com>)
 id 1jwJSy-0003i4-LD
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:28 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:37628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LT8RXwsKCu4XiaYddUceUdWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--hskinnemoen.bounces.google.com>)
 id 1jwJSx-0005HE-1w
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:28 -0400
Received: by mail-pg1-x549.google.com with SMTP id h5so7200291pgq.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=frc86mILmkHC+wqWcKw1PPJTa/OZk2Y3JpwlzSnJqMM=;
 b=T1puZXUBXlcMoWFROgqScO4xHSDWK+e87YnMYExRLrvuOElQ1MiJjWpRy9oWD00nYY
 e3TtVfyQq0btj5BpL9h1tTV1DmZzVGXo9203v9qOB8TJZ8rnGPebuQLb2Kk3p134Q6Z1
 ZmsxSzqlv6g77zysQCmoNU1qW9aPtyot4Z5ZFzJIC2wiyhORxU4jnnt6c1st8jaLuL/p
 qm1icrFywU5nfUrMZoYzntgvNw/wnDQ3OqMEDzikN0XG/+w5u+Su/Gq/XUJSkHUcgu+9
 Gyc8suo9S5Ld6gjeKt+tV/4vdUZFNmRF8dXZ2bJk3n5snZVsiasvCeL874XauV1DyrYk
 lVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=frc86mILmkHC+wqWcKw1PPJTa/OZk2Y3JpwlzSnJqMM=;
 b=BM3TItZxBLBSlXq7NQP9gDkAVBza+illoWn6sfkrUh2RemviqNcWxoZD12Lwr7Fkq3
 Gm9pAwXx5I/2BYSxqHAlhrKXl076EXYARXtxjN1dTgnElnmC1F+Bk4LQ3+7nIAAJFHYk
 F8q62+WcfFHPLYbRNdOUWraa4yts49lRrlEHU1x1eCtDf2U50YYFNOGMYmoi0c+iZkZR
 h22ukT+5+2P73hNtonzR6n+KMWWZir1pVNm0fRKMznG7GPSHnCq0kWu1BJqI8Kqnza3N
 9LOPXybW3foeeM3mryp5kNFKU3EouFXjBC0b7qbcSYp7Bfv4vkTE7MeaKtQmgnLhjfwo
 eTFg==
X-Gm-Message-State: AOAM532Hp8SU2YvfCJ3N1jCoqF6ABiJtz6+MO6tz9IBzpyXgcu7RxO7a
 HZa4u1s5tYRjoWZ3WkieDE1zmyEWvjZMKYAkgQkKaIMFcA3quJAT5RrheefmiwxKDdJD06KDRoc
 1gutfhXR3dUOSqXt85MnUY+LlesAZfUkhiKTMlfh/ODdjZHQDAoD5EQqoRFmGRR2xOYeP7DS6Dg
 ==
X-Google-Smtp-Source: ABdhPJyJcR0Nj1CMZAmFs/XMLczYOutOsMaasTMgPmxSpuR2lkPCg9vekBOeG1LGukIOwTfdWFEyVZYMrSP7UwdQcg==
X-Received: by 2002:a17:90b:194f:: with SMTP id
 nk15mr8495696pjb.189.1594965805094; 
 Thu, 16 Jul 2020 23:03:25 -0700 (PDT)
Date: Thu, 16 Jul 2020 23:02:52 -0700
In-Reply-To: <20200717060258.1602319-1-hskinnemoen@google.com>
Message-Id: <20200717060258.1602319-8-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v6 07/13] hw/arm: Load -bios image as a boot ROM for npcm7xx
From: Havard Skinnemoen <hskinnemoen@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3LT8RXwsKCu4XiaYddUceUdWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x549.google.com
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

If a -bios option is specified on the command line, load the image into
the internal ROM memory region, which contains the first instructions
run by the CPU after reset.

If -bios is not specified, the vbootrom included with qemu is loaded by
default.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 0b9dce2b35..f32557e0e1 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -18,12 +18,41 @@
 
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
+#include "hw/loader.h"
 #include "qapi/error.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
+#include "sysemu/sysemu.h"
 
 #define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
 #define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
 
+static const char npcm7xx_default_bootrom[] = "npcm7xx_bootrom.bin";
+
+static void npcm7xx_load_bootrom(NPCM7xxState *soc)
+{
+    g_autofree char *filename = NULL;
+    const char *bootrom;
+    int ret;
+
+    if (bios_name) {
+        bootrom = bios_name;
+    } else {
+        bootrom = npcm7xx_default_bootrom;
+    }
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bootrom);
+    if (!filename) {
+        error_report("Could not find ROM image '%s'", bootrom);
+        exit(1);
+    }
+    ret = load_image_mr(filename, &soc->irom);
+    if (ret < 0) {
+        error_report("Failed to load ROM image '%s'", filename);
+        exit(1);
+    }
+}
+
 static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
 {
     memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram);
@@ -60,6 +89,7 @@ static void npcm750_evb_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
+    npcm7xx_load_bootrom(soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -71,6 +101,7 @@ static void quanta_gsj_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
+    npcm7xx_load_bootrom(soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog


