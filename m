Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7AEC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFF020725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiHlqL8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFF020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kOb-0006KU-Mj
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kIn-0001P6-2A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kIl-0001rt-TX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kIl-0001rL-PE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnhdSXL39kygO0jjQDrylUKy22GYKWdOdTBn5a5pYTY=;
 b=aiHlqL8reoKNmq3CazZD/k4rqixYqG4duwPGOpIj7VWJf9pMQPk1GZuVz86flqs8Vj1h9H
 mgewtz9vYhUVaxgvnoGwcpnnOlRUXcQ1v/KOJ5/Er0z6l4nQ2Mq1Ofvv1LBH0fvEZdFRJd
 fcU8tQJr4LQWFZGyU5epJvYsYjUQIBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-deNTr94_MHeCzrmF5iRVLQ-1; Mon, 17 Feb 2020 12:35:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C60BD18FE860;
 Mon, 17 Feb 2020 17:35:19 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C43FB8CCE0;
 Mon, 17 Feb 2020 17:35:18 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/79] arm/imx25_pdk: use memdev for RAM
Date: Mon, 17 Feb 2020 12:33:49 -0500
Message-Id: <20200217173452.15243-17-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: deNTr94_MHeCzrmF5iRVLQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jcd@tribudubois.net
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
---
CC: jcd@tribudubois.net
---
 hw/arm/imx25_pdk.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index a2b7b35dcc..9087fcbb80 100644
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
2.18.1


