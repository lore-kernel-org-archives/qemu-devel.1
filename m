Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643FC34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945F824671
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSv+fVTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945F824671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SB3-0000T2-OY
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Rvt-0003FH-TA
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Rvs-0000s9-Og
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58107
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Rvs-0000rn-JJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/G/CBjxKd4ihoUEAR+deQzXOyBrQJlzs8zdylC8FZo=;
 b=fSv+fVTCvnI5/p8JIFGKrdBJM6PiaUTd6OYLbWbmvTMuTz4qVKi8eyyRz0lL/ScLRHk+Xi
 WA2EsMnSSX6hIME+y/ebMoEyRWqns1VoB1IWMnKKM0ik38zp2Tq/nc0gy4yABbd9JuqP3h
 66OeSdXMkjtPj3KjloErfqucAhE0eIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-bCG5QCqwM2SlFt6sUpNzWA-1; Wed, 19 Feb 2020 11:10:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E2DD8048E3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:10:37 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F4A76E3EE;
 Wed, 19 Feb 2020 16:10:36 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 35/79] arm/xilinx_zynq: use memdev for RAM
Date: Wed, 19 Feb 2020 11:09:09 -0500
Message-Id: <20200219160953.13771-36-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bCG5QCqwM2SlFt6sUpNzWA-1
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/xilinx_zynq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index f548c44fbd..3d439a45d5 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -160,7 +160,6 @@ static void zynq_init(MachineState *machine)
 {
     ARMCPU *cpu;
     MemoryRegion *address_space_mem =3D get_system_memory();
-    MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *ocm_ram =3D g_new(MemoryRegion, 1);
     DeviceState *dev;
     SysBusDevice *busdev;
@@ -190,9 +189,7 @@ static void zynq_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), true, "realized", &error_fatal);
=20
     /* DDR remapped to address zero.  */
-    memory_region_allocate_system_memory(ext_ram, NULL, "zynq.ext_ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(address_space_mem, 0, ext_ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
=20
     /* 256K of on-chip memory */
     memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 * KiB,
@@ -318,6 +315,7 @@ static void zynq_machine_init(MachineClass *mc)
     mc->no_sdcard =3D 1;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->default_ram_id =3D "zynq.ext_ram";
 }
=20
 DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
--=20
2.18.1


