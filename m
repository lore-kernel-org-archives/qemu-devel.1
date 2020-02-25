Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF460C35E02
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F21921556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnnzK7o/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F21921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YnK-0005i5-RH
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkR-0000WQ-B6
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkM-0006LU-Lq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:35 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkM-0006GQ-Dz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:30 -0500
Received: by mail-wm1-x331.google.com with SMTP id t23so2679164wmi.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jPbd6b7Kd0gmY/mPYS/0kiL57uD/bHKmeLvmiwY7zUE=;
 b=tnnzK7o/JmqexMKYtQCfkXbuDn6OslNrg0kZs6ATSHpj4vdtAWFuxikOespgklkz/W
 QyGQPWPDVFv9oTkxYY9NeWlDaTUlTVx1Tonf1pmU3E8ddXjZTIR7zTQCYdJV90ymb2Tf
 JjDfCCj6V1NSHDxA3lZwfE0+1g/L4YXn/clS4ut9nzXPpzuli7tKslarziwrVqJSS/nH
 qLJNsT7LP5zaVMo+rVjYS5KUjb9Zc5TZ6RsQ+wWxGc++/ZREKhiDGbZBrspUXBEMy4xd
 J5/sX53JU+8Utmw7fgzlScOI3WpOsmOW6V8D6iXKIOt0DQuOgOHXVMkX4tvSBr6ClovP
 0xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=jPbd6b7Kd0gmY/mPYS/0kiL57uD/bHKmeLvmiwY7zUE=;
 b=jqbQ7JcpCOPw7g4rsAne6CMPbBwIZj2zawcuGMoHRNXWDOMQwHOOr0QLWgzJMKH58b
 4ZV6knEjSU+gbbMxULGhem0o3XhKaDY1z0bgqRzULdrk07x/ngoieR95dmIIkuUdCtCU
 nndgSuEVSvrO+I9LTDbVo0kbWD7GQlR85tIj0pmwh0VvKeROHUqUY7kEe/Ms6RjJH8mI
 RyPKZL2Bo2gFv0uf1J9Saat3DlM4GbovBTf/x6XYVqBr+ohuhHBeD614LfjGcga93qQl
 u0S8pxItZA2SfqLJuCc7wTDLnqgDCy8BXFo4aoCI7poL66umvSj3oVt8MvqPIFPp4tVh
 9ruQ==
X-Gm-Message-State: APjAAAVHaMT+Ds2FYlhxTi3I9g4G95lgZI+vPhVpx+NLHxYEZPXoDZyS
 e01WZ9zBoNqOtVGsv3Dur8c5sAkh
X-Google-Smtp-Source: APXvYqyv/+eL8dcLOmtpcnnEHSOu58TDW8nQoXnYtCzS4bUnjR41ZUGTLmknM/zk5Ip6jWieNSgJNA==
X-Received: by 2002:a05:600c:2481:: with SMTP id
 1mr4940241wms.120.1582631489069; 
 Tue, 25 Feb 2020 03:51:29 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 024/136] arm/musicpal: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:14 +0100
Message-Id: <1582631466-13880-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-25-imammedo@redhat.com>
---
 hw/arm/musicpal.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index dc551bb..db8b03cb 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -32,6 +32,7 @@
 #include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
 #include "ui/pixel_ops.h"
+#include "qemu/cutils.h"
 
 #define MP_MISC_BASE            0x80002000
 #define MP_MISC_SIZE            0x00001000
@@ -1589,16 +1590,21 @@ static void musicpal_init(MachineState *machine)
     int i;
     unsigned long flash_size;
     DriveInfo *dinfo;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
+    /* For now we use a fixed - the original - RAM size */
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     cpu = ARM_CPU(cpu_create(machine->cpu_type));
 
-    /* For now we use a fixed - the original - RAM size */
-    memory_region_allocate_system_memory(ram, NULL, "musicpal.ram",
-                                         MP_RAM_DEFAULT_SIZE);
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     memory_region_init_ram(sram, NULL, "musicpal.sram", MP_SRAM_SIZE,
                            &error_fatal);
@@ -1714,6 +1720,8 @@ static void musicpal_machine_init(MachineClass *mc)
     mc->init = musicpal_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
+    mc->default_ram_size = MP_RAM_DEFAULT_SIZE;
+    mc->default_ram_id = "musicpal.ram";
 }
 
 DEFINE_MACHINE("musicpal", musicpal_machine_init)
-- 
1.8.3.1



