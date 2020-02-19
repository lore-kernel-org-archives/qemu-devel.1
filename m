Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0161C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D18E2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRMaGXMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D18E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SFt-0001Sg-Jt
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Rw2-0003YK-7z
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Rw1-0000wm-2n
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Rw0-0000wb-UF
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/0vdwdCZudEriVMd7fy3JA69r9r2adb2/yqDJN9u4U=;
 b=jRMaGXMXWknQXcYH14xLZuYIhi/e+xDO8tpffkgpCLSHNwc67ISwrCI4PI93VXSLXCsno1
 6v1WiyFyZPwtOeDYWrYASksmlBrFCfQFIESDS2I/icXpatp1RopZG69JWF02qr/7vP70gs
 5g3rz8v2ZqagBCyxR0DDzKR01H6E9ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-D1og4D1ePUqTFRigZm6Tng-1; Wed, 19 Feb 2020 11:10:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD8B1B2C988;
 Wed, 19 Feb 2020 16:10:42 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85CED48;
 Wed, 19 Feb 2020 16:10:41 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 40/79] cris/axis_dev88: use memdev for RAM
Date: Wed, 19 Feb 2020 11:09:14 -0500
Message-Id: <20200219160953.13771-41-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: D1og4D1ePUqTFRigZm6Tng-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, edgar.iglesias@gmail.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
CC: edgar.iglesias@gmail.com
---
 hw/cris/axis_dev88.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index be7760476a..cf6790fd6f 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -249,7 +249,6 @@ static struct cris_load_info li;
 static
 void axisdev88_init(MachineState *machine)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     CRISCPU *cpu;
@@ -261,16 +260,12 @@ void axisdev88_init(MachineState *machine)
     struct etraxfs_dma_client *dma_eth;
     int i;
     MemoryRegion *address_space_mem =3D get_system_memory();
-    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *phys_intmem =3D g_new(MemoryRegion, 1);
=20
     /* init CPUs */
     cpu =3D CRIS_CPU(cpu_create(machine->cpu_type));
=20
-    /* allocate RAM */
-    memory_region_allocate_system_memory(phys_ram, NULL, "axisdev88.ram",
-                                         ram_size);
-    memory_region_add_subregion(address_space_mem, 0x40000000, phys_ram);
+    memory_region_add_subregion(address_space_mem, 0x40000000, machine->ra=
m);
=20
     /* The ETRAX-FS has 128Kb on chip ram, the docs refer to it as the=20
        internal memory.  */
@@ -351,6 +346,7 @@ static void axisdev88_machine_init(MachineClass *mc)
     mc->init =3D axisdev88_init;
     mc->is_default =3D 1;
     mc->default_cpu_type =3D CRIS_CPU_TYPE_NAME("crisv32");
+    mc->default_ram_id =3D "axisdev88.ram";
 }
=20
 DEFINE_MACHINE("axis-dev88", axisdev88_machine_init)
--=20
2.18.1


