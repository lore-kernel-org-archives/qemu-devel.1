Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903F4C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602B8218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8SbGL/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602B8218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZH2-0001bL-GA
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykq-0000x0-9s
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykj-00081R-LX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:00 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yki-0007wW-DQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:53 -0500
Received: by mail-wr1-x435.google.com with SMTP id z15so6036860wrl.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SgZvYL+Hn5j8x93NoxwcO2mgPavkLnr8s0tZPnErZBQ=;
 b=q8SbGL/nQ3BnU35iSktqL7lprX0eVfksdIJCcIw4d+nDYroMKzBh4tXoG6af9Sar7B
 tw1az3eJmZ6/ywK/ZiGRT6eYGoAX8sxM6dpB3F4Ig589FJ/oi/a7f0uxI1GLaZ6QS0j3
 X3c9PncG82Ao6APAEXApgZTyL2fMYbXlcQStMW31hRkCa9I6sXcRhNUMgiHvEMfV5vyP
 7hCZrrxQdz9/6XOppyku2EZeq7b5NZzOS9weIO01+hlNfd0SGLMpjzsVgl0Zbl3uVSM3
 tp6lkrHvY2E710f14ZomX0vaMu94fvXzbBaYwqLXI8S2Ox/dXwPsgzX0iiCIuhAXqRPp
 7qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SgZvYL+Hn5j8x93NoxwcO2mgPavkLnr8s0tZPnErZBQ=;
 b=TtUTtN+K+o+WXJGI8e/I+XAb8p3YNDxrrA2jmohIOb9Ra4+Z2dQOpbjW777RqlolIh
 taDMP4SZ1hP6q1IHJl3Pwn7cz/2OYu3sCrUCV9YAAdulcGcXrS6E2FpYoMJkezoUhTTX
 MU8mKZ5+jCiEMLaQNsYt5zrTE96JHwO32ooXzdnM1tV6grsMlwR/PczViYnOoHrorFM8
 q8xNjtau/SJQNHGbYcYx5TEXgWEasolGTwsSNLjJP0DRDQsG+ePfFmIUM6B3RoobV1RA
 9lyfiipMPNwDK1aalclUMZtRf6J/c1m6Op4QmXFj/LdbF8KYU1o+9AxBFdEHdALoWMyU
 6dxw==
X-Gm-Message-State: APjAAAWUZ6dM5ZPUPyWpG9jNDtJWz1jz/pmsrROjA1LivhfX2cGVYWFP
 xFN+dSd++RT8Z8NSb3JQhyHdRXY5
X-Google-Smtp-Source: APXvYqxxZbOUA1a2cAS4O26cJF06PfQm5n8nDL1AwzghcuS81aaf7lJQuIVWHobctSViWSbDGy8/yQ==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr72017348wrw.244.1582631511118; 
 Tue, 25 Feb 2020 03:51:51 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 048/136] m68k/mcf5208: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:38 +0100
Message-Id: <1582631466-13880-48-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-49-imammedo@redhat.com>
---
 hw/m68k/mcf5208.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index a999c21..31622c7 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -234,7 +234,6 @@ static void mcf5208evb_init(MachineState *machine)
     qemu_irq *pic;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *rom = g_new(MemoryRegion, 1);
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
@@ -249,8 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x00000000, rom);
 
     /* DRAM at 0x40000000 */
-    memory_region_allocate_system_memory(ram, NULL, "mcf5208.ram", ram_size);
-    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
+    memory_region_add_subregion(address_space_mem, 0x40000000, machine->ram);
 
     /* Internal SRAM.  */
     memory_region_init_ram(sram, NULL, "mcf5208.sram", 16 * KiB, &error_fatal);
@@ -354,6 +352,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->init = mcf5208evb_init;
     mc->is_default = 1;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
+    mc->default_ram_id = "mcf5208.ram";
 }
 
 DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
-- 
1.8.3.1



