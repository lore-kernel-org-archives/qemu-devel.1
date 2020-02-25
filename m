Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914A9C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2A12176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOPGc9Y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2A12176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yv2-0002cE-GR
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkT-0000ZS-5G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkR-0006aI-AJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkP-0006Sw-HZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:34 -0500
Received: by mail-wm1-x333.google.com with SMTP id z12so2662893wmi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rCFtj8zFnpz99LXxIAiXBZd2eJwdFhQQ53mwJk3hpuM=;
 b=mOPGc9Y27KkLHb3LlcUlupbl1xlbNF/xIDEBFa+I0OwjNOXk/Vz7/wP7AnrVQMKR/f
 ZyiZb+bkGt6+9+W4CRSPlOIdaZIR1t8Nq2YB0m+NkXmVTnX/Z0kA0lPXeuCtXYrqfy9A
 PBcdIJtpq5rDGhYEfcIZ1HTwGjIvIpGRVhc0kSTmrkYqSsnhgP6d+Z5kS28pzdT71O0u
 uGL7nH9XK6pGagc2psmZhACdxLTYXaOEGg5wugIyJCNAAnUxrbaX3eegTwo40PEBFkT6
 AmS81L/VtdsYJAF05/4xTP7/mAmYo5m4IfF5Gj8Yv2/6bpqcld9SdhxE6Q1OjPQVrMni
 U90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rCFtj8zFnpz99LXxIAiXBZd2eJwdFhQQ53mwJk3hpuM=;
 b=ZVX3PnkBTCm2MkhM0rS4+DixWFlkEIjhCubxGQ+93fv+X8wY3na1R9geWU76ct48Uh
 4Cz74qQiExy/0Ica/BnKNzVCm/z68nczcbiUGsViEr8oQlU02SR5xl18pSu/PlI00umZ
 OE6WcEixrXSky+Jkn4ovJhwjjjn2S/rGpGRcRjbWt27SfRyBvGUDltHElF0rG2MRDjpx
 cSX6GuljclBMto8VeqVfsNtt5+Dz1NTSN1E9udMRItBaE0KTSNAwq5b4PzuAwQ76Eo4g
 6UFSfy/3LlWCfARyOsqPWPL1BB2Pc86vn8v1XgM/09/4zA1DU7d0rx6MgazSBdT16eh5
 5pig==
X-Gm-Message-State: APjAAAU0NbWBBJj63S840GbutYoskq1/nU6hHMiexhgJNbSK8sZ6lhBn
 tArk0hWnjaVAXFijpoCMyuG9sJ54
X-Google-Smtp-Source: APXvYqzAUHgu67kp9OPyhKnUy12zHY+QZr0pju4ObGeXkqmFmAIIJMU0/bkSO6QDVWAOkhByIONvLw==
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr5109312wml.182.1582631492123; 
 Tue, 25 Feb 2020 03:51:32 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 027/136] arm/palm: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:17 +0100
Message-Id: <1582631466-13880-27-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-28-imammedo@redhat.com>
---
 hw/arm/palm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 72eca8c..99554bd 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -31,6 +31,7 @@
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
+#include "qemu/cutils.h"
 
 static uint64_t static_read(void *opaque, hwaddr offset, unsigned size)
 {
@@ -195,15 +196,21 @@ static void palmte_init(MachineState *machine)
     static uint32_t cs2val = 0x0000e1a0;
     static uint32_t cs3val = 0xe1a0e1a0;
     int rom_size, rom_loaded = 0;
-    MemoryRegion *dram = g_new(MemoryRegion, 1);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *cs = g_new(MemoryRegion, 4);
 
-    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
-                                         palmte_binfo.ram_size);
-    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE, dram);
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE,
+                                machine->ram);
 
-    mpu = omap310_mpu_init(dram, machine->cpu_type);
+    mpu = omap310_mpu_init(machine->ram, machine->cpu_type);
 
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
@@ -265,6 +272,8 @@ static void palmte_machine_init(MachineClass *mc)
     mc->init = palmte_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
+    mc->default_ram_size = 0x02000000;
+    mc->default_ram_id = "omap1.dram";
 }
 
 DEFINE_MACHINE("cheetah", palmte_machine_init)
-- 
1.8.3.1



