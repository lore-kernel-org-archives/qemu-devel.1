Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF0BC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEC5207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrjH+PEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEC5207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kdt-0002d5-9A
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJY-0002vn-9f
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJX-0002NO-93
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54608
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJX-0002LG-45
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=re5n7l+nQ9qrqnNQI25KNrL5OHDn4Vh2MyfxJ2WTulI=;
 b=BrjH+PEW2FYFBX08gKw51M3CPqQG9xCdRsysQTuogVZC4WwWNClb4Jzxq/xHplnbhb/eCJ
 uR4/kdc1YzNfdssL9csIONG9jaH9bu0Y4vYn1TAIvUIlCEVQSwHdmhH3g0LqN2HMWNBwqD
 DCAu2JdkT6nRtZiN4JjzJtFNXPqh1Qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Yv6j5kfuN7WE98fEZDCOBQ-1; Mon, 17 Feb 2020 12:36:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0F7218FE861
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:36:05 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C0418CCE0;
 Mon, 17 Feb 2020 17:36:05 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 48/79] m68k/mcf5208: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:21 -0500
Message-Id: <20200217173452.15243-49-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Yv6j5kfuN7WE98fEZDCOBQ-1
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
Acked-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/mcf5208.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index a999c21982..31622c71cb 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -234,7 +234,6 @@ static void mcf5208evb_init(MachineState *machine)
     qemu_irq *pic;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *rom =3D g_new(MemoryRegion, 1);
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
=20
     cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
@@ -249,8 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x00000000, rom);
=20
     /* DRAM at 0x40000000 */
-    memory_region_allocate_system_memory(ram, NULL, "mcf5208.ram", ram_siz=
e);
-    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
+    memory_region_add_subregion(address_space_mem, 0x40000000, machine->ra=
m);
=20
     /* Internal SRAM.  */
     memory_region_init_ram(sram, NULL, "mcf5208.sram", 16 * KiB, &error_fa=
tal);
@@ -354,6 +352,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->init =3D mcf5208evb_init;
     mc->is_default =3D 1;
     mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m5208");
+    mc->default_ram_id =3D "mcf5208.ram";
 }
=20
 DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
--=20
2.18.1


