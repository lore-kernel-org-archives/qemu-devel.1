Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A762C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BFD222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjxikahy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BFD222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YxD-0006BS-Fa
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykd-0000lc-3P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkV-0006jZ-2o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkU-0006d5-Qq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:38 -0500
Received: by mail-wm1-x32d.google.com with SMTP id t23so2679550wmi.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RK0hIr5Ap0dSYFPrObFtlV7JGHjRjPQBlcIJTCr7OgE=;
 b=FjxikahyKkUTxR7uyv2+9FBN2YXo4YbSQOPef2ZBIE8YGPx184h2LX1ueuq67gEOf+
 JTKQsIiiRR28RAkBNwo1tTzNo62ObEQ9laR1sowJFkmvlrcgX/tCmJAwkGbyCpMZi0ZL
 Rfeu3Tmo3kCEou+VIAalpOtmU4zfUuqJ/mXIK/A/rJahcKSZHNpvP/XlSG6NEjjFdkGv
 Oyv3N2gwLW28Q7CLzP3ACN5B0sMc9UlXm0+lYC+Wej7l7y2FYljbEuElM9Hz6QaeWrni
 pT2iOTECq4+uvM/GWzaV0UaKdnbiN+MbuTAiTzGOyHeX/nr4RBUL92giVIRPnCQBVzQK
 KtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RK0hIr5Ap0dSYFPrObFtlV7JGHjRjPQBlcIJTCr7OgE=;
 b=YPEW5XfzCbfobF0s+m6P3yjmqN22yRp8Qjn+GEwfPT3xv6VOu6QFGjtxUGksJrvpJ1
 mRJuiaJdByxtwtFtQGh4d+3MqzUFmWMVTa2KMo79qR2DgXo0JnkcUyhrlbhSkBdivCux
 bXnlCAQ67G5OsWlB2TTzYgKnJlXSl/sVWF1gApCjOTioz7+75lZB60gzBi25h2AsmHf6
 +ZgjLUcK/jj2T6j4tkMj3GPd1gjbTW48lYwJKxYG1x/5juoVpU0uUDgzYs/bPz7YQsWe
 zAfQEKgvYDbGlW6r+NbETDEKeavHjlNkOiZwZXgkrZHLoLgAQJ8xNE5/XRA8mf3ndeZs
 +xvQ==
X-Gm-Message-State: APjAAAU78puXZbdVz7KhOJG6VZCVrGXq9JLlM8TkWXz0PKnND+WKmhs6
 /D9OM+AWwt5Qpgfe4w5slXlZjWVS
X-Google-Smtp-Source: APXvYqxn4bW2KHPiVjmjQGAnhReUZaS1VtU38u9pHquP4+8OkSLd0IvQdRMNqO2iRJ60lbamxFX1Lw==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr4830065wmi.14.1582631494894;
 Tue, 25 Feb 2020 03:51:34 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 030/136] arm/sbsa-ref: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:20 +0100
Message-Id: <1582631466-13880-30-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Message-Id: <20200219160953.13771-31-imammedo@redhat.com>
---
 hw/arm/sbsa-ref.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9b5bcb5..1cba9fc 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -593,7 +593,6 @@ static void sbsa_ref_init(MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = g_new(MemoryRegion, 1);
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded;
     const CPUArchIdList *possible_cpus;
     int n, sbsa_max_cpus;
@@ -685,9 +684,8 @@ static void sbsa_ref_init(MachineState *machine)
         object_unref(cpuobj);
     }
 
-    memory_region_allocate_system_memory(ram, NULL, "sbsa-ref.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base, ram);
+    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base,
+                                machine->ram);
 
     create_fdt(sms);
 
@@ -785,6 +783,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
     mc->default_ram_size = 1 * GiB;
+    mc->default_ram_id = "sbsa-ref.ram";
     mc->default_cpus = 4;
     mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
-- 
1.8.3.1



