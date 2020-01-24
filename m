Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4262FC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E28A2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E28A2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv30K-0001OB-90
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv2x4-0003fZ-2k
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv2x2-0001hz-Sh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:41:02 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:38469 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iv2x2-0001hI-Km
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:41:00 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id A9B8D1A2126;
 Fri, 24 Jan 2020 18:40:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 7AF311A2152;
 Fri, 24 Jan 2020 18:40:55 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] mips/mips_mipssim: use memdev for RAM
Date: Fri, 24 Jan 2020 18:40:45 +0100
Message-Id: <1579887646-5949-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579887646-5949-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1579887646-5949-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1579779525-20065-56-git-send-email-imammedo@redhat.com>
---
 hw/mips/mips_mipssim.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 84c03dd..8df16d8 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -143,14 +143,12 @@ static void mipsnet_init(int base, qemu_irq irq, NI=
CInfo *nd)
 static void
 mips_mipssim_init(MachineState *machine)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
     char *filename;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *isa =3D g_new(MemoryRegion, 1);
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *bios =3D g_new(MemoryRegion, 1);
     MIPSCPU *cpu;
     CPUMIPSState *env;
@@ -167,13 +165,11 @@ mips_mipssim_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
=20
     /* Allocate RAM. */
-    memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
-                                         ram_size);
     memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(bios, true);
=20
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
=20
     /* Map the BIOS / boot exception handler. */
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
@@ -200,7 +196,7 @@ mips_mipssim_init(MachineState *machine)
     }
=20
     if (kernel_filename) {
-        loaderparams.ram_size =3D ram_size;
+        loaderparams.ram_size =3D machine->ram_size;
         loaderparams.kernel_filename =3D kernel_filename;
         loaderparams.kernel_cmdline =3D kernel_cmdline;
         loaderparams.initrd_filename =3D initrd_filename;
@@ -245,6 +241,7 @@ static void mips_mipssim_machine_init(MachineClass *m=
c)
 #else
     mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
 #endif
+    mc->default_ram_id =3D "mips_mipssim.ram";
 }
=20
 DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
--=20
2.7.4


