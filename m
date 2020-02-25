Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD07C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BA72176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLt3+Y/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BA72176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yp1-0000wC-P8
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkG-0000Gt-W1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkD-0005rq-5c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:24 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkC-0005nu-Ur
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:21 -0500
Received: by mail-wr1-x42a.google.com with SMTP id z15so6034874wrl.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IWD2+idtHw0nhgBBfKpVv3ZBllW3r5TcVAjACuqZRiM=;
 b=KLt3+Y/GKZ0l5VEom8EIezqEESEL7KmKe7fSd4VtbqnQaPUN76/YjnEapEgSWD7b/R
 cq0jnYnjoqr/J4Ij1+E79VCkwWe1+qRYM3FAjJr8UBfxP85HRtTpOlycgRXtwdPhLL5L
 LiMUpAR7tJ0OPhdnIw2vEXfUK14LLBKjIP0Q0sMpKEvqmu9YXQeK95pqpt33U0GldHWk
 zj5RJOfBDJ5U4OaahpdDGZ3hQZ917WKq9ISyAfmDiTh0HlVLobYIe0vZiUcGPm2JADtZ
 a53B8TL3rMUYOgS25DO+tkfqDyiLAFT0PNzxvXaJQEnQ3xAClUQzT2Uiuqt50kFD8je+
 YOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IWD2+idtHw0nhgBBfKpVv3ZBllW3r5TcVAjACuqZRiM=;
 b=NdjVgmiaYu48phN2MWQt/9V+8UPM+pS+tGWFXhMyb5C1j3sKzw3Z5n1I0NCgfpfTMf
 cJzdKRfW8cIKlA7uKye+9DGQe9MWdjG1vQfIgRsbCQBt+yBCXJDsOo+A8pjhtw7Ny1s2
 7g9/bId9gsWwENsHmG5GhAbVmYBVH/evzn6wewORPzWymbsPEfdVvaUs6VyPdd710z0k
 260sEHlCmPYfkyx7zTBZiiCEI22uGeVb4q2J/HexWBN9TWMgx0eJqhGBvIq9SmI8mlA3
 vR5PyPO/QqB1wl62buvO1PaCQrvjO3nvFkfVdCpsyecv9NaqA7fzednDN+/oi6TENJro
 kKMA==
X-Gm-Message-State: APjAAAXW/dXX1v4EuTkSUZvRT9r93bdaH77dwYsYLQFTpmF/TKnfQPz6
 fJYf4cejw9kubP0lEnWyktBMfXIS
X-Google-Smtp-Source: APXvYqw1yjZuzwqFaTT+CD2adfwjUN1GreHSdBye678yADvd5HITDDW/nCJkd+bH/Tt3ZVDr+kvocg==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr69521528wru.427.1582631479618; 
 Tue, 25 Feb 2020 03:51:19 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 014/136] arm/highbank: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:04 +0100
Message-Id: <1582631466-13880-14-git-send-email-pbonzini@redhat.com>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-15-imammedo@redhat.com>
---
 hw/arm/highbank.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 518d935..ac9de94 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -236,7 +236,6 @@ enum cxmachines {
  */
 static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
 {
-    ram_addr_t ram_size = machine->ram_size;
     DeviceState *dev = NULL;
     SysBusDevice *busdev;
     qemu_irq pic[128];
@@ -247,7 +246,6 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     qemu_irq cpu_virq[4];
     qemu_irq cpu_vfiq[4];
     MemoryRegion *sysram;
-    MemoryRegion *dram;
     MemoryRegion *sysmem;
     char *sysboot_filename;
 
@@ -290,10 +288,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     }
 
     sysmem = get_system_memory();
-    dram = g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(dram, NULL, "highbank.dram", ram_size);
     /* SDRAM at address zero.  */
-    memory_region_add_subregion(sysmem, 0, dram);
+    memory_region_add_subregion(sysmem, 0, machine->ram);
 
     sysram = g_new(MemoryRegion, 1);
     memory_region_init_ram(sysram, NULL, "highbank.sysram", 0x8000,
@@ -387,7 +383,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
 
     /* TODO create and connect IDE devices for ide_drive_get() */
 
-    highbank_binfo.ram_size = ram_size;
+    highbank_binfo.ram_size = machine->ram_size;
     /* highbank requires a dtb in order to boot, and the dtb will override
      * the board ID. The following value is ignored, so set it to -1 to be
      * clear that the value is meaningless.
@@ -430,6 +426,7 @@ static void highbank_class_init(ObjectClass *oc, void *data)
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_id = "highbank.dram";
 }
 
 static const TypeInfo highbank_type = {
@@ -448,6 +445,7 @@ static void midway_class_init(ObjectClass *oc, void *data)
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_id = "highbank.dram";
 }
 
 static const TypeInfo midway_type = {
-- 
1.8.3.1



