Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469FFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134D7215A4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpxXbU0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134D7215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYXE-0002Ze-9u
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 10:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ixXz9-0005yV-An
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ixXz8-0006ad-4L
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44675
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ixXz8-0006ZM-0a
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580483609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idHv5dKo/9rNqWVnDYADAVuoRWNEBCA/lsvuGxRUqAE=;
 b=SpxXbU0y6YQao76VmzpuJi7ydI98SA0mcfq5pnuB8bQ+QnJ+BMsEJsCeFH86O1MKm0wR3h
 lXZOcZ6IqXkpfFBNif2xOq7wo2iNzSvsps1piUVM4SZbk+4IAZYeHaXtBJ597jhJ/EdYMs
 fc8Np0qzzDJ27BFZSup2Y5UmHfNv0DM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-vhuPJmNoOq-3NDYT4-W08g-1; Fri, 31 Jan 2020 10:13:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CED33107B0EF
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 15:13:19 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54D3189E7E
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 15:13:19 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 59/80] ppc/mac_newworld: use memdev for RAM
Date: Fri, 31 Jan 2020 16:09:29 +0100
Message-Id: <1580483390-131164-60-git-send-email-imammedo@redhat.com>
In-Reply-To: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vhuPJmNoOq-3NDYT4-W08g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_newworld.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 464d012..b8189bf 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -118,7 +118,7 @@ static void ppc_core99_init(MachineState *machine)
     char *filename;
     IrqLines *openpic_irqs;
     int linux_boot, i, j, k;
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(MemoryRe=
gion, 1);
+    MemoryRegion *bios =3D g_new(MemoryRegion, 1);
     hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
     long kernel_size, initrd_size;
     UNINHostState *uninorth_pci;
@@ -152,8 +152,7 @@ static void ppc_core99_init(MachineState *machine)
     }
=20
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "ppc_core99.ram", ram_=
size);
-    memory_region_add_subregion(get_system_memory(), 0, ram);
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
=20
     /* allocate and load BIOS */
     memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
@@ -586,6 +585,7 @@ static void core99_machine_class_init(ObjectClass *oc, =
void *data)
 #else
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("7400_v2.9");
 #endif
+    mc->default_ram_id =3D "ppc_core99.ram";
     mc->ignore_boot_device_suffixes =3D true;
     fwc->get_dev_path =3D core99_fw_dev_path;
 }
--=20
2.7.4


