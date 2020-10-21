Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92144C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27ED24178
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cH3wahpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27ED24178
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVM12-0000IC-AA
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3u6mQXwsKClQ3E649908A092AA270.yA8C08G-z0H079A929G.AD2@flex--hskinnemoen.bounces.google.com>)
 id 1kVLm7-0003VU-6m
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:36:03 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:36701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3u6mQXwsKClQ3E649908A092AA270.yA8C08G-z0H079A929G.AD2@flex--hskinnemoen.bounces.google.com>)
 id 1kVLm3-00037m-AG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:36:02 -0400
Received: by mail-pg1-x549.google.com with SMTP id j16so2016634pgi.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=BwRf8aOhgBOVr7hvsp8KXLsUMQ6nV34eGgW9TnD30xk=;
 b=cH3wahpWcAMcqqf48xhznZ0Kdai5dLdm0WMST1umZE53SF6sM8uv1hPAW2os+WB327
 do+okkmLS9mzYN1bhqw5WteZzbFW/rHHxvqT5aFXd3LSIP2fLgR/4kpy/iRD3nz6d0qc
 d7puxfWhNZVcSMyj+QvebrtvzMjZY/aWiviNhsuGgryBjWt9vZB4viN536iWEvddNATK
 b6dh8pDterYOj4wljE/+rvi35fbFxEX1GzluwF4yaz3dSJbf6xVnrU+dbZlReX+M7ops
 4ilfL5qRRO+uzj/rbmx68CL9wiAxE5ZD51HVVk/AKqdR84WlmB0Voklt1G8Th/XcynCE
 RkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=BwRf8aOhgBOVr7hvsp8KXLsUMQ6nV34eGgW9TnD30xk=;
 b=nnlNQdsaguMuvCOSNMZMO1hDItEfg/RgPTeO9t1rzzJxHlZ+eGQHr+utEp3aEyGIWT
 TRL3oayQ4nEnILeXdRnuZp7mxj1Rslhq7o/6K52h+AdOEnfw+Wlm389TbbnQFaQOl0v7
 VKIvu55K7zM6WZkOgWwa9ksqNWcB/T5zLYpArIsbrJbUCHQDnAPuanWQblX6NBlnVd9L
 gslvkG5OsBjvt79k+WFVO0NGanhOFoLaJvYySMUA6uytBKWN5LJeSdwhEVmGjy13hR2s
 kjmnucNWX36JINL0Wng0SkM/ZdVXNOsWlyYklo7eZMJ1ZgfhZHAjrD/nfMT6n+RDVOA2
 zAaQ==
X-Gm-Message-State: AOAM530yJ2Tv6ChUU8MYdAiPbI1ezl7WAQAMsX9xadYvFmA+YSioO7s1
 EKj9jirNw1SrirXSeLvjnS1lwscahNpzRwFNlQ==
X-Google-Smtp-Source: ABdhPJwldbygYVxJlBPNBxLljCsuH+0ROvaQ0GR/NZ0n/dWT14Bde9WBG1keHWQH9sCFtDneSoTl6ItT+KjMlEnBaA==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by
 2002:a17:902:fe0a:b029:d6:aa7:5220 with
 SMTP id g10-20020a170902fe0ab02900d60aa75220mr1700111plj.16.1603316155224;
 Wed, 21 Oct 2020 14:35:55 -0700 (PDT)
Date: Wed, 21 Oct 2020 14:35:43 -0700
In-Reply-To: <20201021213544.3399271-1-hskinnemoen@google.com>
Message-Id: <20201021213544.3399271-5-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201021213544.3399271-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 4/5] hw/arm/npcm7xx: Add EHCI and OHCI controllers
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, venture@google.com, wuhaotsh@google.com, 
 Havard Skinnemoen <hskinnemoen@google.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3u6mQXwsKClQ3E649908A092AA270.yA8C08G-z0H079A929G.AD2@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

The NPCM730 and NPCM750 chips have a single USB host port shared between
a USB 2.0 EHCI host controller and a USB 1.1 OHCI host controller. This
adds support for both of them.

Testing notes:
  * With -device usb-kbd, qemu will automatically insert a full-speed
    hub, and the keyboard becomes controlled by the OHCI controller.
  * With -device usb-kbd,bus=usb-bus.0,port=1, the keyboard is directly
    attached to the port without any hubs, and the device becomes
    controlled by the EHCI controller since it's high speed capable.
  * With -device usb-kbd,bus=usb-bus.0,port=1,usb_version=1, the
    keyboard is directly attached to the port, but it only advertises
    itself as full-speed capable, so it becomes controlled by the OHCI
    controller.

In all cases, the keyboard device enumerates correctly.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 docs/system/arm/nuvoton.rst |  2 +-
 hw/usb/hcd-ehci.h           |  1 +
 include/hw/arm/npcm7xx.h    |  4 ++++
 hw/arm/npcm7xx.c            | 27 +++++++++++++++++++++++++--
 hw/usb/hcd-ehci-sysbus.c    | 19 +++++++++++++++++++
 5 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 4342434df4..99fc61c740 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -39,6 +39,7 @@ Supported devices
  * OTP controllers (no protection features)
  * Flash Interface Unit (FIU; no protection features)
  * Random Number Generator (RNG)
+ * USB host (USBH)
 
 Missing devices
 ---------------
@@ -54,7 +55,6 @@ Missing devices
    * eSPI slave interface
 
  * Ethernet controllers (GMAC and EMC)
