Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3BAC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C4C2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1ioDVyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C4C2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SEV-0007Of-Ne
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Rw3-0003bQ-Er
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Rw2-0000xK-8W
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49710
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Rw2-0000x4-4n
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32BMJKwaYxafOfAN+FgE+RFa+iq6cQhkJLHriZ08PUI=;
 b=c1ioDVyVOpyQ+RGP9DgB3wxfeelSiQjgBs8kwX8gt2lGUZjV75oLPkSXDuGSWvlWP2wcQ0
 DMY1lT1Pofz+4sRKWON2Fa8C6gVb16DOfObsVFxd0aal5ohfbN2kx4fWQ1QWX4FDZvxBjO
 nW5D4UOth5HCiDlKkCEpbhkXn6CWMA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-36hcEa3eOlCqqAswoC3z_w-1; Wed, 19 Feb 2020 11:10:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56FFE9B3C3;
 Wed, 19 Feb 2020 16:10:45 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3F5F48;
 Wed, 19 Feb 2020 16:10:43 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 42/79] x86/microvm: use memdev for RAM
Date: Wed, 19 Feb 2020 11:09:16 -0500
Message-Id: <20200219160953.13771-43-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 36hcEa3eOlCqqAswoC3z_w-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, ehabkost@redhat.com,
 slp@redhat.com, mst@redhat.com
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
CC: slp@redhat.com
CC: pbonzini@redhat.com
CC: mst@redhat.com
CC: rth@twiddle.net
CC: ehabkost@redhat.com
---
 hw/i386/microvm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d23485108d..38d8e51703 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -167,7 +167,7 @@ static void microvm_memory_init(MicrovmMachineState *mm=
s)
 {
     MachineState *machine =3D MACHINE(mms);
     X86MachineState *x86ms =3D X86_MACHINE(mms);
-    MemoryRegion *ram, *ram_below_4g, *ram_above_4g;
+    MemoryRegion *ram_below_4g, *ram_above_4g;
     MemoryRegion *system_memory =3D get_system_memory();
     FWCfgState *fw_cfg;
     ram_addr_t lowmem;
@@ -214,12 +214,8 @@ static void microvm_memory_init(MicrovmMachineState *m=
ms)
         x86ms->below_4g_mem_size =3D machine->ram_size;
     }
=20
-    ram =3D g_malloc(sizeof(*ram));
-    memory_region_allocate_system_memory(ram, NULL, "microvm.ram",
-                                         machine->ram_size);
-
     ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
-    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
+    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->=
ram,
                              0, x86ms->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
=20
@@ -227,7 +223,8 @@ static void microvm_memory_init(MicrovmMachineState *mm=
s)
=20
     if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
-        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
+        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
+                                 machine->ram,
                                  x86ms->below_4g_mem_size,
                                  x86ms->above_4g_mem_size);
         memory_region_add_subregion(system_memory, 0x100000000ULL,
@@ -502,6 +499,7 @@ static void microvm_class_init(ObjectClass *oc, void *d=
ata)
     mc->auto_enable_numa_with_memhp =3D false;
     mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported =3D false;
+    mc->default_ram_id =3D "microvm.ram";
=20
     /* Avoid relying too much on kernel components */
     mc->default_kernel_irqchip_split =3D true;
--=20
2.18.1


