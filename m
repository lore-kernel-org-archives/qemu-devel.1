Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78794CA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4589A218BA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8aD9Qef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4589A218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMKQS-0007kL-BK
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 19:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMKES-00046q-V1
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 19:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMKER-0002k8-JQ
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 19:03:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMKER-0002jn-FB
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 19:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571612607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYrjwKUtmGWNVT9jpBDGXDGVAk9jA0k5Lxt2r1TTs2k=;
 b=Y8aD9QefUh5qSgs4H4/1sxJZFo8BJ01i+TQ+NXfpllFngmFSwbNP6IPDzYiGExorBwRzHm
 iZwmK0mlTKfAsLCO0P8h3xlcpxbaL9FgjYBQZGCEBxmsLZu2lQeVzxxJRlWTyJen5Djook
 qAPh+NHPXJxVLd6qyjTd8On0KLSYoE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-PfmdNgNiNvSjFWCeEovMUw-1; Sun, 20 Oct 2019 19:03:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3D4A476;
 Sun, 20 Oct 2019 23:03:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0694E60C18;
 Sun, 20 Oct 2019 23:03:00 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 19/21] hw/ppc: Let the machine be the owner of the system
 memory
Date: Mon, 21 Oct 2019 00:56:48 +0200
Message-Id: <20191020225650.3671-20-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-1-philmd@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PfmdNgNiNvSjFWCeEovMUw-1
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
 hw/ppc/e500.c          | 3 ++-
 hw/ppc/mac_newworld.c  | 3 ++-
 hw/ppc/mac_oldworld.c  | 2 +-
 hw/ppc/pnv.c           | 2 +-
 hw/ppc/ppc405_boards.c | 6 +++---
 hw/ppc/prep.c          | 3 ++-
 hw/ppc/spapr.c         | 2 +-
 hw/ppc/virtex_ml507.c  | 2 +-
 8 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 91cd4c26f9..9c7be26248 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -912,7 +912,8 @@ void ppce500_init(MachineState *machine)
     machine->ram_size =3D ram_size;
=20
     /* Register Memory */
-    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram", ram_s=
ize);
+    memory_region_allocate_system_memory(ram, machine, "mpc8544ds.ram",
+                                         ram_size);
     memory_region_add_subregion(address_space_mem, 0, ram);
=20
     dev =3D qdev_create(NULL, "e500-ccsr");
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index c5bbcc7433..8409114eed 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -152,7 +152,8 @@ static void ppc_core99_init(MachineState *machine)
     }
=20
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "ppc_core99.ram", ram_=
size);
+    memory_region_allocate_system_memory(ram, machine, "ppc_core99.ram",
+                                         ram_size);
     memory_region_add_subregion(get_system_memory(), 0, ram);
=20
     /* allocate and load BIOS */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0fa680b749..9dd645476a 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -127,7 +127,7 @@ static void ppc_heathrow_init(MachineState *machine)
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "ppc_heathrow.ram",
+    memory_region_allocate_system_memory(ram, machine, "ppc_heathrow.ram",
                                          ram_size);
     memory_region_add_subregion(sysmem, 0, ram);
=20
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7cf64b6d25..ac731c4f88 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -640,7 +640,7 @@ static void pnv_init(MachineState *machine)
     }
=20
     ram =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ram, NULL, "pnv.ram",
+    memory_region_allocate_system_memory(ram, machine, "pnv.ram",
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(), 0, ram);
=20
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 388cae0b43..8a2d2f4511 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -162,8 +162,8 @@ static void ref405ep_init(MachineState *machine)
     MemoryRegion *sysmem =3D get_system_memory();
=20
     /* XXX: fix this */
-    memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405ep.=
ram",
-                                         0x08000000);
+    memory_region_allocate_system_memory(&ram_memories[0], machine,
+                                         "ef405ep.ram", 128 * MiB);
     ram_bases[0] =3D 0;
     ram_sizes[0] =3D 0x08000000;
     memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
@@ -427,7 +427,7 @@ static void taihu_405ep_init(MachineState *machine)
=20
     /* RAM is soldered to the board so the size cannot be changed */
     ram_size =3D 0x08000000;
-    memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
+    memory_region_allocate_system_memory(ram, machine, "taihu_405ep.ram",
                                          ram_size);
=20
     ram_bases[0] =3D 0;
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 4f3c6bf190..54b00805e0 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -445,7 +445,8 @@ static void ppc_prep_init(MachineState *machine)
     }
=20
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "ppc_prep.ram", ram_si=
ze);
+    memory_region_allocate_system_memory(ram, machine, "ppc_prep.ram",
+                                         ram_size);
     memory_region_add_subregion(sysmem, 0, ram);
=20
     if (linux_boot) {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4eb97d3a9b..1f168edd43 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2840,7 +2840,7 @@ static void spapr_machine_init(MachineState *machine)
     }
=20
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "ppc_spapr.ram",
+    memory_region_allocate_system_memory(ram, machine, "ppc_spapr.ram",
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, 0, ram);
=20
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 68625522d8..86c9273dc0 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -224,7 +224,7 @@ static void virtex_init(MachineState *machine)
=20
     qemu_register_reset(main_cpu_reset, cpu);
=20
-    memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_size);
+    memory_region_allocate_system_memory(phys_ram, machine, "ram", ram_siz=
e);
     memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
--=20
2.21.0


