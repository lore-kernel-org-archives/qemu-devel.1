Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33146C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2546206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNGywn22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2546206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHlf-0002QR-NL
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCY-0005uC-JV
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCX-0004PI-Ak
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCW-0004Mx-VV
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qbUUGrqrGf28pUJFUGCnmxEZcyCOFuqIRng9Iri2ww=;
 b=JNGywn22fsZfO1gJDlNgudyhd93LxZj0R12Y+b47txOW7bGtvBay1R7/Qwc1qmk+OvpTRi
 6kLA08vXs+yZXdeQhTlUvGWipzTDsZlQbUhWOtfJIaw+DnjG4oR7P/gHcs7gQ7ZXb/K8+g
 lcoVb8QABq0KYodxRoUNQgT489+3DFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-6h69OPjVNOSISKhzSAWC7Q-1; Tue, 31 Dec 2019 08:04:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B49C5100550E
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:39 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A036620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:39 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 62/86] ppc:mac_oldworld: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:46 +0100
Message-Id: <1577797450-88458-63-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6h69OPjVNOSISKhzSAWC7Q-1
X-Mimecast-Spam-Score: 0
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
 hw/ppc/mac_oldworld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0fa680b..2be0602 100644
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
2.7.4


