Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2519BC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39E7206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJLv4YPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39E7206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHf8-0000nj-E7
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCS-0005p0-3x
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCM-00048x-Sg
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCL-000452-TC
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28UayHgN+n+bvnj6lYVtrYqru20kTF+ZD4V5VbbMohM=;
 b=SJLv4YPNyEvBDp+8kzmlzWRS5Wy+2/P2jEXjOz6OBQaysVeocHvJO2Dvh+IkJ0b043B5Tq
 FgyTAalLltNsFFpGBlceJJXwjCJNbO3n00lkOcaCmZ5sgztjQiNuKT2TGoGyaVzgVLj8+v
 8x+mljZErxFjVuxers1s1GNliOOklso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-C1pZP0H7OEm5Uns6t2T9nw-1; Tue, 31 Dec 2019 08:04:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03A2F800D41
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:27 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F165620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/86] x86:pc: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:30 +0100
Message-Id: <1577797450-88458-47-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: C1pZP0H7OEm5Uns6t2T9nw-1
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 42014b0..aa956aa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -935,7 +935,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion **ram_memory)
 {
     int linux_boot, i;
-    MemoryRegion *ram, *option_rom_mr;
+    MemoryRegion *option_rom_mr;
     MemoryRegion *ram_below_4g, *ram_above_4g;
     FWCfgState *fw_cfg;
     MachineState *machine =3D MACHINE(pcms);
@@ -948,22 +948,20 @@ void pc_memory_init(PCMachineState *pcms,
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
@@ -1951,6 +1949,7 @@ static void pc_machine_class_init(ObjectClass *oc, vo=
id *data)
     mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported =3D true;
     mc->numa_mem_supported =3D true;
+    mc->default_ram_id =3D "pc.ram";
=20
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
--=20
2.7.4


