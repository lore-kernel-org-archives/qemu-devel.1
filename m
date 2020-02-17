Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FBBC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF21F207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwVU3CF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF21F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kih-0002hs-2b
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJf-0003DK-VB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJe-0002Tv-Qb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJe-0002TP-Jf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zRXquUspfaMKxjK/ZwxOgmeva/U7Ez41JClop5CoXQ=;
 b=MwVU3CF9NvEVG25vbenUNMvjtWbWPp2qjE0rDHYYtAoXgOQMLgsbsaW8GSfI8T5lNOEHEc
 lYktT8XzsDlu99k+mVh2yrV+LSakXbrFcLu+5lNYZpdF0rAwhzvS5vrUESRAH09Y+9NCzC
 PKc9V9+A03RWTcbbyv3syebqUhZ9F5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-fJuntI5FNlSN9KNRI1jC3A-1; Mon, 17 Feb 2020 12:36:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D0A3100550E
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:36:14 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AD548CCE0;
 Mon, 17 Feb 2020 17:36:13 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 53/79] mips/mips_jazz: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:26 -0500
Message-Id: <20200217173452.15243-54-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: fJuntI5FNlSN9KNRI1jC3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
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
 hw/mips/mips_jazz.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 66fd4d867d..85d49cf155 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -159,7 +159,6 @@ static void mips_jazz_init(MachineState *machine,
     ISABus *isa_bus;
     ISADevice *pit;
     DriveInfo *fds[MAX_FD];
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *bios =3D g_new(MemoryRegion, 1);
     MemoryRegion *bios2 =3D g_new(MemoryRegion, 1);
     SysBusESPState *sysbus_esp;
@@ -191,9 +190,7 @@ static void mips_jazz_init(MachineState *machine,
     cc->do_transaction_failed =3D mips_jazz_do_transaction_failed;
=20
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(address_space, 0, ram);
+    memory_region_add_subregion(address_space, 0, machine->ram);
=20
     memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
                            &error_fatal);
@@ -393,6 +390,7 @@ static void mips_magnum_class_init(ObjectClass *oc, voi=
d *data)
     mc->init =3D mips_magnum_init;
     mc->block_default_type =3D IF_SCSI;
     mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("R4000");
+    mc->default_ram_id =3D "mips_jazz.ram";
 }
=20
 static const TypeInfo mips_magnum_type =3D {
@@ -409,6 +407,7 @@ static void mips_pica61_class_init(ObjectClass *oc, voi=
d *data)
     mc->init =3D mips_pica61_init;
     mc->block_default_type =3D IF_SCSI;
     mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("R4000");
+    mc->default_ram_id =3D "mips_jazz.ram";
 }
=20
 static const TypeInfo mips_pica61_type =3D {
--=20
2.18.1


