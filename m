Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17F1C54FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC146206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A25hrsUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC146206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG821-0004hU-PM
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jG80M-0002sR-L0
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jG80K-0002k8-Qe
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:34 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jG80J-0002j6-1v; Sun, 22 Mar 2020 17:19:31 -0400
Received: by mail-pl1-x641.google.com with SMTP id x1so978020plm.4;
 Sun, 22 Mar 2020 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZgsMGDELhEF4+TgSqBXZBt/v6x4+MShoKiq5mNYxWWg=;
 b=A25hrsUrd/dKrtFHB5tKa2BzGOw5+Hx3G87LBJdA0z3XnaKrWzxAVg+0j5XHIXyVYu
 n7w9rgv3mvOr7VQSkulLA8prfYEfUNEQZY+QbFjQ6tBJ5tGrHOzo2LhiHmb7xl4HvenT
 m+CaVpfn8K60oGL4+S25dhDG1i4hF1FGGg9InVXB/1rdIpDHMZKHxtKD3dA3GSG0WYKQ
 q+9+jztvBMdlSCeI8wfkSXDUPrAA9rhbsQYhRXlW0CWev7WCzQAFabQkdve8eCnbzSCV
 ke4qr+ZtO0Hea9X6ndC/LNGLmfgcJnq1uo9vMQ5PoyvrmZ10TkkT+lmPTPNmP4ZnnO5S
 tLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ZgsMGDELhEF4+TgSqBXZBt/v6x4+MShoKiq5mNYxWWg=;
 b=oonyrJDho8VzeLLmJTnTfRmMagcAE3c+c7wt0Jf8kGhkwAXD3nv4fpOCLsEKcAEN30
 yCN2dqe6Ykci0Az+mPKEnCP8V8zSIwrDp960NeprvC8gl6j/WyKcQFIGBgGppVsKJo15
 N8OGReAnDk+MFEG0mdeS8+iLgWA+F3AZE6mmQXcfMy8MYoT32ib/5PlKSjuwaTSgfgV+
 1Vk6DcZQmCsFwdCF6zNyFjWAFRk6hb4QaiNXkhYbTlOtOfeRbMB0OKKK43YbSGFNP+5d
 kmOARQhQbvxxDcorLEIoRw3kaZsuQnRaFqd63h40kfrRfkdEmGsesSDkYk1oKqB6zsjM
 eE3w==
X-Gm-Message-State: ANhLgQ1vjIOiclyfgi757J/dHtoIH3xwZmSpNMcSEiLk8lNFIBeKvq4f
 qbpdGduAXKdQwL/uOKJzZYk=
X-Google-Smtp-Source: ADFU+vstY6i3J5txkInGpGH7IwzCdYCiRYZgT5fAwYYG20/u08QYVju2dkW1ACorAMIC3tkWccReHQ==
X-Received: by 2002:a17:90b:1b05:: with SMTP id
 nu5mr8439811pjb.110.1584911969517; 
 Sun, 22 Mar 2020 14:19:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id f6sm11992971pfk.99.2020.03.22.14.19.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 22 Mar 2020 14:19:29 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/8] hw/watchdog: Implement full i.MX watchdog support
Date: Sun, 22 Mar 2020 14:19:13 -0700
Message-Id: <20200322211919.11335-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322211919.11335-1-linux@roeck-us.net>
References: <20200322211919.11335-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement full support for the watchdog in i.MX systems.
Pretimeout support is optional because the watchdog hardware on i.MX31
does not support pretimeouts.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fixup of CONFIG_WDT_IMX -> CONFIG_WDT_IMX2 moved to patch 1/8

 hw/watchdog/wdt_imx2.c         | 196 +++++++++++++++++++++++++++++++--
 include/hw/watchdog/wdt_imx2.h |  49 ++++++++-
 2 files changed, 231 insertions(+), 14 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index ad1ef02e9e..f5339f3590 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -13,24 +13,157 @@
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "sysemu/watchdog.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
 
 #include "hw/watchdog/wdt_imx2.h"
 
