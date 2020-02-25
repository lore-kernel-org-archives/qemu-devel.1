Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD3BC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAE024683
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqJEaVt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAE024683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z1m-0005xk-UO
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkR-0000WM-BQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkM-0006Ik-64
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:34 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkL-0006F2-U5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id t23so2679044wmi.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WnuXdvaUbWNGuH9SX/umKTGFF9M6WOjsGW3BABTIhKU=;
 b=HqJEaVt5kNZDAYMFO8H8XpVfQwfyB5Dqb5N5fRVDWygFKSv+Gaz5bXqQHCteLksReS
 jSPV2i570WlNPAmpymdgYUezcE0qMzBfy7NMy/drFs+OoWTNsCKDuoG7+Zaw2qKDTfcO
 1I84mE6BmFX+MsftbBIPQiiKkyHAmioQHde+op/599bACOfOwSgXBtpdnKXqkRTQPTl9
 4FiI76nPD46275HeGjoTA4vDujftHArJ0zLT6kHbSEThNW5VfzkQIX/3nO3eNeMLEY+n
 tgt/32IiTsm96KXCHbnDBiJnOuf4lP91B65V4Ij+WSOx4C6SqYI/gRUcBVwoU/MlcBfP
 ndjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=WnuXdvaUbWNGuH9SX/umKTGFF9M6WOjsGW3BABTIhKU=;
 b=qHpjCPqRCbu9Fz2LLKHC2Pw1a1ga+8Y7hUNLqxZJ95VTkHOXFrJHF/yv168neuuY/v
 /Jy25K55tiMjBE1sVE/M5QhKQFtoWgXqowJsXAC/yxnwnaLi9cJM2aWbtf9RK33dWusb
 OrDH5jKzPvvAxGlySl00iu43UseYQFXL7dyXePaKXbThgqMCSwS8Zw/qbf4t3t+Ist98
 6wVc9ZMGhunOWfj/RidrUeqSJ0ZPTl16hdaEJgkadJM0dwm1o3m1Az/WOilfg0+84qJK
 HHyb00es8tzA9KrHdhXBO4DDXETU1cHRswQEs1NMrFN0Vd45qjKdUEQtT4il9A95Xkdz
 mmXQ==
X-Gm-Message-State: APjAAAXmNBu0f9ju1x/xGeTwwlR9NqswKqJGLBXzlkL6B7/R+nF9vy5L
 qt6SRe3mws2zuUJ1Btb3VcBhbAe+
X-Google-Smtp-Source: APXvYqxjaWdoWORkLjYZiN3XdwRXH5zddY81feBbr7TipFJyxwNX1MVLHftQyjB9Km5HyeK5ysfwSQ==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr4888413wmh.35.1582631486509; 
 Tue, 25 Feb 2020 03:51:26 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 021/136] arm/mcimx7d-sabre: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:11 +0100
Message-Id: <1582631466-13880-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

PS:
 remove no longer needed MCIMX7Sabre

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-22-imammedo@redhat.com>
---
 hw/arm/mcimx7d-sabre.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 0d1f62d..de1e264 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -21,15 +21,10 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
 
-typedef struct {
-    FslIMX7State soc;
-    MemoryRegion ram;
-} MCIMX7Sabre;
-
 static void mcimx7d_sabre_init(MachineState *machine)
 {
     static struct arm_boot_info boot_info;
-    MCIMX7Sabre *s = g_new0(MCIMX7Sabre, 1);
+    FslIMX7State *s;
     int i;
 
     if (machine->ram_size > FSL_IMX7_MMDC_SIZE) {
@@ -45,15 +40,12 @@ static void mcimx7d_sabre_init(MachineState *machine)
         .nb_cpus = machine->smp.cpus,
     };
 
-    object_initialize_child(OBJECT(machine), "soc",
-                            &s->soc, sizeof(s->soc),
-                            TYPE_FSL_IMX7, &error_fatal, NULL);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
+    s = FSL_IMX7(object_new(TYPE_FSL_IMX7));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_fatal);
+    object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
 
-    memory_region_allocate_system_memory(&s->ram, NULL, "mcimx7d-sabre.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(get_system_memory(),
-                                FSL_IMX7_MMDC_ADDR, &s->ram);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_MMDC_ADDR,
+                                machine->ram);
 
     for (i = 0; i < FSL_IMX7_NUM_USDHCS; i++) {
         BusState *bus;
@@ -63,7 +55,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
 
         di = drive_get_next(IF_SD);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
-        bus = qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
+        bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
         carddev = qdev_create(bus, TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
         object_property_set_bool(OBJECT(carddev), true,
@@ -71,7 +63,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
     }
 }
 
@@ -80,5 +72,6 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_ram_id = "mcimx7d-sabre.ram";
 }
 DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
-- 
1.8.3.1



