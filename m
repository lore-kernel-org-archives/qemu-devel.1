Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDDFC34055
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F24624654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT+1FXQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F24624654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SPg-0006AG-6b
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4RwY-0004pl-BS
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4RwW-0001Tu-Ph
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25650
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4RwW-0001TZ-LK
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XUSFCyD/Ds7afffE10Ve/SS8+0zAFZVZ4ot1nn6ogA=;
 b=HT+1FXQfjBbO3/JKm1CPk9Jn0y5wfIdC488bPcDa38W2X5Zxmw3j7wRr3fL2coGrngV5YC
 GaD9zGcl8Vcf1PIpWkzdr2o5bghzOGKetaqamDIyDUpSLs+aNTFzov1glNHpmAK7SOJOHT
 KFLUqFSRgW+5fDWv/1j4dqlc2NqAWqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-PUucYdxBMDKbBh8qauPWFw-1; Wed, 19 Feb 2020 11:11:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D651C802599;
 Wed, 19 Feb 2020 16:11:10 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A31B48;
 Wed, 19 Feb 2020 16:11:09 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 64/79] ppc/ppc405_boards: use memdev for RAM
Date: Wed, 19 Feb 2020 11:09:38 -0500
Message-Id: <20200219160953.13771-65-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PUucYdxBMDKbBh8qauPWFw-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 david@gibson.dropbear.id.au
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
in ref405ep alias RAM into ram_memories[] to avoid re-factoring
its user ppc405ep_init(), which would be invasive and out of
scope this patch.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v6:
  - fix copy/paste error s/ef405ep.ram/taihu_405ep.ram/
    (Richard Henderson <richard.henderson@linaro.org>)

CC: richard.henderson@linaro.org
CC: david@gibson.dropbear.id.au
---
 hw/ppc/ppc405_boards.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 057882a5d2..de93c40f1a 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -170,8 +170,8 @@ static void ref405ep_init(MachineState *machine)
     }
=20
     /* XXX: fix this */
-    memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405ep.=
ram",
-                                         machine->ram_size);
+    memory_region_init_alias(&ram_memories[0], NULL, "ef405ep.ram.alias",
+                             machine->ram, 0, machine->ram_size);
     ram_bases[0] =3D 0;
     ram_sizes[0] =3D machine->ram_size;
     memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
@@ -312,6 +312,7 @@ static void ref405ep_class_init(ObjectClass *oc, void *=
data)
     mc->desc =3D "ref405ep";
     mc->init =3D ref405ep_init;
     mc->default_ram_size =3D 0x08000000;
+    mc->default_ram_id =3D "ef405ep.ram";
 }
=20
 static const TypeInfo ref405ep_type =3D {
@@ -424,7 +425,6 @@ static void taihu_405ep_init(MachineState *machine)
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *bios;
     MemoryRegion *ram_memories =3D g_new(MemoryRegion, 2);
-    MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
     hwaddr ram_bases[2], ram_sizes[2];
     long bios_size;
     target_ulong kernel_base, initrd_base;
@@ -439,18 +439,16 @@ static void taihu_405ep_init(MachineState *machine)
         g_free(sz);
         exit(EXIT_FAILURE);
     }
-    memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
-                                         machine->ram_size);
=20
     ram_bases[0] =3D 0;
     ram_sizes[0] =3D 0x04000000;
     memory_region_init_alias(&ram_memories[0], NULL,
-                             "taihu_405ep.ram-0", ram, ram_bases[0],
+                             "taihu_405ep.ram-0", machine->ram, ram_bases[=
0],
                              ram_sizes[0]);
     ram_bases[1] =3D 0x04000000;
     ram_sizes[1] =3D 0x04000000;
     memory_region_init_alias(&ram_memories[1], NULL,
-                             "taihu_405ep.ram-1", ram, ram_bases[1],
+                             "taihu_405ep.ram-1", machine->ram, ram_bases[=
1],
                              ram_sizes[1]);
     ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
                   33333333, &pic, kernel_filename =3D=3D NULL ? 0 : 1);
@@ -546,6 +544,7 @@ static void taihu_class_init(ObjectClass *oc, void *dat=
a)
     mc->desc =3D "taihu";
     mc->init =3D taihu_405ep_init;
     mc->default_ram_size =3D 0x08000000;
+    mc->default_ram_id =3D "taihu_405ep.ram";
 }
=20
 static const TypeInfo taihu_type =3D {
--=20
2.18.1