-#define IMX2_WDT_WCR_WDA    BIT(5)      /* -> External Reset WDOG_B */
-#define IMX2_WDT_WCR_SRS    BIT(4)      /* -> Software Reset Signal */
+static void imx2_wdt_interrupt(void *opaque)
+{
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    s->wicr |= IMX2_WDT_WICR_WTIS;
+    qemu_set_irq(s->irq, 1);
+}
 
-static uint64_t imx2_wdt_read(void *opaque, hwaddr addr,
-                              unsigned int size)
+static void imx2_wdt_expired(void *opaque)
 {
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    s->wrsr = IMX2_WDT_WRSR_TOUT;
+
+    /* Perform watchdog action if watchdog is enabled */
+    if (s->wcr & IMX2_WDT_WCR_WDE) {
+        watchdog_perform_action();
+    }
+}
+
+static void imx2_wdt_reset(DeviceState *dev)
+{
+    IMX2WdtState *s = IMX2_WDT(dev);
+
+    s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
+    s->wsr = 0;
+    s->wrsr &= ~(IMX2_WDT_WRSR_TOUT | IMX2_WDT_WRSR_SFTW);
+    s->wicr = 4;
+    s->wmcr = IMX2_WDT_WMCR_PDE;
+}
+
+static uint64_t imx2_wdt_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    switch (addr) {
+    case IMX2_WDT_WCR:
+        return s->wcr;
+    case IMX2_WDT_WSR:
+        return s->wsr;
+    case IMX2_WDT_WRSR:
+        return s->wrsr;
+    case IMX2_WDT_WICR:
+        return s->wicr;
+    case IMX2_WDT_WMCR:
+        return s->wmcr;
+    }
     return 0;
 }
 
+static void imx_wdt2_update_itimer(IMX2WdtState *s, bool start)
+{
+    bool running = (s->wcr & IMX2_WDT_WCR_WDE) && (s->wcr & IMX2_WDT_WCR_WT);
+    bool enabled = s->wicr & IMX2_WDT_WICR_WIE;
+
+    ptimer_transaction_begin(s->itimer);
+    if (start || !enabled) {
+        ptimer_stop(s->itimer);
+    }
+    if (running && enabled) {
+        int count = ptimer_get_count(s->timer);
+        int pretimeout = s->wicr & IMX2_WDT_WICR_WICT;
+
+        /*
+         * Only (re-)start pretimeout timer if its counter value is larger
+         * than 0. Otherwise it will fire right away and we'll get an
+         * interrupt loop.
+         */
+        if (count > pretimeout) {
+            ptimer_set_count(s->itimer, count - pretimeout);
+            if (start) {
+                ptimer_run(s->itimer, 1);
+            }
+        }
+    }
+    ptimer_transaction_commit(s->itimer);
+}
+
+static void imx_wdt2_update_timer(IMX2WdtState *s, bool start)
+{
+    ptimer_transaction_begin(s->timer);
+    if (start) {
+        ptimer_stop(s->timer);
+    }
+    if ((s->wcr & IMX2_WDT_WCR_WDE) && (s->wcr & IMX2_WDT_WCR_WT)) {
+        int count = (s->wcr & IMX2_WDT_WCR_WT) >> 8;
+
+        ptimer_set_count(s->timer, count);
+        if (start) {
+            ptimer_run(s->timer, 1);
+        }
+    }
+    ptimer_transaction_commit(s->timer);
+    if (s->pretimeout_support) {
+        imx_wdt2_update_itimer(s, start);
+    }
+}
+
 static void imx2_wdt_write(void *opaque, hwaddr addr,
                            uint64_t value, unsigned int size)
 {
-    if (addr == IMX2_WDT_WCR &&
-        (~value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS))) {
-        watchdog_perform_action();
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    switch (addr) {
+    case IMX2_WDT_WCR:
+        s->wcr = value;
+        if (!(value & IMX2_WDT_WCR_SRS)) {
+            s->wrsr = IMX2_WDT_WRSR_SFTW;
+        }
+        if (!(value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS)) ||
+            (!(value & IMX2_WDT_WCR_WT) && (value & IMX2_WDT_WCR_WDE))) {
+            watchdog_perform_action();
+        }
+        s->wcr |= IMX2_WDT_WCR_SRS;
+        imx_wdt2_update_timer(s, true);
+        break;
+    case IMX2_WDT_WSR:
+        if (s->wsr == IMX2_WDT_SEQ1 && value == IMX2_WDT_SEQ2) {
+            imx_wdt2_update_timer(s, false);
+        }
+        s->wsr = value;
+        break;
+    case IMX2_WDT_WRSR:
+        break;
+    case IMX2_WDT_WICR:
+        if (!s->pretimeout_support) {
+            return;
+        }
+        /* The pretimeout value is write-once */
+        if (s->pretimeout_locked) {
+            value &= ~IMX2_WDT_WICR_WICT;
+            s->wicr &= (IMX2_WDT_WICR_WTIS | IMX2_WDT_WICR_WICT);
+        } else {
+            s->wicr &= IMX2_WDT_WICR_WTIS;
+        }
+        s->wicr |= value & (IMX2_WDT_WICR_WIE | IMX2_WDT_WICR_WICT);
+        if (value & IMX2_WDT_WICR_WTIS) {
+            s->wicr &= ~IMX2_WDT_WICR_WTIS;
+            qemu_set_irq(s->irq, 0);
+        }
+        imx_wdt2_update_itimer(s, true);
+        s->pretimeout_locked = true;
+        break;
+    case IMX2_WDT_WMCR:
+        s->wmcr = value & IMX2_WDT_WMCR_PDE;
+        break;
     }
 }
 
