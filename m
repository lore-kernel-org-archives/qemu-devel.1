Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B22DC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB85D2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDYC5JFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB85D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z2r-0008Fb-Pz
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl0-000189-NQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008Fx-4D
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:10 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00083L-E6
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: by mail-wr1-x432.google.com with SMTP id u6so14405702wrt.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ISYF8bE3wZBpQs6aEV6LAzqPTy+sOweNT5V9+csQXHc=;
 b=BDYC5JFJY1RnuY2XTnALpN+oGtOqR4RDxSLzjEfVGp5CiztULSJzZVSfC3m74nl1pR
 Rw6VNjCLu/YMMYnYPy/Hq+EL/rG4qAnbG/zWqeYgbDCxaroNkeoP6FWrnTqPnMYjOx8q
 aoPzGmcX6Q8ShmTyBms/xG+MkVOSrI8S7L5L1eFRyLaIXTHsGZ8pHHDwRhyqskyG1BLb
 16ao/CcfFY/1xafuYnhOV8WbtdX0gy5+M3qLTsEVGBqlJI0TQdh7iv8l+u2wXVIalgLH
 ia4skAtK02VWN1/SW0sLESRsPi7m8m1x3oniHHSzpdoOUZCY46LZtc56BFnldFHoIcM0
 y6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ISYF8bE3wZBpQs6aEV6LAzqPTy+sOweNT5V9+csQXHc=;
 b=MGe8UKntLy/wyIrQpKyxe51Jv359AmVhCZbOxrgA8XH3LXLkrnsB5JYiQCGjd07TKt
 HhIQEzv/qmOCVx1zM9TBXuyq6UYWmaqgLnuxINw89iGWnI6zVKG/gDXH3bSdG/7uGwOJ
 lJ+bTgZ92QnXrXGXsUo8nKG5zKDS2Lt+FqEVYZYlIqZV+9IR1p2IOZkIYNQkT6rowAhW
 GnAhJyrbsjIuM9GL9BPbLfRmDdIh5msmRBBYYhzEAgwn+VH2g5qj2KiPcU9qfbafaguk
 sZwrYR9JwlsaB5A4hKIR9pT59YL2N0ssIE85KUO93DS+dHfzrzg7k8T0DmhVrg8VsbNp
 Qnbw==
X-Gm-Message-State: APjAAAWrVOrdN+tQnZuIxuMWmblTCVrgJ0NP5SGKL1b/olvLskRNH39F
 qfaT6oq3Mfzr1X/w+P6zG6xy5b3u
X-Google-Smtp-Source: APXvYqySqvOYSZ/XmFVMhpyR3Icy3mPpYyEgAEugs4gU+23gOPSRM64zhxMkkio6vpUVHwGd6EDhFw==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr14811813wro.316.1582631518787; 
 Tue, 25 Feb 2020 03:51:58 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 057/136] mips/mips_r4k: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:47 +0100
Message-Id: <1582631466-13880-57-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Message-Id: <20200219160953.13771-58-imammedo@redhat.com>
---
 hw/mips/mips_r4k.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index b2aec43..258cd91 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -171,13 +171,11 @@ static const int sector_len = 32 * KiB;
 static
 void mips_r4k_init(MachineState *machine)
 {
-    ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
     char *filename;
     MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios;
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
     MemoryRegion *isa_io = g_new(MemoryRegion, 1);
@@ -203,14 +201,12 @@ void mips_r4k_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* allocate RAM */
-    if (ram_size > 256 * MiB) {
+    if (machine->ram_size > 256 * MiB) {
         error_report("Too much memory for this machine: %" PRId64 "MB,"
                      " maximum 256MB", ram_size / MiB);
         exit(1);
     }
-    memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram", ram_size);
-
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     memory_region_init_io(iomem, NULL, &mips_qemu_ops,
                           NULL, "mips-qemu", 0x10000);
@@ -261,7 +257,7 @@ void mips_r4k_init(MachineState *machine)
     g_free(filename);
 
     if (kernel_filename) {
-        loaderparams.ram_size = ram_size;
+        loaderparams.ram_size = machine->ram_size;
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
@@ -316,7 +312,7 @@ static void mips_machine_init(MachineClass *mc)
 #else
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
-
+    mc->default_ram_id = "mips_r4k.ram";
 }
 
 DEFINE_MACHINE("mips", mips_machine_init)
-- 
1.8.3.1



