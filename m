Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6262C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E92A2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtRQ79ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E92A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3koG-00057J-Jo
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJm-0003XB-8R
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJl-0002Y8-5j
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39971
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJl-0002Xs-1k
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8OXOFlUy6HW7z5mxWmXiuD5eqJHRIK5b2zLHi4H+VY=;
 b=QtRQ79ixB3BhtE+rlZDnLmZJlTrkRoqyHuZBnaJsn+I+TRDcmFoT9YPLQijvmG6gd+FOhE
 H0Q4xoGGH6T6dFUaGuDKDhpLyALCrqFEIA7fcnEAYOzWKQ7UzoZ70TbexcYYfh9rTvjlGz
 0ZYrJpebPbEmKagSHVI1AG7qcnLNOSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-UkhsQd54MfenvvXh64EDTg-1; Mon, 17 Feb 2020 12:36:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23FCDB20
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:36:21 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA2F90526;
 Mon, 17 Feb 2020 17:36:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 61/79] ppc/mac_oldworld: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:34 -0500
Message-Id: <20200217173452.15243-62-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UkhsQd54MfenvvXh64EDTg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_oldworld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 7318d7e9b4..66e434bba3 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -91,7 +91,6 @@ static void ppc_heathrow_init(MachineState *machine)
     CPUPPCState *env =3D NULL;
     char *filename;
     int linux_boot, i;
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *bios =3D g_new(MemoryRegion, 1);
     uint32_t kernel_base, initrd_base, cmdline_base =3D 0;
     int32_t kernel_size, initrd_size;
@@ -127,9 +126,7 @@ static void ppc_heathrow_init(MachineState *machine)
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "ppc_heathrow.ram",
-                                         ram_size);
-    memory_region_add_subregion(sysmem, 0, ram);
+    memory_region_add_subregion(sysmem, 0, machine->ram);
=20
     /* allocate and load BIOS */
     memory_region_init_ram(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
@@ -446,6 +443,7 @@ static void heathrow_class_init(ObjectClass *oc, void *=
data)
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("750_v3.1");
     mc->default_display =3D "std";
     mc->ignore_boot_device_suffixes =3D true;
+    mc->default_ram_id =3D "ppc_heathrow.ram";
     fwc->get_dev_path =3D heathrow_fw_dev_path;
 }
=20
--=20
2.18.1


