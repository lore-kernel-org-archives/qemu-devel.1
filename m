Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622E7C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305902084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef2FNZ6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305902084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z1B-0004m4-82
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yko-0000uT-Tr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykf-0007ZG-1t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:52 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yke-0007Tk-QO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id v4so1506065wrs.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RflQQugqQD+TmG6zwoLNwhsZIRibctO8/AYIKjncmbQ=;
 b=Ef2FNZ6AMBIBUVJDT4fQsPqOqhnU+CoHOVhn/FwuSzZPDYI1r+XZm5uGa+r0dRHLeg
 UY1s7Ef4C31ZKMkUcdtg63+jNI9QSY9L9I8GCpYyL+rKpKDSLIcWTrMlcM4bUv+JmYKf
 nAPvFjSju1SQV4ruIPrXqN5Fe5hfUF0wwjnBMcGg4XrqdeM3dlzVZsMQirFiZLxZTjTj
 I6+aMgqQKAjdlcO0YOW2lvH6OSP4P1ECgpk3xgXZIzq8PNn3GlfjX1BZVNlM+UjbJ4rx
 G5fpvVpwA+9vOT8b79M/HiX9xHp3ugmdkGwGLiE2WUludfRujjU4DvaMcLYS8atHjZ2C
 C1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RflQQugqQD+TmG6zwoLNwhsZIRibctO8/AYIKjncmbQ=;
 b=CkbEqcsEKVWIInSJ4UMt9js0DaGFtVLtB76KFQHYKBVBlK97z+PXehN/w5VkaVxekq
 CklXuEafA2WFh4cwE9WCnDN4NT5LmhhZ33PdBbz+axWXyZsQR8xCtMYuC1qusSFU503J
 dyFmIGECXa1v4k5JVat3bIOyuSWFcjTc/TH7kjxfU1uIkPs4Saj7x8lHXwcmPlBAvOdD
 FdtwbBr6BfZTi2qpwrEPBWahGmqm9akXyD8gnqUUb5W+es/BNkZ8EYg9zbbhUVPyHdt5
 Od4reNGp6sO0KK3u2LrlSy5kTB6yjNmzVaDQNevYjtqfs+1Y4Q6z39z7IBRD9oSJ0WSV
 GjUg==
X-Gm-Message-State: APjAAAXMKoYwFVPFJTwnrei7IRYiMh88/RYm+3EC/rkLqFEFk7h8Z5/t
 GDy8sqSiwytJ7DjDGzwD9SgUN+zT
X-Google-Smtp-Source: APXvYqx6zVC9T3IQQSRFwTuMKgHyHvniGvHtSDXYvgdAimJE+z5v1P7cW8g+NB+ON/lmh/h4GEZwOA==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr70253391wrq.176.1582631507499; 
 Tue, 25 Feb 2020 03:51:47 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 044/136] lm32/lm32_boards: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:34 +0100
Message-Id: <1582631466-13880-44-git-send-email-pbonzini@redhat.com>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-45-imammedo@redhat.com>
---
 hw/lm32/lm32_boards.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index d1894ad..4e0a98c 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
@@ -75,22 +76,28 @@ static void main_cpu_reset(void *opaque)
 
 static void lm32_evr_init(MachineState *machine)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     LM32CPU *cpu;
     CPULM32State *env;
     DriveInfo *dinfo;
     MemoryRegion *address_space_mem =  get_system_memory();
-    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     ResetInfo *reset_info;
     int i;
 
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     /* memory map */
     hwaddr flash_base  = 0x04000000;
     size_t flash_sector_size       = 256 * KiB;
     size_t flash_size              = 32 * MiB;
     hwaddr ram_base    = 0x08000000;
-    size_t ram_size                = 64 * MiB;
     hwaddr timer0_base = 0x80002000;
     hwaddr uart0_base  = 0x80006000;
     hwaddr timer1_base = 0x8000a000;
@@ -107,9 +114,7 @@ static void lm32_evr_init(MachineState *machine)
 
     reset_info->flash_base = flash_base;
 
-    memory_region_allocate_system_memory(phys_ram, NULL, "lm32_evr.sdram",
-                                         ram_size);
-    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
+    memory_region_add_subregion(address_space_mem, ram_base, machine->ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* Spansion S29NS128P */
@@ -144,7 +149,7 @@ static void lm32_evr_init(MachineState *machine)
 
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(kernel_filename, ram_base,
-                                              ram_size);
+                                              machine->ram_size);
             reset_info->bootstrap_pc = ram_base;
         }
 
@@ -159,6 +164,7 @@ static void lm32_evr_init(MachineState *machine)
 
 static void lm32_uclinux_init(MachineState *machine)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -166,18 +172,23 @@ static void lm32_uclinux_init(MachineState *machine)
     CPULM32State *env;
     DriveInfo *dinfo;
     MemoryRegion *address_space_mem =  get_system_memory();
-    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     HWSetup *hw;
     ResetInfo *reset_info;
     int i;
 
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     /* memory map */
     hwaddr flash_base   = 0x04000000;
     size_t flash_sector_size        = 256 * KiB;
     size_t flash_size               = 32 * MiB;
     hwaddr ram_base     = 0x08000000;
-    size_t ram_size                 = 64 * MiB;
     hwaddr uart0_base   = 0x80000000;
     hwaddr timer0_base  = 0x80002000;
     hwaddr timer1_base  = 0x80010000;
@@ -200,9 +211,7 @@ static void lm32_uclinux_init(MachineState *machine)
 
     reset_info->flash_base = flash_base;
 
-    memory_region_allocate_system_memory(phys_ram, NULL,
-                                         "lm32_uclinux.sdram", ram_size);
-    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
+    memory_region_add_subregion(address_space_mem, ram_base, machine->ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* Spansion S29NS128P */
@@ -238,7 +247,7 @@ static void lm32_uclinux_init(MachineState *machine)
 
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(kernel_filename, ram_base,
-                                              ram_size);
+                                              machine->ram_size);
             reset_info->bootstrap_pc = ram_base;
         }
 
@@ -252,7 +261,7 @@ static void lm32_uclinux_init(MachineState *machine)
     hw = hwsetup_init();
     hwsetup_add_cpu(hw, "LM32", 75000000);
     hwsetup_add_flash(hw, "flash", flash_base, flash_size);
-    hwsetup_add_ddr_sdram(hw, "ddr_sdram", ram_base, ram_size);
+    hwsetup_add_ddr_sdram(hw, "ddr_sdram", ram_base, machine->ram_size);
     hwsetup_add_timer(hw, "timer0", timer0_base, timer0_irq);
     hwsetup_add_timer(hw, "timer1_dev_only", timer1_base, timer1_irq);
     hwsetup_add_timer(hw, "timer2_dev_only", timer2_base, timer2_irq);
@@ -288,6 +297,8 @@ static void lm32_evr_class_init(ObjectClass *oc, void *data)
     mc->init = lm32_evr_init;
     mc->is_default = 1;
     mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
+    mc->default_ram_size = 64 * MiB;
+    mc->default_ram_id = "lm32_evr.sdram";
 }
 
 static const TypeInfo lm32_evr_type = {
@@ -304,6 +315,8 @@ static void lm32_uclinux_class_init(ObjectClass *oc, void *data)
     mc->init = lm32_uclinux_init;
     mc->is_default = 0;
     mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
+    mc->default_ram_size = 64 * MiB;
+    mc->default_ram_id = "lm32_uclinux.sdram";
 }
 
 static const TypeInfo lm32_uclinux_type = {
-- 
1.8.3.1



