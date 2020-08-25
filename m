Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF91C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977F62074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rJvFlbz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977F62074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAMjH-0004dO-Sw
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 20:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nlhEXwsKCmEGRJHMMDLNDMFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--hskinnemoen.bounces.google.com>)
 id 1kAMef-0004AY-UT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:17:37 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849]:56760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nlhEXwsKCmEGRJHMMDLNDMFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--hskinnemoen.bounces.google.com>)
 id 1kAMee-00068B-4F
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:17:37 -0400
Received: by mail-qt1-x849.google.com with SMTP id d24so8118706qtg.23
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 17:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc:content-transfer-encoding;
 bh=6BgkETAcTJ1Tm8Ekvmcx0mODyms04MyIwr14Jstxmpw=;
 b=rJvFlbz1MKK0e6w97fF74oGphSjk5uDVMdaN73C4E0YLsQihc5EbVHb3pVx7Bl/GYL
 QUh5D2VYpU3VjD2HB6EqApjN126oZJTlpA4ib3+tU3V4IZUXAokNjbmNBU02aheh0K/l
 slINJmutbPwzRJzMuEL5pEK5qLn9y06feya9kdcf6AC9cU3e+F2b4HNH0BXvrnR2IDvh
 FMGp8vCtaopX8q7u/CLWe/rMxySckIRuXEJIfUGpYIXO92QWprxVF9DGjcAC9DkaMXLQ
 veqMlaNKxrQGx29FwGYNlaE7iHlLKhkzoG2w7iy/Fn7RN5vqdcPFMHI3jvROTk9cbHr9
 hPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=6BgkETAcTJ1Tm8Ekvmcx0mODyms04MyIwr14Jstxmpw=;
 b=cKScYBsUSU8efZ7scyFCk8FSmtYuOoPfhmV/Hdf9g+7Ib76gmOybGkI3ajIeka6eb/
 PELg94ed2TRwRygAyvOOLtm53qZ7/Nm3yLuKC9vDTsWAKY6kgTJ3HlSThFkLkFw25Ev4
 1O7yYmRFKNt1lQjmoJ8eSJ4Jn4P3sxFEAPHTkPnrftvH5dDXARd37025dwCmdQSZBVJS
 9Y7bHLlSg0txbuUJ22C2BWVNMrIrDpeVMKSk+Mli3kcKN+s1d1hkgZkHq1/wiiD8IeTw
 nmtwExz1Tn96A9uu5XgCivoGCHbf6JZlkdVbaMoHEWV1ZKF8GU3P3bX9mAbAa31erxYc
 E3bQ==
X-Gm-Message-State: AOAM532sf4PdOJQvvHVS2pk18DmA+B9uuyDGXyIzTD+nacZMJcA4sPVe
 URdVcxluHrA9qQRDQHYjOa7AIVtprmIUP8MoEg==
X-Google-Smtp-Source: ABdhPJw9SCvg2+05LgnpO11Buz0X2MQ7jNORQkNYR4JQBCOCq8OHI+RnKVnftGiAWJMknX0efrJAvjOgt1NWBuIp0w==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a0c:ff06:: with SMTP id
 w6mr7437735qvt.61.1598314654879; Mon, 24 Aug 2020 17:17:34 -0700 (PDT)
Date: Mon, 24 Aug 2020 17:17:04 -0700
In-Reply-To: <20200825001711.1340443-1-hskinnemoen@google.com>
Message-Id: <20200825001711.1340443-8-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200825001711.1340443-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v8 07/14] hw/arm: Load -bios image as a boot ROM for npcm7xx
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=3nlhEXwsKCmEGRJHMMDLNDMFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x849.google.com
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
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 0b9dce2b35..b67e45e913 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -18,12 +18,43 @@
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
+static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState *soc)
+{
+    g_autofree char *filename =3D NULL;
+    int ret;
+
+    if (machine->kernel_filename) {
+        /* Don't load the bootrom if user requested direct kernel boot. */
+        return;
+    }
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
@@ -60,6 +91,7 @@ static void npcm750_evb_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
+    npcm7xx_load_bootrom(machine, soc);
     npcm7xx_load_kernel(machine, soc);
 }
=20
@@ -71,6 +103,7 @@ static void quanta_gsj_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
=20
+    npcm7xx_load_bootrom(machine, soc);
     npcm7xx_load_kernel(machine, soc);
 }
=20
--=20
2.28.0.297.g1956fa8f8d-goog


