Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75061C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0FF206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4dxSzcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0FF206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHWG-0006PP-RZ
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHC3-0005Oq-9A
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHC2-00032t-0a
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHC1-00030I-R9
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVKMODe+MpjYLQreYlBXiezNgqlaIQPtM6juxP85AtM=;
 b=a4dxSzcWW3x+tEX8bPYeo5rI0f0HvOVqsVr8GcyoVYw/D5en0FlyxtDxf4WvD6tI5G9w2i
 iMnNOAbpiFFwsshNnouLgAD8Jj0080ZQl4qWDKbh4WFASAaVSI5Ndf8wIpMGRDc+OPfdRK
 hXl4clGSl4Tl6veW5H7ca6+ctvzlP18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-RoNMO_k1M2-lJby3bpMILQ-1; Tue, 31 Dec 2019 08:04:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CB09800D41
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9637F620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:10 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/86] arm:musicpal: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:10 +0100
Message-Id: <1577797450-88458-27-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: RoNMO_k1M2-lJby3bpMILQ-1
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

PS:
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/musicpal.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index f68a399..5bcb144 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1589,16 +1589,20 @@ static void musicpal_init(MachineState *machine)
     int i;
     unsigned long flash_size;
     DriveInfo *dinfo;
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     MemoryRegion *address_space_mem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
=20
+    /* For now we use a fixed - the original - RAM size */
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
+                     mc->default_ram_size);
+        exit(EXIT_FAILURE);
+    }
+
     cpu =3D ARM_CPU(cpu_create(machine->cpu_type));
=20
-    /* For now we use a fixed - the original - RAM size */
-    memory_region_allocate_system_memory(ram, NULL, "musicpal.ram",
-                                         MP_RAM_DEFAULT_SIZE);
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
=20
     memory_region_init_ram(sram, NULL, "musicpal.sram", MP_SRAM_SIZE,
                            &error_fatal);
@@ -1714,6 +1718,8 @@ static void musicpal_machine_init(MachineClass *mc)
     mc->init =3D musicpal_init;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
+    mc->default_ram_size =3D MP_RAM_DEFAULT_SIZE;
+    mc->default_ram_id =3D "musicpal.ram";
 }
=20
 DEFINE_MACHINE("musicpal", musicpal_machine_init)
--=20
2.7.4


