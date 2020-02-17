Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2830C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7064C20725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/jm+pCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7064C20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kRN-0003af-Jr
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kIx-0001n2-6a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kIv-00020D-Va
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23869
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kIv-0001zw-RU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63OWUwwf6dM9OPd3iFItHyW7Aybp3monauZEOO0p+UI=;
 b=h/jm+pClU5cIvEdORKkvebLLPiHmA5PYtWINImVkx3FoJB/wFJ154mMlg11gOcHYsauNK2
 YPY2eL1LLqsSEGAjDn6GYJ4fpRQHjArIaJedHar//2JJRDYUve2dIjjEUEoJSDrQ1c30kx
 Bzrag/jPAQi/RKpub2ttO/IbORyd6CM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-wwkQ-sfYNH2UqwzUxzriWA-1; Mon, 17 Feb 2020 12:35:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE5CA18FE861
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:35:30 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0798890508;
 Mon, 17 Feb 2020 17:35:29 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 26/79] arm/omap_sx1: use memdev for RAM
Date: Mon, 17 Feb 2020 12:33:59 -0500
Message-Id: <20200217173452.15243-27-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wwkQ-sfYNH2UqwzUxzriWA-1
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
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
v2:
  * fix format string causing build failure on 32-bit host
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
---
 hw/arm/omap_sx1.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index be245714db..2bebab4171 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -35,6 +35,7 @@
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
+#include "qemu/cutils.h"
=20
 /*************************************************************************=
****/
 /* Siemens SX1 Cellphone V1 */
@@ -102,8 +103,8 @@ static struct arm_boot_info sx1_binfo =3D {
 static void sx1_init(MachineState *machine, const int version)
 {
     struct omap_mpu_state_s *mpu;
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     MemoryRegion *address_space =3D get_system_memory();
-    MemoryRegion *dram =3D g_new(MemoryRegion, 1);
     MemoryRegion *flash =3D g_new(MemoryRegion, 1);
     MemoryRegion *cs =3D g_new(MemoryRegion, 4);
     static uint32_t cs0val =3D 0x00213090;
@@ -115,15 +116,20 @@ static void sx1_init(MachineState *machine, const int=
 version)
     uint32_t flash_size =3D flash0_size;
     int be;
=20
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        char *sz =3D size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     if (version =3D=3D 2) {
         flash_size =3D flash2_size;
     }
=20
-    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
-                                         sx1_binfo.ram_size);
-    memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, dram);
+    memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, machine->r=
am);
=20
-    mpu =3D omap310_mpu_init(dram, machine->cpu_type);
+    mpu =3D omap310_mpu_init(machine->ram, machine->cpu_type);
=20
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
@@ -223,6 +229,8 @@ static void sx1_machine_v2_class_init(ObjectClass *oc, =
void *data)
     mc->init =3D sx1_init_v2;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
+    mc->default_ram_size =3D sdram_size;
+    mc->default_ram_id =3D "omap1.dram";
 }
=20
 static const TypeInfo sx1_machine_v2_type =3D {
@@ -239,6 +247,8 @@ static void sx1_machine_v1_class_init(ObjectClass *oc, =
void *data)
     mc->init =3D sx1_init_v1;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
+    mc->default_ram_size =3D sdram_size;
+    mc->default_ram_id =3D "omap1.dram";
 }
=20
 static const TypeInfo sx1_machine_v1_type =3D {
--=20
2.18.1


