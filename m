Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A034C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362202053B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd5MUewi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362202053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkmI-0008OV-Ox
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkKF-00081d-LT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkKD-0008M0-Rg
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkKD-0008L2-O5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xP+XfDgYHSkn5jHLJWF0MPXwt9rUfzMHFz128ZKXP8M=;
 b=Vd5MUewi6W98IAJb/qunJUehE3DObJkXk/xVhUrSrEinVYOXDUS19UV19eD1dvW/IpirdQ
 Lw9TjCSWjvIbvS9m3IldqS4JmayADteBmkJb1zmC1cBswjFJmnXXu3brrT5SDrj9y4W/bX
 a2pRZl2Ub/SMPeRDAkZFFK+k7kGZX8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-pbdhUuMTMcymHj3K6npRnA-1; Wed, 15 Jan 2020 10:11:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8C72112F0D8;
 Wed, 15 Jan 2020 15:11:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC2DD19757;
 Wed, 15 Jan 2020 15:11:11 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/86] arm:sabrelite: use memdev for RAM
Date: Wed, 15 Jan 2020 16:06:44 +0100
Message-Id: <1579100861-73692-30-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: pbdhUuMTMcymHj3K6npRnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, jcd@tribudubois.net
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
 remove no longer needed IMX6Sabrelite

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: peter.maydell@linaro.org
CC: qemu-arm@nongnu.org
CC: jcd@tribudubois.net
---
 hw/arm/sabrelite.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 96cc455..e31694b 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -19,11 +19,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
=20
-typedef struct IMX6Sabrelite {
-    FslIMX6State soc;
-    MemoryRegion ram;
-} IMX6Sabrelite;
-
 static struct arm_boot_info sabrelite_binfo =3D {
     /* DDR memory start */
     .loader_start =3D FSL_IMX6_MMDC_ADDR,
@@ -45,7 +40,7 @@ static void sabrelite_reset_secondary(ARMCPU *cpu,
=20
 static void sabrelite_init(MachineState *machine)
 {
-    IMX6Sabrelite *s =3D g_new0(IMX6Sabrelite, 1);
+    FslIMX6State *s;
     Error *err =3D NULL;
=20
     /* Check the amount of memory is compatible with the SOC */
@@ -55,19 +50,16 @@ static void sabrelite_init(MachineState *machine)
         exit(1);
     }
=20
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc=
),
-                            TYPE_FSL_IMX6, &error_abort, NULL);
-
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &err);
+    s =3D FSL_IMX6(object_new(TYPE_FSL_IMX6));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_fa=
tal);
+    object_property_set_bool(OBJECT(s), true, "realized", &err);
     if (err !=3D NULL) {
         error_report("%s", error_get_pretty(err));
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "sabrelite.ram",
-                                         machine->ram_size);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
-                                &s->ram);
+                                machine->ram);
=20
     {
         /*
@@ -78,7 +70,7 @@ static void sabrelite_init(MachineState *machine)
         /* Add the sst25vf016b NOR FLASH memory to first SPI */
         Object *spi_dev;
=20
-        spi_dev =3D object_resolve_path_component(OBJECT(&s->soc), "spi1")=
;
+        spi_dev =3D object_resolve_path_component(OBJECT(s), "spi1");
         if (spi_dev) {
             SSIBus *spi_bus;
=20
@@ -109,7 +101,7 @@ static void sabrelite_init(MachineState *machine)
     sabrelite_binfo.secondary_cpu_reset_hook =3D sabrelite_reset_secondary=
;
=20
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
+        arm_load_kernel(&s->cpu[0], machine, &sabrelite_binfo);
     }
 }
=20
@@ -119,6 +111,7 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->init =3D sabrelite_init;
     mc->max_cpus =3D FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_ram_id =3D "sabrelite.ram";
 }
=20
 DEFINE_MACHINE("sabrelite", sabrelite_machine_init)
--=20
2.7.4


