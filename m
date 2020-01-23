Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B7CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA0921569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXmcs8Gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA0921569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubCW-0005g6-S0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuas2-0005pt-9S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuas0-0004Lj-SR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuas0-0004Ld-OO
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81F1Cwx0a351ptOijvSAE2EQnlOayMHUb+jlSf6z2DU=;
 b=SXmcs8GhojVQgvh6GEYsI2oxOU6vM76oTfFx+vZn23Q6E9n5/cVe9jlGmslchbI81inQza
 dmhGhwuH/staS5YFpXk8t6ncrcv0qgcVpqcIDD1kkeFKJg4ermC2ZKpnBQCTTAoHnbL96X
 jJzWaKqpQ/1lmeI/fcz7jq53VKQbIqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-FwCyJRsWP9OGWYWsZLe8cQ-1; Thu, 23 Jan 2020 06:41:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F0821800D48;
 Thu, 23 Jan 2020 11:41:51 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC7A710016E8;
 Thu, 23 Jan 2020 11:41:47 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 23/80] arm/nseries: use memdev for RAM
Date: Thu, 23 Jan 2020 12:37:48 +0100
Message-Id: <1579779525-20065-24-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: FwCyJRsWP9OGWYWsZLe8cQ-1
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
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  * fix format string causing build failure on 32-bit host
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)

CC: drjones@redhat.com
CC: balrogg@gmail.com
CC: peter.maydell@linaro.org
CC: qemu-arm@nongnu.org
---
 hw/arm/nseries.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 3fd196f..eae800b 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -47,7 +47,6 @@
=20
 /* Nokia N8x0 support */
 struct n800_s {
-    MemoryRegion sdram;
     struct omap_mpu_state_s *mpu;
=20
     struct rfbi_chip_s blizzard;
@@ -1311,13 +1310,19 @@ static void n8x0_init(MachineState *machine,
                       struct arm_boot_info *binfo, int model)
 {
     struct n800_s *s =3D (struct n800_s *) g_malloc0(sizeof(*s));
-    uint64_t sdram_size =3D binfo->ram_size;
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
=20
-    memory_region_allocate_system_memory(&s->sdram, NULL, "omap2.dram",
-                                         sdram_size);
-    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE, &s->sd=
ram);
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        char *sz =3D size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
+                                machine->ram);
=20
-    s->mpu =3D omap2420_mpu_init(&s->sdram, machine->cpu_type);
+    s->mpu =3D omap2420_mpu_init(machine->ram, machine->cpu_type);
=20
     /* Setup peripherals
      *
@@ -1383,9 +1388,8 @@ static void n8x0_init(MachineState *machine,
          *
          * The code above is for loading the `zImage' file from Nokia
          * images.  */
-        load_image_targphys(option_rom[0].name,
-                            OMAP2_Q2_BASE + 0x400000,
-                            sdram_size - 0x400000);
+        load_image_targphys(option_rom[0].name, OMAP2_Q2_BASE + 0x400000,
+                            machine->ram_size - 0x400000);
=20
         n800_setup_nolo_tags(nolo_tags);
         cpu_physical_memory_write(OMAP2_SRAM_BASE, nolo_tags, 0x10000);
@@ -1395,16 +1399,12 @@ static void n8x0_init(MachineState *machine,
=20
 static struct arm_boot_info n800_binfo =3D {
     .loader_start =3D OMAP2_Q2_BASE,
-    /* Actually two chips of 0x4000000 bytes each */
-    .ram_size =3D 0x08000000,
     .board_id =3D 0x4f7,
     .atag_board =3D n800_atag_setup,
 };
=20
 static struct arm_boot_info n810_binfo =3D {
     .loader_start =3D OMAP2_Q2_BASE,
-    /* Actually two chips of 0x4000000 bytes each */
-    .ram_size =3D 0x08000000,
     /* 0x60c and 0x6bf (WiMAX Edition) have been assigned but are not
      * used by some older versions of the bootloader and 5555 is used
      * instead (including versions that shipped with many devices).  */
@@ -1431,6 +1431,9 @@ static void n800_class_init(ObjectClass *oc, void *da=
ta)
     mc->default_boot_order =3D "";
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm1136-r2");
+    /* Actually two chips of 0x4000000 bytes each */
+    mc->default_ram_size =3D 0x08000000;
+    mc->default_ram_id =3D "omap2.dram";
 }
=20
 static const TypeInfo n800_type =3D {
@@ -1448,6 +1451,9 @@ static void n810_class_init(ObjectClass *oc, void *da=
ta)
     mc->default_boot_order =3D "";
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm1136-r2");
+    /* Actually two chips of 0x4000000 bytes each */
+    mc->default_ram_size =3D 0x08000000;
+    mc->default_ram_id =3D "omap2.dram";
 }
=20
 static const TypeInfo n810_type =3D {
--=20
2.7.4


