Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9EC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDB424654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8+7B4Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDB424654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SMG-0006XQ-6A
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4RwH-0004FV-KE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4RwG-00016k-FP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4RwG-00016Z-Ay
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qDRPQ4TK/v2bK7LIJWDnFv1STpVoUJSi1h4wp28qlU=;
 b=R8+7B4Lw/diLbBlpXBUtC+1Y/D777OEiVryd3eHgm0H9Fy1lCM3kBUIvou1chh6fzaXSI2
 0QB8QCWYHawjdP1vIqt5UTFGEKEovqDSBykLDc81Nd1NWhZLOjpFrlS093vfIWhQyDQP2Z
 KEF8fYgpLkPpQTcHbbCnaIiFhWBR30Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-_V1GKCXgOIqOLxFaYHcBQQ-1; Wed, 19 Feb 2020 11:11:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7736C8EDE47
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:11:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92FD68ED00;
 Wed, 19 Feb 2020 16:11:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 55/79] mips/mips_malta: use memdev for RAM
Date: Wed, 19 Feb 2020 11:09:29 -0500
Message-Id: <20200219160953.13771-56-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _V1GKCXgOIqOLxFaYHcBQQ-1
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
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_malta.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 34b76bb6a1..6e7ba9235d 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1224,7 +1224,6 @@ void mips_malta_init(MachineState *machine)
     char *filename;
     PFlashCFI01 *fl;
     MemoryRegion *system_memory =3D get_system_memory();
-    MemoryRegion *ram_high =3D g_new(MemoryRegion, 1);
     MemoryRegion *ram_low_preio =3D g_new(MemoryRegion, 1);
     MemoryRegion *ram_low_postio;
     MemoryRegion *bios, *bios_copy =3D g_new(MemoryRegion, 1);
@@ -1262,13 +1261,11 @@ void mips_malta_init(MachineState *machine)
     }
=20
     /* register RAM at high address where it is undisturbed by IO */
-    memory_region_allocate_system_memory(ram_high, NULL, "mips_malta.ram",
-                                         ram_size);
-    memory_region_add_subregion(system_memory, 0x80000000, ram_high);
+    memory_region_add_subregion(system_memory, 0x80000000, machine->ram);
=20
     /* alias for pre IO hole access */
     memory_region_init_alias(ram_low_preio, NULL, "mips_malta_low_preio.ra=
m",
-                             ram_high, 0, MIN(ram_size, 256 * MiB));
+                             machine->ram, 0, MIN(ram_size, 256 * MiB));
     memory_region_add_subregion(system_memory, 0, ram_low_preio);
=20
     /* alias for post IO hole access, if there is enough RAM */
@@ -1276,7 +1273,7 @@ void mips_malta_init(MachineState *machine)
         ram_low_postio =3D g_new(MemoryRegion, 1);
         memory_region_init_alias(ram_low_postio, NULL,
                                  "mips_malta_low_postio.ram",
-                                 ram_high, 512 * MiB,
+                                 machine->ram, 512 * MiB,
                                  ram_size - 512 * MiB);
         memory_region_add_subregion(system_memory, 512 * MiB,
                                     ram_low_postio);
@@ -1448,6 +1445,7 @@ static void mips_malta_machine_init(MachineClass *mc)
 #else
     mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
 #endif
+    mc->default_ram_id =3D "mips_malta.ram";
 }
=20
 DEFINE_MACHINE("malta", mips_malta_machine_init)
--=20
2.18.1


