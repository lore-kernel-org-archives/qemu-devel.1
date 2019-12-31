Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585D4C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25282206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUN0GdoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25282206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHp2-00076K-KR
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCc-00062j-QY
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCa-0004ea-G5
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCa-0004bR-AW
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odk3qC7kLFgbYVy/6Z/797ZvStkki/1lFZ6fgpzdYI0=;
 b=aUN0GdoSyNub4pNjdjK9JxoekEfNmlTNTThj5NKr32BHF8T1O5K2wYvxrdCmQIBAFOksJy
 U/uj+tRNhy8wHHBmjony7Jt4SwcGrKW+PcqjY/dmY20Qr5NdeCpsyw0+WQGk5xSF0olsR0
 YG12EBdcfA/tkVY5vz+R3kX3gF8X+EA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-4oTzhUpFNtiW_sNY6Tc_fw-1; Tue, 31 Dec 2019 08:04:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49B1E107ACC7
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:45 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4B53620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:44 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 69/86] ppc:spapr: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:53 +0100
Message-Id: <1577797450-88458-70-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4oTzhUpFNtiW_sNY6Tc_fw-1
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
 hw/ppc/spapr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f11422f..915e36a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2589,7 +2589,6 @@ static void spapr_machine_init(MachineState *machine)
     PCIHostState *phb;
     int i;
     MemoryRegion *sysmem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     hwaddr node0_size =3D spapr_node0_size(machine);
     long load_limit, fw_size;
     char *filename;
@@ -2768,10 +2767,8 @@ static void spapr_machine_init(MachineState *machine=
)
         kvmppc_enable_h_page_init();
     }
=20
-    /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "ppc_spapr.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(sysmem, 0, ram);
+    /* map RAM */
+    memory_region_add_subregion(sysmem, 0, machine->ram);
=20
     /* always allocate the device memory information */
     machine->device_memory =3D g_malloc0(sizeof(*machine->device_memory));
@@ -4346,6 +4343,7 @@ static void spapr_machine_class_init(ObjectClass *oc,=
 void *data)
     mc->no_parallel =3D 1;
     mc->default_boot_order =3D "";
     mc->default_ram_size =3D 512 * MiB;
+    mc->default_ram_id =3D "ppc_spapr.ram";
     mc->default_display =3D "std";
     mc->kvm_type =3D spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE)=
;
--=20
2.7.4


