Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613EBC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298172084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFPvZADx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298172084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z4y-0003Fi-Bl
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkY-0000g6-VV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkV-0006jS-1x
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkU-0006f4-Pv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id q9so2665278wmj.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zWmZ61z0msAJ4D8mcX7IeohKOn0UBeDe9d8kqdQ3OKo=;
 b=HFPvZADxkGx3nnJAI3T0XB2JiZL/+SYdQivUhl8psmetT8oCYfn93mssn1yI9S9N67
 Xf/mOPiGzVByJWIxqYIJxF1tckz9RGSq7ghFevOhamz/fHa6BiBWIGuk179jaOnDqH7h
 ooPu9nKMCIGOcWMtdyVTYoZ3a3bJAqCcwZjnmzBscIFiW+4GZ+NujTVGMUrZ4dVqFJWb
 EqJkbzRVbEOrCuEemFJt8R/9Fot6/zmpdTyhkaNM5uYV6eHc5aipZu2mzgOyAAQlpwhW
 O6uRG+rXfZ8Rz/DcUrskI8d11y+E8KQIVlp9uhui3y9nCLhdP2kBLxorhgOQd3gutamu
 4SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zWmZ61z0msAJ4D8mcX7IeohKOn0UBeDe9d8kqdQ3OKo=;
 b=Hr7WxmyZIiytqnZTxIphUQYBeEjkRZ8RGgyCBM3dhoPxrTJFXPyk5v5mx1IZJ5+LDA
 /uQb39Scw8njDSl2NGekaUqSbWK9+BNDM7bmK6uUoWl4mtK78uuuw8LcuFgTOBZvjd/6
 I+u5wuWh7708U0KkM/ixfq4vmWkB9Av32pqRK4Z5FLpv1zRfjt/4D5q/FLZQ9n9vHT8x
 n9dhbCpXUCYzBana8S/1a/C49hWFzTMbGHgZUXNv7myO0BEdILMth0kMQFx9dFzzswkZ
 +6s2T3hXqe0mB4B/drhLjeKOcGvIL5ewVWccHySPYRvuc1HJ4Y19ykPTrlHJ3FkSKW4S
 tm/w==
X-Gm-Message-State: APjAAAUtOZqYe8EtB/LFt3T4m2nMA8M4q0nBw66NzWSO+rxzyTZQnpXQ
 33bpqBbpx8Y3jDgijLgvHzlzPSfS
X-Google-Smtp-Source: APXvYqzyODzZ566gpNG6NQ26WERv7DNoN2y+9U+skiDDz231wtoGMCgi3a0ituiR7XxYF7ETjpXypg==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr4987857wmh.18.1582631496733;
 Tue, 25 Feb 2020 03:51:36 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 032/136] arm/vexpress: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:22 +0100
Message-Id: <1582631466-13880-32-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-33-imammedo@redhat.com>
---
 hw/arm/vexpress.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 4673a88..ed683ee 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -273,7 +273,6 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
 {
     MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *lowram = g_new(MemoryRegion, 1);
     ram_addr_t low_ram_size;
 
@@ -283,8 +282,6 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
         exit(1);
     }
 
-    memory_region_allocate_system_memory(ram, NULL, "vexpress.highmem",
-                                         ram_size);
     low_ram_size = ram_size;
     if (low_ram_size > 0x4000000) {
         low_ram_size = 0x4000000;
@@ -293,9 +290,10 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
      * address space should in theory be remappable to various
      * things including ROM or RAM; we always map the RAM there.
      */
-    memory_region_init_alias(lowram, NULL, "vexpress.lowmem", ram, 0, low_ram_size);
+    memory_region_init_alias(lowram, NULL, "vexpress.lowmem", machine->ram,
+                             0, low_ram_size);
     memory_region_add_subregion(sysmem, 0x0, lowram);
-    memory_region_add_subregion(sysmem, 0x60000000, ram);
+    memory_region_add_subregion(sysmem, 0x60000000, machine->ram);
 
     /* 0x1e000000 A9MPCore (SCU) private memory region */
     init_cpus(machine, cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic,
@@ -360,7 +358,6 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
 {
     MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
     {
@@ -375,10 +372,8 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
         }
     }
 
-    memory_region_allocate_system_memory(ram, NULL, "vexpress.highmem",
-                                         ram_size);
     /* RAM is from 0x80000000 upwards; there is no low-memory alias for it. */
-    memory_region_add_subregion(sysmem, 0x80000000, ram);
+    memory_region_add_subregion(sysmem, 0x80000000, machine->ram);
 
     /* 0x2c000000 A15MPCore private memory region (GIC) */
     init_cpus(machine, cpu_type, TYPE_A15MPCORE_PRIV,
@@ -795,6 +790,7 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
     mc->init = vexpress_common_init;
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_id = "vexpress.highmem";
 }
 
 static void vexpress_a9_class_init(ObjectClass *oc, void *data)
-- 
1.8.3.1



