Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D41BC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D192072B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVV+A+wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D192072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkvo-00067v-JW
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkL3-0000xx-I3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkL2-0000U7-2L
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkL1-0000TS-To
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Kqr9aiF31huc28DjhRc5tM0qbIUiRhH8yiBXgE9Y5Q=;
 b=HVV+A+wgDpJhAGnTbCThIVPcC7NBNIGfDx7GckJGGdL/j8OlZoedbzlg+BtpYbLo0gVdZF
 5wK4q45/eLmG0B2C/BRwYxW3dXrW/td+IizWsFoM/fuO14ZL5T/MikdMZHuioFimU7Q88w
 2z8N1CYYbdjcLF4hmBaxMqP8uxKSCIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-_FtGjCciOqiX7FYyBFxH3Q-1; Wed, 15 Jan 2020 10:12:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEEA311472AB;
 Wed, 15 Jan 2020 15:12:02 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A18E5196AE;
 Wed, 15 Jan 2020 15:12:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 68/86] ppc:prep: use memdev for RAM
Date: Wed, 15 Jan 2020 16:07:23 +0100
Message-Id: <1579100861-73692-69-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _FtGjCciOqiX7FYyBFxH3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-ppc@nongnu.org, hpoussin@reactos.org, david@gibson.dropbear.id.au
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: hpoussin@reactos.org
CC: david@gibson.dropbear.id.au
CC: qemu-ppc@nongnu.org
---
 hw/ppc/prep.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 862345c..bf75dde 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -400,7 +400,6 @@ static int PPC_NVRAM_set_params (Nvram *nvram, uint16_t=
 NVRAM_size,
 /* PowerPC PREP hardware initialisation */
 static void ppc_prep_init(MachineState *machine)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -413,7 +412,6 @@ static void ppc_prep_init(MachineState *machine)
     MemoryRegion *xcsr =3D g_new(MemoryRegion, 1);
 #endif
     int linux_boot, i, nb_nics1;
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     uint32_t kernel_base, initrd_base;
     long kernel_size, initrd_size;
     DeviceState *dev;
@@ -444,15 +442,14 @@ static void ppc_prep_init(MachineState *machine)
         qemu_register_reset(ppc_prep_reset, cpu);
     }
=20
-    /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "ppc_prep.ram", ram_si=
ze);
-    memory_region_add_subregion(sysmem, 0, ram);
+    /* map RAM */
+    memory_region_add_subregion(sysmem, 0, machine->ram);
=20
     if (linux_boot) {
         kernel_base =3D KERNEL_LOAD_ADDR;
         /* now we can load the kernel */
         kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
-                                          ram_size - kernel_base);
+                                          machine->ram_size - kernel_base)=
;
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
@@ -461,7 +458,7 @@ static void ppc_prep_init(MachineState *machine)
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
@@ -576,7 +573,7 @@ static void ppc_prep_init(MachineState *machine)
     sysctrl->nvram =3D m48t59;
=20
     /* Initialise NVRAM */
-    PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", ram_size,
+    PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", machine->ram_size,
                          ppc_boot_device,
                          kernel_base, kernel_size,
                          kernel_cmdline,
@@ -596,6 +593,7 @@ static void prep_machine_init(MachineClass *mc)
     mc->default_boot_order =3D "cad";
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("602");
     mc->default_display =3D "std";
+    mc->default_ram_id =3D "ppc_prep.ram";
 }
=20
 static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
@@ -814,6 +812,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->init =3D ibm_40p_init;
     mc->max_cpus =3D 1;
     mc->default_ram_size =3D 128 * MiB;
+    mc->default_ram_id =3D "ppc_prep.ram";
     mc->block_default_type =3D IF_SCSI;
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("604");
--=20
2.7.4


