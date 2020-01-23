Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BE3206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGLwuGfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BE3206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubKD-0007W4-P6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuasM-00069w-MK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuasL-0004Uw-2j
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuasK-0004UJ-6c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dU4A1ol9+RV1MxN3TNqpKB5fZBZ1daE0CVda99LGnPU=;
 b=GGLwuGfpZjouJzCGIuueqNcwZBopTH7k4JXZpTtFQbnHnEygih4NcmkvdSZMVRvOyQtm95
 yBSDB1ROV3S454o/FsSzqqmfnJ8RoOE/EVqWHPmiZZllA3SgVtU0jCR6u0o2cU1oBbNAOp
 IvKjC+mVJB5oMLfQNvr2zaM4ZNrWtZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-br9DgDl_PZS2KVDAd85Mrw-1; Thu, 23 Jan 2020 06:42:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 182038010D6;
 Thu, 23 Jan 2020 11:42:10 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE5410016E8;
 Thu, 23 Jan 2020 11:42:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 31/80] arm/virt: use memdev for RAM
Date: Thu, 23 Jan 2020 12:37:56 +0100
Message-Id: <1579779525-20065-32-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: br9DgDl_PZS2KVDAd85Mrw-1
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_allocate_system_memory() API is going away,
so replace it with memdev allocated MemoryRegion.
The later is initialized by generic code, so board only
needs to opt in to memdev scheme by providing
  MachineClass::default_ram_id
and then map memory region provided by
  MachineState::ram_memdev

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
CC: peter.maydell@linaro.org
CC: qemu-arm@nongnu.org
CC: drjones@redhat.com
---
 hw/arm/virt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 39ab5f4..e2fbca3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1512,7 +1512,6 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *secure_sysmem =3D NULL;
     int n, virt_max_cpus;
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     bool firmware_loaded;
     bool aarch64 =3D true;
     bool has_ged =3D !vmc->no_ged;
@@ -1701,9 +1700,8 @@ static void machvirt_init(MachineState *machine)
         }
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
+    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
+                                machine->ram);
     if (machine->device_memory) {
         memory_region_add_subregion(sysmem, machine->device_memory->base,
                                     &machine->device_memory->mr);
@@ -2053,6 +2051,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
     hc->unplug_request =3D virt_machine_device_unplug_request_cb;
     mc->numa_mem_supported =3D true;
     mc->auto_enable_numa_with_memhp =3D true;
+    mc->default_ram_id =3D "mach-virt.ram";
 }
=20
 static void virt_instance_init(Object *obj)
--=20
2.7.4


