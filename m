Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D27C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC1A206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqwnYP5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC1A206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssjC-00039v-Og
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VsMEXwsKCu0WhZXccTbdTcVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--hskinnemoen.bounces.google.com>)
 id 1jssdG-0000Ng-H6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:54 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a]:38342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VsMEXwsKCu0WhZXccTbdTcVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--hskinnemoen.bounces.google.com>)
 id 1jssdE-0007ar-33
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:54 -0400
Received: by mail-qt1-x84a.google.com with SMTP id 71so23357556qte.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=VbDO2mkLoftcJxkNlO9sINkU2IM/6wHFBs/gYcP1ZDQ=;
 b=DqwnYP5q06qqVSvqj+cNub5kNydEGIA5OCMspBQtFQqIOXOD3s5Zd3tCOmf8tfgP8t
 8NCXWNZpOUEHsLv7e+7lQqYiz6YY1O5vvplm+NuhBHln3Lk/P2vadJiqriBeCV25YKqS
 Hw3Kj/L8sYSELg/KugyeAdF7hPTudTqX9IsFgv2Y4h9uPan+gtPccgLgXOmYp+qZUfDA
 FfZ7Yq3w+krgZRNVrBDvzJH72a04PoTaUGQHJkiiIDUL+c/zlVEi7mVEdLw1t20dlxOH
 a9uUIrnFaUIXYLWLBMbAT2iq9VvJoeFNvgaeKAFWgecqiX6IJ3BMZScjQ9WRMsm5USl/
 G4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=VbDO2mkLoftcJxkNlO9sINkU2IM/6wHFBs/gYcP1ZDQ=;
 b=ahIdADl0F6awcMB7kJd47V3KOclqGDkrnk5BGunQtv2yqVIapbStw518T9PZM8Dwen
 qJt+jZincpayjjKVmfNyhWW/0QAD1rxxfPBAW7TgyP1c+a/7nuy5vOOOwGnaVrH5n0J5
 Ur8ifxgBNN9ps3c/CuOdLrCKuBeTWz7BzmF+RRc7j5R6LhUdKRAgogzNt4+AX+tSZerr
 p0TINLfKQIsxSDilOsxm44shSsfMlgHx/JApt2LUJ7POkr8gOEF5xzYEtY/pVDGZ15Wi
 JmDaFqsuMPw5NL9WtsEgqQizKNnUvOnCkQyOB8E3habXhInKtBU+DqX6Wfr+vUZzOXL4
 U6Xw==
X-Gm-Message-State: AOAM533ZtT0WOWDgUs0XKNV8ffCdjvTTrK/CrqrjbEKzfsonCtkN9vKE
 SYfRk2PWrCXlIFGuNrq7syFjyooqnh3Bt3t84w==
X-Google-Smtp-Source: ABdhPJx9Mhu5SqfL9FLfxzy8fWoCnvCz8BdFs1nUMdVziaqhzB59FARX+Q6Hb8e3dxIhPKAjFKpvvcilALZIWhht6g==
X-Received: by 2002:ad4:57c4:: with SMTP id y4mr51685670qvx.230.1594147670847; 
 Tue, 07 Jul 2020 11:47:50 -0700 (PDT)
Date: Tue,  7 Jul 2020 11:47:25 -0700
In-Reply-To: <20200707184730.3047754-1-hskinnemoen@google.com>
Message-Id: <20200707184730.3047754-8-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 07/12] hw/arm: Load -bios image as a boot ROM for npcm7xx
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, philmd@redhat.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3VsMEXwsKCu0WhZXccTbdTcVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x84a.google.com
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

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 205243cde6..de2d2ca786 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -19,8 +19,11 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
+#include "hw/loader.h"
 #include "qapi/error.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
+#include "sysemu/sysemu.h"
 
 #define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
 #define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
@@ -34,6 +37,25 @@ static struct arm_boot_info npcm7xx_binfo = {
     .board_id           = -1,
 };
 
+static void npcm7xx_load_bootrom(NPCM7xxState *soc)
+{
+    if (bios_name) {
+        g_autofree char *filename = NULL;
+        int ret;
+
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        if (!filename) {
+            error_report("Could not find ROM image '%s'", bios_name);
+            exit(1);
+        }
+        ret = load_image_mr(filename, &soc->irom);
+        if (ret < 0) {
+            error_report("Failed to load ROM image '%s'", filename);
+            exit(1);
+        }
+    }
+}
+
 static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
 {
     NPCM7xxClass *sc = NPCM7XX_GET_CLASS(soc);
@@ -66,7 +88,7 @@ static void npcm750_evb_init(MachineState *machine)
     NPCM7xxState *soc;
 
     soc = npcm7xx_create_soc(machine, NPCM750_EVB_POWER_ON_STRAPS);
-
+    npcm7xx_load_bootrom(soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -75,7 +97,7 @@ static void quanta_gsj_init(MachineState *machine)
     NPCM7xxState *soc;
 
     soc = npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
-
+    npcm7xx_load_bootrom(soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
-- 
2.27.0.212.ge8ba1cc988-goog


