Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C19C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21885205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRRpDDD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21885205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHzv-00053V-Vg
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCY-0005uj-ST
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCX-0004PW-AV
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCW-0004N8-Ui
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExbM5OGtJdj+rUFSl6KHm5sc5tKjnopsn7zA/zbbJZA=;
 b=KRRpDDD9gzdTQ+qmg32zZihZjpnpX2vODwavPgAAaOYUsSKVcN/JzfzyC4SdLGwS7Zxt+j
 xJNwU88EWXNodlgpIGj2VJ0+bhDXSX1bf6KAeRuVTz+TixtEktUl57ccCeVtMb34Vx03OV
 yqs09afC2PksDsa3MXkFMn8dut9xE5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-Dy2dS16ONh6xgaSXeGKUwA-1; Tue, 31 Dec 2019 08:04:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80FCB800D4E
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:40 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08572620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:39 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 63/86] ppc:pnv: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:47 +0100
Message-Id: <1577797450-88458-64-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Dy2dS16ONh6xgaSXeGKUwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 hw/ppc/pnv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f77e7ca..8eaa7de 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -676,7 +676,6 @@ static void pnv_init(MachineState *machine)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(machine);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
-    MemoryRegion *ram;
     char *fw_filename;
     long fw_size;
     int i;
@@ -688,11 +687,7 @@ static void pnv_init(MachineState *machine)
     if (machine->ram_size < (1 * GiB)) {
         warn_report("skiboot may not work with < 1GB of RAM");
     }
-
-    ram =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ram, NULL, "pnv.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(get_system_memory(), 0, ram);
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
=20
     /*
      * Create our simple PNOR device
@@ -1811,6 +1806,7 @@ static void pnv_machine_class_init(ObjectClass *oc, v=
oid *data)
      * enough to fit the maximum initrd size at it's load address
      */
     mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
+    mc->default_ram_id =3D "pnv.ram";
     ispc->print_info =3D pnv_pic_print_info;
=20
     pnv_machine_class_props_init(oc);
--=20
2.7.4


