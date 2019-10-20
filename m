Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B26CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8360920700
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtfDOisJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8360920700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMKJa-0000OM-JI
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 19:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMKB2-0001Az-TM
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMKB1-0001Gw-Bn
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:59:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34904
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMKB1-0001Fw-87
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571612394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSzxhfBjRtdS3tYnNag/BhLYbc88B8grh2N4vY+Fq+o=;
 b=XtfDOisJv3Uck5klKxCEXzxStcmyBzW02vsuVw3wpRh22h51hLveH0FAEXyfdbOlLBnbgH
 Jo2WRitLON9+Os398XYrThohg0Ov0lCSv9lJM8RIX+q0S7LOSbjJ4Yo5hOj0J6SgYhCWr2
 aXVohYEWChUfX3VYuUx76R4WxW5dy4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-aywJjEjxOyyn1SNA9RuIhw-1; Sun, 20 Oct 2019 18:59:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A78A80183E;
 Sun, 20 Oct 2019 22:59:49 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BB1360C18;
 Sun, 20 Oct 2019 22:59:29 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 08/21] hw/alpha/dp264: Create the RAM in the board
Date: Mon, 21 Oct 2019 00:56:37 +0200
Message-Id: <20191020225650.3671-9-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-1-philmd@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: aywJjEjxOyyn1SNA9RuIhw-1
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

The SDRAM is incorrectly created in the Tyohoon northbridge ASIC.
Move its creation in the board code, this will later allow the
board to have the QOM ownership of the RAM.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
checkpatch complains:

 ERROR: spaces required around that '*' (ctx:WxV)
 #10: FILE: hw/alpha/alpha_sys.h:13:
 +PCIBus *typhoon_init(ISABus **, qemu_irq *, AlphaCPU *[4],
                                                       ^
---
 hw/alpha/alpha_sys.h |  2 +-
 hw/alpha/dp264.c     | 11 ++++++++++-
 hw/alpha/typhoon.c   |  9 +--------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 4e127a6de8..17f97e1bfe 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -10,7 +10,7 @@
 #include "hw/i386/pc.h"
=20
=20
-PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *, AlphaCPU *[4],
+PCIBus *typhoon_init(ISABus **, qemu_irq *, AlphaCPU *[4],
                      pci_map_irq_fn);
=20
 /* alpha_pci.c.  */
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 51feee8558..ddc249261c 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -62,6 +62,7 @@ static void clipper_init(MachineState *machine)
     uint64_t palcode_entry, palcode_low, palcode_high;
     uint64_t kernel_entry, kernel_low, kernel_high;
     unsigned int smp_cpus =3D machine->smp.cpus;
+    MemoryRegion ram_region;
=20
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
@@ -73,8 +74,16 @@ static void clipper_init(MachineState *machine)
     cpus[0]->env.trap_arg1 =3D 0;
     cpus[0]->env.trap_arg2 =3D smp_cpus;
=20
+    /*
+     * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
+     * but the address space hole reserved at this point is 8TB.
+     */
+    memory_region_allocate_system_memory(&ram_region, NULL, "ram",
+                                         ram_size);
+    memory_region_add_subregion(get_system_memory(), 0, &ram_region);
+
     /* Init the chipset.  */
-    pci_bus =3D typhoon_init(ram_size, &isa_bus, &rtc_irq, cpus,
+    pci_bus =3D typhoon_init(&isa_bus, &rtc_irq, cpus,
                            clipper_pci_map_irq);
=20
     /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 8489ec335c..12589ef331 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -58,7 +58,6 @@ typedef struct TyphoonState {
     TyphoonCchip cchip;
     TyphoonPchip pchip;
     MemoryRegion dchip_region;
-    MemoryRegion ram_region;
 } TyphoonState;
=20
 /* Called when one of DRIR or DIM changes.  */
@@ -817,7 +816,7 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
=20
-PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
+PCIBus *typhoon_init(ISABus **isa_bus,
                      qemu_irq *p_rtc_irq,
                      AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq)
 {
@@ -849,12 +848,6 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa=
_bus,
=20
     *p_rtc_irq =3D qemu_allocate_irq(typhoon_set_timer_irq, s, 0);
=20
-    /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
-       but the address space hole reserved at this point is 8TB.  */
-    memory_region_allocate_system_memory(&s->ram_region, NULL, "ram",
-                                         ram_size);
-    memory_region_add_subregion(addr_space, 0, &s->ram_region);
-
     /* TIGbus, 0x801.0000.0000, 1GB.  */
     /* ??? The TIGbus is used for delivering interrupts, and access to
        the flash ROM.  I'm not sure that we need to implement it at all.  =
*/
--=20
2.21.0