@@ -45,28 +178,67 @@ static const MemoryRegionOps imx2_wdt_ops = {
          * real device but in practice there is no reason for a guest
          * to access this device unaligned.
          */
-        .min_access_size = 4,
-        .max_access_size = 4,
+        .min_access_size = 2,
+        .max_access_size = 2,
         .unaligned = false,
     },
 };
 
+static const VMStateDescription vmstate_imx2_wdt = {
+    .name = "imx2.wdt",
+    .fields = (VMStateField[]) {
+        VMSTATE_PTIMER(timer, IMX2WdtState),
+        VMSTATE_PTIMER(itimer, IMX2WdtState),
+        VMSTATE_BOOL(pretimeout_locked, IMX2WdtState),
+        VMSTATE_UINT16(wcr, IMX2WdtState),
+        VMSTATE_UINT16(wsr, IMX2WdtState),
+        VMSTATE_UINT16(wrsr, IMX2WdtState),
+        VMSTATE_UINT16(wmcr, IMX2WdtState),
+        VMSTATE_UINT16(wicr, IMX2WdtState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void imx2_wdt_realize(DeviceState *dev, Error **errp)
 {
     IMX2WdtState *s = IMX2_WDT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     memory_region_init_io(&s->mmio, OBJECT(dev),
                           &imx2_wdt_ops, s,
-                          TYPE_IMX2_WDT".mmio",
-                          IMX2_WDT_REG_NUM * sizeof(uint16_t));
-    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+                          TYPE_IMX2_WDT,
+                          IMX2_WDT_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->timer = ptimer_init(imx2_wdt_expired, s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_freq(s->timer, 2);
+    ptimer_set_limit(s->timer, 0xff, 1);
+    ptimer_transaction_commit(s->timer);
+    if (s->pretimeout_support) {
+        s->itimer = ptimer_init(imx2_wdt_interrupt, s, PTIMER_POLICY_DEFAULT);
+        ptimer_transaction_begin(s->itimer);
+        ptimer_set_freq(s->itimer, 2);
+        ptimer_set_limit(s->itimer, 0xff, 1);
+        ptimer_transaction_commit(s->itimer);
+    }
 }
 
+static Property imx2_wdt_properties[] = {
+    DEFINE_PROP_BOOL("pretimeout-support", IMX2WdtState, pretimeout_support,
+                     false),
+};
+
 static void imx2_wdt_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    device_class_set_props(dc, imx2_wdt_properties);
     dc->realize = imx2_wdt_realize;
+    dc->reset = imx2_wdt_reset;
+    dc->vmsd = &vmstate_imx2_wdt;
+    dc->desc = "i.MX watchdog timer";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index b91b002528..bed7aa6835 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -12,22 +12,67 @@
 #ifndef IMX2_WDT_H
 #define IMX2_WDT_H
 
+#include "qemu/bitops.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "hw/ptimer.h"
 
 #define TYPE_IMX2_WDT "imx2.wdt"
 #define IMX2_WDT(obj) OBJECT_CHECK(IMX2WdtState, (obj), TYPE_IMX2_WDT)
 
 enum IMX2WdtRegisters {
-    IMX2_WDT_WCR     = 0x0000,
-    IMX2_WDT_REG_NUM = 0x0008 / sizeof(uint16_t) + 1,
+    IMX2_WDT_WCR  = 0x0000, /* Control Register */
+    IMX2_WDT_WSR  = 0x0002, /* Service Register */
+    IMX2_WDT_WRSR = 0x0004, /* Reset Status Register */
+    IMX2_WDT_WICR = 0x0006, /* Interrupt Control Register */
+    IMX2_WDT_WMCR = 0x0008, /* Misc Register */
 };
 
+#define IMX2_WDT_MMIO_SIZE 0x000a
+
+/* Control Register definitions */
+#define IMX2_WDT_WCR_WT         (0xFF << 8) /* Watchdog Timeout Field */
+#define IMX2_WDT_WCR_WDA        BIT(5)      /* WDOG Assertion */
+#define IMX2_WDT_WCR_SRS        BIT(4)      /* Software Reset Signal */
+#define IMX2_WDT_WCR_WDT        BIT(3)      /* WDOG Timeout Assertion */
+#define IMX2_WDT_WCR_WDE        BIT(2)      /* Watchdog Enable */
+#define IMX2_WDT_WCR_WDZST      BIT(0)      /* Watchdog Timer Suspend */
+
+/* Service Register definitions */
+#define IMX2_WDT_SEQ1           0x5555      /* service sequence 1 */
+#define IMX2_WDT_SEQ2           0xAAAA      /* service sequence 2 */
+
+/* Reset Status Register definitions */
+#define IMX2_WDT_WRSR_TOUT      BIT(1)      /* Reset due to Timeout */
+#define IMX2_WDT_WRSR_SFTW      BIT(0)      /* Reset due to Timeout */
+
+/* Interrupt Control Register definitions */
+#define IMX2_WDT_WICR_WIE       BIT(15)     /* Interrupt Enable */
+#define IMX2_WDT_WICR_WTIS      BIT(14)     /* Interrupt Status */
+#define IMX2_WDT_WICR_WICT      0xff        /* Interrupt Timeout */
+
+/* Misc Control Register definitions */
+#define IMX2_WDT_WMCR_PDE       BIT(0)      /* Power-Down Enable */
 
 typedef struct IMX2WdtState {
     /* <private> */
     SysBusDevice parent_obj;
 
+    /*< public >*/
     MemoryRegion mmio;
+    qemu_irq irq;
+
+    struct ptimer_state *timer;
+    struct ptimer_state *itimer;
+
+    bool pretimeout_support;
+    bool pretimeout_locked;
+
+    uint16_t wcr;
+    uint16_t wsr;
+    uint16_t wrsr;
+    uint16_t wicr;
+    uint16_t wmcr;
 } IMX2WdtState;
 
 #endif /* IMX2_WDT_H */
-- 
2.17.1


