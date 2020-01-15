Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD1DC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C4E2187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEFCFNj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C4E2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkxO-0000fH-MN
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkKb-00007F-A5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkKa-0000Dw-0C
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkKZ-0000Dk-Ss
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/enYbyHxk3Z12MMC45GqMAUDK5glkL5hLGowK9Sj5jI=;
 b=aEFCFNj09vJckP/Ag6c+4vKy7GZrp2b2PVAtHi6hAdyElBQzBmIT38nn5V/K40NzLqOCbY
 fvl9AjcaYZST5/k319ViK7inYZhXzppLrG3vxau4hFFpGxQfB6oOfpe0dV3n3mMpL7/Hvb
 4DdDsg+yA27b5JIw+iGtp17cgr+pHGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-c5vueoCVM_K29n5d48n7Zg-1; Wed, 15 Jan 2020 10:11:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9883A1135558;
 Wed, 15 Jan 2020 15:11:36 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC444196AE;
 Wed, 15 Jan 2020 15:11:35 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 48/86] lm32:milkymist: use memdev for RAM
Date: Wed, 15 Jan 2020 16:07:03 +0100
Message-Id: <1579100861-73692-49-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: c5vueoCVM_K29n5d48n7Zg-1
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
Cc: michael@walle.cc
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

CC: michael@walle.cc
---
 hw/lm32/milkymist.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 460d322..73c28f4 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -82,6 +82,7 @@ static void main_cpu_reset(void *opaque)
 static void
 milkymist_init(MachineState *machine)
 {
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -90,22 +91,26 @@ milkymist_init(MachineState *machine)
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
+        error_report("Invalid RAM size, should be " RAM_ADDR_UFMT " Bytes"=
,
+                     mc->default_ram_size);
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
@@ -116,9 +121,7 @@ milkymist_init(MachineState *machine)
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
@@ -183,7 +186,7 @@ milkymist_init(MachineState *machine)
=20
         if (kernel_size < 0) {
             kernel_size =3D load_image_targphys(kernel_filename, sdram_bas=
e,
-                                              sdram_size);
+                                              machine->ram_size);
             reset_info->bootstrap_pc =3D sdram_base;
         }
=20
@@ -216,6 +219,8 @@ static void milkymist_machine_init(MachineClass *mc)
     mc->init =3D milkymist_init;
     mc->is_default =3D 0;
     mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
+    mc->default_ram_size =3D 128 * MiB;
+    mc->default_ram_id =3D "milkymist.sdram";
 }
=20
 DEFINE_MACHINE("milkymist", milkymist_machine_init)
--=20
2.7.4


