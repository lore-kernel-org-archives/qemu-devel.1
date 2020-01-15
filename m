Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B31C33CB3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950712053B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSf1PnGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950712053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkgc-0007og-4j
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkKH-00082u-Hp
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkKF-0008Nn-M2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkKF-0008NK-GX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SagVUdG2WaGuT4qgYSl7NBvOsnHYzLbuOb0tXuQrz/E=;
 b=cSf1PnGi8lDY40QXYxMAw2ymoysRcojzIuKhf4aIEu/vBgFD+PT0U1vi7zsCItmQ0wyALw
 fkJL/jGlHrcPggbItun5LIMBbpWBRgHuoE6iVGmR1OdOjD32o1B+4lVKiCBgNDyruI8PZX
 9iWeq9CIGekjnimYSH2dixZ+tUGnXeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-y6IR6RL4OkaWq1BbcMOYrg-1; Wed, 15 Jan 2020 10:11:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6366892735B;
 Wed, 15 Jan 2020 15:11:14 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EB77196AE;
 Wed, 15 Jan 2020 15:11:13 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/86] arm:sbsa-ref: use memdev for RAM
Date: Wed, 15 Jan 2020 16:06:45 +0100
Message-Id: <1579100861-73692-31-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: y6IR6RL4OkaWq1BbcMOYrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 radoslaw.biernacki@linaro.org, leif.lindholm@linaro.org
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
CC: peter.maydell@linaro.org
CC: qemu-arm@nongnu.org
CC: radoslaw.biernacki@linaro.org
CC: leif.lindholm@linaro.org
---
 hw/arm/sbsa-ref.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9b5bcb5..1cba9fc 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -593,7 +593,6 @@ static void sbsa_ref_init(MachineState *machine)
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *secure_sysmem =3D g_new(MemoryRegion, 1);
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     bool firmware_loaded;
     const CPUArchIdList *possible_cpus;
     int n, sbsa_max_cpus;
@@ -685,9 +684,8 @@ static void sbsa_ref_init(MachineState *machine)
         object_unref(cpuobj);
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "sbsa-ref.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base, ra=
m);
+    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base,
+                                machine->ram);
=20
     create_fdt(sms);
=20
@@ -785,6 +783,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *=
data)
     mc->block_default_type =3D IF_IDE;
     mc->no_cdrom =3D 1;
     mc->default_ram_size =3D 1 * GiB;
+    mc->default_ram_id =3D "sbsa-ref.ram";
     mc->default_cpus =3D 4;
     mc->possible_cpu_arch_ids =3D sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props =3D sbsa_ref_cpu_index_to_props;
--=20
2.7.4


