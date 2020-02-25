Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E44C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5852084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkbqVSIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5852084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z5B-0003Rq-FN
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yko-0000uV-R8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykg-0007hM-0I
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykf-0007af-P7
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:49 -0500
Received: by mail-wr1-x42f.google.com with SMTP id l5so10127539wrx.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JZ18+psHXsYlBdcmBOszobjy8NTgnnLlqRFdeQO1hMc=;
 b=RkbqVSIp38q4FkPZ0fTF/bW7+IT4Qfvm2EOzRwW2Hq+VCNAMu5LdZnlDCAwZ+e608j
 dxa3sO5QDNCE2z0lgYCeEDnbcdsbVVWZ724ZVhizPLe0AdA2DhNZJod0FKJQdZwC47C5
 SOPC66fegWTw2aeD5/uKheX4oW/ktbEnBl/0zdK3Ggxdd3msLQX4yuen8iGPkEvRLUDu
 TOAq+AEKhysHkpCjbx1hCwOy9NQaVPdE5FOLPnVGSfCfrVSUnoXPj32gYaT325l8lInD
 jWRVdJJrV6tiu3mc3mdldgVEd+DOcm4VYZTcr4lIV2ijiKUSPkwwGkS+RZunANjMQMLt
 TgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JZ18+psHXsYlBdcmBOszobjy8NTgnnLlqRFdeQO1hMc=;
 b=CwRLYD6RKARfKq2xo672laG1polB7aJs6Q+zmCF4vO6fzTDEpPO5ftpt5mr7LfogED
 rd86S3k6tAJt6WXyIeMCRGn9HnJzynsEpiOpE3tH3izkFfdW4ABMgmhkN011PcUj+JfG
 p3jK010B2CZSnCNNUAwhcF6phQBCIIxi5e7Yz8vlEJ/wTZdLWHmtp3IS4NoMfxehMh+1
 ZTegRC6uejnGDgrcIBhMybf6+H7rOrw5Zjxqgewe46EPo6yoIP748S9DRzci4xOCD0Pp
 T1jG+S82/4MElwH1Q9nEObumKzuzn4rTKQTl6Lz16wpE5bd26Hs6NRX3MULOCqKW2iE/
 4njg==
X-Gm-Message-State: APjAAAXymcpJKU2G/h34eRI0t+jXbZH5gJj8G5DWjXTlqXWip9cIeWKM
 dT7vophegYoh/zoWM5iHF4sOpRmn
X-Google-Smtp-Source: APXvYqzKEcyeOWbWcdDiOcUZz8wkEykMn9C5dHkxZWJoKMTOtk4qMgjldVg7NxBKaw5PBkPwXBR4cA==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr73756637wrg.266.1582631508541; 
 Tue, 25 Feb 2020 03:51:48 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 045/136] lm32/milkymist: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:35 +0100
Message-Id: <1582631466-13880-45-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-46-imammedo@redhat.com>
---
 hw/lm32/milkymist.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 6d46134..5c72266 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -36,6 +36,7 @@
 #include "hw/display/milkymist_tmu2.h"
 #include "lm32.h"
 #include "exec/address-spaces.h"
+#include "qemu/cutils.h"
 
 #define BIOS_FILENAME    "mmone-bios.bin"
 #define BIOS_OFFSET      0x00860000
@@ -82,6 +83,7 @@ static void main_cpu_reset(void *opaque)
 static void
 milkymist_init(MachineState *machine)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -90,22 +92,27 @@ milkymist_init(MachineState *machine)
     int kernel_size;
     DriveInfo *dinfo;
     MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *phys_sdram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     int i;
     char *bios_filename;
     ResetInfo *reset_info;
 
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     /* memory map */
     hwaddr flash_base   = 0x00000000;
     size_t flash_sector_size        = 128 * KiB;
     size_t flash_size               = 32 * MiB;
     hwaddr sdram_base   = 0x40000000;
-    size_t sdram_size               = 128 * MiB;
 
     hwaddr initrd_base  = sdram_base + 0x1002000;
     hwaddr cmdline_base = sdram_base + 0x1000000;
-    size_t initrd_max = sdram_size - 0x1002000;
+    size_t initrd_max = machine->ram_size - 0x1002000;
 
     reset_info = g_malloc0(sizeof(ResetInfo));
 
@@ -116,9 +123,7 @@ milkymist_init(MachineState *machine)
 
     cpu_lm32_set_phys_msb_ignore(env, 1);
 
-    memory_region_allocate_system_memory(phys_sdram, NULL, "milkymist.sdram",
-                                         sdram_size);
-    memory_region_add_subregion(address_space_mem, sdram_base, phys_sdram);
+    memory_region_add_subregion(address_space_mem, sdram_base, machine->ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* Numonyx JS28F256J3F105 */
@@ -183,7 +188,7 @@ milkymist_init(MachineState *machine)
 
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(kernel_filename, sdram_base,
-                                              sdram_size);
+                                              machine->ram_size);
             reset_info->bootstrap_pc = sdram_base;
         }
 
@@ -216,6 +221,8 @@ static void milkymist_machine_init(MachineClass *mc)
     mc->init = milkymist_init;
     mc->is_default = 0;
     mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
+    mc->default_ram_size = 128 * MiB;
+    mc->default_ram_id = "milkymist.sdram";
 }
 
 DEFINE_MACHINE("milkymist", milkymist_machine_init)
-- 
1.8.3.1



