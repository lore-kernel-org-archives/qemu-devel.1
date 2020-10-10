Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046D0C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A46D22461
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBGnDAlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A46D22461
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRInb-0004H4-Mz
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdz-0000iU-N3
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdu-0003sU-HS
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id n6so13370382wrm.13
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tcSJN3WRYnSDrhVA+aXirUwwuRtaV2HQ16b4T6e3VA4=;
 b=RBGnDAlYMQWKKSWxw10Rs4ujxuZ9nfuKKS5hsDlQk+ZDWhCXTnqS+ZTlfTRd0x71yr
 51sQvX6Yro7KZkldlYA6hYGboTSWFQBUl1MVC68yHnwgj6eixEAYUlY8bNmuS3qWVZA4
 p0l6L//QDBnCfznY0O+u4BEjzi/B1tzlYvYe1pwS3N0NyU7l53pFKBhtxVIcL2zwSvgB
 eWG9l08RPoZ+gdn1KRPp71oht0GM2w7OHw/zLkUx6kxG2OqmESjV7EVMMASLQjUgHIWT
 yutpjWnCI/EbJlR1CR4VBz8y/rWquL3jlP3hb/VfXolE6VjvifU4Ojw91v4mhtTKPe+D
 Zx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tcSJN3WRYnSDrhVA+aXirUwwuRtaV2HQ16b4T6e3VA4=;
 b=IUUA1CVzPOeBwR7BCUBgCIOpwK6csJ01eaX8PhCKlEaEdV7X9I19wwHMA2tOx++YMY
 DkxnlwVODQlMEPWeMeirzzmguYHWX0aJvgkJDa82zEGrof2+2Nb5V4nd2/fZVyL0EbVf
 ZZo8AkUTFdVSsS4ZthLNsQqJzMXQRZVIg0TgIiQicreFeNBXTnYrBbCz98rg8O4SwgGv
 /jneUlEpTtNcBtnu/vVJvikQJ9sD10tFbg+/ATAKHLocuc3mShWsElxVhAs9oTwJ5eUB
 ghxfRVic5wnU7ZVG1XifggyiAs+ftlzlFl4i8gOqxJr6GFoDtQR6gWRraKqugq5+MWcM
 bTwA==
X-Gm-Message-State: AOAM531btIXAIqorWHeLkBE8fxtinlQr1QZ439RUY6+CiGpmRXvULV5F
 h09S8kLMSatCusBbn4u+gPI8eUYOYUQ=
X-Google-Smtp-Source: ABdhPJzj+dRgzxxSVZnpEvSCsQnsx7f4noyXJeWW2BnXbTjyVHF5MHlH2Ph3Wo3CyzsNwAvwHYvaTg==
X-Received: by 2002:adf:a50e:: with SMTP id i14mr17758194wrb.121.1602350801741; 
 Sat, 10 Oct 2020 10:26:41 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/20] hw/mips/cps: Expose input clock and connect it to
 CPU cores
Date: Sat, 10 Oct 2020 19:26:13 +0200
Message-Id: <20201010172617.3079633-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose a qdev input clock named 'clk', and connect it to each
core.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/mips/cps.h | 2 ++
 hw/mips/cps.c         | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 9e35a881366..859a8d4a674 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -21,6 +21,7 @@
 #define MIPS_CPS_H
 
 #include "hw/sysbus.h"
+#include "hw/clock.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/intc/mips_gic.h"
 #include "hw/misc/mips_cpc.h"
@@ -43,6 +44,7 @@ struct MIPSCPSState {
     MIPSGICState gic;
     MIPSCPCState cpc;
     MIPSITUState itu;
+    Clock *clock;
 };
 
 qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 23c0f87e41a..c332609f7b3 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "hw/mips/cps.h"
 #include "hw/mips/mips.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/mips/cpudevs.h"
 #include "sysemu/kvm.h"
@@ -38,6 +39,7 @@ static void mips_cps_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     MIPSCPSState *s = MIPS_CPS(obj);
 
+    s->clock = qdev_init_clock_in(DEVICE(obj), "clk", NULL, NULL);
     /*
      * Cover entire address space as there do not seem to be any
      * constraints for the base address of CPC and GIC.
@@ -80,6 +82,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                                       errp)) {
             return;
         }
+        qdev_connect_clock_in(DEVICE(cpu), "clk", s->clock);
 
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
             return;
-- 
2.26.2


