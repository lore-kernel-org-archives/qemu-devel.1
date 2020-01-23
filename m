Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107BDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC0024655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGNTudyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC0024655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubqk-00086U-E6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuatl-0008Ow-RO
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuatj-0005Cf-UN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53483
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuati-0005BJ-7F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/Y+TeQhJLFvkD1utNmQya59Mk0HjE69BPP5CGsPWis=;
 b=AGNTudyXguj3lfnF50j+RaFpP+2+XhsMlLk+3moZz/IMuYJO5tPkcSwZfWUKGwXCRPwxoJ
 qC1ah/5Ja2kt4r4BKWNEXgE8vI9eUuVVoh+gc1ZkmhIeG9ktQw1LFBFlHHrjyRP4iqKncI
 TQX9caoX2Nvr2goRIGBch4aBiyeMlr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-gIg9OevmPMKTKC9IKeATOA-1; Thu, 23 Jan 2020 06:43:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DC9D100550E
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:43:39 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2299C100164D
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:43:38 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 70/80] sparc/leon3: use memdev for RAM
Date: Thu, 23 Jan 2020 12:38:35 +0100
Message-Id: <1579779525-20065-71-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: gIg9OevmPMKTKC9IKeATOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/sparc/leon3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 8038887..64399eb 100644
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


