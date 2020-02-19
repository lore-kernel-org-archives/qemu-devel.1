Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2C7C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673D02464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzHkSxy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673D02464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4S5i-0004zW-IY
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Rvf-0002hT-Dm
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Rve-0000e3-5d
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Rve-0000dv-1e
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjQpvX88zqHR76PbZyO8fIM2w+mT/wXHBT1WDLpxQYQ=;
 b=JzHkSxy0us657DIgtMaXWFFrsgH0Es6aVyUAlf6w8rwyxTG095hWLjtqdsZosvkuooyhoa
 j3mGbLHquH/Bl23DwdCkIc/MY3kheu4UELMvjneXrQeYq9XOictc+I2Xa4UTnb6QvEatoG
 376JpEWX3iu096o8SxH3hEOo0/aMsyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-NmD2ZspWNluraEBmTUCojA-1; Wed, 19 Feb 2020 11:10:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C608010CA;
 Wed, 19 Feb 2020 16:10:21 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBD048ED00;
 Wed, 19 Feb 2020 16:10:20 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 21/79] arm/mcimx7d-sabre: use memdev for RAM
Date: Wed, 19 Feb 2020 11:08:55 -0500
Message-Id: <20200219160953.13771-22-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: NmD2ZspWNluraEBmTUCojA-1
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
Cc: andrew.smirnov@gmail.com, Paolo Bonzini <pbonzini@redhat.com>
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
 remove no longer needed MCIMX7Sabre

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
CC: andrew.smirnov@gmail.com
---
 hw/arm/mcimx7d-sabre.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 0d1f62d30a..de1e264217 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -21,15 +21,10 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
=20
-typedef struct {
-    FslIMX7State soc;
-    MemoryRegion ram;
-} MCIMX7Sabre;
-
 static void mcimx7d_sabre_init(MachineState *machine)
 {
     static struct arm_boot_info boot_info;
-    MCIMX7Sabre *s =3D g_new0(MCIMX7Sabre, 1);
+    FslIMX7State *s;
     int i;
=20
     if (machine->ram_size > FSL_IMX7_MMDC_SIZE) {
@@ -45,15 +40,12 @@ static void mcimx7d_sabre_init(MachineState *machine)
         .nb_cpus =3D machine->smp.cpus,
     };
=20
-    object_initialize_child(OBJECT(machine), "soc",
-                            &s->soc, sizeof(s->soc),
-                            TYPE_FSL_IMX7, &error_fatal, NULL);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fat=
al);
+    s =3D FSL_IMX7(object_new(TYPE_FSL_IMX7));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_fa=
tal);
+    object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "mcimx7d-sabre.ram=
",
-                                         machine->ram_size);
-    memory_region_add_subregion(get_system_memory(),
-                                FSL_IMX7_MMDC_ADDR, &s->ram);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_MMDC_ADDR,
+                                machine->ram);
=20
     for (i =3D 0; i < FSL_IMX7_NUM_USDHCS; i++) {
         BusState *bus;
@@ -63,7 +55,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
=20
         di =3D drive_get_next(IF_SD);
         blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
-        bus =3D qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
+        bus =3D qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
         carddev =3D qdev_create(bus, TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
         object_property_set_bool(OBJECT(carddev), true,
@@ -71,7 +63,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
=20
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
     }
 }
=20
@@ -80,5 +72,6 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->desc =3D "Freescale i.MX7 DUAL SABRE (Cortex A7)";
     mc->init =3D mcimx7d_sabre_init;
     mc->max_cpus =3D FSL_IMX7_NUM_CPUS;
+    mc->default_ram_id =3D "mcimx7d-sabre.ram";
 }
 DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
--=20
2.18.1


