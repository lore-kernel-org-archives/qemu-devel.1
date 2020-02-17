Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B167C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5858320725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPxo0BJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5858320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kXI-0005y8-GC
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJP-0002bC-5D
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJO-0002HR-2K
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJN-0002H8-Uw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nyuoTEj0EQwddChvt7tHdaQd2fKsDMSQelB0wpdXkFM=;
 b=JPxo0BJHTM5tyY65dO79lgoS/rsxBdaaTXNUZyaA+gosSPgd/ogXSlbVs8Zwxsee3Ohgz6
 7rILVljtCaehGOpX0U2bz2c3H9ygoZfprlbnfnGoTf0tYSZktyvXtVRH3XhiQ2n7yC+dzy
 puD9k7+nb8hHdsU8ZiTSAzL3Okk/eRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-wZ4PrxKUPVybVug5elzGgA-1; Mon, 17 Feb 2020 12:35:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0D85800D50;
 Mon, 17 Feb 2020 17:35:57 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9233390533;
 Mon, 17 Feb 2020 17:35:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 43/79] x86/pc: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:16 -0500
Message-Id: <20200217173452.15243-44-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wZ4PrxKUPVybVug5elzGgA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, ehabkost@redhat.com,
 mst@redhat.com
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
---
CC: mst@redhat.com
CC: pbonzini@redhat.com
CC: rth@twiddle.net
CC: ehabkost@redhat.com
---
 hw/i386/pc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ddce4230a..6ab4acb0c6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -937,7 +937,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion **ram_memory)
 {
     int linux_boot, i;
-    MemoryRegion *ram, *option_rom_mr;
+    MemoryRegion *option_rom_mr;
     MemoryRegion *ram_below_4g, *ram_above_4g;
     FWCfgState *fw_cfg;
     MachineState *machine =3D MACHINE(pcms);
@@ -950,22 +950,20 @@ void pc_memory_init(PCMachineState *pcms,
=20
     linux_boot =3D (machine->kernel_filename !=3D NULL);
=20
-    /* Allocate RAM.  We allocate it as a single memory region and use
-     * aliases to address portions of it, mostly for backwards compatibili=
ty
-     * with older qemus that used qemu_ram_alloc().
+    /*
+     * Split single memory region and use aliases to address portions of i=
t,
+     * done for backwards compatibility with older qemus.
      */
-    ram =3D g_malloc(sizeof(*ram));
-    memory_region_allocate_system_memory(ram, NULL, "pc.ram",
-                                         machine->ram_size);
-    *ram_memory =3D ram;
+    *ram_memory =3D machine->ram;
     ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
-    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
+    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->=
ram,
                              0, x86ms->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
     e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
     if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
-        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
+        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
+                                 machine->ram,
                                  x86ms->below_4g_mem_size,
                                  x86ms->above_4g_mem_size);
         memory_region_add_subregion(system_memory, 0x100000000ULL,
@@ -1952,6 +1950,7 @@ static void pc_machine_class_init(ObjectClass *oc, vo=
id *data)
     mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported =3D true;
     mc->numa_mem_supported =3D true;
+    mc->default_ram_id =3D "pc.ram";
=20
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
--=20
2.18.1


