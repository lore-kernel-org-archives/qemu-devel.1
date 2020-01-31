Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA077C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF9520707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ek0G5aXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF9520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYL4-0001AD-MK
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 10:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ixXyQ-0004Th-Bp
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ixXyP-0004C8-2Q
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:12:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ixXyN-00049q-50
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580483562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OW5z769Am4PJUq+bHDGqLzjSwCC5/5tmAvDgDY/KoUY=;
 b=ek0G5aXyYRtBNWX3/h/V++Njj8FEtLtZL2efUsVaYyWw1RQLfiF+i+AKnsGLim+llML2iq
 X/qR+kXdgioaEJP5yI5+BFgaiYa0IYkPv8S8tRyLH934WiGTqhPT/uHjdwooTGQu8ahm82
 FHVE29J05IxnJA0hr7rzbpT7K+Ib0rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-pooFq6VfPLCx4Rao-wsC9g-1; Fri, 31 Jan 2020 10:12:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2084D107B0EF;
 Fri, 31 Jan 2020 15:12:39 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 745D686C4B;
 Fri, 31 Jan 2020 15:12:38 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 27/80] arm/palm: use memdev for RAM
Date: Fri, 31 Jan 2020 16:08:57 +0100
Message-Id: <1580483390-131164-28-git-send-email-imammedo@redhat.com>
In-Reply-To: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: pooFq6VfPLCx4Rao-wsC9g-1
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

CC: balrogg@gmail.com
---
 hw/arm/palm.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 72eca8c..388b262 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -31,6 +31,7 @@
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
+#include "qemu/cutils.h"
=20
 static uint64_t static_read(void *opaque, hwaddr offset, unsigned size)
 {
@@ -181,7 +182,6 @@ static void palmte_gpio_setup(struct omap_mpu_state_s *=
cpu)
=20
 static struct arm_boot_info palmte_binfo =3D {
     .loader_start =3D OMAP_EMIFF_BASE,
-    .ram_size =3D 0x02000000,
     .board_id =3D 0x331,
 };
=20
@@ -195,15 +195,21 @@ static void palmte_init(MachineState *machine)
     static uint32_t cs2val =3D 0x0000e1a0;
     static uint32_t cs3val =3D 0xe1a0e1a0;
     int rom_size, rom_loaded =3D 0;
-    MemoryRegion *dram =3D g_new(MemoryRegion, 1);
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     MemoryRegion *flash =3D g_new(MemoryRegion, 1);
     MemoryRegion *cs =3D g_new(MemoryRegion, 4);
=20
-    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
-                                         palmte_binfo.ram_size);
-    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE, dram);
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        char *sz =3D size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE,
+                                machine->ram);
=20
-    mpu =3D omap310_mpu_init(dram, machine->cpu_type);
+    mpu =3D omap310_mpu_init(machine->ram, machine->cpu_type);
=20
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
@@ -265,6 +271,8 @@ static void palmte_machine_init(MachineClass *mc)
     mc->init =3D palmte_init;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
+    mc->default_ram_size =3D 0x02000000;
+    mc->default_ram_id =3D "omap1.dram";
 }
=20
 DEFINE_MACHINE("cheetah", palmte_machine_init)
--=20
2.7.4


