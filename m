Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECFC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91C72187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7jEuv8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91C72187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlAu-0001Af-B3
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkKv-0000jJ-Go
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkKt-0000Mo-SS
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31249
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkKt-0000Md-Ob
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YoRguV9oBEiDRJrrjRVQKlmZhFrMyoc8aSv0o/pGs+A=;
 b=Q7jEuv8aCf4jWvOv3xfYYViKLFD5DXruOyTrrwQ7soMWmqicLBuiulhEeB6bJRmbc9HCDB
 59jKz0/bREj7/Mi1PxI/AUOualMqT99kUBFnydiYnKR3NwQ8EPqFOvRkR1fQjMqWOukKgV
 VvCw0U/e+QY4IMcZdbma2q9ETj7S0OQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-vEgngxlgNLOaU8qJ1tRa0Q-1; Wed, 15 Jan 2020 10:11:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E2C4969FD;
 Wed, 15 Jan 2020 15:11:57 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37FD119757;
 Wed, 15 Jan 2020 15:11:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 64/86] ppc:ppc405_boards: add RAM size checks
Date: Wed, 15 Jan 2020 16:07:19 +0100
Message-Id: <1579100861-73692-65-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: vEgngxlgNLOaU8qJ1tRa0Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If user provided non-sense RAM size, board will ignore it
and continue running with fixed RAM size.

Also RAM is going to be allocated by generic code, so it
won't be possible for board to fix CLI.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

PS:
move fixed RAM size into mc->default_ram_size, so that
generic code will know how much to allocate.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  * fix format string causing build failure on 32-bit host
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)

CC: david@gibson.dropbear.id.au
CC: qemu-ppc@nongnu.org
---
 hw/ppc/ppc405_boards.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 1f721fe..a7a432d 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -137,7 +137,7 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem, ui=
nt32_t base)
=20
 static void ref405ep_init(MachineState *machine)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -161,15 +161,20 @@ static void ref405ep_init(MachineState *machine)
     DriveInfo *dinfo;
     MemoryRegion *sysmem =3D get_system_memory();
=20
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        error_report("Invalid RAM size, should be " RAM_ADDR_UFMT " Bytes"=
,
+                     mc->default_ram_size);
+        exit(EXIT_FAILURE);
+    }
+
     /* XXX: fix this */
     memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405ep.=
ram",
-                                         0x08000000);
+                                         machine->ram_size);
     ram_bases[0] =3D 0;
-    ram_sizes[0] =3D 0x08000000;
+    ram_sizes[0] =3D machine->ram_size;
     memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
     ram_bases[1] =3D 0x00000000;
     ram_sizes[1] =3D 0x00000000;
-    ram_size =3D 128 * MiB;
     env =3D ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
                         33333333, &pic, kernel_filename =3D=3D NULL ? 0 : =
1);
     /* allocate SRAM */
@@ -227,7 +232,7 @@ static void ref405ep_init(MachineState *machine)
     if (linux_boot) {
         memset(&bd, 0, sizeof(bd));
         bd.bi_memstart =3D 0x00000000;
-        bd.bi_memsize =3D ram_size;
+        bd.bi_memsize =3D machine->ram_size;
         bd.bi_flashstart =3D -bios_size;
         bd.bi_flashsize =3D -bios_size;
         bd.bi_flashoffset =3D 0;
@@ -255,7 +260,7 @@ static void ref405ep_init(MachineState *machine)
         kernel_base =3D KERNEL_LOAD_ADDR;
         /* now we can load the kernel */
         kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
-                                          ram_size - kernel_base);
+                                          machine->ram_size - kernel_base)=
;
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
@@ -266,7 +271,7 @@ static void ref405ep_init(MachineState *machine)
         if (initrd_filename) {
             initrd_base =3D INITRD_LOAD_ADDR;
             initrd_size =3D load_image_targphys(initrd_filename, initrd_ba=
se,
-                                              ram_size - initrd_base);
+                                              machine->ram_size - initrd_b=
ase);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -304,6 +309,7 @@ static void ref405ep_class_init(ObjectClass *oc, void *=
data)
=20
     mc->desc =3D "ref405ep";
     mc->init =3D ref405ep_init;
+    mc->default_ram_size =3D 0x08000000;
 }
=20
 static const TypeInfo ref405ep_type =3D {
@@ -408,7 +414,7 @@ static void taihu_cpld_init(MemoryRegion *sysmem, uint3=
2_t base)
=20
 static void taihu_405ep_init(MachineState *machine)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const char *kernel_filename =3D machine->kernel_filename;
     const char *initrd_filename =3D machine->initrd_filename;
     char *filename;
@@ -425,10 +431,13 @@ static void taihu_405ep_init(MachineState *machine)
     int fl_idx;
     DriveInfo *dinfo;
=20
-    /* RAM is soldered to the board so the size cannot be changed */
-    ram_size =3D 0x08000000;
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        error_report("Invalid RAM size, should be " RAM_ADDR_UFMT " Bytes"=
,
+                     mc->default_ram_size);
+        exit(EXIT_FAILURE);
+    }
     memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
-                                         ram_size);
+                                         machine->ram_size);
=20
     ram_bases[0] =3D 0;
     ram_sizes[0] =3D 0x04000000;
@@ -500,7 +509,7 @@ static void taihu_405ep_init(MachineState *machine)
         kernel_base =3D KERNEL_LOAD_ADDR;
         /* now we can load the kernel */
         kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
-                                          ram_size - kernel_base);
+                                          machine->ram_size - kernel_base)=
;
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
@@ -509,7 +518,7 @@ static void taihu_405ep_init(MachineState *machine)
         if (initrd_filename) {
             initrd_base =3D INITRD_LOAD_ADDR;
             initrd_size =3D load_image_targphys(initrd_filename, initrd_ba=
se,
-                                              ram_size - initrd_base);
+                                              machine->ram_size - initrd_b=
ase);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -533,6 +542,7 @@ static void taihu_class_init(ObjectClass *oc, void *dat=
a)
=20
     mc->desc =3D "taihu";
     mc->init =3D taihu_405ep_init;
+    mc->default_ram_size =3D 0x08000000;
 }
=20
 static const TypeInfo taihu_type =3D {
--=20
2.7.4


