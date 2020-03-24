Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69607C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EF7206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EG+Xfc3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EF7206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjxM-0002VW-C5
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGjwI-0000tX-FZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGjwH-00029H-G0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:49:54 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGjwH-00027w-9m
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:49:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id 65so4822811wrl.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bE22CGlWWqUPL8NcmKjZG+N4XUlNXckt3+kKgAcyxzY=;
 b=EG+Xfc3LqvAQjBcs5BovLBfw1GEfhFecLp2IVF2O1rfNiIfTzNR1X09FUaT64KisjG
 bKna6v1cu/ZLL/Y9d24895gkYk7yAPQa6Q+UREMvPmyh/41/sJzUVByd8hFlZGwLBydS
 co0VjUTRZfeWTNiY/H/aDXFRGC5vwp4NxGWLkHaJ/XqW/kBPOboRqZXiVykuXzDIh2X4
 SYHH3J3N7u206eeTi1KkBvG2ulunbPU9tSezIsZ3Gu0y41/Fb6l/RM3DxHaTRXXuEoGh
 M5R+A1JhbLK508AF5WKno6vZDlJ1k1Xw0qp8E0My0tPMLvYQLTvN/mmHj/5T3JbyGLqr
 nIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bE22CGlWWqUPL8NcmKjZG+N4XUlNXckt3+kKgAcyxzY=;
 b=hC6YaNgokVdmqX5e47Mp7g8GCtzTbNQu+2gfLL2cILSGu6Y+fI+pm+4wBCP2GOaTao
 rXoLyf1FKH6JisYiyCn6ci18eOjqY28Md9PE8gYXSNUcxdMdDbzbpqrl37FD02ofYIV4
 +nrhUxUC+8Sz6IhRfK7/PQiUUcappnXyx+Ef4vhzXgR2gi6Z4D8jyR0LlD2uBLu5Nc8m
 0mcW/aM3c1NFdo/DGHWkxfqYjTAmapxHPlo8NwoxFyJoH+mZ/MTu7ZwUq2ISxXLZPnmc
 oexuX2HSh87IhtSJI5BxBzYTwcJbik60SFBWGVtMUhsb9OzfWgi5DazEzRSK7gqRMKo3
 sx+w==
X-Gm-Message-State: ANhLgQ0/QDuEtz0ryCjP9gHd4LG5zeopmjtUSxf+1cFCXTo1mPylRntD
 fcGxG4XigA6cUM3538TmcjTR9Q==
X-Google-Smtp-Source: ADFU+vtF47Tc8g7QOWs9dRT1JxNcXUSbBKYz7VvRNLC5xWC+isvBC4SrpcGZXW6uYIDM744H/OkQhg==
X-Received: by 2002:adf:e98b:: with SMTP id h11mr17446177wrm.409.1585057792255; 
 Tue, 24 Mar 2020 06:49:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id k3sm4332067wmf.16.2020.03.24.06.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 06:49:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/arm/xlnx-zynqmp.c: Add missing error-propagation code
Date: Tue, 24 Mar 2020 13:49:47 +0000
Message-Id: <20200324134947.15384-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324134947.15384-1-peter.maydell@linaro.org>
References: <20200324134947.15384-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In some places in xlnx_zynqmp_realize() we were putting an
error into our local Error*, but forgetting to check for
failure and pass it back to the caller. Add the missing code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Spotted while I was writing the previous patch.
---
 hw/arm/xlnx-zynqmp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index a13dbeeacec..b84d153d56a 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -530,8 +530,20 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
          * - eMMC Specification Version 4.51
          */
         object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_uint(sdhci, SDHCI_CAPABILITIES, "capareg", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_uint(sdhci, UHS_I, "uhs", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(sdhci, true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
@@ -551,6 +563,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         gchar *bus_name;
 
         object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
@@ -565,6 +581,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     object_property_set_bool(OBJECT(&s->qspi), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0, QSPI_ADDR);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 1, LQSPI_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->qspi), 0, gic_spi[QSPI_IRQ]);
@@ -619,6 +639,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
         object_property_set_uint(OBJECT(&s->gdma[i]), 128, "bus-width", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->gdma[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.20.1


