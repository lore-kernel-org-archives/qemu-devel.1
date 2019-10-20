Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADE3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139DA20869
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1htgIpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139DA20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMKNb-00058F-Ug
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 19:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMKCU-000272-Fm
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 19:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMKCO-0001w9-4v
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 19:01:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49432
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMKCN-0001vc-VD
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 19:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571612479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Jc2f00M6xHmkHXXGb5T12BbzTsN0gBBhZ999arg5vI=;
 b=g1htgIpIsY3YI91Q/wLoTlpv3WXOYA5nxYru5LMucfSuiS6iYSWe8tdzE6d2714Zc+5y3x
 astD5xzV4SJ/YGr9ofg8ttwvGy7bl7TerqSsLpTaD0pZP+8n91Y3y5+0PQiNrXTgLn3t4f
 ezDAPhMzyRw5IWN1PqscRl0pQwgMzZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-knGsZIHFNQCyvtw1Hyg-Bg-1; Sun, 20 Oct 2019 19:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 652961005509;
 Sun, 20 Oct 2019 23:01:11 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A97D460C18;
 Sun, 20 Oct 2019 23:00:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 12/21] hw/arm: Let the machine be the owner of the system
 memory
Date: Mon, 21 Oct 2019 00:56:41 +0200
Message-Id: <20191020225650.3671-13-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-1-philmd@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: knGsZIHFNQCyvtw1Hyg-Bg-1
X-Mimecast-Spam-Score: 0
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/aspeed.c           | 2 +-
 hw/arm/collie.c           | 2 +-
 hw/arm/cubieboard.c       | 2 +-
 hw/arm/digic_boards.c     | 7 ++++---
 hw/arm/highbank.c         | 3 ++-
 hw/arm/imx25_pdk.c        | 2 +-
 hw/arm/integratorcp.c     | 2 +-
 hw/arm/kzm.c              | 2 +-
 hw/arm/mcimx6ul-evk.c     | 2 +-
 hw/arm/mcimx7d-sabre.c    | 2 +-
 hw/arm/mps2-tz.c          | 4 ++--
 hw/arm/mps2.c             | 4 ++--
 hw/arm/musicpal.c         | 2 +-
 hw/arm/nseries.c          | 2 +-
 hw/arm/omap_sx1.c         | 2 +-
 hw/arm/palm.c             | 2 +-
 hw/arm/raspi.c            | 2 +-
 hw/arm/sabrelite.c        | 2 +-
 hw/arm/sbsa-ref.c         | 2 +-
 hw/arm/versatilepb.c      | 2 +-
 hw/arm/vexpress.c         | 4 ++--
 hw/arm/virt.c             | 2 +-
 hw/arm/xilinx_zynq.c      | 2 +-
 hw/arm/xlnx-versal-virt.c | 2 +-
 hw/arm/xlnx-zcu102.c      | 2 +-
 25 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 52993f84b4..f2a52e1ade 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -212,7 +212,7 @@ static void aspeed_board_init(MachineState *machine,
     ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "ram-size",
                                         &error_abort);
