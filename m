Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B407C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442BA2068E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXzfT3N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442BA2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjVn9-0002ej-GF
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 18:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3kLDiXgsKCnkephfkkbjlbkdlldib.Zljnbjr-absbiklkdkr.lod@flex--hskinnemoen.bounces.google.com>)
 id 1jjVik-00041I-QT
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:30:50 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:34848)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3kLDiXgsKCnkephfkkbjlbkdlldib.Zljnbjr-absbiklkdkr.lod@flex--hskinnemoen.bounces.google.com>)
 id 1jjVii-00049Z-UF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:30:50 -0400
Received: by mail-yb1-xb49.google.com with SMTP id w9so8339388ybt.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=oSdui/Du7unAC6uctVO3rzywqjb0HcKiSu95MGjPi34=;
 b=tXzfT3N8pyKe8hMoNVzbztNe5BZdTMZxKYehpDacvvpxhEgL4PvzeLnW9lRR/gnJrF
 bWj7wOhwqoMrBAd0LRfmE1ywPuZwTQabE6tNBtnsWDTBNciGecy+RXP4kMXptVZ3N6g/
 ze/0tSEbL5uWYer7YwByBlcs+xlnqw/tMcep6Ogt7j/avDecSZYCNNbOIr5aDtSt0A1Q
 kQPyalCQEACpGHAxBiOKUsxgsyE3/neP3WFx2U/G4v9o0ZfUM9thDr4Pd6sHmoh9LjVN
 H20HGZiKOoSXF628as46B+TLSvRchhNsLXtepMefjgKvR5nUGfvN+cwPSTFkpQ8Y3mxl
 N0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=oSdui/Du7unAC6uctVO3rzywqjb0HcKiSu95MGjPi34=;
 b=YOWPRHXf+cXoHsu7sZIggWhDILmszPkJJ2Hw9iSX/SzKSVUJAjGoJDG10U5FokJcws
 ltAMZS4bsiWV6SNtUajSaHgbmuAde0rhoKXwiI16/V9yH/hSV2DF3Bith80/qPgFZdJ1
 Mm1W50pcr5Nvt3Yv6KaWncQW10KzQFyvMigLWj2oBFGCvw1ZSe6PO8OL+zre6UyFsRCc
 e8GbjGr5TD1Y9qlmeK3AgraCZEUqdbo1NzSAvnlWFL4O+mCdwkg9lb1O1Y1AyVUIhVYX
 JvaobmcbVeH9scq/VldsChBbOYwerQspTBCxfrhA84yWCyUGcULFPWA1ae7GFH+t6uNC
 SPPA==
X-Gm-Message-State: AOAM531lg++PTRIKc5f9oIfPZyPuJVimbevJBBgVUkvCnY0cq+SgxOfB
 uj243vnic+RfxMF/9JN6uEn1vOIQuWTJaONlhg==
X-Google-Smtp-Source: ABdhPJz8KHHNCqPidaGhncG+RfSlWVi4excxeEd/mURg7Ymfx4f9ssl7QG4b9QfJOb6n6h5mwpLhxw489sZ/4XqO4w==
X-Received: by 2002:a25:ce50:: with SMTP id x77mr18453626ybe.253.1591914640626; 
 Thu, 11 Jun 2020 15:30:40 -0700 (PDT)
Date: Thu, 11 Jun 2020 15:30:11 -0700
In-Reply-To: <20200611223016.259837-1-hskinnemoen@google.com>
Message-Id: <20200611223016.259837-8-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200611223016.259837-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH v2 07/12] hw/arm: Load -bios image as a boot ROM for npcm7xx
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3kLDiXgsKCnkephfkkbjlbkdlldib.Zljnbjr-absbiklkdkr.lod@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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

A minimal Apache-2.0-licensed boot ROM can be found at

https://github.com/google/vbootrom

It is by no means feature complete, but it is enough to launch the
Nuvoton bootblock[1] from offset 0 in the flash, which in turn will
launch u-boot and finally the Linux kernel.

[1] https://github.com/Nuvoton-Israel/bootblock

Change-Id: I41eae4fc7786d33f532c14087e930bf1b5012562
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index a5dbf08c00..417bc16b5c 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -22,6 +22,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "sysemu/sysemu.h"
 
@@ -270,6 +271,22 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(get_system_memory(), NPCM7XX_ROM_BA, &s->irom);
 
+    if (bios_name) {
+        g_autofree char *filename = NULL;
+        int ret;
+
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        if (!filename) {
+            error_setg(errp, "Could not find ROM image '%s'", bios_name);
+            return;
+        }
+        ret = load_image_mr(filename, &s->irom);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load ROM image '%s'", filename);
+            return;
+        }
+    }
+
     /* External DDR4 SDRAM */
     memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, s->dram);
 }
-- 
2.27.0.290.gba653c62da-goog


