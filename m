Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3215C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6E6218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9WtCZne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6E6218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LGG-0001E7-Sw
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6KnJ-0000T8-5x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6KnH-0004LZ-II
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23218
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6KnH-0004L4-4z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shskCEX2uYtXc4beNl78HPxrHEcrnngUbNyRlJDIBE8=;
 b=B9WtCZnehnMS9NX1zocgB3+Jsk3Kg9uQIHatKr7Qdvt+7doKuJYvEYdx5+xPbrkGG4050+
 UXvGYvet3D2gVBYlmLc3YOpPAj/LopuS79engnX11Rl4OmpqmJlXLPWv6RJPdSlz2XE97I
 9DXgVR/nOezge5eWVarAzXN5KQ7nvjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-ZTrULF2jMiO5BKSC1h24ow-1; Mon, 24 Feb 2020 15:57:32 -0500
X-MC-Unique: ZTrULF2jMiO5BKSC1h24ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A39B3801FA7;
 Mon, 24 Feb 2020 20:57:28 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-162.brq.redhat.com [10.40.205.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C9995C241;
 Mon, 24 Feb 2020 20:57:10 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH RESEND v2 05/32] hw/arm: Use memory_region_init_rom() with
 read-only regions
Date: Mon, 24 Feb 2020 21:55:06 +0100
Message-Id: <20200224205533.23798-6-philmd@redhat.com>
In-Reply-To: <20200224205533.23798-1-philmd@redhat.com>
References: <20200224205533.23798-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
index 59a27bdd68..3af6502a5e 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -311,9 +311,8 @@ static void exynos4210_realize(DeviceState *socdev, Err=
or **errp)
                                 &s->chipid_mem);
=20
     /* Internal ROM */
-    memory_region_init_ram(&s->irom_mem, NULL, "exynos4210.irom",
+    memory_region_init_rom(&s->irom_mem, NULL, "exynos4210.irom",
                            EXYNOS4210_IROM_SIZE, &error_fatal);
-    memory_region_set_readonly(&s->irom_mem, true);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_BASE_ADDR,
                                 &s->irom_mem);
     /* mirror of iROM */
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 6e64dfab50..05a806b422 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -125,9 +125,8 @@ static void mainstone_common_init(MemoryRegion *address=
_space_mem,
     /* Setup CPU & memory */
     mpu =3D pxa270_init(address_space_mem, mainstone_binfo.ram_size,
                       machine->cpu_type);
-    memory_region_init_ram(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
+    memory_region_init_rom(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
                            &error_fatal);
-    memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
=20
 #ifdef TARGET_WORDS_BIGENDIAN
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index be245714db..6c3fd1b271 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -126,9 +126,8 @@ static void sx1_init(MachineState *machine, const int v=
ersion)
     mpu =3D omap310_mpu_init(dram, machine->cpu_type);
=20
     /* External Flash (EMIFS) */
-    memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
+    memory_region_init_rom(flash, NULL, "omap_sx1.flash0-0", flash_size,
                            &error_fatal);
-    memory_region_set_readonly(flash, true);
     memory_region_add_subregion(address_space, OMAP_CS0_BASE, flash);
=20
     memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val,
@@ -168,9 +167,8 @@ static void sx1_init(MachineState *machine, const int v=
ersion)
     if ((version =3D=3D 1) &&
             (dinfo =3D drive_get(IF_PFLASH, 0, fl_idx)) !=3D NULL) {
         MemoryRegion *flash_1 =3D g_new(MemoryRegion, 1);
-        memory_region_init_ram(flash_1, NULL, "omap_sx1.flash1-0",
+        memory_region_init_rom(flash_1, NULL, "omap_sx1.flash1-0",
                                flash1_size, &error_fatal);
-        memory_region_set_readonly(flash_1, true);
         memory_region_add_subregion(address_space, OMAP_CS1_BASE, flash_1)=
;
=20
         memory_region_init_io(&cs[1], NULL, &static_ops, &cs1val,
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 72eca8cc55..265d5891a6 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -206,9 +206,8 @@ static void palmte_init(MachineState *machine)
     mpu =3D omap310_mpu_init(dram, machine->cpu_type);
=20
     /* External Flash (EMIFS) */
-    memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
+    memory_region_init_rom(flash, NULL, "palmte.flash", flash_size,
                            &error_fatal);
-    memory_region_set_readonly(flash, true);
     memory_region_add_subregion(address_space_mem, OMAP_CS0_BASE, flash);
=20
     memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val, "palmte-cs0"=
,
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index e001088103..1d27399721 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -924,8 +924,7 @@ static void spitz_common_init(MachineState *machine,
=20
     sl_flash_register(mpu, (model =3D=3D spitz) ? FLASH_128M : FLASH_1024M=
);
=20
-    memory_region_init_ram(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal=
);
-    memory_region_set_readonly(rom, true);
+    memory_region_init_rom(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal=
);
     memory_region_add_subregion(address_space_mem, 0, rom);
=20
     /* Setup peripherals */
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 221a78674e..d136ba1a92 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1300,9 +1300,8 @@ static void stellaris_init(MachineState *ms, stellari=
s_board_info *board)
     sram_size =3D ((board->dc0 >> 18) + 1) * 1024;
=20
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
-    memory_region_init_ram(flash, NULL, "stellaris.flash", flash_size,
+    memory_region_init_rom(flash, NULL, "stellaris.flash", flash_size,
                            &error_fatal);
-    memory_region_set_readonly(flash, true);
     memory_region_add_subregion(system_memory, 0, flash);
=20
     memory_region_init_ram(sram, NULL, "stellaris.sram", sram_size,
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 4d95a1f3e2..5dee2d76c6 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -226,8 +226,7 @@ static void tosa_init(MachineState *machine)
=20
     mpu =3D pxa255_init(address_space_mem, tosa_binfo.ram_size);
=20
-    memory_region_init_ram(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
-    memory_region_set_readonly(rom, true);
+    memory_region_init_rom(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
     memory_region_add_subregion(address_space_mem, 0, rom);
=20
     tmio =3D tc6393xb_init(address_space_mem, 0x10000000,
--=20
2.21.1


