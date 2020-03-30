Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12068C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D762073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOHpox2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D762073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIudp-0000H6-0d
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub4-0004QU-ED
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub3-0001CK-8p
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIub3-0001B8-2e
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id j17so21587757wru.13
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GXWYkaSAnVpJmlpHK48UeIW7/97jzoeF9/dNiAzNhNU=;
 b=MOHpox2aNNfqHmLQcs5JQy+RQPfI+uvXj/+gD0u/7VbNJ4G9bwyZN/94jF1oJ+KN1+
 9QpsKscJ8IDRHqU77L4mu76zb+dfxLf2Ud+H8+s0wufM9WwfuZXcyboAXYmMBwM2zCc4
 WNZtkR7/XYydHhFDH7JOAt1GAoQ35k0elvNoQWF362554I3Z969vyV2/gmEpqhnMfXop
 f1Uz1shzg19EGucVD4Xut9BPY6Eu3mfbX78KibVcex0ndGaqQ4hRpUwbgRoQ+aTe7ET9
 XaW9iiMXltC9kp/U00ObiL0CY8wq+D1uljUHvy3eZfVoIxsqma0CeEyKAs+YHV4TrFlK
 wKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GXWYkaSAnVpJmlpHK48UeIW7/97jzoeF9/dNiAzNhNU=;
 b=Y5LTtc8CZWlhmB/KrNOCDMq1bQPU0Ry3ZloDWU6qboJdNtDqrNw7dCg8SPCmkrbBmx
 H8JTFxNsfs39FpUDq/UDclbyH+WZ3ICc9IPDoUMxyV9/8n4+4P/GEe+Hvh7kKLem0KiM
 7qbqdsqIUsicre9Bd28VfvQKKbVqhRtUuOlVdV6ED3RqKvYMkFn8KS7eEfmeD79TEjZu
 KXk8vtjmmlfoKsfxcV8giyCaRJJgZWZsN/csQ1g6fuJzK2qbh4ALQeHjNIyz84iFt2wH
 rFvdawQ01rhwl15bGRgUqT0aQu4PJ61F9XcHoGQvHGULoie5DiJSrFrQWSBSMaPrxcUx
 hfgQ==
X-Gm-Message-State: ANhLgQ03xmFl7+f8Y8XQDdk9Q+ADv1gSeYOXeSycXxP4znFxkefwyNGG
 d09lH2+r35QkWu1Wij9hRhE1JA/CiMS+7w==
X-Google-Smtp-Source: ADFU+vusPuAI1+O1zTHUYSvKB3lH7QyizZ6VcupLZd9RggDMou7flc7L3LuzXoPgA+/tfAOuABZ+zw==
X-Received: by 2002:a05:6000:1090:: with SMTP id
 y16mr14159275wrw.281.1585575415844; 
 Mon, 30 Mar 2020 06:36:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o14sm20756504wmh.22.2020.03.30.06.36.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:36:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] hw/arm/xlnx-zynqmp.c: Add missing error-propagation code
Date: Mon, 30 Mar 2020 14:36:47 +0100
Message-Id: <20200330133648.22297-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330133648.22297-1-peter.maydell@linaro.org>
References: <20200330133648.22297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

In some places in xlnx_zynqmp_realize() we were putting an
error into our local Error*, but forgetting to check for
failure and pass it back to the caller. Add the missing code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200324134947.15384-3-peter.maydell@linaro.org
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


