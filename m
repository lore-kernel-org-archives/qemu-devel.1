Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF453C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3FD2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpYaWrq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3FD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z17-0004cm-K0
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkU-0000ar-Rx
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkP-0006Vs-HA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkO-0006PZ-M8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:33 -0500
Received: by mail-wm1-x329.google.com with SMTP id q9so2664958wmj.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ni7BFcmeIVVMnmuVlUkskdnbHjwGqcPCtd1ZdP9PuMY=;
 b=IpYaWrq2WJESeucZxY+GiwJ7SoMf5n/K3m5ft5uSJbYxXJw45Ey5VAqWIx0KTVMabM
 wkCeT5s7Lw0vGTUnxC9bUilY4ZXrtMtDPNAyFZRoYsmu09aCoTU2lacg5pET8UoBlzFi
 +SGJtyXxGseJLkJJj4BlnpL97j0KbRRhzQQ3uUOjrpdoP7T9+t7ropvx0Mj6El0ciZIa
 V+ZUaPWJn2MsCtWek+Z4gcL4vMbmnsfP/diT13WMTDvVC7VmMT/s/kCkYsD5299OLrZQ
 H5EEQtgPp9+Q0novGsKrjHWhKgAn9NuE1/mndyU7w8Wln2NkEwp94JZWv8f1Y48QWiYu
 NYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ni7BFcmeIVVMnmuVlUkskdnbHjwGqcPCtd1ZdP9PuMY=;
 b=ldPnI+255FWNreCfJKyDbHRwL2JCSsT+Crf+guTe/wIGymApgDJdOyag+SUADsaCDI
 BxsldONM/X2cPDrs7JpjZhdxF0eQFPVD18HTKMOBu1Hi+t111v5GT6eDSG34ZfUaH4SP
 D6fx4ZTOF+5KUlDjberxTwd4mSc2+c3AHqAxbBRXvJtuYnXF1EIs0GcQk3BG5s2vd0BB
 0Ywsoyvt/MqaRGN25VbhyqfhCGpIG4UdRdANBhXQjAXY+e0lDjaK3tWYkY+njtZ5zVdb
 FwTrxExEoNf+r3yl/LFRXNQqiYqwhaVH44CwI94zDG21GA/5r4UQw4PS/Pup6IFoNpLj
 Y1Rg==
X-Gm-Message-State: APjAAAUAoE77FLm2RwOb9M+PRmXaOfPGA/7mk/jTeJAnd4BqSe7ZuhTV
 b4xQVZrx32LI3ICJdmFUuLzWSDRh
X-Google-Smtp-Source: APXvYqxzfOAYXlslJxURJXauk/MuVV3Deov1+VuGdOKJftHmYg27ZLag+R7zzGIMKMOFVcTw2+5mHA==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr5005624wmj.150.1582631491030; 
 Tue, 25 Feb 2020 03:51:31 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 026/136] arm/omap_sx1: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:16 +0100
Message-Id: <1582631466-13880-26-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-27-imammedo@redhat.com>
---
 hw/arm/omap_sx1.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index be24571..2bebab4 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -35,6 +35,7 @@
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
+#include "qemu/cutils.h"
 
 /*****************************************************************************/
 /* Siemens SX1 Cellphone V1 */
@@ -102,8 +103,8 @@ static struct arm_boot_info sx1_binfo = {
 static void sx1_init(MachineState *machine, const int version)
 {
     struct omap_mpu_state_s *mpu;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *address_space = get_system_memory();
-    MemoryRegion *dram = g_new(MemoryRegion, 1);
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *cs = g_new(MemoryRegion, 4);
     static uint32_t cs0val = 0x00213090;
@@ -115,15 +116,20 @@ static void sx1_init(MachineState *machine, const int version)
     uint32_t flash_size = flash0_size;
     int be;
 
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     if (version == 2) {
         flash_size = flash2_size;
     }
 
-    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
-                                         sx1_binfo.ram_size);
-    memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, dram);
+    memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, machine->ram);
 
-    mpu = omap310_mpu_init(dram, machine->cpu_type);
+    mpu = omap310_mpu_init(machine->ram, machine->cpu_type);
 
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
@@ -223,6 +229,8 @@ static void sx1_machine_v2_class_init(ObjectClass *oc, void *data)
     mc->init = sx1_init_v2;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
+    mc->default_ram_size = sdram_size;
+    mc->default_ram_id = "omap1.dram";
 }
 
 static const TypeInfo sx1_machine_v2_type = {
@@ -239,6 +247,8 @@ static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
     mc->init = sx1_init_v1;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
+    mc->default_ram_size = sdram_size;
+    mc->default_ram_id = "omap1.dram";
 }
 
 static const TypeInfo sx1_machine_v1_type = {
-- 
1.8.3.1



