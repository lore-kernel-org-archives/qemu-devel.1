Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E00CC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38343206E4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TA1PZ/VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38343206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHmy-0003ws-Sj
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCQ-0005oN-Pz
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCM-00049E-TI
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCL-00045M-TL
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Os8S5mWzKZZEK83G6W/iBkxGcYC8BSaNwcUNdu16YRM=;
 b=TA1PZ/VBWiJHzFXuQBvvuam/ldBHmYHexd/9K/NpWIJvVo3ozhGfq6O/vEQzMcUgsgxlgQ
 sVdMB5E27FHA+JWgUWjOeire3nS3yE33kmb6GMEmqD+4wp30Davx2AZVrIU1c/5Wy/O6BC
 SGdths/zkElZ3TyoC7fvp4LeceQznVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-efqOnJlwOf6ZB4LDwdkmOA-1; Tue, 31 Dec 2019 08:04:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7A5B10054E3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:27 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CDCD620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:27 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 47/86] lm32:lm32_boards: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:31 +0100
Message-Id: <1577797450-88458-48-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: efqOnJlwOf6ZB4LDwdkmOA-1
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
 hw/lm32/lm32_boards.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 5ae308b..0d3771b 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -75,22 +75,27 @@ static void main_cpu_reset(void *opaque)
=20
 static void lm32_evr_init(MachineState *machine)
 {
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const char *kernel_filename =3D machine->kernel_filename;
     LM32CPU *cpu;
     CPULM32State *env;
     DriveInfo *dinfo;
     MemoryRegion *address_space_mem =3D  get_system_memory();
-    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     ResetInfo *reset_info;
     int i;
=20
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
+                     mc->default_ram_size);
+        exit(EXIT_FAILURE);
+    }
+
     /* memory map */
     hwaddr flash_base  =3D 0x04000000;
     size_t flash_sector_size       =3D 256 * KiB;
     size_t flash_size              =3D 32 * MiB;
     hwaddr ram_base    =3D 0x08000000;
-    size_t ram_size                =3D 64 * MiB;
     hwaddr timer0_base =3D 0x80002000;
     hwaddr uart0_base  =3D 0x80006000;
     hwaddr timer1_base =3D 0x8000a000;
@@ -107,9 +112,7 @@ static void lm32_evr_init(MachineState *machine)
=20
     reset_info->flash_base =3D flash_base;
=20
-    memory_region_allocate_system_memory(phys_ram, NULL, "lm32_evr.sdram",
-                                         ram_size);
-    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
+    memory_region_add_subregion(address_space_mem, ram_base, machine->ram)=
;
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     /* Spansion S29NS128P */
@@ -144,7 +147,7 @@ static void lm32_evr_init(MachineState *machine)
=20
         if (kernel_size < 0) {
             kernel_size =3D load_image_targphys(kernel_filename, ram_base,
-                                              ram_size);
+                                              machine->ram_size);
             reset_info->bootstrap_pc =3D ram_base;
         }
=20
@@ -159,6 +162,7 @@ static void lm32_evr_init(MachineState *machine)
=20
 static void lm32_uclinux_init(MachineState *machine)
 {
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -166,18 +170,22 @@ static void lm32_uclinux_init(MachineState *machine)
     CPULM32State *env;
     DriveInfo *dinfo;
     MemoryRegion *address_space_mem =3D  get_system_memory();
-    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     HWSetup *hw;
     ResetInfo *reset_info;
     int i;
=20
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
+                     mc->default_ram_size);
+        exit(EXIT_FAILURE);
+    }
+
     /* memory map */
     hwaddr flash_base   =3D 0x04000000;
     size_t flash_sector_size        =3D 256 * KiB;
     size_t flash_size               =3D 32 * MiB;
     hwaddr ram_base     =3D 0x08000000;
-    size_t ram_size                 =3D 64 * MiB;
     hwaddr uart0_base   =3D 0x80000000;
     hwaddr timer0_base  =3D 0x80002000;
     hwaddr timer1_base  =3D 0x80010000;
@@ -200,9 +208,7 @@ static void lm32_uclinux_init(MachineState *machine)
=20
     reset_info->flash_base =3D flash_base;
=20
-    memory_region_allocate_system_memory(phys_ram, NULL,
-                                         "lm32_uclinux.sdram", ram_size);
-    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
+    memory_region_add_subregion(address_space_mem, ram_base, machine->ram)=
;
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     /* Spansion S29NS128P */
@@ -238,7 +244,7 @@ static void lm32_uclinux_init(MachineState *machine)
=20
         if (kernel_size < 0) {
             kernel_size =3D load_image_targphys(kernel_filename, ram_base,
-                                              ram_size);
+                                              machine->ram_size);
             reset_info->bootstrap_pc =3D ram_base;
         }
=20
@@ -252,7 +258,7 @@ static void lm32_uclinux_init(MachineState *machine)
     hw =3D hwsetup_init();
     hwsetup_add_cpu(hw, "LM32", 75000000);
     hwsetup_add_flash(hw, "flash", flash_base, flash_size);
-    hwsetup_add_ddr_sdram(hw, "ddr_sdram", ram_base, ram_size);
+    hwsetup_add_ddr_sdram(hw, "ddr_sdram", ram_base, machine->ram_size);
     hwsetup_add_timer(hw, "timer0", timer0_base, timer0_irq);
     hwsetup_add_timer(hw, "timer1_dev_only", timer1_base, timer1_irq);
     hwsetup_add_timer(hw, "timer2_dev_only", timer2_base, timer2_irq);
@@ -288,6 +294,8 @@ static void lm32_evr_class_init(ObjectClass *oc, void *=
data)
     mc->init =3D lm32_evr_init;
     mc->is_default =3D 1;
     mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
+    mc->default_ram_size =3D 64 * MiB;
+    mc->default_ram_id =3D "lm32_evr.sdram";
 }
=20
 static const TypeInfo lm32_evr_type =3D {
@@ -304,6 +312,8 @@ static void lm32_uclinux_class_init(ObjectClass *oc, vo=
id *data)
     mc->init =3D lm32_uclinux_init;
     mc->is_default =3D 0;
     mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
+    mc->default_ram_size =3D 64 * MiB;
+    mc->default_ram_id =3D "lm32_uclinux.sdram";
 }
=20
 static const TypeInfo lm32_uclinux_type =3D {
--=20
2.7.4


