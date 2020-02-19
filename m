Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E349C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A01020675
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul+5JCMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A01020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Rys-0000YZ-2e
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4RvU-0002Db-Hg
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4RvT-0000Y9-5e
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4RvT-0000Xy-19
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+zaD2IgVVkgyQgNB7cHMaNThnjhY5Zndgs/1n3SnwI=;
 b=Ul+5JCMDfzPVSb80BEztinM9+1LwEe4gtE5w2906h+3SbaQBO/wlleAGyDomrw1U+31if3
 3fZFvwk7knJluw9m7/sYXGwj5uvOr+NDCHX0sTGA8Ue751RiXkcEqTUOtrjk2xAmzxEgZg
 MmB5IymzWrbZTM8Yu5gEzH14h9gBi7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-VxIudnHgOeKbhXEC7R5w3Q-1; Wed, 19 Feb 2020 11:10:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D8A88E111C;
 Wed, 19 Feb 2020 16:10:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7246B48;
 Wed, 19 Feb 2020 16:10:10 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/79] arm/cubieboard: use memdev for RAM
Date: Wed, 19 Feb 2020 11:08:46 -0500
Message-Id: <20200219160953.13771-13-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VxIudnHgOeKbhXEC7R5w3Q-1
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
Cc: b.galvani@gmail.com, Paolo Bonzini <pbonzini@redhat.com>
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
While at it, get rid of no longer needed CubieBoardState wrapper.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
CC: b.galvani@gmail.com
---
 hw/arm/cubieboard.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 6dc2f1d6b6..089f9a30c1 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -28,52 +28,42 @@ static struct arm_boot_info cubieboard_binfo =3D {
     .board_id =3D 0x1008,
 };
=20
-typedef struct CubieBoardState {
-    AwA10State *a10;
-    MemoryRegion sdram;
-} CubieBoardState;
-
 static void cubieboard_init(MachineState *machine)
 {
-    CubieBoardState *s =3D g_new(CubieBoardState, 1);
+    AwA10State *a10 =3D AW_A10(object_new(TYPE_AW_A10));
     Error *err =3D NULL;
=20
-    s->a10 =3D AW_A10(object_new(TYPE_AW_A10));
-
-    object_property_set_int(OBJECT(&s->a10->emac), 1, "phy-addr", &err);
+    object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
     if (err !=3D NULL) {
         error_reportf_err(err, "Couldn't set phy address: ");
         exit(1);
     }
=20
-    object_property_set_int(OBJECT(&s->a10->timer), 32768, "clk0-freq", &e=
rr);
+    object_property_set_int(OBJECT(&a10->timer), 32768, "clk0-freq", &err)=
;
     if (err !=3D NULL) {
         error_reportf_err(err, "Couldn't set clk0 frequency: ");
         exit(1);
     }
=20
-    object_property_set_int(OBJECT(&s->a10->timer), 24000000, "clk1-freq",
-                            &err);
+    object_property_set_int(OBJECT(&a10->timer), 24000000, "clk1-freq", &e=
rr);
     if (err !=3D NULL) {
         error_reportf_err(err, "Couldn't set clk1 frequency: ");
         exit(1);
     }
=20
-    object_property_set_bool(OBJECT(s->a10), true, "realized", &err);
+    object_property_set_bool(OBJECT(a10), true, "realized", &err);
     if (err !=3D NULL) {
         error_reportf_err(err, "Couldn't realize Allwinner A10: ");
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(&s->sdram, NULL, "cubieboard.ram"=
,
-                                         machine->ram_size);
     memory_region_add_subregion(get_system_memory(), AW_A10_SDRAM_BASE,
-                                &s->sdram);
+                                machine->ram);
=20
     /* TODO create and connect IDE devices for ide_drive_get() */
=20
     cubieboard_binfo.ram_size =3D machine->ram_size;
-    arm_load_kernel(&s->a10->cpu, machine, &cubieboard_binfo);
+    arm_load_kernel(&a10->cpu, machine, &cubieboard_binfo);
 }
=20
 static void cubieboard_machine_init(MachineClass *mc)
@@ -84,6 +74,7 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->block_default_type =3D IF_IDE;
     mc->units_per_default_bus =3D 1;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_ram_id =3D "cubieboard.ram";
 }
=20
 DEFINE_MACHINE("cubieboard", cubieboard_machine_init)
--=20
2.18.1


