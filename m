Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD60C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899DB20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxEV8U1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899DB20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZKw-0001GQ-MH
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl4-0001K8-V1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl0-0008Oi-DX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:14 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl0-0008IC-47
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:10 -0500
Received: by mail-wr1-x42a.google.com with SMTP id l5so10128740wrx.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dqcIX6d4mXg0667lv0+tfsAloiBk56z9WM/RHf/Ue/M=;
 b=XxEV8U1rl2hRuNyGRqZOVxKbEJIe62x6eufYcK+rQb2sfAryG0t8ViGcbBnuuCykP8
 WkTOvb946s3DqPoOi5OV0K1HeIpjzAaEFvrOCBke5VkYHffY8Z84YrUZFCnoP4Ik0RbS
 IwwrPVgsFMuAUUQhuEHzbpqmUwbxnwE9hXGEKYhcv6uZ6pcpyzw0dTE0g0QxB4faDoUI
 PpFdGvZquzm8kwUA163HRslUecl+Fm59gIQeN+/eg4uz2E3uaU0/Fhz2M5Cy0OM2nms1
 FvqjtBvCdCRsj1N32eYvKqE24cmhFAeBe1CTJpKIj6613c8CjvwLD9eKw6ZiUfq4Uk4l
 i67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dqcIX6d4mXg0667lv0+tfsAloiBk56z9WM/RHf/Ue/M=;
 b=exF7iGpb6zvCPyFStsKTmuib4VBO0aVkav3q9+3gJ6ivBMJRE+NovNRrFMA1PQHJji
 kEBAZdW1PHwlbvyBUX5E1IajQhmSi44Mlt14yRVYA7tkF1LDegxYWiboveIE+L/Z7SWi
 Cn67EbqxNIK+OLyxPTlAyOH4yOxcPG2JdD+hgVrIFEM22xWsmy3ASgo05q2Jt5Gyoh7m
 4AYc82T1XQzkUfPyhNA2WI9DUiVRxFnhrSmO2Pq1rdl+EaZaeZC0X25ip+YhYcYurlPe
 Raozwu+baahQSpiFK8ViMef/y/A92K4R3+bVl7r75YHEAMCbxPa+xgpWcdeJ7VdP36IL
 Z1Bw==
X-Gm-Message-State: APjAAAW46mBNPoNYTJ97H/bDsTrrfsc1Rh1TfGxKMPfMQQJHxZPSTijk
 78eMj1T7zX5Uox5H5CJlpFOsC/0A
X-Google-Smtp-Source: APXvYqwFL24VoCttIIMccVal6cQWZx1FCQKDm/cK/9yOEb4UcxEaPcdwXnGd5NX3KduxoCbeskGWyg==
X-Received: by 2002:adf:afc9:: with SMTP id y9mr8681306wrd.346.1582631528822; 
 Tue, 25 Feb 2020 03:52:08 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 068/136] ppc/virtex_ml507: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:58 +0100
Message-Id: <1582631466-13880-68-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-69-imammedo@redhat.com>
---
 hw/ppc/virtex_ml507.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 91dd00e..b6f4507 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -193,7 +193,6 @@ static int xilinx_load_device_tree(hwaddr addr,
 
 static void virtex_init(MachineState *machine)
 {
-    ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     hwaddr initrd_base = 0;
@@ -204,7 +203,6 @@ static void virtex_init(MachineState *machine)
     CPUPPCState *env;
     hwaddr ram_base = 0;
     DriveInfo *dinfo;
-    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32], *cpu_irq;
     int kernel_size;
     int i;
@@ -221,8 +219,7 @@ static void virtex_init(MachineState *machine)
 
     qemu_register_reset(main_cpu_reset, cpu);
 
-    memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_size);
-    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
+    memory_region_add_subregion(address_space_mem, ram_base, machine->ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
@@ -265,7 +262,7 @@ static void virtex_init(MachineState *machine)
             /* If we failed loading ELF's try a raw image.  */
             kernel_size = load_image_targphys(kernel_filename,
                                               boot_offset,
-                                              ram_size);
+                                              machine->ram_size);
             boot_info.bootstrap_pc = boot_offset;
             high = boot_info.bootstrap_pc + kernel_size + 8192;
         }
@@ -276,7 +273,7 @@ static void virtex_init(MachineState *machine)
         if (machine->initrd_filename) {
             initrd_base = high = ROUND_UP(high, 4);
             initrd_size = load_image_targphys(machine->initrd_filename,
-                                              high, ram_size - high);
+                                              high, machine->ram_size - high);
 
             if (initrd_size < 0) {
                 error_report("couldn't load ram disk '%s'",
@@ -290,7 +287,7 @@ static void virtex_init(MachineState *machine)
         boot_info.fdt = high + (8192 * 2);
         boot_info.fdt &= ~8191;
 
-        xilinx_load_device_tree(boot_info.fdt, ram_size,
+        xilinx_load_device_tree(boot_info.fdt, machine->ram_size,
                                 initrd_base, initrd_size,
                                 kernel_cmdline);
     }
@@ -302,6 +299,7 @@ static void virtex_machine_init(MachineClass *mc)
     mc->desc = "Xilinx Virtex ML507 reference design";
     mc->init = virtex_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440-xilinx");
+    mc->default_ram_id = "ram";
 }
 
 DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
-- 
1.8.3.1



