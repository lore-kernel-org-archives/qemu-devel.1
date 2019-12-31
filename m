Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6116EC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE9B206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws/Yn6Fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE9B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHpJ-0007Ve-Kf
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCS-0005pH-3l
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCM-00048Q-PY
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59063
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCL-00044S-0E
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2eelqXaC3pUz3GeVceDZ8mL4XweDBc6wJNeqRDorwA=;
 b=Ws/Yn6FcJEZ6JsrDEWtpo2VqQM1deC7DiuYvX1YgX/L6WIFQMyoWffXCRULWA/qi+tFv1q
 87Y0kjHfUUp4Yd4Mjxygc7yekQJe0IS69YZG+Pi0TLkXN61FDFU+YTfn6U8zfFk/lZM5oM
 +fBMGQAbRp4ER4HZUPkplzNszflQ9+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-KRUOG5qPOJKMERconQhozQ-1; Tue, 31 Dec 2019 08:04:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 684B618031DE
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:25 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3897620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:24 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/86] hppa: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:28 +0100
Message-Id: <1577797450-88458-45-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: KRUOG5qPOJKMERconQhozQ-1
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
 hw/hppa/machine.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 25f5afc..b2f7bc5 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -70,7 +70,6 @@ static void machine_hppa_init(MachineState *machine)
     uint64_t kernel_entry =3D 0, kernel_low, kernel_high;
     MemoryRegion *addr_space =3D get_system_memory();
     MemoryRegion *rom_region;
-    MemoryRegion *ram_region;
     MemoryRegion *cpu_region;
     long i;
     unsigned int smp_cpus =3D machine->smp.cpus;
@@ -96,11 +95,7 @@ static void machine_hppa_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
=20
-    /* Main memory region. */
-    ram_region =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ram_region, OBJECT(machine),
-                                         "ram", ram_size);
-    memory_region_add_subregion(addr_space, 0, ram_region);
+    memory_region_add_subregion(addr_space, 0, machine->ram);
=20
     /* Init Dino (PCI host bus chip).  */
     pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
@@ -284,6 +279,7 @@ static void machine_hppa_machine_init(MachineClass *mc)
     mc->is_default =3D 1;
     mc->default_ram_size =3D 512 * MiB;
     mc->default_boot_order =3D "cd";
+    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("hppa", machine_hppa_machine_init)
--=20
2.7.4


