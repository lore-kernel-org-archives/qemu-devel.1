Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D91C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903722084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/NJDvnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903722084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z30-0008MN-PC
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yko-0000vP-Oj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykh-0007t1-AR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:55 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykg-0007iR-Nr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: by mail-wr1-x431.google.com with SMTP id y17so5561475wrn.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Frd9kAdV84R9k9k/O1Hor30Emol0j6Z4RBCmBlmORMU=;
 b=l/NJDvnN9q+AycqU81VHIqwkq9uJ81euJfxHlKaEKtUdHuYKS/itzl9NhK90GseOEb
 TpLhKfXF47OOELTjGxfmJFZjgbRXL52ZF5hoCGw6pcKIPok/d+e4AJ7ASP68B14WqZcS
 WBt3nHk5BURAjUVrDGBGjBsYFihJ5ozH94Zh58fLDSEFJAjlUAy+Sr2eBBTZzgzw2tHL
 eHU/drqBVAZxhNQtrkZbczVa7KZEu3OuvNoM5MlKcwoSGjG+MrAvjqgXQQk/KphXTkys
 I/PY4lbVFf79PysJ3rnZG60smgq+/sFA2spHO/CSR2SBbc62m/mYiY0Yfbzb96DghYFA
 N54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Frd9kAdV84R9k9k/O1Hor30Emol0j6Z4RBCmBlmORMU=;
 b=qv/FzZmSYtVVehmWu7zDGUtqEnkGpRhKzm9qrDcIRSNimrDI63kBoEmVuLmtPMRtTF
 B5PXtipzpth5gtk6KDbZQsM6OcVgYbB87ag2ARviZuBzifvBGiwWJI2QQKZxWrYnAUCM
 +ot0E037oZh6MxaD/y4Q464R5XzyMb75hgbaYt+XT+L+zckQ1vpsE2Db8b+FC7205Ahc
 JdcU+B7SGbBCcG5RvPEKxZ1VqY+VFSe6Lze7qSQnmy8v2AeDNw6NsdMq8qTtWPDAxWZg
 JmXsZjfQtWPTXm0aRjXn8smntm2QDzw/VAQ539xCjArB1pOCWrbRsJv9kNxlBVhwJTeu
 67YA==
X-Gm-Message-State: APjAAAV4lYHwbKUZqFEmr+FrgsAwIy//OQecu+01DsUJxy+zt285dpE8
 YlNvtoEF1P0HTf4WZBOFAHIox8gq
X-Google-Smtp-Source: APXvYqwKcaKFCchGuGi15U9oG4MDHLVBcEt9xdG/h8HsunTqVZbpKlLmWAen4jRqA6Rm44P1L0ABpw==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr14810976wro.316.1582631509521; 
 Tue, 25 Feb 2020 03:51:49 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 046/136] m68k/an5206: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:36 +0100
Message-Id: <1582631466-13880-46-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Message-Id: <20200219160953.13771-47-imammedo@redhat.com>
---
 hw/m68k/an5206.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index bed43a9..846f4e4 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -33,7 +33,6 @@ static void an5206_init(MachineState *machine)
     uint64_t elf_entry;
     hwaddr entry;
     MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
@@ -46,8 +45,7 @@ static void an5206_init(MachineState *machine)
     env->rambar0 = AN5206_RAMBAR_ADDR | 1;
 
     /* DRAM at address zero */
-    memory_region_allocate_system_memory(ram, NULL, "an5206.ram", ram_size);
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     /* Internal SRAM.  */
     memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal);
@@ -89,6 +87,7 @@ static void an5206_machine_init(MachineClass *mc)
     mc->desc = "Arnewsh 5206";
     mc->init = an5206_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
+    mc->default_ram_id = "an5206.ram";
 }
 
 DEFINE_MACHINE("an5206", an5206_machine_init)
-- 
1.8.3.1



