Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E9EC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB412176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZf3RGEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB412176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZBs-00081b-9U
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykh-0000q9-BC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykd-0007QD-AB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykd-00079l-1m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id a9so2847425wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jDn1Evqlhv0edo4aB8U4WodyMKNx8yc9pxEgR9k2D2w=;
 b=AZf3RGEM1dcW0sow0gV38x24yy22jv+mC09Jn85fXGOzYHs1187xo8Un0TqWy2JGpb
 7hOmRF8PjAwJfhALQ1EN38TLPKFZWZc2oN5Zwr9UmQdRNhlH9hFNv43EdfK9YS3Yvfgj
 Bonr9t/+7zrtqxO6IWKg0UWhSFiuluCOJFxmj45kHsX2vSUEjH43lQjLFWX9oDsVN8Rl
 11hDJsuyoHjXcqb1B0eHL/7ryeu1OBAGKB0i8mFQx/PXdYWrM96icrx5cD/AFLUrx0XL
 lSXEWXpehVz7fQBs178IiRpvUst5+CnE4u5lkzL8rHhl6z+NcWFXEFfTB+i7jXGrx/Ev
 Orgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jDn1Evqlhv0edo4aB8U4WodyMKNx8yc9pxEgR9k2D2w=;
 b=RHEdgdU1rH34RBxz0IeL2CSXlgodvqGIBU6hi1DBE3oTpvhaTxiI6O+X2ZHbvdIs+9
 h4K0KITal0ttZoUiyK9bqKICo08OklD5WN7Qc73bWIb+3m3NR772jHrXqXUWwk4gLdmM
 UGMJqmLbz+KwZRlVfXodKqSY+XoOonIdsCgNBFMdnoFGg9cwjs5dK82PqG9yLyJL4haB
 5g+kY/91JX2tAULQLtrc/7WV9ZmKLd/yjQnLJ2hI36UyM40E4nPYlh7YwPPkexnfbXXV
 iAAb5tWv5bp+dguzpbtsv5TFjOqNFz6BWih/fYC6z057xVT6uUWiecLn8Lac4fTXHUSs
 QqFg==
X-Gm-Message-State: APjAAAUMo/YPADX36ItdsS0S6abBHIQ04XL7pS8OxX1+MnPGonk6XtYO
 nKCCE0nbe8beuNz59MxmQKS0U/7R
X-Google-Smtp-Source: APXvYqyzTtISsrOFpo6qMzp595X3hNCCkNJ+efaUveB6P0tbfUj3hCMZY9FNU8UpvQL5tIfH03cCxg==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr4832272wme.41.1582631504673; 
 Tue, 25 Feb 2020 03:51:44 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 041/136] hppa: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:31 +0100
Message-Id: <1582631466-13880-41-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-42-imammedo@redhat.com>
---
 hw/hppa/machine.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d8755ec..67181e7 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -71,14 +71,11 @@ static void machine_hppa_init(MachineState *machine)
     uint64_t kernel_entry = 0, kernel_low, kernel_high;
     MemoryRegion *addr_space = get_system_memory();
     MemoryRegion *rom_region;
-    MemoryRegion *ram_region;
     MemoryRegion *cpu_region;
     long i;
     unsigned int smp_cpus = machine->smp.cpus;
     SysBusDevice *s;
 
-    ram_size = machine->ram_size;
-
     /* Create CPUs.  */
     for (i = 0; i < smp_cpus; i++) {
         char *name = g_strdup_printf("cpu%ld-io-eir", i);
@@ -97,10 +94,8 @@ static void machine_hppa_init(MachineState *machine)
         error_report("RAM size is currently restricted to 3GB");
         exit(EXIT_FAILURE);
     }
-    ram_region = g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ram_region, OBJECT(machine),
-                                         "ram", ram_size);
-    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
+    memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
+
 
     /* Init Lasi chip */
     lasi_init(addr_space);
@@ -298,6 +293,7 @@ static void machine_hppa_machine_init(MachineClass *mc)
     mc->is_default = 1;
     mc->default_ram_size = 512 * MiB;
     mc->default_boot_order = "cd";
+    mc->default_ram_id = "ram";
 }
 
 DEFINE_MACHINE("hppa", machine_hppa_machine_init)
-- 
1.8.3.1



