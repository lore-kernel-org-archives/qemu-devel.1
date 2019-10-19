Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D954CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6002082F
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkraq4V3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6002082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyW2-0006Dh-NS
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRW-00009s-14
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRU-0005Xn-QK
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRU-0005XK-Kc; Sat, 19 Oct 2019 19:47:28 -0400
Received: by mail-wm1-x342.google.com with SMTP id 5so9584120wmg.0;
 Sat, 19 Oct 2019 16:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tcth+JDU+ZzQi6ASbN2YExjNxmTw0uOL6sqXDgsMrm4=;
 b=bkraq4V3flNQwxwUJdtmXQYYZw8PMb6cPqJm/UaxM1gOjycAI/B6aVRjQqYHSMr9+R
 ILaECGKixxtGftXv3jO28RTB63jyDHZ10Fofl15SsaM1rBxviGovKEVEuaOnHYAOGiek
 vIcENlnKkBZR3ISmEF6tR89pAnHQHWYXBe/yjZvssSo/y1+dItoxuCAKKoi29r9A5KVH
 zKUd+HTy6pqGW/APjBS9VBqxvsSbaIjAAz+kK29v+t0LS1BfZveAOOMsOsGY3qPs5LrP
 CZeZ0+y5I3PBvUnpipRyVdDSOld1SDjamrDd+B5N154SQb9sZCOAh39fSlBlB9znkYJb
 hCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tcth+JDU+ZzQi6ASbN2YExjNxmTw0uOL6sqXDgsMrm4=;
 b=twJeGc1PNmOiTE17xjXQh33NobwKeNrFZlhVlrj/gYTubeWMyJqmOV+5S0LYJv08vN
 Rgv+2BShe6rFju8Fw0/OuoMo+nRZ2r94WRQYJPLduuz6OydWllH7WUBCtvsDOCAO4p5d
 FJhaCz4+TZfX/R7or6TVg4V5+M1npirOTi8AFDMtNBVT68f5F4CEffThv7TQLu/IJza7
 YGF/uc+Pad/Mgry3e3Il0ZbZGdBToMF+lmPOzF/w4zSSfebL8g1bxSkFbgBoJ+SzCrAb
 8UixT56ocjum1+SLcwEgdexGCwLErNcPeH52E7WIWc2MSAeYRQ3vLm7epwVlZpXlCjQ9
 Jy1Q==
X-Gm-Message-State: APjAAAUnQUmkFRdfE5RMFzBRVgBxdQE9BXenNPIk8myx0/q6shB4f6nE
 vlx9svtOA7GeA3rQKXYdK9N71dXD
X-Google-Smtp-Source: APXvYqwPBanywM19PdLE9x+LjxhdWkXwWjYzl7SxjOkl8b0t+pfef5o1qf0XWuXRFLYX0zeNe7HkXg==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr824913wmb.168.1571528847327; 
 Sat, 19 Oct 2019 16:47:27 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/16] hw/arm/bcm2836: Make the SoC code modular
Date: Sun, 20 Oct 2019 01:47:04 +0200
Message-Id: <20191019234715.25750-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This file creates the BCM2836/BCM2837 blocks.
The biggest differences with the BCM2838 we are going to add, are
the base addresses of the interrupt controller and the peripherals.
Add these addresses in the BCM283XInfo structure to make this
block more modular. Remove the MCORE_OFFSET offset as it is
not useful and rather confusing.

Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 723aef6bf5..019e67b906 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -16,15 +16,11 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
 
-/* Peripheral base address seen by the CPU */
-#define BCM2836_PERI_BASE       0x3F000000
-
-/* "QA7" (Pi2) interrupt controller and mailboxes etc. */
-#define BCM2836_CONTROL_BASE    0x40000000
-
 struct BCM283XInfo {
     const char *name;
     const char *cpu_type;
+    hwaddr peri_base; /* Peripheral base address seen by the CPU */
+    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
     int clusterid;
 };
 
@@ -32,12 +28,16 @@ static const BCM283XInfo bcm283x_socs[] = {
     {
         .name = TYPE_BCM2836,
         .cpu_type = ARM_CPU_TYPE_NAME("cortex-a7"),
+        .peri_base = 0x3f000000,
+        .ctrl_base = 0x40000000,
         .clusterid = 0xf,
     },
 #ifdef TARGET_AARCH64
     {
         .name = TYPE_BCM2837,
         .cpu_type = ARM_CPU_TYPE_NAME("cortex-a53"),
+        .peri_base = 0x3f000000,
+        .ctrl_base = 0x40000000,
         .clusterid = 0x0,
     },
 #endif
@@ -104,7 +104,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
-                            BCM2836_PERI_BASE, 1);
+                            info->peri_base, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
@@ -113,7 +113,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, BCM2836_CONTROL_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
@@ -126,7 +126,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpus[n]),
-                                BCM2836_PERI_BASE + MSYNC_OFFSET,
+                                info->peri_base,
                                 "reset-cbar", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.21.0


