Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE05AC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BC320CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFmI4BZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BC320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zxt-0007Pt-Lo
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlY-0002Wx-Es
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlX-0002Vp-4A
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:44 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:35865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlW-0002RO-T9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:43 -0500
Received: by mail-wm1-x335.google.com with SMTP id p17so2862384wma.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hQKEDHZ7ybfue6PbnahmlzzYTgRr4IP7NeUXkWEOGMQ=;
 b=TFmI4BZOIVmBxZJyvARp4wRuqP1YLgYtak89yGwhAzV9lEVUZFJ/JNLVLleKqM6Mum
 vSTetvTsJEz2Wp/wzLGtiBFh7URrXJQ4J4A2O4AlL0ovqM0opAq6t0Fsl6s5PhQKj+PL
 kDgRlAtGz7FGX3BWTMHXs03hCFJESHC2xbhSMcN/TlW6+uapP251vVoJS+KGCEt3vmKD
 +YsQLUHX9H0W8eVX2NJbVZft60SFPlSpuEgJE6bUKPcoA3lQXwjeYly4Cl3pD3upwR2C
 fnDaUrNJl/60HHCelByDM/RxVBtY7WySpHauk6AWbBYlGn3w5ccIVrX3q/2tOPgGAoJs
 heow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hQKEDHZ7ybfue6PbnahmlzzYTgRr4IP7NeUXkWEOGMQ=;
 b=WcgnRg77SW/rBe5R2rpP6y+cQOKLZ3r95oq1oK+tzVhIirsiwZp/tMYo7tTfbS5aVJ
 9dPeltFSLMthgBfnMupu0DmEy9N8anKE8debEK0+3GKZsVLsPtE3SP1nDfIIDrJYNRkL
 W1AWyi1Su2UDtJgCvXV0AKvFe3zTNuTsf0sbiktbkX+BU6jVFsBP5gd2tuFbraMVl6sx
 cdjThowRGUuB91eKkQqw7Y5okvURTzpamg2S9lBgcdsEoflnHhy4d6IdDEnU1IOSQhUb
 DrC9YU2FyD5GX/ZSxacHR1CR77V9eclRuL5GRRzwp4hL+DOVoetFjgIEi4EhzFQOrp3n
 sT5g==
X-Gm-Message-State: APjAAAWukHS4JWws4Lueuhhgg6HvNIz/iUKd/q4eojkpC8IblkCt7tFW
 u6pxJKFHGPOe6qxdxVv1XlFXBExH
X-Google-Smtp-Source: APXvYqwAthK/3M/DuC3zAMXpx+PtcJNftneOoCRyAxNydY6wiHy1NW2oCpWtL1vI4luzk/1ou/d0sg==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr4849102wme.94.1582631561407; 
 Tue, 25 Feb 2020 03:52:41 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 103/136] hw/arm: Use memory_region_init_rom() with read-only
 regions
Date: Tue, 25 Feb 2020 12:50:33 +0100
Message-Id: <1582631466-13880-103-git-send-email-pbonzini@redhat.com>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-6-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/arm/exynos4210.c | 3 +--
 hw/arm/mainstone.c  | 3 +--
 hw/arm/omap_sx1.c   | 6 ++----
 hw/arm/palm.c       | 3 +--
 hw/arm/spitz.c      | 3 +--
 hw/arm/stellaris.c  | 3 +--
 hw/arm/tosa.c       | 3 +--
 7 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 59a27bd..3af6502 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -311,9 +311,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
                                 &s->chipid_mem);
 
     /* Internal ROM */
-    memory_region_init_ram(&s->irom_mem, NULL, "exynos4210.irom",
+    memory_region_init_rom(&s->irom_mem, NULL, "exynos4210.irom",
                            EXYNOS4210_IROM_SIZE, &error_fatal);
-    memory_region_set_readonly(&s->irom_mem, true);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_BASE_ADDR,
                                 &s->irom_mem);
     /* mirror of iROM */
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 6e64dfa..05a806b 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -125,9 +125,8 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
     /* Setup CPU & memory */
     mpu = pxa270_init(address_space_mem, mainstone_binfo.ram_size,
                       machine->cpu_type);
-    memory_region_init_ram(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
+    memory_region_init_rom(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
                            &error_fatal);
-    memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
 
 #ifdef TARGET_WORDS_BIGENDIAN
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index be24571..6c3fd1b 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -126,9 +126,8 @@ static void sx1_init(MachineState *machine, const int version)
     mpu = omap310_mpu_init(dram, machine->cpu_type);
 
     /* External Flash (EMIFS) */
-    memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
+    memory_region_init_rom(flash, NULL, "omap_sx1.flash0-0", flash_size,
                            &error_fatal);
-    memory_region_set_readonly(flash, true);
     memory_region_add_subregion(address_space, OMAP_CS0_BASE, flash);
 
     memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val,
@@ -168,9 +167,8 @@ static void sx1_init(MachineState *machine, const int version)
     if ((version == 1) &&
             (dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
         MemoryRegion *flash_1 = g_new(MemoryRegion, 1);
-        memory_region_init_ram(flash_1, NULL, "omap_sx1.flash1-0",
+        memory_region_init_rom(flash_1, NULL, "omap_sx1.flash1-0",
                                flash1_size, &error_fatal);
-        memory_region_set_readonly(flash_1, true);
         memory_region_add_subregion(address_space, OMAP_CS1_BASE, flash_1);
 
         memory_region_init_io(&cs[1], NULL, &static_ops, &cs1val,
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 72eca8c..265d589 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -206,9 +206,8 @@ static void palmte_init(MachineState *machine)
     mpu = omap310_mpu_init(dram, machine->cpu_type);
 
     /* External Flash (EMIFS) */
-    memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
+    memory_region_init_rom(flash, NULL, "palmte.flash", flash_size,
                            &error_fatal);
-    memory_region_set_readonly(flash, true);
     memory_region_add_subregion(address_space_mem, OMAP_CS0_BASE, flash);
 
     memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val, "palmte-cs0",
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index e001088..1d27399 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -924,8 +924,7 @@ static void spitz_common_init(MachineState *machine,
 
     sl_flash_register(mpu, (model == spitz) ? FLASH_128M : FLASH_1024M);
 
-    memory_region_init_ram(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal);
-    memory_region_set_readonly(rom, true);
+    memory_region_init_rom(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal);
     memory_region_add_subregion(address_space_mem, 0, rom);
 
     /* Setup peripherals */
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 221a786..d136ba1 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1300,9 +1300,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     sram_size = ((board->dc0 >> 18) + 1) * 1024;
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
-    memory_region_init_ram(flash, NULL, "stellaris.flash", flash_size,
+    memory_region_init_rom(flash, NULL, "stellaris.flash", flash_size,
                            &error_fatal);
-    memory_region_set_readonly(flash, true);
     memory_region_add_subregion(system_memory, 0, flash);
 
     memory_region_init_ram(sram, NULL, "stellaris.sram", sram_size,
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 4d95a1f..5dee2d7 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -226,8 +226,7 @@ static void tosa_init(MachineState *machine)
 
     mpu = pxa255_init(address_space_mem, tosa_binfo.ram_size);
 
-    memory_region_init_ram(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
-    memory_region_set_readonly(rom, true);
+    memory_region_init_rom(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
     memory_region_add_subregion(address_space_mem, 0, rom);
 
     tmio = tc6393xb_init(address_space_mem, 0x10000000,
-- 
1.8.3.1



