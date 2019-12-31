Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C293EC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891E2205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RS8+PtRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891E2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHR3-0007hW-FN
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHBv-0005Hf-G6
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBu-0002lU-Af
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBu-0002iz-5z
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MVEXNd4S6ttq+EKbUodUue5MkTAw/xeqZaBHAzbSjIE=;
 b=RS8+PtRgBnAuqmqIKQEbqGkEJEJ3UTmZVT//nv19+DbbdC/SwETuHxy3VddGvDZK/xORlr
 n66skMrloGkAzsbVquBQlaHxzhxJvu5VR+JBwWCCvIOhtvrYdAyrMbMU0KG6CO0aYafN6p
 rTSsVQXp/MPfXr8R44hOsaiy061fRz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-ACyh4GmjP_iSzu8VIAxmLA-1; Tue, 31 Dec 2019 08:04:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D97C107ACC7
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:03 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 981CC620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:02 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/86] arm:highbank: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:00 +0100
Message-Id: <1577797450-88458-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ACyh4GmjP_iSzu8VIAxmLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
---
 hw/arm/highbank.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 518d935..ac9de94 100644
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
2.7.4


