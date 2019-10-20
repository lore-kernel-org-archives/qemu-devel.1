Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA5CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3772B21929
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKEAqUYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3772B21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMKCy-0001UF-EM
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 19:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMK9Y-0007Tw-N1
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMK9X-0000hb-Et
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:58:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38769
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMK9X-0000hD-BB
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571612302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ct9GxQAra7Nz2QfsyFV24ARRUDhuyExjCbAMSK5fQ0A=;
 b=DKEAqUYxHBPcMLMFCZpupo930v35r/1Hqs0fkW64eFGUN34svAjaX9dArUwwJkAgv7KgF8
 Ib/4AxNQzuMGmFVaj0r9VROqDLPIAXGytaDmX6AlGZJLD+GPao1vjZM/1Jg6GmUCk8GERz
 rj+9ZKsIQ01lDorNWiQGm7NEQkFcy6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-saRSUd18PTCqyhOHWl-9jA-1; Sun, 20 Oct 2019 18:58:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13F541800D9B;
 Sun, 20 Oct 2019 22:58:15 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5098960C18;
 Sun, 20 Oct 2019 22:57:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 03/21] hw/arm/collie: Create the RAM in the board
Date: Mon, 21 Oct 2019 00:56:32 +0200
Message-Id: <20191020225650.3671-4-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-1-philmd@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: saRSUd18PTCqyhOHWl-9jA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

The SDRAM is incorrectly created in the SA1110 SoC.
Move its creation in the board code, this will later allow the
board to have the QOM ownership of the RAM.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/collie.c    | 8 ++++++--
 hw/arm/strongarm.c | 7 +------
 hw/arm/strongarm.h | 4 +---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index b1288ccea8..970a4405cc 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -27,9 +27,13 @@ static void collie_init(MachineState *machine)
 {
     StrongARMState *s;
     DriveInfo *dinfo;
-    MemoryRegion *sysmem =3D get_system_memory();
+    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
=20
-    s =3D sa1110_init(sysmem, collie_binfo.ram_size, machine->cpu_type);
+    s =3D sa1110_init(machine->cpu_type);
+
+    memory_region_allocate_system_memory(sdram, NULL, "strongarm.sdram",
+                                         collie_binfo.ram_size);
+    memory_region_add_subregion(get_system_memory(), SA_SDCS0, sdram);
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index dc65d88a65..6bee034914 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1586,8 +1586,7 @@ static const TypeInfo strongarm_ssp_info =3D {
 };
=20
 /* Main CPU functions */
-StrongARMState *sa1110_init(MemoryRegion *sysmem,
-                            unsigned int sdram_size, const char *cpu_type)
+StrongARMState *sa1110_init(const char *cpu_type)
 {
     StrongARMState *s;
     int i;
@@ -1601,10 +1600,6 @@ StrongARMState *sa1110_init(MemoryRegion *sysmem,
=20
     s->cpu =3D ARM_CPU(cpu_create(cpu_type));
=20
-    memory_region_allocate_system_memory(&s->sdram, NULL, "strongarm.sdram=
",
-                                         sdram_size);
-    memory_region_add_subregion(sysmem, SA_SDCS0, &s->sdram);
-
     s->pic =3D sysbus_create_varargs("strongarm_pic", 0x90050000,
                     qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ),
                     qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_FIQ),
diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
index e98840b461..192821f6aa 100644
--- a/hw/arm/strongarm.h
+++ b/hw/arm/strongarm.h
@@ -55,7 +55,6 @@ enum {
=20
 typedef struct {
     ARMCPU *cpu;
-    MemoryRegion sdram;
     DeviceState *pic;
     DeviceState *gpio;
     DeviceState *ppc;
@@ -63,7 +62,6 @@ typedef struct {
     SSIBus *ssp_bus;
 } StrongARMState;
=20
-StrongARMState *sa1110_init(MemoryRegion *sysmem,
-                            unsigned int sdram_size, const char *rev);
+StrongARMState *sa1110_init(const char *cpu_type);
=20
 #endif
--=20
2.21.0


