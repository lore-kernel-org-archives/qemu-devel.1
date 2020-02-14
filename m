Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE1C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB0E2187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7oP71Tw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB0E2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2UMZ-00010Z-7e
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 01:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2ULq-0008Ry-Va
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2ULp-0007xR-Uh
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:21:22 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2ULm-0007t3-S7; Fri, 14 Feb 2020 01:21:18 -0500
Received: by mail-pf1-x443.google.com with SMTP id x185so4361603pfc.5;
 Thu, 13 Feb 2020 22:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oWX5NGUdCW690swjYtECXPxbffDj1syFks5kugYHzIQ=;
 b=c7oP71TwLVjH05aq/GGR8CWns8f/mHWlLTxUt+TUavDbBLBj0/bbvBwbNE0lrydnUF
 LBp5Up9d1PHEWLR5a5U/yUYVFHzjPGDsFlMmtjgWeXkTaNXTJNV9yvgA7ElIhIhcfPyM
 5JwKOiz/XNpzj+fcNCVL0ayQt26rXRtJSYwUeuIwdw9S6AIJiKkT7xiAtVEKtqvi4n1l
 uCv6qVmt/4DlSYw11mj2/lokWYjd3+RVzhKfPgD9STCXtAnvwfevytgkbtZ4yZ6Pi7cq
 7G4AkHPyZgITswwrCT5akSucrjfNILCduUkIGyZn9qPBpFolpabtheqaarhaZXM8OIuv
 McAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=oWX5NGUdCW690swjYtECXPxbffDj1syFks5kugYHzIQ=;
 b=dLvfqBWffahPwHNFEKPIddDPuX1SqFDQepDqSFHbG36VoRwIdzQi+qNJlJvQPkhqox
 +plykRoQQL9YBQQaZ0nNwX0lkcaZAcTWRJidEDdRndwR6Xqz+tQiV81RQ07h20siqSO2
 95sqHv5nyBmr6pZqNEh/0OHRgi2Q+joz4s8ChOESxDaq5je0XgdZW1CHPew4deZ3Gc6j
 uYUCQ8BfJuVdl67B3AkJU32vliAPbeN5xlgpnQQuhKQSmyUjrj2PhZo/9FKVWBKEtNLr
 EL0kRwscWQBV0GTVXkcyv53vAVJ080bfTCNGwbdCDjmOea4GkWBN4KzXF6eMdSz4bmoC
 P9DA==
X-Gm-Message-State: APjAAAV0R2CGRfR+A+FKoroxn678MbUTkbjd9CoO7RKs2rnFVxwhMEbW
 OAQiEZ9YLBpQ0Rg802XXAGI=
X-Google-Smtp-Source: APXvYqx1wOMCGKE2wWk5BmLpbEwrAwJSnuWmVd2Kp4ozNp6mWRQA7PY2oC7eDlNXOC8JtoitF+dl7w==
X-Received: by 2002:a63:4525:: with SMTP id s37mr1752683pga.418.1581661277905; 
 Thu, 13 Feb 2020 22:21:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id g2sm5383978pgn.59.2020.02.13.22.21.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Feb 2020 22:21:17 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/3] arm: allwinner: Wire up USB OHCI
Date: Thu, 13 Feb 2020 22:21:08 -0800
Message-Id: <20200214062109.24494-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214062109.24494-1-linux@roeck-us.net>
References: <20200214062109.24494-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initialize OHCI controllers on Allwinner A10. With this patch applied,
USB OHCI ports are discovered when booting the cubieboard machine with
a recent Linux kernel.

ohci-platform 1c14400.usb: Generic Platform OHCI controller
ohci-platform 1c14400.usb: new USB bus registered, assigned bus number 3
ohci-platform 1c14400.usb: irq 27, io mem 0x01c14400
ohci-platform 1c1c400.usb: Generic Platform OHCI controller
ohci-platform 1c1c400.usb: new USB bus registered, assigned bus number 4
ohci-platform 1c1c400.usb: irq 32, io mem 0x01c1c400

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/allwinner-a10.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/allwinner-a10.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 45cd8d2db5..818145428c 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -24,12 +24,15 @@
 #include "hw/arm/allwinner-a10.h"
 #include "hw/misc/unimp.h"
 #include "sysemu/sysemu.h"
+#include "hw/boards.h"
+#include "hw/usb/hcd-ohci.h"
 
 #define AW_A10_CCM_REG_BASE     0x01c20000
 #define AW_A10_PIC_REG_BASE     0x01c20400
 #define AW_A10_PIT_REG_BASE     0x01c20c00
 #define AW_A10_UART0_REG_BASE   0x01c28000
 #define AW_A10_EMAC_BASE        0x01c0b000
+#define AW_A10_OHCI_BASE        0x01c14400
 #define AW_A10_SATA_BASE        0x01c18000
 
 static void aw_a10_init(Object *obj)
@@ -53,6 +56,15 @@ static void aw_a10_init(Object *obj)
 
     sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
                           TYPE_ALLWINNER_AHCI);
+
+    if (machine_usb(current_machine)) {
+        int i;
+
+        for (i = 0; i < ARRAY_SIZE(s->ohci); i++) {
+            sysbus_init_child_obj(obj, "ohci[*]", OBJECT(&s->ohci[i]),
+                                  sizeof(s->ohci[i]), TYPE_SYSBUS_OHCI);
+        }
+    }
 }
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
@@ -133,6 +145,24 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2,
                    qdev_get_gpio_in(dev, 1),
                    115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+
+    if (machine_usb(current_machine)) {
+        int i;
+
+        for (i = 0; i < ARRAY_SIZE(s->ohci); i++) {
+
+            object_property_set_bool(OBJECT(&s->ohci[i]), true, "realized",
+                                     &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
+            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                            AW_A10_OHCI_BASE + i * 0x8000);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                               qdev_get_gpio_in(dev, 64 + i));
+        }
+    }
 }
 
 static void aw_a10_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 0007a927bb..4864adbec3 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -9,6 +9,7 @@
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/net/allwinner_emac.h"
 #include "hw/ide/ahci.h"
+#include "hw/usb/hcd-ohci.h"
 
 #include "target/arm/cpu.h"
 
@@ -29,6 +30,7 @@ typedef struct AwA10State {
     AwEmacState emac;
     AllwinnerAHCIState sata;
     MemoryRegion sram_a;
+    OHCISysBusState ohci[2];
 } AwA10State;
 
 #endif
-- 
2.17.1


