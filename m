Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A1C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7583E206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJezb71x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7583E206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW1U-0005I5-L0
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr2-0001vQ-0T
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqz-0002dU-O7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqz-0002V2-HI; Mon, 06 Apr 2020 13:48:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so493725wrt.6;
 Mon, 06 Apr 2020 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9GzJBcaH7YPzqJchPXzUGJQV7uPNUIzvdkgPb+3/qBw=;
 b=lJezb71x6OD7EoU5SBsLyeXUDP99ZBy0CoJ2JTT9wrKvQUrcAA+9t72QAzfSE1WKGY
 EuPlLcv0ZcepsfwePaaxGy+zU7JE2uUkM1GqwPcaDLqcCelTrOHmQNMqm2ei0ABRHkWt
 aKg7QHkbs0qjq8UVo6L8r1RZq+ZElSn6kIcFWnDMOKx0Io7ptetsDceQeD/ULVjwWjVl
 uUrUJrfxI1NG0HsZ1DS0n8pnfGvQV559182Rs9a0IsPAk4p8cgVKaU5LSLarEY9Vq255
 aqLVBlzgTwXtNVaGTyW/y29r3kd0E1LhZROdcw105xJuLHfej+x9WsqQH6Jy7zHYNN5I
 9S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9GzJBcaH7YPzqJchPXzUGJQV7uPNUIzvdkgPb+3/qBw=;
 b=hGfi+fS7iNFWY8ks17ZVB5C7o+VGMDQYkkZwoaIcXLAh/QGOTYTtwWDg9c+jO+oGSQ
 Q9DWQQk1u9pN4WOZmAGhu9i+R+qCwM70hskqVG0o3vRFLizhEmnioHyq5atBAM3ldmzH
 PlFMpnaufNZ08FJg0HBQkG2SqsRIg928bpyDCn859KQ5TAp0hQFSWUTI9fFdD9mw/QQL
 8+kNxIoiS7bXgJpjlacc3uQD4clyfAXysPN/sT4GX+QvJYv39mlR+d1KqJ/okIKJZ8NI
 eB3gQihMmTJ1h/hOcOKdVzMLfvjFnFETInJ68HZxCO5yxhNj4T3iz4IHMVId4wsIa6cq
 SSlw==
X-Gm-Message-State: AGi0PuZxVKHjLHoq5WMjjVsqSB+7miYs6oUoDdHNfM3rq7UEwCa3Q8v4
 z+HLZswk2xDR5B6Vd0gNav8jbEu1T2g=
X-Google-Smtp-Source: APiQypKT8yu3DseEnPCJ1+pdq8XW7v+6zneWJaBf4wB7jVdEClEFcvHCrcRVbTpkWP/+nguC88Lzlw==
X-Received: by 2002:adf:db4f:: with SMTP id f15mr362504wrj.95.1586195288048;
 Mon, 06 Apr 2020 10:48:08 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 16/54] hw/arm/xlnx-zynqmp: Move some code from
 realize() to init()
Date: Mon,  6 Apr 2020 19:47:05 +0200
Message-Id: <20200406174743.16956-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle failed at processing this file:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/xlnx-zynqmp.c
  EXN: Coccinelle_modules.Common.Timeout

Move the calls using &error_abort which don't depend of input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xlnx-zynqmp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 457057198a..5ec9c24ee7 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -242,6 +242,11 @@ static void xlnx_zynqmp_init(Object *obj)
                                 &s->apu_cpu[i], sizeof(s->apu_cpu[i]),
                                 ARM_CPU_TYPE_NAME("cortex-a53"),
                                 &error_abort, NULL);
+
+        object_property_set_int(OBJECT(&s->apu_cpu[i]), QEMU_PSCI_CONDUIT_SMC,
+                                "psci-conduit", &error_abort);
+        object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
+                                "reset-cbar", &error_abort);
     }
 
     sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
@@ -250,6 +255,10 @@ static void xlnx_zynqmp_init(Object *obj)
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
         sysbus_init_child_obj(obj, "gem[*]", &s->gem[i], sizeof(s->gem[i]),
                               TYPE_CADENCE_GEM);
+        object_property_set_int(OBJECT(&s->gem[i]), GEM_REVISION, "revision",
+                                &error_abort);
+        object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-queues",
+                                &error_abort);
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
@@ -259,6 +268,8 @@ static void xlnx_zynqmp_init(Object *obj)
 
     sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
                           TYPE_SYSBUS_AHCI);
+    object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
+                            &error_abort);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
         sysbus_init_child_obj(obj, "sdhci[*]", &s->sdhci[i],
@@ -370,9 +381,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < num_apus; i++) {
         char *name;
 
-        object_property_set_int(OBJECT(&s->apu_cpu[i]), QEMU_PSCI_CONDUIT_SMC,
-                                "psci-conduit", &error_abort);
-
         name = object_get_canonical_path_component(OBJECT(&s->apu_cpu[i]));
         if (strcmp(name, boot_cpu)) {
             /* Secondary CPUs start in PSCI powered-down state */
@@ -387,8 +395,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                  s->secure, "has_el3", NULL);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]),
                                  s->virt, "has_el2", NULL);
-        object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
-                                "reset-cbar", &error_abort);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), num_apus,
                                 "core-count", &error_abort);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
@@ -490,10 +496,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
             qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
             qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
         }
-        object_property_set_int(OBJECT(&s->gem[i]), GEM_REVISION, "revision",
-                                &error_abort);
-        object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-queues",
-                                &error_abort);
         object_property_set_bool(OBJECT(&s->gem[i]), true, "realized", &err);
         if (err) {
             goto out_propagate_error;
@@ -514,8 +516,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                            gic_spi[uart_intr[i]]);
     }
 
-    object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
-                            &error_abort);
     object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
     if (err) {
         goto out_propagate_error;
-- 
2.21.1