=20
-    memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size)=
;
+    memory_region_allocate_system_memory(&bmc->ram, machine, "ram", ram_si=
ze);
     memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
     memory_region_add_subregion(get_system_memory(),
                                 sc->memmap[ASPEED_SDRAM],
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 970a4405cc..632531a88d 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -31,7 +31,7 @@ static void collie_init(MachineState *machine)
=20
     s =3D sa1110_init(machine->cpu_type);
=20
-    memory_region_allocate_system_memory(sdram, NULL, "strongarm.sdram",
+    memory_region_allocate_system_memory(sdram, machine, "strongarm.sdram"=
,
                                          collie_binfo.ram_size);
     memory_region_add_subregion(get_system_memory(), SA_SDCS0, sdram);
=20
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 6dc2f1d6b6..b76ad7ef69 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -65,7 +65,7 @@ static void cubieboard_init(MachineState *machine)
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(&s->sdram, NULL, "cubieboard.ram"=
,
+    memory_region_allocate_system_memory(&s->sdram, machine, "cubieboard.r=
am",
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(), AW_A10_SDRAM_BASE,
                                 &s->sdram);
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index ef3fc2b6a5..f3d1febe87 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -53,7 +53,7 @@ typedef struct DigicBoard {
     const char *rom1_def_filename;
 } DigicBoard;
=20
-static void digic4_board_init(DigicBoard *board)
+static void digic4_board_init(MachineState *machine, DigicBoard *board)
 {
     Error *err =3D NULL;
=20
@@ -66,7 +66,8 @@ static void digic4_board_init(DigicBoard *board)
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "ram", board->ram_=
size);
+    memory_region_allocate_system_memory(&s->ram, machine, "ram",
+                                         board->ram_size);
     memory_region_add_subregion(get_system_memory(), 0, &s->ram);
=20
     if (board->add_rom0) {
@@ -142,7 +143,7 @@ static DigicBoard digic4_board_canon_a1100 =3D {
=20
 static void canon_a1100_init(MachineState *machine)
 {
-    digic4_board_init(&digic4_board_canon_a1100);
+    digic4_board_init(machine, &digic4_board_canon_a1100);
 }
=20
 static void canon_a1100_machine_init(MachineClass *mc)
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index f1724d6929..57e549ec00 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -290,7 +290,8 @@ static void calxeda_init(MachineState *machine, enum cx=
machines machine_id)
=20
     sysmem =3D get_system_memory();
     dram =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(dram, NULL, "highbank.dram", ram_=
size);
+    memory_region_allocate_system_memory(dram, machine, "highbank.dram",
+                                         ram_size);
     /* SDRAM at address zero.  */
     memory_region_add_subregion(sysmem, 0, dram);
=20
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index c76fc2bd94..e88d325e10 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -84,7 +84,7 @@ static void imx25_pdk_init(MachineState *machine)
         machine->ram_size =3D FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZ=
E;
     }
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "imx25.ram",
+    memory_region_allocate_system_memory(&s->ram, machine, "imx25.ram",
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_SDRAM0_ADDR=
,
                                 &s->ram);
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 524970840d..a8053be396 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -605,7 +605,7 @@ static void integratorcp_init(MachineState *machine)
=20
     cpu =3D ARM_CPU(cpuobj);
=20
-    memory_region_allocate_system_memory(ram, NULL, "integrator.ram",
+    memory_region_allocate_system_memory(ram, machine, "integrator.ram",
                                          ram_size);
     /* ??? On a real system the first 1Mb is mapped as SSRAM or boot flash=
.  */
     /* ??? RAM should repeat to fill physical memory space.  */
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 1d5ef289d5..e81bd8e0dc 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -84,7 +84,7 @@ static void kzm_init(MachineState *machine)
         machine->ram_size =3D FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZ=
E;
     }
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "kzm.ram",
+    memory_region_allocate_system_memory(&s->ram, machine, "kzm.ram",
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_SDRAM0_ADDR=
,
                                 &s->ram);
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index e90b393a44..95653db599 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -48,7 +48,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
=20
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fat=
al);
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "mcimx6ul-evk.ram"=
,
+    memory_region_allocate_system_memory(&s->ram, machine, "mcimx6ul-evk.r=
am",
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(),
                                 FSL_IMX6UL_MMDC_ADDR, &s->ram);
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 0d1f62d30a..d535a119f7 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -50,7 +50,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
                             TYPE_FSL_IMX7, &error_fatal, NULL);
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fat=
al);
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "mcimx7d-sabre.ram=
",
+    memory_region_allocate_system_memory(&s->ram, machine, "mcimx7d-sabre.=
ram",
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(),
                                 FSL_IMX7_MMDC_ADDR, &s->ram);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f8b620bcc6..96fe815361 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -458,8 +458,8 @@ static void mps2tz_common_init(MachineState *machine)
      * tradeoffs. For QEMU they're all just RAM, though. We arbitrarily
      * call the 16MB our "system memory", as it's the largest lump.
      */
-    memory_region_allocate_system_memory(&mms->psram,
-                                         NULL, "mps.ram", 16 * MiB);
+    memory_region_allocate_system_memory(&mms->psram, machine,
+                                         "mps.ram", 16 * MiB);
     memory_region_add_subregion(system_memory, 0x80000000, &mms->psram);
=20
     /* The overflow IRQs for all UARTs are ORed together.
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index d002b126d3..4687bc7ed1 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -146,8 +146,8 @@ static void mps2_common_init(MachineState *machine)
      * This is of no use for QEMU so we don't implement it (as if
      * zbt_boot_ctrl is always zero).
      */
-    memory_region_allocate_system_memory(&mms->psram,
-                                         NULL, "mps.ram", 16 * MiB);
+    memory_region_allocate_system_memory(&mms->psram, machine,
+                                         "mps.ram", 16 * MiB);
     memory_region_add_subregion(system_memory, 0x21000000, &mms->psram);
=20
     switch (mmc->fpga_type) {
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index f68a399a98..2a2c7b3abf 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1596,7 +1596,7 @@ static void musicpal_init(MachineState *machine)
     cpu =3D ARM_CPU(cpu_create(machine->cpu_type));
=20
     /* For now we use a fixed - the original - RAM size */
-    memory_region_allocate_system_memory(ram, NULL, "musicpal.ram",
+    memory_region_allocate_system_memory(ram, machine, "musicpal.ram",
                                          MP_RAM_DEFAULT_SIZE);
     memory_region_add_subregion(address_space_mem, 0, ram);
=20
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 11f2c193f3..8ab30fde24 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1315,7 +1315,7 @@ static void n8x0_init(MachineState *machine,
     struct n800_s *s =3D (struct n800_s *) g_malloc0(sizeof(*s));
     uint64_t sdram_size =3D binfo->ram_size;
=20
-    memory_region_allocate_system_memory(sdram, NULL, "omap2.dram",
+    memory_region_allocate_system_memory(sdram, machine, "omap2.dram",
                                          sdram_size);
     memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE, sdram)=
;
=20
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index be245714db..26f4e1834b 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -119,7 +119,7 @@ static void sx1_init(MachineState *machine, const int v=
ersion)
         flash_size =3D flash2_size;
     }
=20
-    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
+    memory_region_allocate_system_memory(dram, machine, "omap1.dram",
                                          sx1_binfo.ram_size);
     memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, dram);
=20
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 72eca8cc55..dceb4ab6a8 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -199,7 +199,7 @@ static void palmte_init(MachineState *machine)
     MemoryRegion *flash =3D g_new(MemoryRegion, 1);
     MemoryRegion *cs =3D g_new(MemoryRegion, 4);
=20
-    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
+    memory_region_allocate_system_memory(dram, machine, "omap1.dram",
                                          palmte_binfo.ram_size);
     memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE, dram);
=20
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index f76b6eaad3..6f1520bad6 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -182,7 +182,7 @@ static void raspi_init(MachineState *machine, int versi=
on)
                             &error_abort, NULL);
