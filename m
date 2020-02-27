Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66130C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D06724656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D06724656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JJu-0000uC-EK
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j7JE2-0001on-D8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j7JE1-0005oJ-8s
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:29:14 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:40293 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1j7JE0-0004XJ-Uh
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:29:13 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 3D0D51A20E4;
 Thu, 27 Feb 2020 14:28:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1A38F1A20A0;
 Thu, 27 Feb 2020 14:28:10 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] hw/mips: Use memory_region_init_rom() with read-only
 regions
Date: Thu, 27 Feb 2020 14:27:35 +0100
Message-Id: <1582810056-22646-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20200224205533.23798-8-philmd@redhat.com>
---
 hw/mips/mips_fulong2e.c | 3 +--
 hw/mips/mips_jazz.c     | 6 ++----
 hw/mips/mips_mipssim.c  | 3 +--
 hw/mips/mips_r4k.c      | 3 +--
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index c373ab0..4727b1d 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -319,9 +319,8 @@ static void mips_fulong2e_init(MachineState *machine)
     }
=20
     /* allocate RAM */
-    memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
-    memory_region_set_readonly(bios, true);
=20
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 32fbd10..afea52b 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -197,9 +197,8 @@ static void mips_jazz_init(MachineState *machine,
     /* allocate RAM */
     memory_region_add_subregion(address_space, 0, machine->ram);
=20
-    memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZ=
E,
+    memory_region_init_rom(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZ=
E,
                            &error_fatal);
-    memory_region_set_readonly(bios, true);
     memory_region_init_alias(bios2, NULL, "mips_jazz.bios", bios,
                              0, MAGNUM_BIOS_SIZE);
     memory_region_add_subregion(address_space, 0x1fc00000LL, bios);
@@ -265,9 +264,8 @@ static void mips_jazz_init(MachineState *machine,
         {
             /* Simple ROM, so user doesn't have to provide one */
             MemoryRegion *rom_mr =3D g_new(MemoryRegion, 1);
-            memory_region_init_ram(rom_mr, NULL, "g364fb.rom", 0x80000,
+            memory_region_init_rom(rom_mr, NULL, "g364fb.rom", 0x80000,
                                    &error_fatal);
-            memory_region_set_readonly(rom_mr, true);
             uint8_t *rom =3D memory_region_get_ram_ptr(rom_mr);
             memory_region_add_subregion(address_space, 0x60000000, rom_m=
r);
             rom[0] =3D 0x10; /* Mips G364 */
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index b2555dd..d220318 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -165,9 +165,8 @@ mips_mipssim_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
=20
     /* Allocate RAM. */
-    memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
                            &error_fatal);
-    memory_region_set_readonly(bios, true);
=20
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
=20
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 258cd91..ad8b75e 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -237,9 +237,8 @@ void mips_r4k_init(MachineState *machine)
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if ((bios_size > 0) && (bios_size <=3D BIOS_SIZE)) {
         bios =3D g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
+        memory_region_init_rom(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
                                &error_fatal);
-        memory_region_set_readonly(bios, true);
         memory_region_add_subregion(get_system_memory(), 0x1fc00000, bio=
s);
=20
         load_image_targphys(filename, 0x1fc00000, BIOS_SIZE);
--=20
2.7.4


