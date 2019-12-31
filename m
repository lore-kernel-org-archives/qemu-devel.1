Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DBEC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A62206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVz/3nSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A62206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHjc-0007g6-8J
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCQ-0005oQ-Pq
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCO-0004Cg-Sr
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39818
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCO-0004AT-KA
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xCibiO0DuQ8HOOkneszn2NvPyD91S4PuKX+VpAoqqA=;
 b=fVz/3nSy+ahOWEwGG96dGDiJozSmFTyUZsUHJMNRCHomxOYQr2CMjZ2Hhzfyo+CNEMMa8z
 LD4GuqZO+WIGHIF17pgjieNb/lpmH/qUouFO+djHy4Ste3NnlYSGLq5Pgz9Fh2HSqgCtxR
 ncnBA6vwreuKkpDRb10r09n+yubkX5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-ZwP9VxEnN-Gt9e9sKCyQlg-1; Tue, 31 Dec 2019 08:04:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BD9818031D0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:33 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D89AE620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:32 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/86] mips:mips_fulong2e: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:38 +0100
Message-Id: <1577797450-88458-55-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZwP9VxEnN-Gt9e9sKCyQlg-1
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
 hw/mips/mips_fulong2e.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 4a5e5b4..f3fe68a 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -294,7 +294,6 @@ static void mips_fulong2e_init(MachineState *machine)
     const char *initrd_filename =3D machine->initrd_filename;
     char *filename;
     MemoryRegion *address_space_mem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *bios =3D g_new(MemoryRegion, 1);
     long bios_size;
     uint8_t *spd_data;
@@ -320,13 +319,11 @@ static void mips_fulong2e_init(MachineState *machine)
     }
=20
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram",
-                                         machine->ram_size);
     memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(bios, true);
=20
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
=20
     /*
@@ -402,6 +399,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc=
)
     mc->block_default_type =3D IF_IDE;
     mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size =3D 256 * MiB;
+    mc->default_ram_id =3D "fulong2e.ram";
 }
=20
 DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
--=20
2.7.4


