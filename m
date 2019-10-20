Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60782CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D41021A4A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0BwBkbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D41021A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMKMR-0003wq-1n
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 19:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMKAi-0000mB-Ds
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMKAh-00018t-3S
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:59:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMKAh-00018j-01
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571612374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7M1IUjrqcXlYCM8d7hykgPS4Gzumj9wbW6o3J1eHCc=;
 b=L0BwBkbUkyqGpRt4unziaHg6aEzuSZNcVm2uMkyrijaJqCK2sxFhps9wyfZg5XZwwxnRK8
 0uNHxdA3IMvYJTR1EkXR9Xjz095zQ1X/YwCxAKdnxkBtl0A+xCY/HDjGPNtesKtBfmkUXV
 zwHANIZGAG6voEXPRylfB5z8KlZVBVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-sHJr98qlNeWmDG17MSJU5w-1; Sun, 20 Oct 2019 18:59:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 478D5107AD31;
 Sun, 20 Oct 2019 22:59:29 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BEDC60C18;
 Sun, 20 Oct 2019 22:59:11 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 07/21] hw: Drop QOM ownership on
 memory_region_allocate_system_memory() calls
Date: Mon, 21 Oct 2019 00:56:36 +0200
Message-Id: <20191020225650.3671-8-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-1-philmd@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sHJr98qlNeWmDG17MSJU5w-1
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

All the memory_region_allocate_system_memory() calls are in the
board_init() code.  From the 58 calls in the repository, only
4 set the 'owner' parameter. It is obvious we want the Machine
to be the owner of the RAM, so we want to use OBJECT(machine)
as owner. We can simplify a bit by passing MachineState to
memory_region_allocate_system_memory(). In preparation of this
refactor, first drop the 'owner' argument from these 4 uses.

  $ git grep memory_region_allocate_system_memory hw/ | wc -l
  58

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/alpha/typhoon.c | 2 +-
 hw/arm/raspi.c     | 2 +-
 hw/hppa/machine.c  | 2 +-
 hw/sparc/sun4m.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 179e1f7658..8489ec335c 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -851,7 +851,7 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_=
bus,
=20
     /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
        but the address space hole reserved at this point is 8TB.  */
-    memory_region_allocate_system_memory(&s->ram_region, OBJECT(s), "ram",
+    memory_region_allocate_system_memory(&s->ram_region, NULL, "ram",
                                          ram_size);
     memory_region_add_subregion(addr_space, 0, &s->ram_region);
=20
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 615d755879..f76b6eaad3 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -182,7 +182,7 @@ static void raspi_init(MachineState *machine, int versi=
on)
                             &error_abort, NULL);
=20
     /* Allocate and map RAM */
-    memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
+    memory_region_allocate_system_memory(&s->ram, NULL, "ram",
                                          machine->ram_size);
     /* FIXME: Remove when we have custom CPU address space support */
     memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram, 0=
);
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 953d454f48..dbe1ff0fe5 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -96,7 +96,7 @@ static void machine_hppa_init(MachineState *machine)
=20
     /* Main memory region. */
     ram_region =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ram_region, OBJECT(machine),
+    memory_region_allocate_system_memory(ram_region, NULL,
                                          "ram", ram_size);
     memory_region_add_subregion(addr_space, 0, ram_region);
=20
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 6c5a17a020..0bb7524655 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -788,7 +788,7 @@ static void ram_realize(DeviceState *dev, Error **errp)
     RamDevice *d =3D SUN4M_RAM(dev);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
=20
-    memory_region_allocate_system_memory(&d->ram, OBJECT(d), "sun4m.ram",
+    memory_region_allocate_system_memory(&d->ram, NULL, "sun4m.ram",
                                          d->size);
     sysbus_init_mmio(sbd, &d->ram);
 }
--=20
2.21.0


