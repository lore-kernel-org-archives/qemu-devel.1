Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2AE2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXhE2mn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2AE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMd42-00065Z-6u
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 15:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMd1c-00046W-6f
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMd1a-0001xn-S8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:07:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43213
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMd1a-0001xO-LX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571684846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Djlb/LOp0JEWa3jMyB/e62bHk5Ac8Y4m7TdUNTq7Tmc=;
 b=QXhE2mn57UnfvdO+Is1Pe+2D0+B4E0uJ9MfERRZ7Tml+ZxqHcTh6Az29bJW8i2tPfnmeHQ
 xjDRPPlkd3L7jJthSaB3h+ykInGqCE2NfVQjoIy0glKDnwriqkWTexqB0tRO+WZos82Fza
 4y/I/gegUuzamvr7rDPacUxlCoFUeVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-wJo49e-xOjeqbMNX0jUXgQ-1; Mon, 21 Oct 2019 15:07:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E26107AD31;
 Mon, 21 Oct 2019 19:07:21 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-124.brq.redhat.com [10.40.204.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCBE5196AE;
 Mon, 21 Oct 2019 19:07:15 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 4/6] hw/arm/omap2: Create the RAM in the board
Date: Mon, 21 Oct 2019 21:06:51 +0200
Message-Id: <20191021190653.9511-5-philmd@redhat.com>
In-Reply-To: <20191021190653.9511-1-philmd@redhat.com>
References: <20191021190653.9511-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: wJo49e-xOjeqbMNX0jUXgQ-1
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

The SDRAM is incorrectly created in the OMAP2420 SoC.
Move its creation in the board code, this will later allow the
board to have the QOM ownership of the RAM.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Move MemoryRegion sdram to struct n800_s (Richard)
---
 hw/arm/nseries.c      | 10 +++++++---
 hw/arm/omap2.c        | 13 +++++--------
 include/hw/arm/omap.h |  4 +---
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index a36971d39a..7e361936a9 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -47,6 +47,7 @@
=20
 /* Nokia N8x0 support */
 struct n800_s {
+    MemoryRegion sdram;
     struct omap_mpu_state_s *mpu;
=20
     struct rfbi_chip_s blizzard;
@@ -1311,11 +1312,14 @@ static int n810_atag_setup(const struct arm_boot_in=
fo *info, void *p)
 static void n8x0_init(MachineState *machine,
                       struct arm_boot_info *binfo, int model)
 {
-    MemoryRegion *sysmem =3D get_system_memory();
     struct n800_s *s =3D (struct n800_s *) g_malloc0(sizeof(*s));
-    int sdram_size =3D binfo->ram_size;
+    uint64_t sdram_size =3D binfo->ram_size;
=20
-    s->mpu =3D omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
+    memory_region_allocate_system_memory(&s->sdram, NULL, "omap2.dram",
+                                         sdram_size);
+    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE, &s->sd=
ram);
+
+    s->mpu =3D omap2420_mpu_init(&s->sdram, machine->cpu_type);
=20
     /* Setup peripherals
      *
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index bd7ddff983..457f152bac 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
@@ -2276,8 +2277,7 @@ static const struct dma_irq_map omap2_dma_irq_map[] =
=3D {
     { 0, OMAP_INT_24XX_SDMA_IRQ3 },
 };
=20
-struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
-                unsigned long sdram_size,
+struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
                 const char *cpu_type)
 {
     struct omap_mpu_state_s *s =3D g_new0(struct omap_mpu_state_s, 1);
@@ -2286,11 +2286,11 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRe=
gion *sysmem,
     int i;
     SysBusDevice *busdev;
     struct omap_target_agent_s *ta;
+    MemoryRegion *sysmem =3D get_system_memory();
=20
     /* Core */
     s->mpu_model =3D omap2420;
     s->cpu =3D ARM_CPU(cpu_create(cpu_type));
-    s->sdram_size =3D sdram_size;
     s->sram_size =3D OMAP242X_SRAM_SIZE;
=20
     s->wakeup =3D qemu_allocate_irq(omap_mpu_wakeup, s, 0);
@@ -2299,9 +2299,6 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegi=
on *sysmem,
     omap_clk_init(s);
=20
     /* Memory-mapped stuff */
-    memory_region_allocate_system_memory(&s->sdram, NULL, "omap2.dram",
-                                         s->sdram_size);
-    memory_region_add_subregion(sysmem, OMAP2_Q2_BASE, &s->sdram);
     memory_region_init_ram(&s->sram, NULL, "omap2.sram", s->sram_size,
                            &error_fatal);
     memory_region_add_subregion(sysmem, OMAP2_SRAM_BASE, &s->sram);
@@ -2338,8 +2335,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegi=
on *sysmem,
     s->port->addr_valid =3D omap2_validate_addr;
=20
     /* Register SDRAM and SRAM ports for fast DMA transfers.  */
-    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->sdram),
-                         OMAP2_Q2_BASE, s->sdram_size);
+    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(sdram),
+                         OMAP2_Q2_BASE, memory_region_size(sdram));
     soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->sram),
                          OMAP2_SRAM_BASE, s->sram_size);
=20
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 2fda996648..763d8eab4f 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -824,7 +824,6 @@ struct omap_mpu_state_s {
     MemoryRegion tap_iomem;
     MemoryRegion imif_ram;
     MemoryRegion emiff_ram;
-    MemoryRegion sdram;
     MemoryRegion sram;
=20
     struct omap_dma_port_if_s {
@@ -938,8 +937,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion =
*system_memory,
                 const char *core);
=20
 /* omap2.c */
-struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
-                unsigned long sdram_size,
+struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
                 const char *core);
=20
 uint32_t omap_badwidth_read8(void *opaque, hwaddr addr);
--=20
2.21.0


