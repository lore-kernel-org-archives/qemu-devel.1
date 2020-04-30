Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF07BC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CE020757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVMjoUW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CE020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7nO-00034A-NV
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jO-0002ee-QY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jO-0000Kc-3Q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jN-0000K0-LN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id 188so1511224wmc.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=E6VqovrvHpgQrx8t2mX5Zs5JVaWsOq4hn1vYLIHJajw=;
 b=oVMjoUW/k8Bxe1ItZhqBkmLhKz+RGLhk98isVWoAjpXcl7doohab4OB7Rgbjz1j4b4
 4FqxSwbfgNiqNV+UncUW0g9QotwsOfZA0zfsBLNn9dV9maTQwRCINUyYv0ATqesmuXDB
 woJQkwzpbRBrnAls+3GLn+WgfPENjD4b9eX48aCUf4yz+XnQq28d809kR0pYoORHBzLL
 is+Z7WvUEFsuoFgkWyXvkgULdDkFdpnaKxg8PirY7Bw8pnEWX5oaR/voRNlIuQ1yz5/Y
 fSDRuRnOD1gBPk3s4p0LLCuAcODb18EUu6YOLeRwC/4ZtfH4kiqiCkRsVLQFkLas/Ru4
 d2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E6VqovrvHpgQrx8t2mX5Zs5JVaWsOq4hn1vYLIHJajw=;
 b=oEBtBAyqaYqmD6QWPc2+5BsRUvZ+RwPEJzl1NR/jSM7MNN70WghGi/F4IT55piz6ii
 ag19Cwh0BjMH7qXv//WbgFl3k1dNOlxkVNB6AlJH+WebJrnesjJ9UfOOVc1NdZ01x5TT
 3KG0WvLa8fzLY/dsahe/0zRSUwt2lv4r3qsGqrBZPrn1YRPZg325+NzOXrzWCPJlr59Z
 vqFYXrC5uEidusgtRpC9rvnqaEOMnQcJMNyBYpCK7a8MqWFQGKwCB423CNQnY0cfVTmd
 dilQuKn1M378lIftVyDpW1IlUIMsG5/NSkDfEVrGL5lFICrMhbrgvhzJuyJwqXPjD727
 J2HQ==
X-Gm-Message-State: AGi0PuapebpYPLhO47gV7u8XxO5gPQ167kFK126kgEXbMnXQcuFmXYqE
 D1bwP8OT7r9mwQ0lHQdbrxEn2VpcBIITOg==
X-Google-Smtp-Source: APiQypKitfEk37QGTQwWq95EJVrf+vw01IZiB91q6Jt3lOWE6na/6VX2BSwmcw/wntVpqx3X8n40qA==
X-Received: by 2002:a7b:c250:: with SMTP id b16mr2683559wmj.100.1588247511952; 
 Thu, 30 Apr 2020 04:51:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/31] msf2: Add EMAC block to SmartFusion2 SoC
Date: Thu, 30 Apr 2020 12:51:18 +0100
Message-Id: <20200430115142.13430-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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

From: Subbaraya Sundeep <sundeep.lkml@gmail.com>

With SmartFusion2 Ethernet MAC model in
place this patch adds the same to SoC.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1587048891-30493-3-git-send-email-sundeep.lkml@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/msf2-soc.h |  2 ++
 hw/arm/msf2-soc.c         | 26 ++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index 3cfe5c76ee2..c9cb214aa67 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -29,6 +29,7 @@
 #include "hw/timer/mss-timer.h"
 #include "hw/misc/msf2-sysreg.h"
 #include "hw/ssi/mss-spi.h"
+#include "hw/net/msf2-emac.h"
 
 #define TYPE_MSF2_SOC     "msf2-soc"
 #define MSF2_SOC(obj)     OBJECT_CHECK(MSF2State, (obj), TYPE_MSF2_SOC)
@@ -62,6 +63,7 @@ typedef struct MSF2State {
     MSF2SysregState sysreg;
     MSSTimerState timer;
     MSSSpiState spi[MSF2_NUM_SPIS];
+    MSF2EmacState emac;
 } MSF2State;
 
 #endif
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 588d643b8d2..a455b8831ff 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -1,7 +1,7 @@
 /*
  * SmartFusion2 SoC emulation.
  *
- * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
+ * Copyright (c) 2017-2020 Subbaraya Sundeep <sundeep.lkml@gmail.com>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -35,11 +35,14 @@
 
 #define MSF2_TIMER_BASE       0x40004000
 #define MSF2_SYSREG_BASE      0x40038000
+#define MSF2_EMAC_BASE        0x40041000
 
 #define ENVM_BASE_ADDRESS     0x60000000
 
 #define SRAM_BASE_ADDRESS     0x20000000
 
+#define MSF2_EMAC_IRQ         12
+
 #define MSF2_ENVM_MAX_SIZE    (512 * KiB)
 
 /*
@@ -81,6 +84,13 @@ static void m2sxxx_soc_initfn(Object *obj)
         sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
                           TYPE_MSS_SPI);
     }
+
+    sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac),
+                          TYPE_MSS_EMAC);
+    if (nd_table[0].used) {
+        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
+        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
+    }
 }
 
 static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -192,6 +202,19 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         g_free(bus_name);
     }
 
+    dev = DEVICE(&s->emac);
+    object_property_set_link(OBJECT(&s->emac), OBJECT(get_system_memory()),
+                             "ahb-bus", &error_abort);
+    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, MSF2_EMAC_BASE);
+    sysbus_connect_irq(busdev, 0,
+                       qdev_get_gpio_in(armv7m, MSF2_EMAC_IRQ));
+
     /* Below devices are not modelled yet. */
     create_unimplemented_device("i2c_0", 0x40002000, 0x1000);
     create_unimplemented_device("dma", 0x40003000, 0x1000);
@@ -202,7 +225,6 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("can", 0x40015000, 0x1000);
     create_unimplemented_device("rtc", 0x40017000, 0x1000);
     create_unimplemented_device("apb_config", 0x40020000, 0x10000);
-    create_unimplemented_device("emac", 0x40041000, 0x1000);
     create_unimplemented_device("usb", 0x40043000, 0x1000);
 }
 
-- 
2.20.1


