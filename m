Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8116CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3732082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzNA+akC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3732082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYbO-0001Td-FT
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 10:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ixXzC-00065L-LH
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ixXzB-0006ku-Hh
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59693)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ixXzB-0006eC-Di
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580483611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxPQu7ACy6Nxc4Ef3oGPgdzcL0Tcqt7GD/Y31IzNZok=;
 b=DzNA+akCl6ukRqyhDTz9SZFGjviR6vHPcOt/cQEjaFvYibMYUoLjDsZ7QGIFHxZnXaKjWM
 R4pq0LyQ6QqnNFTAVh04kVnS6sUFRH61N6ciKTom+RxvEuLd3icn9FVKWiOQpgjyBf/PfA
 2wwLPxB4yMtDYqKa2ceUbM7D2bF8Y0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-5tT-JjNYNBCERLkc84-Q9g-1; Fri, 31 Jan 2020 10:13:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9074C107ACC5
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 15:13:28 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1647286C4B
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 15:13:27 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 70/80] sparc/leon3: use memdev for RAM
Date: Fri, 31 Jan 2020 16:09:40 +0100
Message-Id: <1580483390-131164-71-git-send-email-imammedo@redhat.com>
In-Reply-To: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 5tT-JjNYNBCERLkc84-Q9g-1
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
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/sparc/leon3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index f5a087d..5fa58aa 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -189,7 +189,6 @@ static void leon3_generic_hw_init(MachineState *machine=
)
     SPARCCPU *cpu;
     CPUSPARCState   *env;
     MemoryRegion *address_space_mem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *prom =3D g_new(MemoryRegion, 1);
     int         ret;
     char       *filename;
@@ -251,8 +250,8 @@ static void leon3_generic_hw_init(MachineState *machine=
)
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "leon3.ram", ram_size)=
;
-    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET, ram);
+    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET,
+                                machine->ram);
=20
     /* Allocate BIOS */
     prom_size =3D 8 * MiB;
@@ -358,6 +357,7 @@ static void leon3_generic_machine_init(MachineClass *mc=
)
     mc->desc =3D "Leon-3 generic";
     mc->init =3D leon3_generic_hw_init;
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("LEON3");
+    mc->default_ram_id =3D "leon3.ram";
 }
=20
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
--=20
2.7.4


