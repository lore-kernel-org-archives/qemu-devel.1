Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B1C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B50F214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcCFqXiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B50F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEbu-0006dr-7a
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEWD-0000Np-3O
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEWB-0001aM-GE
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:00:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEWB-0001W9-5H
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576357202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVY3k3PXmSJpFd+itDbLg545Lfy8MyLnQ8WHFK1FOqU=;
 b=HcCFqXiHdYLJtC3TlOlDcgG04EeX+VORp7/uhRWYY9niDo/mBjCj6mUw0fCjNM5S9Ilroc
 TeLY110yfKf3+Mk4rAEbkWhaZ67Y8mEU7Pz6DVxhZsxACvbUSPfszfDTYCRrP9BIUnPcOG
 Uze2u+Qkgk1pgtG99P3VkLM1IlD0jOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-izlcFJRFOTCG14SMImFy1g-1; Sat, 14 Dec 2019 10:57:43 -0500
X-MC-Unique: izlcFJRFOTCG14SMImFy1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBADE107ACC4;
 Sat, 14 Dec 2019 15:57:41 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04D3D5D6A7;
 Sat, 14 Dec 2019 15:57:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] hw/mips/boston: Use memory_region_add_subregion() when
 priority is 0
Date: Sat, 14 Dec 2019 16:56:11 +0100
Message-Id: <20191214155614.19004-6-philmd@redhat.com>
In-Reply-To: <20191214155614.19004-1-philmd@redhat.com>
References: <20191214155614.19004-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Paul Burton <pburton@wavecomp.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is pointless to overlap a memory subregion with priority 0.
Use the simpler memory_region_add_subregion() function.

This patch was produced with the following spatch script:

    @@
    expression region;
    expression offset;
    expression subregion;
    @@
    -memory_region_add_subregion_overlap(region, offset, subregion, 0)
    +memory_region_add_subregion(region, offset, subregion)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/boston.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index ca7d813a52..a27258b4d1 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -412,10 +412,10 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bu=
s_nr,
     qdev_init_nofail(dev);
=20
     cfg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
+    memory_region_add_subregion(sys_mem, cfg_base, cfg);
=20
     mmio =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
-    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);
+    memory_region_add_subregion(sys_mem, 0, mmio);
=20
     qdev_connect_gpio_out_named(dev, "interrupt_out", 0, irq);
=20
@@ -471,17 +471,17 @@ static void boston_mach_init(MachineState *machine)
=20
     flash =3D  g_new(MemoryRegion, 1);
     memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err)=
;
-    memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
+    memory_region_add_subregion(sys_mem, 0x18000000, flash);
=20
     ddr =3D g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ddr, NULL, "boston.ddr",
                                          machine->ram_size);
-    memory_region_add_subregion_overlap(sys_mem, 0x80000000, ddr, 0);
+    memory_region_add_subregion(sys_mem, 0x80000000, ddr);
=20
     ddr_low_alias =3D g_new(MemoryRegion, 1);
     memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
                              ddr, 0, MIN(machine->ram_size, (256 * MiB))=
);
-    memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
+    memory_region_add_subregion(sys_mem, 0, ddr_low_alias);
=20
     xilinx_pcie_init(sys_mem, 0,
                      0x10000000, 32 * MiB,
@@ -501,7 +501,7 @@ static void boston_mach_init(MachineState *machine)
     platreg =3D g_new(MemoryRegion, 1);
     memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
                           "boston-platregs", 0x1000);
-    memory_region_add_subregion_overlap(sys_mem, 0x17ffd000, platreg, 0)=
;
+    memory_region_add_subregion(sys_mem, 0x17ffd000, platreg);
=20
     s->uart =3D serial_mm_init(sys_mem, 0x17ffe000, 2,
                              get_cps_irq(&s->cps, 3), 10000000,
@@ -509,7 +509,7 @@ static void boston_mach_init(MachineState *machine)
=20
     lcd =3D g_new(MemoryRegion, 1);
     memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0=
x8);
-    memory_region_add_subregion_overlap(sys_mem, 0x17fff000, lcd, 0);
+    memory_region_add_subregion(sys_mem, 0x17fff000, lcd);
=20
     chr =3D qemu_chr_new("lcd", "vc:320x240", NULL);
     qemu_chr_fe_init(&s->lcd_display, chr, NULL);
--=20
2.21.0


