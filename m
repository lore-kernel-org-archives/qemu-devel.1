Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D9C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7B622527
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMcGLbH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7B622527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j454l-0006s1-42
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j452R-0004Ph-Kb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j452Q-0003By-Do
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:43:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j452Q-0003Bo-AG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582040633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0Sf4uZg1IWbwEwAZayxLLmB0s75d8OVe06ZUQ5zUBU=;
 b=OMcGLbH8zEoDlgS96CARMA8ZzoKk6DhGm8hR8qhRN8RzJIixCzv4WM12HyswBmL5g+KnxM
 Yd7b9ec2H3MGcbZtWBAydknk2+00asym4R1NvTQQ1Z2mdWgWUG3qVNGyeOXlmR1Jemgjnr
 QD/yZYGSQawydIui2rq5wlEC7lJw76Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-hshdOYGaNmeJghLpwpFudQ-1; Tue, 18 Feb 2020 10:43:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA6328010FE;
 Tue, 18 Feb 2020 15:43:48 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F8955C1B2;
 Tue, 18 Feb 2020 15:43:47 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 64/79] ppc/ppc405_boards: use memdev for RAM
Date: Tue, 18 Feb 2020 10:43:46 -0500
Message-Id: <20200218154346.9704-1-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-65-imammedo@redhat.com>
References: <20200217173452.15243-65-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: hshdOYGaNmeJghLpwpFudQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
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


