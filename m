Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F6C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B287E20725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUrc3uv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B287E20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kNd-0004df-Qj
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kIf-00014v-GU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kIe-0001lK-9r
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34533
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kIe-0001kr-5a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX7ZP+Z3ukgokdjlGVg3Xww8w3o7m7mRnx8yNMa+F+Q=;
 b=HUrc3uv+pPal2w56xrU1/JVR1RWToX0F1rMaxDmiX12CqXIygLLRalLO+jAzWtCpXF+aBL
 zLMMd7IIQfD6z/13XfRrMsge4SVIogIFsi2PKzARyTKo1c68AOm136xjCWh6Jw/XoygiBG
 04hjj+qpixJqNd2ClQHl96GBC/CWkyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-I6S0PUP1M6G1y1OZBQt5Hw-1; Mon, 17 Feb 2020 12:35:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39C8918FE860
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:35:13 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88F8490526;
 Mon, 17 Feb 2020 17:35:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/79] arm/collie: use memdev for RAM
Date: Mon, 17 Feb 2020 12:33:44 -0500
Message-Id: <20200217173452.15243-12-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: I6S0PUP1M6G1y1OZBQt5Hw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

PS:
 - while at it add check for user supplied RAM size and error
   out if it mismatches board expected value.
 - introduce RAM_ADDR_UFMT to avoid build errors on 32-bit hosts
   when specifying format string for ram_addr_t type

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
v2:
  * fix format string causing build failure on 32-bit host
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
v3:
  * instead of RAM_ADDR_UFMT adding use size_to_str()
     Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/collie.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 970a4405cc..024893fc9e 100644
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
2.18.1


