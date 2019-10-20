Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D45ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E998121929
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+m8cIMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E998121929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMKGA-0004zL-JY
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 19:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMK9n-0007rt-BU
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMK9l-0000mf-Sy
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:58:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMK9l-0000mM-Ow
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571612317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00y7jQpSxo9MyQHgBlj8zdJXUgyhGSSLykacNJ1ow64=;
 b=J+m8cIMQnuC4eRQrdUHOIis1Qpaqz/pgWtXkBVKgQ56mx1zZ1hMPY0ZgwXNj8MlWeCTuze
 wOvfSndkRGWUHVtaQ19IVjYLjdtoIoQN+NQxXRE2fWR9LNoHBfX/93agx4tDS7bEjTdJVF
 11IyPTQ45xyHt+G3x9HDIjd7l0sgz9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-v505K273OgOtL1nkGe2Q9Q-1; Sun, 20 Oct 2019 18:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15AC91005509;
 Sun, 20 Oct 2019 22:58:30 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A79D60C18;
 Sun, 20 Oct 2019 22:58:15 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 04/21] hw/arm/omap2: Create the RAM in the board
Date: Mon, 21 Oct 2019 00:56:33 +0200
Message-Id: <20191020225650.3671-5-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-1-philmd@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: v505K273OgOtL1nkGe2Q9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The SDRAM is incorrectly created in the OMAP2420 SoC.
Move its creation in the board code, this will later allow the
board to have the QOM ownership of the RAM.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/nseries.c      | 10 +++++++---
 hw/arm/omap2.c        | 13 +++++--------
 include/hw/arm/omap.h |  4 +---
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index a36971d39a..11f2c193f3 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1311,11 +1311,15 @@ static int n810_atag_setup(const struct arm_boot_in=
fo *info, void *p)
 static void n8x0_init(MachineState *machine,
                       struct arm_boot_info *binfo, int model)
 {
-    MemoryRegion *sysmem =3D get_system_memory();
+    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
     struct n800_s *s =3D (struct n800_s *) g_malloc0(sizeof(*s));
-    int sdram_size =3D binfo->ram_size;
+    uint64_t sdram_size =3D binfo->ram_size;
=20
-    s->mpu =3D omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
+    memory_region_allocate_system_memory(sdram, NULL, "omap2.dram",
+                                         sdram_size);
+    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE, sdram)=
;
+
+    s->mpu =3D omap2420_mpu_init(sdram, machine->cpu_type);
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


