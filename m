Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68879C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386FC2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXvALhJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386FC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z2m-000879-B2
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkY-0000fw-EU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkU-0006i8-K2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:42 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkT-0006cR-22
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id t23so2679540wmi.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wz874YjoVdOIdzRW9y7yfDR7tnamNyqzdfj742uUVUg=;
 b=PXvALhJIPXPb/x0B6H+hL5bZ+jBceKf+YO0XeNDDtF+QYudBJ5QKRb24jTt0ttF+Pm
 0uGmYgQp+Rw6NPUaOR5MTTHOHaeNzk3pXSjVcxNYf1RvKUgV2ObXlqenEGQnKZ4ZiVCB
 q5cyfH2Qgwfd6WrR0Yoh/PFDqqOq0Xw8o3e/wsEwmNtaV6iyCP1zE4cy8qzn9Wl/a0WW
 OMUSUlJHbTw8Fea4tU8KJaalaKVQAkdmNJzajYGh85mWt4EQGf9oy2I8Un30cbhMZ+VZ
 upxSPLaiSyeDVLCYOmum120+iuY3AyGvPgihoropNZl1PW+6Hg3f2tW7AhyMcB7DAz4t
 g37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Wz874YjoVdOIdzRW9y7yfDR7tnamNyqzdfj742uUVUg=;
 b=UfPsqDYpxxHILk1wy/iSW0yI5XR8MRQ+w4A/VcIVL7YdaaFnNN2hLIi0ObUbJ9fGiP
 PWU4tGrHRSwfZPAW8OU9yYVZKcsUzf4uut7viYXXg0VEyPtwYebaI8gvcw0ZWi8YQ5oI
 oPdKECrgPoolqbUxj3in5TFwG43QjMRqy+2zWPex73loT+O6LE4mgvc0zioDFP1ANM8W
 V4aNSK9O6F6SM/xdKP1fsPuqlgswpGRVa1yAvaFRf7C+I1f0qanVRCdq46mt1q4cu3TP
 FxZRl0ZUS/XmaOCUKYa8rCOMopmEKUjiHwgY3euQ8nzevot6FpEpUWEtgEE/r7wyknRf
 wsOw==
X-Gm-Message-State: APjAAAWczZlBceMZW3njZ9NxH24E2um10yI8epKlFmKuFcGfrr12qh6A
 wHEEx4smU7WxlNlaVWJLlHE/9uRv
X-Google-Smtp-Source: APXvYqyVnqxxE4cDX5CDVMJM0AIEQF5WzT6VPE56J7SCVKbvdkCjq7F9fmSGUk6HhLC1KRKEMJ6QVA==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5069513wmi.116.1582631495604; 
 Tue, 25 Feb 2020 03:51:35 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 031/136] arm/versatilepb: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:21 +0100
Message-Id: <1582631466-13880-31-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Message-Id: <20200219160953.13771-32-imammedo@redhat.com>
---
 hw/arm/versatilepb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e86af01..f3c4a50 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -184,7 +184,6 @@ static void versatile_init(MachineState *machine, int board_id)
     Object *cpuobj;
     ARMCPU *cpu;
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     qemu_irq pic[32];
     qemu_irq sic[32];
     DeviceState *dev, *sysctl;
@@ -220,11 +219,9 @@ static void versatile_init(MachineState *machine, int board_id)
 
     cpu = ARM_CPU(cpuobj);
 
-    memory_region_allocate_system_memory(ram, NULL, "versatile.ram",
-                                         machine->ram_size);
     /* ??? RAM should repeat to fill physical memory space.  */
     /* SDRAM at address zero.  */
-    memory_region_add_subregion(sysmem, 0, ram);
+    memory_region_add_subregion(sysmem, 0, machine->ram);
 
     sysctl = qdev_create(NULL, "realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", 0x41007004);
@@ -398,6 +395,7 @@ static void versatilepb_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
+    mc->default_ram_id = "versatile.ram";
 }
 
 static const TypeInfo versatilepb_type = {
@@ -415,6 +413,7 @@ static void versatileab_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
+    mc->default_ram_id = "versatile.ram";
 }
 
 static const TypeInfo versatileab_type = {
-- 
1.8.3.1



