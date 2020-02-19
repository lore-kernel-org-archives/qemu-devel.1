Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F045C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEE524654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWoqZ6Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEE524654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SIx-0007w1-TO
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Rw8-0003qd-R1
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Rw7-000113-Of
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Rw7-00010k-Ju
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvzDzCLroL8ZQYu0S3xDnyf0sc9quNuUaGJMW+M8050=;
 b=JWoqZ6Ze+dVHPzikhSVky560IihzTT8cXNS2Mma5ZoLs/YAF/oaXQQbrpHcSSe/AXxdqre
 ahPqT889U2K5xUjOIM4W7IgEoDSimfZ51aCWOuHNnJdXeSSX6uMI2jXbEjaZTYGhkH+Lbj
 0bnK6Fmedes0ZIo3EwRcILqq0j8i3yM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-UAjcENQWMR-wyRtb53ZztQ-1; Wed, 19 Feb 2020 11:10:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C5FC802B84
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:10:52 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA10048;
 Wed, 19 Feb 2020 16:10:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 48/79] m68k/mcf5208: use memdev for RAM
Date: Wed, 19 Feb 2020 11:09:22 -0500
Message-Id: <20200219160953.13771-49-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UAjcENQWMR-wyRtb53ZztQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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


