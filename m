Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4001C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712072084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uneqT1as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712072084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z6f-0006mD-KD
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl2-0001C9-3l
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008Gl-AL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:11 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yky-000823-Ke
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:09 -0500
Received: by mail-wr1-x42d.google.com with SMTP id p18so10722127wre.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HZbjw+zNbvyHHDi4Vl4rQmzRhVek9kp6hCCBPtDdrFY=;
 b=uneqT1asALWacDMeWp8wx7zDL/mAXYZDBcQfX4V4Fb7ncUrmDkBP/yESPOXOev3tsf
 wcyZhF+N8qLBxk4s4bGC+wqqFKIjVlkb62hsWU8vRHbYoPSHBEgY6ei6JcpY/mnK+Dtu
 /w4C2dUpcXLrllKt6B3HFkuQbxnNlg0YhQe7v/e1tuhZt/0K571zUPqQp9PJv4twoU0Z
 6M5vrTcFslQWBwQk7ZR8S3y8BjtsMMQTQNpbkA+g3xFx6DrzXOWu0v3k6fobTmRjhFgZ
 FTARsuIdPzHFatLfWeINBeHTrPtMnGGwN9uVuBzehhlL9BTseu45rnIJe/9aZWnok9mV
 xk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HZbjw+zNbvyHHDi4Vl4rQmzRhVek9kp6hCCBPtDdrFY=;
 b=rErL9DuXzKZdwW9r571ACU2e7mRySwFA/X0/jqkILmolWVDbOaw2YNtAa6AVchriO2
 KPcNxxrtGhSD4mkPeQH0YwBdVKx91Iweu/kMU0p8LTEDY02rGNtA+Yxx3b5kxLKCxQGH
 UHa8aHrR1IKugSKRcbh5PdFrhJKT5kcaH6EIzWsqS3ZkbbE9J+v4Ltk7DiuVcTE58KqN
 1iKuZZwqYExWrDygOXes6BxqobISskINMvx/UAxUYx9jNv1HIrP0ToZ+yotiy5MC1Ztn
 4P4MS+fR3CKYkqyOxxqws7JBp44w3vUZNeX19/9HXaIo85tiCsbkM84ptFEXHusMRrWH
 /gjw==
X-Gm-Message-State: APjAAAX38i9qSnLlhaqAHDeqG1HIf2Q7542CbzZ+jqhBv8wKTVl4Uew/
 7kjNloKn7henqj9HvFUfoxngJU8u
X-Google-Smtp-Source: APXvYqxPUUc8U2pK4lYYxQSYfCzZizT3mkLvKcdGGewgP75e1JfLVc6DT4NzmLF0XcrgUHp1eYihog==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr70254129wrq.176.1582631515454; 
 Tue, 25 Feb 2020 03:51:55 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 053/136] mips/mips_jazz: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:43 +0100
Message-Id: <1582631466-13880-53-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Message-Id: <20200219160953.13771-54-imammedo@redhat.com>
---
 hw/mips/mips_jazz.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 66fd4d8..85d49cf 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -159,7 +159,6 @@ static void mips_jazz_init(MachineState *machine,
     ISABus *isa_bus;
     ISADevice *pit;
     DriveInfo *fds[MAX_FD];
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MemoryRegion *bios2 = g_new(MemoryRegion, 1);
     SysBusESPState *sysbus_esp;
@@ -191,9 +190,7 @@ static void mips_jazz_init(MachineState *machine,
     cc->do_transaction_failed = mips_jazz_do_transaction_failed;
 
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(address_space, 0, ram);
+    memory_region_add_subregion(address_space, 0, machine->ram);
 
     memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
                            &error_fatal);
@@ -393,6 +390,7 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
     mc->init = mips_magnum_init;
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
+    mc->default_ram_id = "mips_jazz.ram";
 }
 
 static const TypeInfo mips_magnum_type = {
@@ -409,6 +407,7 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
     mc->init = mips_pica61_init;
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
+    mc->default_ram_id = "mips_jazz.ram";
 }
 
 static const TypeInfo mips_pica61_type = {
-- 
1.8.3.1



