Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7838C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923C220678
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiPl+xfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923C220678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlMK-0006t9-LL
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlE3-0006kv-G5
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlE1-0002s1-Ry
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:15 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlE1-0002rQ-Lg; Sun, 12 Apr 2020 18:37:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id e26so7922076wmk.5;
 Sun, 12 Apr 2020 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4j3n0ZN8lrQk9Ox5ZI487lTmFghYMiP7ZCOjQ+gtTO0=;
 b=FiPl+xfImHl2GpHUMPv7DS3HnCGs7y5Yv7rRAWLbBxSA+Zejhz/zl3dYLZFx9NwO3C
 ruBIj4ErorNm/wEEEwmAZQN7jz+KhLLNa3qUtc6sXdKd0t4oGGLXPCHrZDaqFOt7+heG
 akctvFAf/HakBv2w5G3h7MQwU/7e8gmOEEk6Z3+IDI0ZJ8CQnO1vrHu4pMgXZE7FtJ37
 +V2y1Eimw56yRDBdiaV3zqgFJs1xlb2++xZYHy83WCjNnfGmjYL3b+tsJbkPb0JXPjQ6
 mm7I3D/7KEPFhiTmxZNJOmqeOOKBoCVRVDbYfbGEZ4JPJvWn79ulzvCvctV9S8Op08JM
 6KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4j3n0ZN8lrQk9Ox5ZI487lTmFghYMiP7ZCOjQ+gtTO0=;
 b=NDk6OdbEfQIzD4f7kNQB7TtSmI+3GaowfGPmWcuE6OI+tVK6TpDsiqd0UGQK2qnmmh
 BejAKN8SjEfqTt6MKwJQ/jmGEvgxBuADzg9jJEVZmJWGDUGdvo23pDosPNDPX4hBpFc0
 5rJdsy54zyCp0ftdmQRZk6rXCM8JFT74GU4ogCiCrrCv0X022bl69rCCHzYsTK/t544E
 ajb4NMgmE0beHEz2alF3agWFSVgxVuOPDPZeMqBAjCWJntVlsi1oE42viY0zd/tXIjzR
 56cFgRnqwKZyIYH9gmPQhVOkd08QDJDdkRQ3gIvkSJ9jZgdU6Fv+PXCypPY8qNuMvJGd
 v/bw==
X-Gm-Message-State: AGi0PuaR+VGZEmMahti7aVPdm9EfelZQh4tMBfAdAzgpwydSx+PQynl9
 Qv0XVETGASH50VnzAxhayImVmyVveln+WQ==
X-Google-Smtp-Source: APiQypKQ+yRJxYVK62KIGa19FQEaCOa3lcvmah3jW7keXINk4PdHa+2g4NBI/LDjsNJ8Vg5U1+YoBA==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr16763598wmb.26.1586731032454; 
 Sun, 12 Apr 2020 15:37:12 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:37:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 14/24] hw/arm/xlnx-zynqmp: Use single
 propagate_error() call
Date: Mon, 13 Apr 2020 00:36:09 +0200
Message-Id: <20200412223619.11284-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle failed at processing this file:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/xlnx-zynqmp.c
  EXN: Coccinelle_modules.Common.Timeout

We are going to manually add the missing propagate_error() calls.
As there are many Error* calls used, simplify by using an unique
call to propagate_error().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xlnx-zynqmp.c | 61 +++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index b84d153d56..43d57fa7de 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -385,15 +385,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
                                  &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
     }
 
     object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
     if (err) {
-        error_propagate(errp, err);
-        return;
+        goto out_propagate_error;
     }
 
     assert(ARRAY_SIZE(xlnx_zynqmp_gic_regions) == XLNX_ZYNQMP_GIC_REGIONS);
@@ -462,8 +460,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     xlnx_zynqmp_create_rpu(ms, s, boot_cpu, &err);
     if (err) {
-        error_propagate(errp, err);
-        return;
+        goto out_propagate_error;
     }
 
     if (!s->boot_cpu_ptr) {
@@ -488,8 +485,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 &error_abort);
         object_property_set_bool(OBJECT(&s->gem[i]), true, "realized", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 0,
@@ -500,8 +496,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
@@ -512,8 +507,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                             &error_abort);
     object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
     if (err) {
-        error_propagate(errp, err);
-        return;
+        goto out_propagate_error;
     }
 
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0, SATA_ADDR);
@@ -531,23 +525,19 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
          */
         object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
         object_property_set_uint(sdhci, SDHCI_CAPABILITIES, "capareg", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
         object_property_set_uint(sdhci, UHS_I, "uhs", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
         object_property_set_bool(sdhci, true, "realized", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
         sysbus_mmio_map(sbd, 0, sdhci_addr[i]);
         sysbus_connect_irq(sbd, 0, gic_spi[sdhci_intr[i]]);
@@ -564,8 +554,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_addr[i]);
@@ -582,8 +571,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     object_property_set_bool(OBJECT(&s->qspi), true, "realized", &err);
     if (err) {
-        error_propagate(errp, err);
-        return;
+        goto out_propagate_error;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0, QSPI_ADDR);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 1, LQSPI_ADDR);
@@ -605,16 +593,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     object_property_set_bool(OBJECT(&s->dp), true, "realized", &err);
     if (err) {
-        error_propagate(errp, err);
-        return;
+        goto out_propagate_error;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dp), 0, DP_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dp), 0, gic_spi[DP_IRQ]);
 
     object_property_set_bool(OBJECT(&s->dpdma), true, "realized", &err);
     if (err) {
-        error_propagate(errp, err);
-        return;
+        goto out_propagate_error;
     }
     object_property_set_link(OBJECT(&s->dp), OBJECT(&s->dpdma), "dpdma",
                              &error_abort);
@@ -623,16 +609,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     object_property_set_bool(OBJECT(&s->ipi), true, "realized", &err);
     if (err) {
-        error_propagate(errp, err);
-        return;
+        goto out_propagate_error;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
 
     object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
     if (err) {
-        error_propagate(errp, err);
-        return;
+        goto out_propagate_error;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, RTC_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0, gic_spi[RTC_IRQ]);
@@ -640,13 +624,11 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
         object_property_set_uint(OBJECT(&s->gdma[i]), 128, "bus-width", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
         object_property_set_bool(OBJECT(&s->gdma[i]), true, "realized", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gdma[i]), 0, gdma_ch_addr[i]);
@@ -657,14 +639,17 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
         object_property_set_bool(OBJECT(&s->adma[i]), true, "realized", &err);
         if (err) {
-            error_propagate(errp, err);
-            return;
+            goto out_propagate_error;
         }
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->adma[i]), 0, adma_ch_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->adma[i]), 0,
                            gic_spi[adma_ch_intr[i]]);
     }
+    return;
+
+out_propagate_error:
+    error_propagate(errp, err);
 }
 
 static Property xlnx_zynqmp_props[] = {
-- 
2.21.1