- * USB host (USBH)
  * USB device (USBD)
  * SMBus controller (SMBF)
  * Peripheral SPI controller (PSPI)
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index fd122dd4cd..a173707d9b 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -344,6 +344,7 @@ struct EHCIPCIState {
 #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
 #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
 #define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
+#define TYPE_NPCM7XX_EHCI "npcm7xx-ehci-usb"
 #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
 #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
 #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 761f9b987e..aeee1beaaa 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -25,6 +25,8 @@
 #include "hw/nvram/npcm7xx_otp.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "hw/ssi/npcm7xx_fiu.h"
+#include "hw/usb/hcd-ehci.h"
+#include "hw/usb/hcd-ohci.h"
 #include "target/arm/cpu.h"
 
 #define NPCM7XX_MAX_NUM_CPUS    (2)
@@ -77,6 +79,8 @@ typedef struct NPCM7xxState {
     NPCM7xxOTPState     fuse_array;
     NPCM7xxMCState      mc;
     NPCM7xxRNGState     rng;
+    EHCISysBusState     ehci;
+    OHCISysBusState     ohci;
     NPCM7xxFIUState     fiu[2];
 } NPCM7xxState;
 
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index cb4db41c54..c1d122576b 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -46,6 +46,10 @@
 #define NPCM7XX_MC_BA           (0xf0824000)
 #define NPCM7XX_RNG_BA          (0xf000b000)
 
+/* USB Host modules */
+#define NPCM7XX_EHCI_BA         (0xf0806000)
+#define NPCM7XX_OHCI_BA         (0xf0807000)
+
 /* Internal AHB SRAM */
 #define NPCM7XX_RAM3_BA         (0xc0008000)
 #define NPCM7XX_RAM3_SZ         (4 * KiB)
@@ -90,6 +94,8 @@ enum NPCM7xxInterrupt {
     NPCM7XX_WDG0_IRQ            = 47,   /* Timer Module 0 Watchdog */
     NPCM7XX_WDG1_IRQ,                   /* Timer Module 1 Watchdog */
     NPCM7XX_WDG2_IRQ,                   /* Timer Module 2 Watchdog */
+    NPCM7XX_EHCI_IRQ            = 61,
+    NPCM7XX_OHCI_IRQ            = 62,
 };
 
 /* Total number of GIC interrupts, including internal Cortex-A9 interrupts. */
@@ -263,6 +269,9 @@ static void npcm7xx_init(Object *obj)
         object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
     }
 
+    object_initialize_child(obj, "ehci", &s->ehci, TYPE_NPCM7XX_EHCI);
+    object_initialize_child(obj, "ohci", &s->ohci, TYPE_SYSBUS_OHCI);
+
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_fiu) != ARRAY_SIZE(s->fiu));
     for (i = 0; i < ARRAY_SIZE(s->fiu); i++) {
         object_initialize_child(obj, npcm7xx_fiu[i].name, &s->fiu[i],
@@ -380,6 +389,22 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->rng), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rng), 0, NPCM7XX_RNG_BA);
 
+    /* USB Host */
+    object_property_set_bool(OBJECT(&s->ehci), "companion-enable", true,
+                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ehci), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci), 0, NPCM7XX_EHCI_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci), 0,
+                       npcm7xx_irq(s, NPCM7XX_EHCI_IRQ));
+
+    object_property_set_str(OBJECT(&s->ohci), "masterbus", "usb-bus.0",
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->ohci), "num-ports", 1, &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ohci), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci), 0, NPCM7XX_OHCI_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci), 0,
+                       npcm7xx_irq(s, NPCM7XX_OHCI_IRQ));
+
     /*
      * Flash Interface Unit (FIU). Can fail if incorrect number of chip selects
      * specified, but this is a programming error.
@@ -464,8 +489,6 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm7xx.mcphy",        0xf05f0000,  64 * KiB);
     create_unimplemented_device("npcm7xx.gmac1",        0xf0802000,   8 * KiB);
     create_unimplemented_device("npcm7xx.gmac2",        0xf0804000,   8 * KiB);
-    create_unimplemented_device("npcm7xx.ehci",         0xf0806000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.ohci",         0xf0807000,   4 * KiB);
     create_unimplemented_device("npcm7xx.vcd",          0xf0810000,  64 * KiB);
     create_unimplemented_device("npcm7xx.ece",          0xf0820000,   8 * KiB);
     create_unimplemented_device("npcm7xx.vdma",         0xf0822000,   8 * KiB);
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 3730736540..e3758db1b1 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -147,6 +147,24 @@ static const TypeInfo ehci_aw_h3_type_info = {
     .class_init    = ehci_aw_h3_class_init,
 };
 
+static void ehci_npcm7xx_class_init(ObjectClass *oc, void *data)
+{
+    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    sec->capsbase = 0x0;
+    sec->opregbase = 0x10;
+    sec->portscbase = 0x44;
+    sec->portnr = 1;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+}
+
+static const TypeInfo ehci_npcm7xx_type_info = {
+    .name          = TYPE_NPCM7XX_EHCI,
+    .parent        = TYPE_SYS_BUS_EHCI,
+    .class_init    = ehci_npcm7xx_class_init,
+};
+
 static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -269,6 +287,7 @@ static void ehci_sysbus_register_types(void)
     type_register_static(&ehci_platform_type_info);
     type_register_static(&ehci_exynos4210_type_info);
     type_register_static(&ehci_aw_h3_type_info);
+    type_register_static(&ehci_npcm7xx_type_info);
     type_register_static(&ehci_tegra2_type_info);
     type_register_static(&ehci_ppc4xx_type_info);
     type_register_static(&ehci_fusbh200_type_info);
-- 
2.29.0.rc1.297.gfa9743e501-goog


