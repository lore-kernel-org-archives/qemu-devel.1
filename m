Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED540C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C6E20725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdsP+PQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C6E20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kPs-0000P5-UP
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kIj-0001Ed-Ku
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kIi-0001oZ-AD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kIi-0001oA-5G
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyGiYVnyrESE+bDVRdAtrFy5/IupR4jaS3wni1rBVjQ=;
 b=BdsP+PQHhuiO759Q+u3eFZ8aQpqxCtYuwhv+t9VilttKVxp+orTqXCQL+L2C2pbVoGjT3V
 Hby/6UXmn0HP3KY2SvdugtqExwoiBOfsWw9Dh9k4Ptd1LCWQp1iTyIEJnwOI4UbanXBDT2
 MRHeMqA/mRbrPSVOU7NJu9O1KPpmTiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-hkfVTUg6Pq2m8rAMRFxOhA-1; Mon, 17 Feb 2020 12:35:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7F931084431;
 Mon, 17 Feb 2020 17:35:16 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDAD48CCE0;
 Mon, 17 Feb 2020 17:35:15 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/79] arm/highbank: use memdev for RAM
Date: Mon, 17 Feb 2020 12:33:47 -0500
Message-Id: <20200217173452.15243-15-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hkfVTUg6Pq2m8rAMRFxOhA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, robh@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
CC: robh@kernel.org
---
 hw/arm/highbank.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 518d935fdf..ac9de9411e 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -236,7 +236,6 @@ enum cxmachines {
  */
 static void calxeda_init(MachineState *machine, enum cxmachines machine_id=
)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
     DeviceState *dev =3D NULL;
     SysBusDevice *busdev;
     qemu_irq pic[128];
@@ -247,7 +246,6 @@ static void calxeda_init(MachineState *machine, enum cx=
machines machine_id)
     qemu_irq cpu_virq[4];
     qemu_irq cpu_vfiq[4];
     MemoryRegion *sysram;
-    MemoryRegion *dram;
     MemoryRegion *sysmem;
     char *sysboot_filename;
=20
@@ -290,10 +288,8 @@ static void calxeda_init(MachineState *machine, enum c=
xmachines machine_id)
     }
=20
     sysmem =3D get_system_memory();
-    dram =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(dram, NULL, "highbank.dram", ram_=
size);
     /* SDRAM at address zero.  */
-    memory_region_add_subregion(sysmem, 0, dram);
+    memory_region_add_subregion(sysmem, 0, machine->ram);
=20
     sysram =3D g_new(MemoryRegion, 1);
     memory_region_init_ram(sysram, NULL, "highbank.sysram", 0x8000,
@@ -387,7 +383,7 @@ static void calxeda_init(MachineState *machine, enum cx=
machines machine_id)
=20
     /* TODO create and connect IDE devices for ide_drive_get() */
=20
-    highbank_binfo.ram_size =3D ram_size;
+    highbank_binfo.ram_size =3D machine->ram_size;
     /* highbank requires a dtb in order to boot, and the dtb will override
      * the board ID. The following value is ignored, so set it to -1 to be
      * clear that the value is meaningless.
@@ -430,6 +426,7 @@ static void highbank_class_init(ObjectClass *oc, void *=
data)
     mc->units_per_default_bus =3D 1;
     mc->max_cpus =3D 4;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_ram_id =3D "highbank.dram";
 }
=20
 static const TypeInfo highbank_type =3D {
@@ -448,6 +445,7 @@ static void midway_class_init(ObjectClass *oc, void *da=
ta)
     mc->units_per_default_bus =3D 1;
     mc->max_cpus =3D 4;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_ram_id =3D "highbank.dram";
 }
=20
 static const TypeInfo midway_type =3D {
--=20
2.18.1


