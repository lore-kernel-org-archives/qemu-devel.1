Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA5EC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E9E2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8NFsLQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E9E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkrJ-0007Uf-12
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkKY-0008SE-7U
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkKX-0000Bs-0r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31294
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkKW-0000Bd-Th
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LmbT4utHw3jVlrOr00QmnnfO7V5reIzeADeYrdgAyuw=;
 b=S8NFsLQgD878w9pTptL7CIMNC29eznmP67VJaeNt/QizZh/Q9477RNdxlF/6Jv2odBY14l
 g3s19CSYUEkD5Av17n5bBtmrm+h1TWOTvbwglUUWo+oVi86Yfa4hQDOY4FpzVxdmPKaYla
 /lmlw3/3DtqPYU9WcIwckNMPXCLtWvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-OEvF7mrBPvemLCm95e_WYQ-1; Wed, 15 Jan 2020 10:11:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB0199069BD;
 Wed, 15 Jan 2020 15:11:33 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3F0F196AE;
 Wed, 15 Jan 2020 15:11:30 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 45/86] x86:microvm: use memdev for RAM
Date: Wed, 15 Jan 2020 16:07:00 +0100
Message-Id: <1579100861-73692-46-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: OEvF7mrBPvemLCm95e_WYQ-1
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com,
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
index 827ce29..7d78b99 100644
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
2.7.4


