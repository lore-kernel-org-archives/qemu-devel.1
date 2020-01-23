Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4F8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151572051A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cf9wUUh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151572051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iub0Z-0007Gw-NA
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuarX-00058C-4H
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuarV-0003wG-UE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51427
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuarV-0003vi-QR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4Qqxi1sa/PV17dNNizDT5oKsAk3IDkuhly8MZCeasI=;
 b=Cf9wUUh5vrWKUtN2Uh9hgZpVfnAsTMdJwwgoCbtCRr1jqZxJaQJEz4644QLlbVpr4S11Rr
 xXvwXzct4AlF1vrie3SRF0spDERJHeCKxCGlJzis39O65xpVqCb5pN+y+Cpvjv9FSFGLYf
 DI+xu175/G/xcPe6dI7s1HZdaZT8Zro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-F-9puqLhMQWeFc4zdG85FQ-1; Thu, 23 Jan 2020 06:41:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15CDE107ACCA;
 Thu, 23 Jan 2020 11:41:20 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1475F100164D;
 Thu, 23 Jan 2020 11:41:18 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 09/80] arm/collie: use memdev for RAM
Date: Thu, 23 Jan 2020 12:37:34 +0100
Message-Id: <1579779525-20065-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: F-9puqLhMQWeFc4zdG85FQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org
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
 - while at it add check for user supplied RAM size and error
   out if it mismatches board expected value.
 - introduce RAM_ADDR_UFMT to avoid build errors on 32-bit hosts
   when specifying format string for ram_addr_t type

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  * fix format string causing build failure on 32-bit host
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
v3:
  * instead of RAM_ADDR_UFMT adding use size_to_str()
     Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

CC: drjones@redhat.com
CC: peter.maydell@linaro.org
CC: qemu-arm@nongnu.org
---
 hw/arm/collie.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 970a440..024893f 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -10,6 +10,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "strongarm.h"
@@ -20,20 +21,24 @@
=20
 static struct arm_boot_info collie_binfo =3D {
     .loader_start =3D SA_SDCS0,
-    .ram_size =3D 0x20000000,
 };
=20
 static void collie_init(MachineState *machine)
 {
     StrongARMState *s;
     DriveInfo *dinfo;
-    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
+
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        char *sz =3D size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
=20
     s =3D sa1110_init(machine->cpu_type);
=20
-    memory_region_allocate_system_memory(sdram, NULL, "strongarm.sdram",
-                                         collie_binfo.ram_size);
-    memory_region_add_subregion(get_system_memory(), SA_SDCS0, sdram);
+    memory_region_add_subregion(get_system_memory(), SA_SDCS0, machine->ra=
m);
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
@@ -57,6 +62,8 @@ static void collie_machine_init(MachineClass *mc)
     mc->init =3D collie_init;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("sa1110");
+    mc->default_ram_size =3D 0x20000000;
+    mc->default_ram_id =3D "strongarm.sdram";
 }
=20
 DEFINE_MACHINE("collie", collie_machine_init)
--=20
2.7.4


