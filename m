Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CB1C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BBC207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgODzL0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BBC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kmO-0001DT-3Q
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJi-0003K2-49
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJh-0002Vf-0k
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59153
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJg-0002VK-St
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYXuDbjJcUSvNaDuoVXNHT9Sh856w+KlNFUz7bVm8lU=;
 b=OgODzL0OnOjjn3DaUj79BPwvplfU6zGg6vZ8byjJr16M4p38y5zFkNlPB7Nof3IUqbhq2f
 KcIirTzn8vrn2C8jNuUgaaAiB4JhZ8/2HzAFf51ZmUMi/tfih+HTJi8/QcgTsC7PGngBiW
 E0FMoxUjNlndafye6wzYtGf4q0EEZf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-EohZX9F3Mu-Alzl8Xx0u9w-1; Mon, 17 Feb 2020 12:36:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0BAC800D55
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:36:17 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B1E18CCE0;
 Mon, 17 Feb 2020 17:36:17 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 57/79] mips/mips_r4k: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:30 -0500
Message-Id: <20200217173452.15243-58-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EohZX9F3Mu-Alzl8Xx0u9w-1
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_r4k.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index b2aec434c3..258cd91578 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -171,13 +171,11 @@ static const int sector_len =3D 32 * KiB;
 static
 void mips_r4k_init(MachineState *machine)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
     char *filename;
     MemoryRegion *address_space_mem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *bios;
     MemoryRegion *iomem =3D g_new(MemoryRegion, 1);
     MemoryRegion *isa_io =3D g_new(MemoryRegion, 1);
@@ -203,14 +201,12 @@ void mips_r4k_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
=20
     /* allocate RAM */
-    if (ram_size > 256 * MiB) {
+    if (machine->ram_size > 256 * MiB) {
         error_report("Too much memory for this machine: %" PRId64 "MB,"
                      " maximum 256MB", ram_size / MiB);
         exit(1);
     }
-    memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram", ram_si=
ze);
-
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
=20
     memory_region_init_io(iomem, NULL, &mips_qemu_ops,
                           NULL, "mips-qemu", 0x10000);
@@ -261,7 +257,7 @@ void mips_r4k_init(MachineState *machine)
     g_free(filename);
=20
     if (kernel_filename) {
-        loaderparams.ram_size =3D ram_size;
+        loaderparams.ram_size =3D machine->ram_size;
         loaderparams.kernel_filename =3D kernel_filename;
         loaderparams.kernel_cmdline =3D kernel_cmdline;
         loaderparams.initrd_filename =3D initrd_filename;
@@ -316,7 +312,7 @@ static void mips_machine_init(MachineClass *mc)
 #else
     mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
 #endif
-
+    mc->default_ram_id =3D "mips_r4k.ram";
 }
=20
 DEFINE_MACHINE("mips", mips_machine_init)
--=20
2.18.1


