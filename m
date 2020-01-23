Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC330C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60CB2253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWgZ3BkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60CB2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubGq-0002YM-9M
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuas9-000645-OT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuas8-0004Pu-FO
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuas7-0004Pe-U6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiZvlZ1MdawhjZtdHcXJjV0fD5PvL8u6QTlQRmLYaxY=;
 b=PWgZ3BkRcuDggf+cysJsFp9zmAXfY1sXpZK8oJz70MnZgEmZl7k49EaL1iGBeD1n8pN2LJ
 Dyd20+x3bEE2hm3NV9WwI6ADgWR3728ARUJL3tRlzAloMBAg2QTvRK47f7OBDBSdQohbbj
 RQw9U1K3zNTwSRAbIi8R6aj90szWCE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-K1Q_s_-POXuOTL5vmuWAow-1; Thu, 23 Jan 2020 06:42:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA75218C8C1F;
 Thu, 23 Jan 2020 11:41:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3A971084198;
 Thu, 23 Jan 2020 11:41:54 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 26/80] arm/raspi: use memdev for RAM
Date: Thu, 23 Jan 2020 12:37:51 +0100
Message-Id: <1579779525-20065-27-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: K1Q_s_-POXuOTL5vmuWAow-1
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 Andrew.Baumann@microsoft.com
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
 remove no longer needed RasPiState

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
CC: Andrew.Baumann@microsoft.com
CC: philmd@redhat.com
CC: peter.maydell@linaro.org
CC: qemu-arm@nongnu.org
---
 hw/arm/raspi.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 6a510aa..33ace66 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -32,11 +32,6 @@
 /* Table of Linux board IDs for different Pi versions */
 static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43, [3] =
=3D 0xc44};
=20
-typedef struct RasPiState {
-    BCM283XState soc;
-    MemoryRegion ram;
-} RasPiState;
-
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] =3D {
@@ -166,7 +161,7 @@ static void setup_boot(MachineState *machine, int versi=
on, size_t ram_size)
=20
 static void raspi_init(MachineState *machine, int version)
 {
-    RasPiState *s =3D g_new0(RasPiState, 1);
+    Object *soc;
     uint32_t vcram_size;
     DriveInfo *di;
     BlockBackend *blk;
@@ -179,30 +174,26 @@ static void raspi_init(MachineState *machine, int ver=
sion)
         exit(1);
     }
=20
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc=
),
-                            version =3D=3D 3 ? TYPE_BCM2837 : TYPE_BCM2836=
,
-                            &error_abort, NULL);
+    soc =3D object_new(version =3D=3D 3 ? TYPE_BCM2837 : TYPE_BCM2836);
+    object_property_add_child(OBJECT(machine), "soc", soc, &error_fatal);
=20
-    /* Allocate and map RAM */
-    memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
-                                         machine->ram_size);
     /* FIXME: Remove when we have custom CPU address space support */
-    memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram, 0=
);
+    memory_region_add_subregion_overlap(get_system_memory(), 0,
+                                        machine->ram, 0);
=20
     /* Setup the SOC */
-    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram)=
,
+    object_property_add_const_link(soc, "ram", OBJECT(machine->ram),
                                    &error_abort);
-    object_property_set_int(OBJECT(&s->soc), machine->smp.cpus, "enabled-c=
pus",
+    object_property_set_int(soc, machine->smp.cpus, "enabled-cpus",
                             &error_abort);
     int board_rev =3D version =3D=3D 3 ? 0xa02082 : 0xa21041;
-    object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
-                            &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abo=
rt);
+    object_property_set_int(soc, board_rev, "board-rev", &error_abort);
+    object_property_set_bool(soc, true, "realized", &error_abort);
=20
     /* Create and plug in the SD cards */
     di =3D drive_get_next(IF_SD);
     blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
-    bus =3D qdev_get_child_bus(DEVICE(&s->soc), "sd-bus");
+    bus =3D qdev_get_child_bus(DEVICE(soc), "sd-bus");
     if (bus =3D=3D NULL) {
         error_report("No SD bus found in SOC object");
         exit(1);
@@ -211,8 +202,7 @@ static void raspi_init(MachineState *machine, int versi=
on)
     qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
     object_property_set_bool(OBJECT(carddev), true, "realized", &error_fat=
al);
=20
-    vcram_size =3D object_property_get_uint(OBJECT(&s->soc), "vcram-size",
-                                          &error_abort);
+    vcram_size =3D object_property_get_uint(soc, "vcram-size", &error_abor=
t);
     setup_boot(machine, version, machine->ram_size - vcram_size);
 }
=20
@@ -233,6 +223,7 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->min_cpus =3D BCM283X_NCPUS;
     mc->default_cpus =3D BCM283X_NCPUS;
     mc->default_ram_size =3D 1 * GiB;
+    mc->default_ram_id =3D "ram";
     mc->ignore_memory_transaction_failures =3D true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
@@ -255,6 +246,7 @@ static void raspi3_machine_init(MachineClass *mc)
     mc->min_cpus =3D BCM283X_NCPUS;
     mc->default_cpus =3D BCM283X_NCPUS;
     mc->default_ram_size =3D 1 * GiB;
+    mc->default_ram_id =3D "ram";
 }
 DEFINE_MACHINE("raspi3", raspi3_machine_init)
 #endif
--=20
2.7.4


