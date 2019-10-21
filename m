Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E897C47E49
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2884920882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFbXEQRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2884920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMd6Q-0000av-WD
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 15:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMd1f-0004Ce-UY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMd1e-0001zi-Hq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:07:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44927
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMd1e-0001zQ-Es
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571684850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DX9d+kTgb8IhSTWDTp51phSf6KdCis8b9hmzJkoqI5A=;
 b=QFbXEQRpqebfHEfhTJliwuMFQiIrumIuD/mZJ6Wa2kwypDRvryKr5wCEeTfuIdcFNiqt/Q
 dJGKlYzKw5sK+spfN07XDnYOcvv293/HmDARsXd444oUakVFEWhU9h/cGDdiiFKY2H1q1q
 Nr/I/6xUJIlOB7FxGHGJmlUpAp8qJB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-NfIB8rREPUqflFXEHtxaKA-1; Mon, 21 Oct 2019 15:07:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 566C71800D79;
 Mon, 21 Oct 2019 19:07:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-124.brq.redhat.com [10.40.204.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BC0E194BE;
 Mon, 21 Oct 2019 19:07:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 5/6] hw/arm/omap1: Create the RAM in the board
Date: Mon, 21 Oct 2019 21:06:52 +0200
Message-Id: <20191021190653.9511-6-philmd@redhat.com>
In-Reply-To: <20191021190653.9511-1-philmd@redhat.com>
References: <20191021190653.9511-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NfIB8rREPUqflFXEHtxaKA-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SDRAM is incorrectly created in the OMAP310 SoC.
Move its creation in the board code, this will later allow the
board to have the QOM ownership of the RAM.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/omap1.c        | 12 +++++-------
 hw/arm/omap_sx1.c     |  8 ++++++--
 hw/arm/palm.c         |  8 ++++++--
 include/hw/arm/omap.h |  6 ++----
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 0400593805..6ce038a453 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
@@ -3858,8 +3859,7 @@ static int omap_validate_tipb_mpui_addr(struct omap_m=
pu_state_s *s,
     return range_covers_byte(0xe1010000, 0xe1020004 - 0xe1010000, addr);
 }
=20
-struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
-                unsigned long sdram_size,
+struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
                 const char *cpu_type)
 {
     int i;
@@ -3867,11 +3867,12 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryReg=
ion *system_memory,
     qemu_irq dma_irqs[6];
     DriveInfo *dinfo;
     SysBusDevice *busdev;
+    MemoryRegion *system_memory =3D get_system_memory();
=20
     /* Core */
     s->mpu_model =3D omap310;
     s->cpu =3D ARM_CPU(cpu_create(cpu_type));
-    s->sdram_size =3D sdram_size;
+    s->sdram_size =3D memory_region_size(dram);
     s->sram_size =3D OMAP15XX_SRAM_SIZE;
=20
     s->wakeup =3D qemu_allocate_irq(omap_mpu_wakeup, s, 0);
@@ -3880,9 +3881,6 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegio=
n *system_memory,
     omap_clk_init(s);
=20
     /* Memory-mapped stuff */
-    memory_region_allocate_system_memory(&s->emiff_ram, NULL, "omap1.dram"=
,
-                                         s->sdram_size);
-    memory_region_add_subregion(system_memory, OMAP_EMIFF_BASE, &s->emiff_=
ram);
     memory_region_init_ram(&s->imif_ram, NULL, "omap1.sram", s->sram_size,
                            &error_fatal);
     memory_region_add_subregion(system_memory, OMAP_IMIF_BASE, &s->imif_ra=
m);
@@ -3925,7 +3923,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegio=
n *system_memory,
     s->port[tipb_mpui].addr_valid =3D omap_validate_tipb_mpui_addr;
=20
     /* Register SDRAM and SRAM DMA ports for fast transfers.  */
-    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->emiff_ram),
+    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(dram),
                          OMAP_EMIFF_BASE, s->sdram_size);
     soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->imif_ram),
                          OMAP_IMIF_BASE, s->sram_size);
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index c071197be7..be245714db 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -103,6 +103,7 @@ static void sx1_init(MachineState *machine, const int v=
ersion)
 {
     struct omap_mpu_state_s *mpu;
     MemoryRegion *address_space =3D get_system_memory();
+    MemoryRegion *dram =3D g_new(MemoryRegion, 1);
     MemoryRegion *flash =3D g_new(MemoryRegion, 1);
     MemoryRegion *cs =3D g_new(MemoryRegion, 4);
     static uint32_t cs0val =3D 0x00213090;
@@ -118,8 +119,11 @@ static void sx1_init(MachineState *machine, const int =
version)
         flash_size =3D flash2_size;
     }
=20
-    mpu =3D omap310_mpu_init(address_space, sx1_binfo.ram_size,
-                           machine->cpu_type);
+    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
+                                         sx1_binfo.ram_size);
+    memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, dram);
+
+    mpu =3D omap310_mpu_init(dram, machine->cpu_type);
=20
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 02a3a82b9b..72eca8cc55 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -190,16 +190,20 @@ static void palmte_init(MachineState *machine)
     MemoryRegion *address_space_mem =3D get_system_memory();
     struct omap_mpu_state_s *mpu;
     int flash_size =3D 0x00800000;
-    int sdram_size =3D palmte_binfo.ram_size;
     static uint32_t cs0val =3D 0xffffffff;
     static uint32_t cs1val =3D 0x0000e1a0;
     static uint32_t cs2val =3D 0x0000e1a0;
     static uint32_t cs3val =3D 0xe1a0e1a0;
     int rom_size, rom_loaded =3D 0;
+    MemoryRegion *dram =3D g_new(MemoryRegion, 1);
     MemoryRegion *flash =3D g_new(MemoryRegion, 1);
     MemoryRegion *cs =3D g_new(MemoryRegion, 4);
=20
-    mpu =3D omap310_mpu_init(address_space_mem, sdram_size, machine->cpu_t=
ype);
+    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
+                                         palmte_binfo.ram_size);
+    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE, dram);
+
+    mpu =3D omap310_mpu_init(dram, machine->cpu_type);
=20
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 763d8eab4f..f3aa670036 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -823,7 +823,6 @@ struct omap_mpu_state_s {
     MemoryRegion mpui_io_iomem;
     MemoryRegion tap_iomem;
     MemoryRegion imif_ram;
-    MemoryRegion emiff_ram;
     MemoryRegion sram;
=20
     struct omap_dma_port_if_s {
@@ -835,7 +834,7 @@ struct omap_mpu_state_s {
                         hwaddr addr);
     } port[__omap_dma_port_last];
=20
-    unsigned long sdram_size;
+    uint64_t sdram_size;
     unsigned long sram_size;
=20
     /* MPUI-TIPB peripherals */
@@ -932,8 +931,7 @@ struct omap_mpu_state_s {
 };
=20
 /* omap1.c */
-struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
-                unsigned long sdram_size,
+struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *sdram,
                 const char *core);
=20
 /* omap2.c */
--=20
2.21.0


