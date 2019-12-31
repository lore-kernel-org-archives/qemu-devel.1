Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4751C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97283205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0VDVrFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97283205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHOR-0004nH-28
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHC0-0005L0-Uu
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBv-0002sH-Tz
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBv-0002q8-PV
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AgsgEz3bPReN2HNetzEt+ok3xDpMnyxvVHdEtWZO7U8=;
 b=O0VDVrFqP0Wk1wlwFD67hdR5nLoBSSyr2KvKU5JA3/Nh43spH1hLYwWgiLC9qslCVb1i5D
 teoDvjIezc5GWKVD1VmROitI2gPq2VfE5yZ54P05NQiya3RAgYgtZ6Fjco6lSKLqDkoFfu
 1SeoC8H41T9dQwnF4azVKHJ4FpyufCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-bQGZrOECObOVDm8nuvOWwA-1; Tue, 31 Dec 2019 08:04:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B143F800D48
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:04 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37638620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/86] arm:imx25_pdk: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:02 +0100
Message-Id: <1577797450-88458-19-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: bQGZrOECObOVDm8nuvOWwA-1
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
 hw/arm/imx25_pdk.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index a2b7b35..9087fcb 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -58,7 +58,6 @@
=20
 typedef struct IMX25PDK {
     FslIMX25State soc;
-    MemoryRegion ram;
     MemoryRegion ram_alias;
 } IMX25PDK;
=20
@@ -84,10 +83,8 @@ static void imx25_pdk_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "imx25.ram",
-                                         machine->ram_size);
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_SDRAM0_ADDR=
,
-                                &s->ram);
+                                machine->ram);
=20
     /* initialize the alias memory if any */
     for (i =3D 0, ram_size =3D machine->ram_size, alias_offset =3D 0;
@@ -107,7 +104,8 @@ static void imx25_pdk_init(MachineState *machine)
=20
         if (size < ram[i].size) {
             memory_region_init_alias(&s->ram_alias, NULL, "ram.alias",
-                                     &s->ram, alias_offset, ram[i].size - =
size);
+                                     machine->ram,
+                                     alias_offset, ram[i].size - size);
             memory_region_add_subregion(get_system_memory(),
                                         ram[i].addr + size, &s->ram_alias)=
;
         }
@@ -135,6 +133,7 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->desc =3D "ARM i.MX25 PDK board (ARM926)";
     mc->init =3D imx25_pdk_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_ram_id =3D "imx25.ram";
 }
=20
 DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
--=20
2.7.4


