Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844CEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F36820707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y92U3Vq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F36820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCVS-00078a-BJ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTm-0005D9-43
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTk-0002ok-P6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:42 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTk-0002o5-Il
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:40 -0500
Received: by mail-wr1-x434.google.com with SMTP id a6so4727126wrx.12
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wkn1AOV8t66g8xUrVaEPWBIHxHvOo4ew4OLKGFBPagg=;
 b=Y92U3Vq/8+F9aaCQd5GObsJptMvtswkR9yHYa7lYaM9GvLQDeLATHv8WPdVJhu99xt
 NMoiMl7Y4GHheonndHRW4PzvQHwf9twdZcy0Z/VbJxmQXLDUJFz1wdwmTPIIt9Tn1S+i
 3agmceM2+tJXoIakmPwN8neDy/STvzg6wSeC8kTchGhBYMy6Mo3ZxXaug08uWviCW3WB
 H5dSTlELhFBUeZ5mbN+oLDTibRPzxdsAJXwDZcd7rUeQkUT3TSAxsRBwnZ2heIMgRD7l
 nsGt2cOgVlP+WUxxMX0MgeFzOsLpqYBqJ/jxBEVOAKWUB4+N5HV3W650Di+ZLzqG9d8r
 p2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wkn1AOV8t66g8xUrVaEPWBIHxHvOo4ew4OLKGFBPagg=;
 b=C3FxozsFMm08YxJcJvuecjpR/3rlw5JoXtQkxuLOXF/xoMiY/pwIMekI9UkE4TMOGx
 ruzSU/sGEMq/VBCy+Ge0Eg1Qw4c+Me88TUnMmk57ZixwSVjYSkTgFa5nybk7lBZHOQ30
 cA2UO6Hy5taLv+WQFVVGeJZK3ONcuYTHkv3CfbV9vVYJq2W9AGsGL23wRNRomFCQwDUH
 B68brXb4MmoIICeebwIVZdMiaUb9sfll9z8JqPU3ROSsDntblK5JDh8W0tcmZJ5jMHaZ
 gXp5sYLms3iwdT9rZ0hLyos3KCUtVR0w402CC/49YWqeRyHJVx1uI87DKWBtlH8motfz
 Mlaw==
X-Gm-Message-State: APjAAAV+BnxWcvFBtgQce7vsLb6WI0SL9SHj0kvbqvtrgy98ROPgM55J
 rRnIHXguAkD/i1i8PIOfmZ0UywG5Bcn2Qw==
X-Google-Smtp-Source: APXvYqz1pfazEfbhznFAQG6dJIenf/iz2evA69EAQm9QLdnpIkAdtScXDfsRhjqrup2YTnm1SAFYqg==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr6360451wrt.110.1580400939282; 
 Thu, 30 Jan 2020 08:15:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/26] hw/sd: Configure number of slots exposed by the ASPEED
 SDHCI model
Date: Thu, 30 Jan 2020 16:15:10 +0000
Message-Id: <20200130161533.8180-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

From: Andrew Jeffery <andrew@aj.id.au>

The AST2600 includes a second cut-down version of the SD/MMC controller
found in the AST2500, named the eMMC controller. It's cut down in the
sense that it only supports one slot rather than two, but it brings the
total number of slots supported by the AST2600 to three.

The existing code assumed that the SD controller always provided two
slots. Rework the SDHCI object to expose the number of slots as a
property to be set by the SoC configuration.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200114103433.30534-2-clg@kaod.org
[PMM: fixed up to use device_class_set_props()]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/aspeed_sdhci.h |  1 +
 hw/arm/aspeed.c              |  2 +-
 hw/arm/aspeed_ast2600.c      |  2 ++
 hw/arm/aspeed_soc.c          |  2 ++
 hw/sd/aspeed_sdhci.c         | 11 +++++++++--
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
index dfdab437902..dffbb46946b 100644
--- a/include/hw/sd/aspeed_sdhci.h
+++ b/include/hw/sd/aspeed_sdhci.h
@@ -24,6 +24,7 @@ typedef struct AspeedSDHCIState {
     SysBusDevice parent;
 
     SDHCIState slots[ASPEED_SDHCI_NUM_SLOTS];
+    uint8_t num_slots;
 
     MemoryRegion iomem;
     qemu_irq irq;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index cc06af4fbb3..4174e313cae 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -263,7 +263,7 @@ static void aspeed_machine_init(MachineState *machine)
         amc->i2c_init(bmc);
     }
 
-    for (i = 0; i < ARRAY_SIZE(bmc->soc.sdhci.slots); i++) {
+    for (i = 0; i < bmc->soc.sdhci.num_slots; i++) {
         SDHCIState *sdhci = &bmc->soc.sdhci.slots[i];
         DriveInfo *dinfo = drive_get_next(IF_SD);
         BlockBackend *blk;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 89e4b009504..fb73c4043ea 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -199,6 +199,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
     sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhci),
                           TYPE_ASPEED_SDHCI);
 
+    object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_abort);
+
     /* Init sd card slot class here so that they're under the correct parent */
     for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
         sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 99892cbae67..b5e809a1d3f 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -209,6 +209,8 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhci),
                           TYPE_ASPEED_SDHCI);
 
+    object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_abort);
+
     /* Init sd card slot class here so that they're under the correct parent */
     for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
         sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index cff3eb7dd21..6a039a1d2f1 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
 
 #define ASPEED_SDHCI_INFO            0x00
 #define  ASPEED_SDHCI_INFO_RESET     0x00030000
@@ -120,14 +121,14 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
 
     /* Create input irqs for the slots */
     qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_irq,
-                                        sdhci, NULL, ASPEED_SDHCI_NUM_SLOTS);
+                                        sdhci, NULL, sdhci->num_slots);
 
     sysbus_init_irq(sbd, &sdhci->irq);
     memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_ops,
                           sdhci, TYPE_ASPEED_SDHCI, 0x1000);
     sysbus_init_mmio(sbd, &sdhci->iomem);
 
-    for (int i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+    for (int i = 0; i < sdhci->num_slots; ++i) {
         Object *sdhci_slot = OBJECT(&sdhci->slots[i]);
         SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slots[i]);
 
@@ -174,6 +175,11 @@ static const VMStateDescription vmstate_aspeed_sdhci = {
     },
 };
 
+static Property aspeed_sdhci_properties[] = {
+    DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
@@ -181,6 +187,7 @@ static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
     dc->realize = aspeed_sdhci_realize;
     dc->reset = aspeed_sdhci_reset;
     dc->vmsd = &vmstate_aspeed_sdhci;
+    device_class_set_props(dc, aspeed_sdhci_properties);
 }
 
 static TypeInfo aspeed_sdhci_info = {
-- 
2.20.1


