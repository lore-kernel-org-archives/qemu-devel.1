Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3897AC761A3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065F220725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1cvsPHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065F220725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3f1y-0005ZZ-8H
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqa-0006qT-0M
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqY-0002YS-66
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:55 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:54673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqW-0002W8-9e; Mon, 17 Feb 2020 06:45:52 -0500
Received: by mail-wm1-x330.google.com with SMTP id g1so16815320wmh.4;
 Mon, 17 Feb 2020 03:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ux9PEPOM3HzoCcwHXWuWj9LnAFV7GP+CVR1oHredxx0=;
 b=g1cvsPHCrbjUuWltWY6BJvvEc8Jvk8iKqrOFIq0zzbm6BxHNuKDSYEJbIs3r+WyuVD
 9n3Exze4YkWDnSe23tZCWaFhPI/p6yc9/aDXqzEviNoXll/eByxZygBnq1wyGWaqq7an
 LFWKEK0RXpY/9IU+00JGDM1ExRZ6Pr6dAaa2LVbzKtrum/tYBSF1kUBnZhaku89z/gLD
 aN29QGWgkE7IkoP4X9LGsfrd05ipFzL6UIf4jqmb4A0nSOVcVxRhcfXuM5Qs5JnndWgv
 F8n0I+5v9wqC79tKwZ6DeSg21wi8DdGiMF5rRB/7kHwAKtF48CHq1YdBulQGlEV1CsK7
 THxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ux9PEPOM3HzoCcwHXWuWj9LnAFV7GP+CVR1oHredxx0=;
 b=LF2mFOaLjI4kYBd75pmUtYwVrzZgGt36lTuaREVHD1B0MJIwcChcb9wxtBxZcY2rRq
 lTKRDH6ATfklFl4Tpb3sNFHtWP+OrDkc4MA4FuAT0dsLnvlztL7GtGLXfgiNR+r1BC1x
 0IyV09I//4kHNLVn5tW2au054g30NPFgbHnk/9lZWrwVSBLlqiWc0mOlWD3CJIekwG/x
 fzjnJW+Mu9hVVzBH9zUz8xlmL+absqR9q39LcgPfYmHTKDwImUHFSN2P6tJsO8gaoBfb
 0h/9JgtFUWlIusZiS5MH6GMH6jgdSBuinVP9Q9Q1B9ufv5+pfZNDEPpAVlnLBDEO/ko3
 jmlg==
X-Gm-Message-State: APjAAAUrz8U4FiuOuaNAUQBh7Ze225wZs0tfRJpRuYSHgohnV0f0pnyQ
 M3pc7kgs3Ff3a6Lz1/vLepJIrq/CdIg=
X-Google-Smtp-Source: APXvYqwAqrRqndyzvK7VgkkpCAOkaMS5qBNQuGvJBcCSN+9E4JokKs3/ICR5zzUWskwxwvHx8GxBKw==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr22606979wma.171.1581939950423; 
 Mon, 17 Feb 2020 03:45:50 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i2sm268149wmb.28.2020.02.17.03.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 03:45:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/13] hw/arm/bcm2836: Introduce the BCM2835 SoC
Date: Mon, 17 Feb 2020 12:45:31 +0100
Message-Id: <20200217114533.17779-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217114533.17779-1-f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h |  1 +
 hw/arm/bcm2836.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/raspi.c           |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index acc75bf553..3d46469a73 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -24,6 +24,7 @@
  * them, code using these devices should always handle them via the
  * BCM283x base class, so they have no BCM2836(obj) etc macros.
  */
+#define TYPE_BCM2835 "bcm2835"
 #define TYPE_BCM2836 "bcm2836"
 #define TYPE_BCM2837 "bcm2837"
 
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 2b6fe31139..bce5f8a866 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -103,6 +103,31 @@ static void bcm283x_common_realize(DeviceState *dev, Error **errp)
                             bc->peri_base, 1);
 }
 
+static void bcm2835_realize(DeviceState *dev, Error **errp)
+{
+    BCM283XState *s = BCM283X(dev);
+    Error *err = NULL;
+
+    bcm283x_common_realize(dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_bool(OBJECT(&s->cpu[0].core), true,
+                             "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* Connect irq/fiq outputs from the interrupt controller. */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
+            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
+            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_FIQ));
+}
+
 static void bcm2836_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
@@ -184,6 +209,17 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 }
 
+static void bcm2835_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    BCM283XClass *bc = BCM283X_CLASS(oc);
+
+    bc->cpu_type = ARM_CPU_TYPE_NAME("arm1176");
+    bc->core_count = 1;
+    bc->peri_base = 0x20000000;
+    dc->realize = bcm2835_realize;
+};
+
 static void bcm2836_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -214,6 +250,10 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo bcm283x_types[] = {
     {
+        .name           = TYPE_BCM2835,
+        .parent         = TYPE_BCM283X,
+        .class_init     = bcm2835_class_init,
+    }, {
         .name           = TYPE_BCM2836,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2836_class_init,
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fff501affb..3537a329ac 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -70,6 +70,7 @@ FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
 FIELD(REV_CODE, STYLE,             23, 1);
 
 typedef enum RaspiProcessorId {
+    PROCESSOR_ID_BCM2835 = 0,
     PROCESSOR_ID_BCM2836 = 1,
     PROCESSOR_ID_BCM2837 = 2,
 } RaspiProcessorId;
@@ -78,6 +79,7 @@ static const struct {
     const char *type;
     int cores_count;
 } soc_property[] = {
+    [PROCESSOR_ID_BCM2835] = {TYPE_BCM2835, 1},
     [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS},
     [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
 };
-- 
2.21.1


