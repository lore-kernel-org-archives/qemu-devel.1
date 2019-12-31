Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CFCC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAD0205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYHcPecj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAD0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHRY-0008L8-93
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCA-0005a7-46
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHC7-0003UF-Sf
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54566
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHC7-0003Rt-N0
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=87VpN3EqpvI+rlxdwzPnHBP3SLPbPyMldba+XN6e6Bs=;
 b=KYHcPecj0kSR3KX8y4Ub0D8EN4V3GbgwuZpd4qGDZzRwuJ+929dL5UkWo9ALAdcc5tigdI
 rVVX4EKWnKDQlUO+aC3yhN3K3QxTgXR1pG6XtesOeAWsCbb0DAZWmbwNJ9ztpxX/fOibXT
 XEoTpPGXNe0ukj0+BDdjxz0qzDnS+3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-7NtWFZvqOoGXurRH0IRqGw-1; Tue, 31 Dec 2019 08:04:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7DC9801E66
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:16 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EB1B620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:16 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/86] arm:versatilepb: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:17 +0100
Message-Id: <1577797450-88458-34-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 7NtWFZvqOoGXurRH0IRqGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 hw/arm/versatilepb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e86af01..f3c4a50 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -184,7 +184,6 @@ static void versatile_init(MachineState *machine, int b=
oard_id)
     Object *cpuobj;
     ARMCPU *cpu;
     MemoryRegion *sysmem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     qemu_irq pic[32];
     qemu_irq sic[32];
     DeviceState *dev, *sysctl;
@@ -220,11 +219,9 @@ static void versatile_init(MachineState *machine, int =
board_id)
=20
     cpu =3D ARM_CPU(cpuobj);
=20
-    memory_region_allocate_system_memory(ram, NULL, "versatile.ram",
-                                         machine->ram_size);
     /* ??? RAM should repeat to fill physical memory space.  */
     /* SDRAM at address zero.  */
-    memory_region_add_subregion(sysmem, 0, ram);
+    memory_region_add_subregion(sysmem, 0, machine->ram);
=20
     sysctl =3D qdev_create(NULL, "realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", 0x41007004);
@@ -398,6 +395,7 @@ static void versatilepb_class_init(ObjectClass *oc, voi=
d *data)
     mc->block_default_type =3D IF_SCSI;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
+    mc->default_ram_id =3D "versatile.ram";
 }
=20
 static const TypeInfo versatilepb_type =3D {
@@ -415,6 +413,7 @@ static void versatileab_class_init(ObjectClass *oc, voi=
d *data)
     mc->block_default_type =3D IF_SCSI;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
+    mc->default_ram_id =3D "versatile.ram";
 }
=20
 static const TypeInfo versatileab_type =3D {
--=20
2.7.4


