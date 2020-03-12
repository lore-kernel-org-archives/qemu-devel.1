Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DDCC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7ED206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7qubbLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7ED206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR0E-0005G7-3s
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxQ-0008Jg-E5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxO-00056w-VO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxO-00056D-OT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id s14so8372171wrt.8
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=en5/ehXOAmbdpuPeqqCQ5CpQm+7ZLZrY9Fmfjm5xj+0=;
 b=m7qubbLxEx3BQ/ZXv/7yU1SepiJKufWcBUW8cBIacEhvVexLFVDXHhpLAggF6AzZMZ
 qp4z0EY0t48H2rDc5m55w6dAlqKHiid5Pk1vvc+QmrCxwCBEuEfNPf1b2GVmQIUiwYwh
 2CHu92zcbEo8okvkcqry7sLO+hMcQOSKSBSfXF8xcZI+Hezj79XMIYMfK1zBDTQodi4h
 OngSJpa9ol3Z9V/pwLFLjoK5xNGNpJIdKO/4KZab1mbiKAnaxskUbt7lRGA3zV2kYgQz
 e7Ri0YjsqrURkt4v9v3ffFhSL25IGdH01/5svrh0ZIw5YRt2/aMMZ5tpzcqq1zggrMNJ
 i3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=en5/ehXOAmbdpuPeqqCQ5CpQm+7ZLZrY9Fmfjm5xj+0=;
 b=A5AT2xQyDKOwQPDwogh8GyQ1TfhO+xZx1VtDsiYj6DunCTsSpswwNrezW/fqFhefm/
 gjx6mKeunaXtIZWfHixlx47Er9cULENpTA0qmaEelJmkclVBSDp3E3a3Tla3WC1mBnLS
 /DrPE+aX5Jvfk5JgM6/DJZUtybFhLbZta3vfJtpM/6le4S+PabBkyITXO1XedqxsdvC8
 1h7B04Tdj7rDm0VPNsB6y1c4LXRrz3e+GBtLSUE3/g1kABaUyiIm17Vh0C24OwaRHMDE
 iPBh9vTfjewMR775XPtwwShPBypvPMIziVwNes4ynNXHopZnq2321NZf1g4437C5xaoo
 DwLA==
X-Gm-Message-State: ANhLgQ2vWb42K9kkGs17RdT8O5fwFKqn5ZtBONSHhpF3aaHaVkbNis/e
 QUrlMGl9sYtA/9ou5UzuvYVGoYNSMQVfgg==
X-Google-Smtp-Source: ADFU+vs8bVY+6KT0rOTGe/DQ65+V0EK1Sg4t2+uJvCbmQTmcNlqgoiImFEqpb0o4szKWjCxmVP2/aw==
X-Received: by 2002:adf:e911:: with SMTP id f17mr11382196wrm.87.1584031513315; 
 Thu, 12 Mar 2020 09:45:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/36] hw/arm/fsl-imx25: Wire up eSDHC controllers
Date: Thu, 12 Mar 2020 16:44:33 +0000
Message-Id: <20200312164459.25924-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

From: Guenter Roeck <linux@roeck-us.net>

Wire up eSDHC controllers in fsl-imx25. For imx25-pdk, connect drives
provided on the command line to available eSDHC controllers.

This patch enables booting the imx25-pdk emulation from SD card.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200310215146.19688-2-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: made commit subject consistent with other patch]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx25.h |  9 +++++++++
 hw/arm/fsl-imx25.c         | 32 ++++++++++++++++++++++++++++++++
 hw/arm/imx25_pdk.c         | 16 ++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 1c86bb55fbd..4e2d4868cda 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -27,6 +27,7 @@
 #include "hw/misc/imx_rngc.h"
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/sd/sdhci.h"
 #include "exec/memory.h"
 #include "target/arm/cpu.h"
 
@@ -38,6 +39,7 @@
 #define FSL_IMX25_NUM_EPITS 2
 #define FSL_IMX25_NUM_I2CS 3
 #define FSL_IMX25_NUM_GPIOS 4
