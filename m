Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81634C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5502084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcwF6N2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5502084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z53-0003Jy-GK
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-00013f-5y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykt-00085s-Tx
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykr-00081E-KG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id t79so1178529wmt.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4crmfNV4jsRN691e2/MvyZO9QauHaSK12p3Pg7oIRAs=;
 b=WcwF6N2Ixc3j1Q3XHkxlRCVj3jzF2nG5YFYggg97oJ+shHQvDz3CCMZKrq37YqSYXQ
 x97XUA4dTXgskWfoNrYhpEjZf4tNEy1yGeW8S0ZmK6skfNF5bFNbW3T6Irzk7qoBF4MK
 r/bbrl0ejVik5UF8ts+0/Nyp6rjMe6+Q2gpvQJbMh7brcbKUoDa0pn8sDSXSFiI+RRhD
 4r/RH4yLPivSkPeRlQPPBmb7FgEb6hhYlmXUHNQN4zWYMmt5BGoeG/Gu1sd87VKU5mdl
 G7A+zeI+4KU94fiEst5giH1/v21uql4TLAS7T4qybsal2nKt6nyjp2kubLunEdo5NLBq
 mgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4crmfNV4jsRN691e2/MvyZO9QauHaSK12p3Pg7oIRAs=;
 b=NHIH0dUxrXnQ2gP6fH43Zpv/788k+mqZFv21Mm8LyZJj5o0BUmlO2wNVNrC4urb73L
 mcZKp/M5+7a40FpVz72jreoxzngdDclSqGk9NZ5tHNg5ERjETL3em9WM596GiyNBXtVt
 UGv5V0zY4CRCgk2WjF6mB+mSsC62M3uLsmS5zxyyj7SQVVslzMq7F8zc6zLqzdXdm9RW
 k3Ry9xPZYrgN0TTL1VQ6zP/AjoIGiskXZk5nccLXFxoh6E+DqZKe3iwLLDaVHPrem+kM
 HbxrLdfEesTA+EK0U82BLQfJZmk3RJTvzAqdGW8Jm9iXumKozjJOnbLBQa+MAOXRObon
 w5sg==
X-Gm-Message-State: APjAAAWYayNARYJ2Fa2PCMoVJG3HCDf4ZQyc7Xv/RZHHGYx3fDVpriiu
 U5OWiBVITuQV0TTO2xssrlhZVNyA
X-Google-Smtp-Source: APXvYqxo/whhjSDsNHXrKTKK55SIosOpaVqdd3qunR6+BZq1kiKwEY9hl20BwdPTTSnyOTwdyS4yWg==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr5245957wmi.152.1582631512067; 
 Tue, 25 Feb 2020 03:51:52 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 049/136] m68k/next-cube: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:39 +0100
Message-Id: <1582631466-13880-49-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Message-Id: <20200219160953.13771-50-imammedo@redhat.com>
---
 hw/m68k/next-cube.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e534334..cd93d9e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -860,7 +860,6 @@ static void next_cube_init(MachineState *machine)
 {
     M68kCPU *cpu;
     CPUM68KState *env;
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *rom = g_new(MemoryRegion, 1);
     MemoryRegion *mmiomem = g_new(MemoryRegion, 1);
     MemoryRegion *scrmem = g_new(MemoryRegion, 1);
@@ -893,8 +892,7 @@ static void next_cube_init(MachineState *machine)
     memcpy(ns->rtc.ram, rtc_ram2, 32);
 
     /* 64MB RAM starting at 0x04000000  */
-    memory_region_allocate_system_memory(ram, NULL, "next.ram", ram_size);
-    memory_region_add_subregion(sysmem, 0x04000000, ram);
+    memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
 
     /* Framebuffer */
     dev = qdev_create(NULL, TYPE_NEXTFB);
@@ -967,6 +965,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "NeXT Cube";
     mc->init = next_cube_init;
     mc->default_ram_size = RAM_SIZE;
+    mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
 }
 
-- 
1.8.3.1



