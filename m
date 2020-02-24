Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5860BC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25864218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOhV4u2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25864218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LIq-0005dT-Ad
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Knh-0001GT-PE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Kng-0004jb-Eo
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:58:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37899
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Kng-0004j6-Aw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EimZBb/wTLnnIdXn4hxLBCiwdZq9+sATqGkFdsLXgrs=;
 b=YOhV4u2ZGJGL/D8Vj/E1TraHTGHYCG6LexYypjybsWeUKnCcMl9w9n4oy5ezw8sCOGIpV2
 fsWyTz/AGFQ/Y32Edkv52hCX19/B/RKs7XtBS1P4SVnqa6yL95d+rq9CChJ5GKuJ4ypb8c
 7vEEItH8pm8gq+FkWi5TEGoErzKWFQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-Uo2-Nbj1PWqzfAAFdLsOig-1; Mon, 24 Feb 2020 15:57:58 -0500
X-MC-Unique: Uo2-Nbj1PWqzfAAFdLsOig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42A6C189F760;
 Mon, 24 Feb 2020 20:57:54 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-162.brq.redhat.com [10.40.205.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B02A5C54A;
 Mon, 24 Feb 2020 20:57:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH RESEND v2 07/32] hw/mips: Use memory_region_init_rom() with
 read-only regions
Date: Mon, 24 Feb 2020 21:55:08 +0100
Message-Id: <20200224205533.23798-8-philmd@redhat.com>
In-Reply-To: <20200224205533.23798-1-philmd@redhat.com>
References: <20200224205533.23798-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 hw/mips/mips_fulong2e.c | 3 +--
 hw/mips/mips_jazz.c     | 6 ++----
 hw/mips/mips_mipssim.c  | 3 +--
 hw/mips/mips_r4k.c      | 3 +--
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 2e043cbb98..547a7d3a45 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -319,9 +319,8 @@ static void mips_fulong2e_init(MachineState *machine)
=20
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_si=
ze);
-    memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
-    memory_region_set_readonly(bios, true);
=20
     memory_region_add_subregion(address_space_mem, 0, ram);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 66fd4d867d..cf47335ea5 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -195,9 +195,8 @@ static void mips_jazz_init(MachineState *machine,
                                          machine->ram_size);
     memory_region_add_subregion(address_space, 0, ram);
=20
-    memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
                            &error_fatal);
-    memory_region_set_readonly(bios, true);
     memory_region_init_alias(bios2, NULL, "mips_jazz.bios", bios,
                              0, MAGNUM_BIOS_SIZE);
     memory_region_add_subregion(address_space, 0x1fc00000LL, bios);
@@ -263,9 +262,8 @@ static void mips_jazz_init(MachineState *machine,
         {
             /* Simple ROM, so user doesn't have to provide one */
             MemoryRegion *rom_mr =3D g_new(MemoryRegion, 1);
-            memory_region_init_ram(rom_mr, NULL, "g364fb.rom", 0x80000,
+            memory_region_init_rom(rom_mr, NULL, "g364fb.rom", 0x80000,
                                    &error_fatal);
-            memory_region_set_readonly(rom_mr, true);
             uint8_t *rom =3D memory_region_get_ram_ptr(rom_mr);
             memory_region_add_subregion(address_space, 0x60000000, rom_mr)=
;
             rom[0] =3D 0x10; /* Mips G364 */
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index b934ca9d51..3fdbb21680 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -169,9 +169,8 @@ mips_mipssim_init(MachineState *machine)
     /* Allocate RAM. */
     memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
                                          ram_size);
-    memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
                            &error_fatal);
-    memory_region_set_readonly(bios, true);
=20
     memory_region_add_subregion(address_space_mem, 0, ram);
=20
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index b2aec434c3..54b286ceee 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -241,9 +241,8 @@ void mips_r4k_init(MachineState *machine)
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if ((bios_size > 0) && (bios_size <=3D BIOS_SIZE)) {
         bios =3D g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
+        memory_region_init_rom(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
                                &error_fatal);
-        memory_region_set_readonly(bios, true);
         memory_region_add_subregion(get_system_memory(), 0x1fc00000, bios)=
;
=20
         load_image_targphys(filename, 0x1fc00000, BIOS_SIZE);
--=20
2.21.1