+#define FSL_IMX25_NUM_ESDHCS 2
 
 typedef struct FslIMX25State {
     /*< private >*/
@@ -54,6 +56,7 @@ typedef struct FslIMX25State {
     IMXRNGCState   rngc;
     IMXI2CState    i2c[FSL_IMX25_NUM_I2CS];
     IMXGPIOState   gpio[FSL_IMX25_NUM_GPIOS];
+    SDHCIState     esdhc[FSL_IMX25_NUM_ESDHCS];
     MemoryRegion   rom[2];
     MemoryRegion   iram;
     MemoryRegion   iram_alias;
@@ -215,6 +218,10 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_GPIO3_SIZE    0x4000
 #define FSL_IMX25_RNGC_ADDR     0x53FB0000
 #define FSL_IMX25_RNGC_SIZE     0x4000
+#define FSL_IMX25_ESDHC1_ADDR   0x53FB4000
+#define FSL_IMX25_ESDHC1_SIZE   0x4000
+#define FSL_IMX25_ESDHC2_ADDR   0x53FB8000
+#define FSL_IMX25_ESDHC2_SIZE   0x4000
 #define FSL_IMX25_GPIO1_ADDR    0x53FCC000
 #define FSL_IMX25_GPIO1_SIZE    0x4000
 #define FSL_IMX25_GPIO2_ADDR    0x53FD0000
@@ -250,5 +257,7 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_GPIO2_IRQ     51
 #define FSL_IMX25_GPIO3_IRQ     16
 #define FSL_IMX25_GPIO4_IRQ     23
+#define FSL_IMX25_ESDHC1_IRQ    9
+#define FSL_IMX25_ESDHC2_IRQ    8
 
 #endif /* FSL_IMX25_H */
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index da3471b3953..f977c42426b 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -31,6 +31,8 @@
 #include "hw/qdev-properties.h"
 #include "chardev/char.h"
 
+#define IMX25_ESDHC_CAPABILITIES     0x07e20000
+
 static void fsl_imx25_init(Object *obj)
 {
     FslIMX25State *s = FSL_IMX25(obj);
@@ -74,6 +76,11 @@ static void fsl_imx25_init(Object *obj)
         sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
                               TYPE_IMX_GPIO);
     }
+
+    for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
+        sysbus_init_child_obj(obj, "sdhc[*]", &s->esdhc[i], sizeof(s->esdhc[i]),
+                              TYPE_IMX_USDHC);
+    }
 }
 
 static void fsl_imx25_realize(DeviceState *dev, Error **errp)
@@ -246,6 +253,31 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                             gpio_table[i].irq));
     }
 
+    /* Initialize all SDHC */
+    for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } esdhc_table[FSL_IMX25_NUM_ESDHCS] = {
+            { FSL_IMX25_ESDHC1_ADDR, FSL_IMX25_ESDHC1_IRQ },
+            { FSL_IMX25_ESDHC2_ADDR, FSL_IMX25_ESDHC2_IRQ },
+        };
+
+        object_property_set_uint(OBJECT(&s->esdhc[i]), 2, "sd-spec-version",
+                                 &err);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
+                                 "capareg", &err);
+        object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->esdhc[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->avic),
+                                            esdhc_table[i].irq));
+    }
+
     /* initialize 2 x 16 KB ROM */
     memory_region_init_rom(&s->rom[0], NULL,
                            "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 26713d9a7e7..b3ca82bafa7 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/fsl-imx25.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
@@ -120,6 +121,21 @@ static void imx25_pdk_init(MachineState *machine)
     imx25_pdk_binfo.board_id = 1771,
     imx25_pdk_binfo.nb_cpus = 1;
 
+    for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
+        BusState *bus;
+        DeviceState *carddev;
+        DriveInfo *di;
+        BlockBackend *blk;
+
+        di = drive_get_next(IF_SD);
+        blk = di ? blk_by_legacy_dinfo(di) : NULL;
+        bus = qdev_get_child_bus(DEVICE(&s->soc.esdhc[i]), "sd-bus");
+        carddev = qdev_create(bus, TYPE_SD_CARD);
+        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+        object_property_set_bool(OBJECT(carddev), true,
+                                 "realized", &error_fatal);
+    }
+
     /*
      * We test explicitly for qtest here as it is not done (yet?) in
      * arm_load_kernel(). Without this the "make check" command would
-- 
2.20.1


