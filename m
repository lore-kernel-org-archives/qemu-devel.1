Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15618C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D788B207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Upm3uhBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D788B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3keG-0003Yf-1C
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJU-0002mg-0E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJR-0002JK-Tk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJR-0002J8-Pj
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfDrulq357FrWbeD12TUj99TtuCapOUvAuZPqemU0p8=;
 b=Upm3uhBxfRjRAhLLVi0bQRHHirJ9+qyimsoPIfcV5byCF0PNYreb+drWlSEhLaBg9g4WYx
 2ojnhlRyNjoMH3Rn+3Gt+pfutvzhBn91Drg2PeeIo1Rkf+ov7p3MTbDz/UmaIYVX36HUe9
 eFdwIcwv5+Zam5brvCaelBt4EIKiGlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-UsKsvr47Nx2Zx6GT04gl7g-1; Mon, 17 Feb 2020 12:36:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF7DE107ACC9;
 Mon, 17 Feb 2020 17:36:02 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F2F690508;
 Mon, 17 Feb 2020 17:36:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 45/79] lm32/milkymist: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:18 -0500
Message-Id: <20200217173452.15243-46-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UsKsvr47Nx2Zx6GT04gl7g-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, michael@walle.cc
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2:
  * fix format string causing build failure on 32-bit host
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
v3:
  * use size_to_str() to pretty print size in MiB
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)

CC: michael@walle.cc
---
 hw/lm32/milkymist.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 6d46134232..5c72266e58 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -36,6 +36,7 @@
 #include "hw/display/milkymist_tmu2.h"
 #include "lm32.h"
 #include "exec/address-spaces.h"
+#include "qemu/cutils.h"
=20
 #define BIOS_FILENAME    "mmone-bios.bin"
 #define BIOS_OFFSET      0x00860000
@@ -82,6 +83,7 @@ static void main_cpu_reset(void *opaque)
 static void
 milkymist_init(MachineState *machine)
 {
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -90,22 +92,27 @@ milkymist_init(MachineState *machine)
     int kernel_size;
     DriveInfo *dinfo;
     MemoryRegion *address_space_mem =3D get_system_memory();
-    MemoryRegion *phys_sdram =3D g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     int i;
     char *bios_filename;
     ResetInfo *reset_info;
=20
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        char *sz =3D size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     /* memory map */
     hwaddr flash_base   =3D 0x00000000;
     size_t flash_sector_size        =3D 128 * KiB;
     size_t flash_size               =3D 32 * MiB;
     hwaddr sdram_base   =3D 0x40000000;
-    size_t sdram_size               =3D 128 * MiB;
=20
     hwaddr initrd_base  =3D sdram_base + 0x1002000;
     hwaddr cmdline_base =3D sdram_base + 0x1000000;
-    size_t initrd_max =3D sdram_size - 0x1002000;
+    size_t initrd_max =3D machine->ram_size - 0x1002000;
=20
     reset_info =3D g_malloc0(sizeof(ResetInfo));
=20
@@ -116,9 +123,7 @@ milkymist_init(MachineState *machine)
=20
     cpu_lm32_set_phys_msb_ignore(env, 1);
=20
-    memory_region_allocate_system_memory(phys_sdram, NULL, "milkymist.sdra=
m",
-                                         sdram_size);
-    memory_region_add_subregion(address_space_mem, sdram_base, phys_sdram)=
;
+    memory_region_add_subregion(address_space_mem, sdram_base, machine->ra=
m);
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     /* Numonyx JS28F256J3F105 */
@@ -183,7 +188,7 @@ milkymist_init(MachineState *machine)
=20
         if (kernel_size < 0) {
             kernel_size =3D load_image_targphys(kernel_filename, sdram_bas=
e,
-                                              sdram_size);
+                                              machine->ram_size);
             reset_info->bootstrap_pc =3D sdram_base;
         }
=20
@@ -216,6 +221,8 @@ static void milkymist_machine_init(MachineClass *mc)
     mc->init =3D milkymist_init;
     mc->is_default =3D 0;
     mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
+    mc->default_ram_size =3D 128 * MiB;
+    mc->default_ram_id =3D "milkymist.sdram";
 }
=20
 DEFINE_MACHINE("milkymist", milkymist_machine_init)
--=20
2.18.1


