Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375FCC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0232820CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWKi1vwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0232820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZDW-00038U-28
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykh-0000s1-Sb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yke-0007So-0S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykd-0007Q4-Q9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:47 -0500
Received: by mail-wr1-x42d.google.com with SMTP id u6so14404906wrt.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hpM8ElmGZBnECi1BlrS1EbDP4ehth1GmlWVlNCDrI8Q=;
 b=IWKi1vwoVqvX0xYnJGeuQiIEFLjwoIQYesJvN/OLoTHAtxq4GeRlv+UV9iJu/J9AvA
 1FPCoJ5ChaAjVJMgqYbJq3bSOjrTmgZXXIOYk5cE3dYQCCs3Ygx4le5nX/L8+5aLN6Ng
 H4E6Nv5Ebmuvu5uUPv4dcF9eS7yMDNZtmAHCqzWj9r+zo3oDnfW3wu98kqWqpFqTL/UF
 5d6Oz7LYHC1bcoBmCjCpTyVeD4x8I/lZbdNZC2eIPTQlwLexthd25r7roTIi+MzdPhyy
 +BfXvyhJEsOLeU4s/UVB4aVvyOMsKBb/FkwIpr+cEU1nxVbZG/D6k+b1RXSwC6K9OJVs
 /f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=hpM8ElmGZBnECi1BlrS1EbDP4ehth1GmlWVlNCDrI8Q=;
 b=TK4TDvhRZy61Dbyl3+Q9YCNmRq+QhkCCJK03MgoNlFMmSi259aB/FDPtv+1tpjuspF
 vuZGHFIzCJBaufBF6EzislsuEBdJ3lnY+XkYZ1LZ3tQrhOyFQM1zuBcJtnGq38+g8Cdd
 5imZVtpHSx23uXrlbLsdZxk/5WQACySJYqN4U+WFsygRgg/IvsdobFIQgycGNyg9DhcR
 cncH6F3sZeOeGBwouv7GTNoXTZI4HhV1CfDKBnYFeCRCG0qPdLJ+AEPQ8WQ6E5syPMCg
 2ExMMDeB4JnIcqt4HzkQEAO00N9YxyxAVUAVSOaSf+8vA6xdwVz3RnIbVtVU9H4xHzZg
 hE1w==
X-Gm-Message-State: APjAAAWgC+G2eZcBFo7dK0DOP1Bk+V/ikvbOZ6rg4ns2oY4dC2NUkvYh
 FyNRTN9mkAozWfctoakoUqS8cfpV
X-Google-Smtp-Source: APXvYqwRNG+tvuCKWV0ZHkIbYK8Rbu+b/rHeXt1T1ryJdW9wl+Nj2l+jpOIbNhFi7qyih83TKoi0Wg==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr70958935wrm.89.1582631506490; 
 Tue, 25 Feb 2020 03:51:46 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 043/136] x86/pc: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:33 +0100
Message-Id: <1582631466-13880-43-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-44-imammedo@redhat.com>
---
 hw/i386/pc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ddce42..6ab4acb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -937,7 +937,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion **ram_memory)
 {
     int linux_boot, i;
-    MemoryRegion *ram, *option_rom_mr;
+    MemoryRegion *option_rom_mr;
     MemoryRegion *ram_below_4g, *ram_above_4g;
     FWCfgState *fw_cfg;
     MachineState *machine = MACHINE(pcms);
@@ -950,22 +950,20 @@ void pc_memory_init(PCMachineState *pcms,
 
     linux_boot = (machine->kernel_filename != NULL);
 
-    /* Allocate RAM.  We allocate it as a single memory region and use
-     * aliases to address portions of it, mostly for backwards compatibility
-     * with older qemus that used qemu_ram_alloc().
+    /*
+     * Split single memory region and use aliases to address portions of it,
+     * done for backwards compatibility with older qemus.
      */
-    ram = g_malloc(sizeof(*ram));
-    memory_region_allocate_system_memory(ram, NULL, "pc.ram",
-                                         machine->ram_size);
-    *ram_memory = ram;
+    *ram_memory = machine->ram;
     ram_below_4g = g_malloc(sizeof(*ram_below_4g));
-    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
+    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
                              0, x86ms->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
     e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
     if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g = g_malloc(sizeof(*ram_above_4g));
-        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
+        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
+                                 machine->ram,
                                  x86ms->below_4g_mem_size,
                                  x86ms->above_4g_mem_size);
         memory_region_add_subregion(system_memory, 0x100000000ULL,
@@ -1952,6 +1950,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
     mc->numa_mem_supported = true;
+    mc->default_ram_id = "pc.ram";
 
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
-- 
1.8.3.1



