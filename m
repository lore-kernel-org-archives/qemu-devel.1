Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3794FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C43206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLnWHUB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C43206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHm6-0002vT-Cg
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCX-0005re-1Y
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCS-0004Ie-Id
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27841
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCR-0004GC-Uo
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFQ4xBmnEBht7XvkseDuNIY2IDkul95ZAGH47gI0iJY=;
 b=gLnWHUB5xO9jLG+hBvCm3AulfW3M/Bx+0CpLxdQybfecSoS65200X8La4TCFYmSo3irIbM
 JH1w6FL532L2755zgpbyhSlUKh5H2532aV4ImYA0Jn/Tl2rzXsNWokp13Jw0iWm6fvksub
 e4FgTWOQZXBuhetlcXn9rwR5JYJ8fyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-D9nzNTQpOJuPqEwSUUVERg-1; Tue, 31 Dec 2019 08:04:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87C66477
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:36 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F844620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:35 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 58/86] mips:mips_r4k: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:42 +0100
Message-Id: <1577797450-88458-59-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: D9nzNTQpOJuPqEwSUUVERg-1
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
 hw/mips/mips_r4k.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index fd926a3..69b6549 100644
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
2.7.4


