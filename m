Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8195C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73341206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dS6IK9Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73341206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHuc-0005WV-6i
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCd-00064E-Jd
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCc-0004mA-0Q
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42148
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCb-0004iE-Nf
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIXg3gtxgKYpM9gfSOJZn7379xm7KeZ2nseujTyVB/U=;
 b=dS6IK9PlKj70tHa1jemJwJMjfNrHL6igMHGI8zgVoCA7t1o6ZOz7eL5bngVC21VEEBn9nq
 9DZ8wPFBSni2NeFlh8Ejs5lSsN7d9748YDZRlkVoJSwFITfxrvsCt57gjJ6vQ2te6csAMy
 2j0pVK9NsLzjZuTlW0A/hJMyJ79FYmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-kA90dABRPMeLAuWtsyd71Q-1; Tue, 31 Dec 2019 08:04:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9DBC800D48
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:46 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60747620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:46 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 71/86] ppc:virtex_ml507: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:55 +0100
Message-Id: <1577797450-88458-72-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kA90dABRPMeLAuWtsyd71Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 hw/ppc/virtex_ml507.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 651d8db..b74a269 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -193,7 +193,6 @@ static int xilinx_load_device_tree(hwaddr addr,
=20
 static void virtex_init(MachineState *machine)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     hwaddr initrd_base =3D 0;
@@ -204,7 +203,6 @@ static void virtex_init(MachineState *machine)
     CPUPPCState *env;
     hwaddr ram_base =3D 0;
     DriveInfo *dinfo;
-    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
     qemu_irq irq[32], *cpu_irq;
     int kernel_size;
     int i;
@@ -221,8 +219,7 @@ static void virtex_init(MachineState *machine)
=20
     qemu_register_reset(main_cpu_reset, cpu);
=20
-    memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_size);
-    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
+    memory_region_add_subregion(address_space_mem, ram_base, machine->ram)=
;
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
@@ -265,7 +262,7 @@ static void virtex_init(MachineState *machine)
             /* If we failed loading ELF's try a raw image.  */
             kernel_size =3D load_image_targphys(kernel_filename,
                                               boot_offset,
-                                              ram_size);
+                                              machine->ram_size);
             boot_info.bootstrap_pc =3D boot_offset;
             high =3D boot_info.bootstrap_pc + kernel_size + 8192;
         }
@@ -276,7 +273,7 @@ static void virtex_init(MachineState *machine)
         if (machine->initrd_filename) {
             initrd_base =3D high =3D ROUND_UP(high, 4);
             initrd_size =3D load_image_targphys(machine->initrd_filename,
-                                              high, ram_size - high);
+                                              high, machine->ram_size - hi=
gh);
=20
             if (initrd_size < 0) {
                 error_report("couldn't load ram disk '%s'",
@@ -290,7 +287,7 @@ static void virtex_init(MachineState *machine)
         boot_info.fdt =3D high + (8192 * 2);
         boot_info.fdt &=3D ~8191;
=20
-        xilinx_load_device_tree(boot_info.fdt, ram_size,
+        xilinx_load_device_tree(boot_info.fdt, machine->ram_size,
                                 initrd_base, initrd_size,
                                 kernel_cmdline);
     }
@@ -302,6 +299,7 @@ static void virtex_machine_init(MachineClass *mc)
     mc->desc =3D "Xilinx Virtex ML507 reference design";
     mc->init =3D virtex_init;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440-xilinx");
+    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
--=20
2.7.4