=20
     /* Allocate and map RAM */
-    memory_region_allocate_system_memory(&s->ram, NULL, "ram",
+    memory_region_allocate_system_memory(&s->ram, machine, "ram",
                                          machine->ram_size);
     /* FIXME: Remove when we have custom CPU address space support */
     memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram, 0=
);
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 96cc455c5c..dfeffcb2a7 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -64,7 +64,7 @@ static void sabrelite_init(MachineState *machine)
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "sabrelite.ram",
+    memory_region_allocate_system_memory(&s->ram, machine, "sabrelite.ram"=
,
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
                                 &s->ram);
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 27046cc284..1d4db8d7fd 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -687,7 +687,7 @@ static void sbsa_ref_init(MachineState *machine)
         object_unref(cpuobj);
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "sbsa-ref.ram",
+    memory_region_allocate_system_memory(ram, machine, "sbsa-ref.ram",
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base, ra=
m);
=20
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e86af01537..5cde8e3677 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -220,7 +220,7 @@ static void versatile_init(MachineState *machine, int b=
oard_id)
=20
     cpu =3D ARM_CPU(cpuobj);
=20
-    memory_region_allocate_system_memory(ram, NULL, "versatile.ram",
+    memory_region_allocate_system_memory(ram, machine, "versatile.ram",
                                          machine->ram_size);
     /* ??? RAM should repeat to fill physical memory space.  */
     /* SDRAM at address zero.  */
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 4673a88a8d..b97770cc68 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -283,7 +283,7 @@ static void a9_daughterboard_init(const VexpressMachine=
State *vms,
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "vexpress.highmem",
+    memory_region_allocate_system_memory(ram, machine, "vexpress.highmem",
                                          ram_size);
     low_ram_size =3D ram_size;
     if (low_ram_size > 0x4000000) {
@@ -375,7 +375,7 @@ static void a15_daughterboard_init(const VexpressMachin=
eState *vms,
         }
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "vexpress.highmem",
+    memory_region_allocate_system_memory(ram, machine, "vexpress.highmem",
                                          ram_size);
     /* RAM is from 0x80000000 upwards; there is no low-memory alias for it=
. */
     memory_region_add_subregion(sysmem, 0x80000000, ram);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4bedc2607..917d5549c1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1702,7 +1702,7 @@ static void machvirt_init(MachineState *machine)
         }
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
+    memory_region_allocate_system_memory(ram, machine, "mach-virt.ram",
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
     if (machine->device_memory) {
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3a0fa5b23f..abb3162cfc 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -190,7 +190,7 @@ static void zynq_init(MachineState *machine)
     }
=20
     /* DDR remapped to address zero.  */
-    memory_region_allocate_system_memory(ext_ram, NULL, "zynq.ext_ram",
+    memory_region_allocate_system_memory(ext_ram, machine, "zynq.ext_ram",
                                          ram_size);
     memory_region_add_subregion(address_space_mem, 0, ext_ram);
=20
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 462493c467..565a52bdab 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -414,7 +414,7 @@ static void versal_virt_init(MachineState *machine)
         psci_conduit =3D QEMU_PSCI_CONDUIT_SMC;
     }
=20
-    memory_region_allocate_system_memory(&s->mr_ddr, NULL, "ddr",
+    memory_region_allocate_system_memory(&s->mr_ddr, machine, "ddr",
                                          machine->ram_size);
=20
     sysbus_init_child_obj(OBJECT(machine), "xlnx-ve", &s->soc,
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 53cfe7c1f1..0de41adb75 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -87,7 +87,7 @@ static void xlnx_zcu102_init(MachineState *machine)
                  ram_size);
     }
=20
-    memory_region_allocate_system_memory(&s->ddr_ram, NULL, "ddr-ram",
+    memory_region_allocate_system_memory(&s->ddr_ram, machine, "ddr-ram",
                                          ram_size);
=20
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc=
),
--=20
2.21.0


