Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C7C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9151A24656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEjjrBl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9151A24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YxD-0006DF-Ia
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkX-0000fF-2A
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkT-0006ej-6Y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:50784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkR-0006Wz-9a
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id a5so2683992wmb.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=U5kFGAIJC6XbMJAjuz4YlirYUr1fp+EN3cTHmi55J7k=;
 b=CEjjrBl1VDADTFUROdro99P3ZjBiY+SGsugsEHKleK1bgdHw+ow7hqm4Udw6NeVQx6
 jf5VkTt3Y0hRsaBrJ2EgGt0OVnSro77aFGewqXnh+nibOclUA8fCi9fX2RLpfniSfnL7
 +eobvBxX3psLjz8GQ/XZI9HX2Isiv8A3ixkOTcYIwllqakSG/bkOPCCv2rbRawcluY02
 +z3iQm+HZWv8aAfH2q5a/rxDG6ajEn3Ak6r+hqlGs2eymfNBNzCSw+UQo+zBxp5HhjCO
 5cEqRmIG869vTTTGGIgUY+frJyKgm0IL/tUROaSZ39+XH3cgtMW6HLpbSwoglwGqO4bj
 bhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=U5kFGAIJC6XbMJAjuz4YlirYUr1fp+EN3cTHmi55J7k=;
 b=LZwg+9uAE9/H+fZyY5dusHpETeCX58nV+OkoF7rTqeaZYWRTPOd9cyW59t36es6t8y
 C/u+ex8eSltO/goXSR2JHGzET6SSTkxKwD7JgSRpdmou9fOyQjoKJU2Er/QAY1dRGqFA
 Z5LVKlkZJXeyRBDyGI6QLAGHVI6leojqF/Y3sNpqVU8q6j2tPfvmgoKMb6AmsbQ69x5N
 l+JTdqC7ZvZLkbSffT9TO1FnAgncCMBJ19HX04vqy2C4DHrwYt1Xgp4WPPRorzKGf5KU
 weOt90TmujUVzBYpOW9Get0Y2nvnkRLWXm/aIDAtyR3iAJtPJH/EzarUSxVb+RxRg+XU
 vNjQ==
X-Gm-Message-State: APjAAAVHifu9aa/vHhiijPUZFfkf49haUBTQIglxkro2JNc5YZBTtbca
 JqOit0YUqiCTIJFNzET8E/S/Hb7H
X-Google-Smtp-Source: APXvYqxKD0iD3S8RSRNvq5qAsZZdiyD3Od/TRz2jByFfH9sT7EquOL+OmChl9q8pRak4YOMFq9EA/Q==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr4888972wmh.35.1582631493121; 
 Tue, 25 Feb 2020 03:51:33 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 028/136] arm/sabrelite: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:18 +0100
Message-Id: <1582631466-13880-28-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
 remove no longer needed IMX6Sabrelite

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-29-imammedo@redhat.com>
---
 hw/arm/sabrelite.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 96cc455..e31694b 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -19,11 +19,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
 
-typedef struct IMX6Sabrelite {
-    FslIMX6State soc;
-    MemoryRegion ram;
-} IMX6Sabrelite;
-
 static struct arm_boot_info sabrelite_binfo = {
     /* DDR memory start */
     .loader_start = FSL_IMX6_MMDC_ADDR,
@@ -45,7 +40,7 @@ static void sabrelite_reset_secondary(ARMCPU *cpu,
 
 static void sabrelite_init(MachineState *machine)
 {
-    IMX6Sabrelite *s = g_new0(IMX6Sabrelite, 1);
+    FslIMX6State *s;
     Error *err = NULL;
 
     /* Check the amount of memory is compatible with the SOC */
@@ -55,19 +50,16 @@ static void sabrelite_init(MachineState *machine)
         exit(1);
     }
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_FSL_IMX6, &error_abort, NULL);
-
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &err);
+    s = FSL_IMX6(object_new(TYPE_FSL_IMX6));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_fatal);
+    object_property_set_bool(OBJECT(s), true, "realized", &err);
     if (err != NULL) {
         error_report("%s", error_get_pretty(err));
         exit(1);
     }
 
-    memory_region_allocate_system_memory(&s->ram, NULL, "sabrelite.ram",
-                                         machine->ram_size);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
-                                &s->ram);
+                                machine->ram);
 
     {
         /*
@@ -78,7 +70,7 @@ static void sabrelite_init(MachineState *machine)
         /* Add the sst25vf016b NOR FLASH memory to first SPI */
         Object *spi_dev;
 
-        spi_dev = object_resolve_path_component(OBJECT(&s->soc), "spi1");
+        spi_dev = object_resolve_path_component(OBJECT(s), "spi1");
         if (spi_dev) {
             SSIBus *spi_bus;
 
@@ -109,7 +101,7 @@ static void sabrelite_init(MachineState *machine)
     sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
+        arm_load_kernel(&s->cpu[0], machine, &sabrelite_binfo);
     }
 }
 
@@ -119,6 +111,7 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->init = sabrelite_init;
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_id = "sabrelite.ram";
 }
 
 DEFINE_MACHINE("sabrelite", sabrelite_machine_init)
-- 
1.8.3.1



