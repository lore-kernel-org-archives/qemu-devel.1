Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E240C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD18C20675
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dwi+XoCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD18C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4S1w-0006R2-1Q
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Rvb-0002Y4-OP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Rva-0000cJ-HT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Rva-0000c1-Bz
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPJbwtsOsZJ0VNJepE8MCyC3QguRyuxPinpkDKfB2Pg=;
 b=Dwi+XoCipPekmMF9RLQaCd0A3jepblDW81+7cv62CdbSdOVvDq12oTbAg5IVKog14pWzmq
 tM17hFv5HLsUggVj3BAAOWsfAJbsB/4wwOtxQ3zHGURtXJ4gsTJhP/8sglDGfjyVsrCXiq
 orqDU5CCPQpmc4WPgetNmj0JlvEyF/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-AZMyc6vXO4W42C2Qnj5wmQ-1; Wed, 19 Feb 2020 11:10:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 600C68F0459
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:10:19 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD9E448;
 Wed, 19 Feb 2020 16:10:18 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 19/79] arm/kzm: use memdev for RAM
Date: Wed, 19 Feb 2020 11:08:53 -0500
Message-Id: <20200219160953.13771-20-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: AZMyc6vXO4W42C2Qnj5wmQ-1
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
Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/kzm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 94cbac11de..34f6bcb491 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -52,7 +52,6 @@
=20
 typedef struct IMX31KZM {
     FslIMX31State soc;
-    MemoryRegion ram;
     MemoryRegion ram_alias;
 } IMX31KZM;
=20
@@ -85,10 +84,8 @@ static void kzm_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "kzm.ram",
-                                         machine->ram_size);
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_SDRAM0_ADDR=
,
-                                &s->ram);
+                                machine->ram);
=20
     /* initialize the alias memory if any */
     for (i =3D 0, ram_size =3D machine->ram_size, alias_offset =3D 0;
@@ -108,7 +105,8 @@ static void kzm_init(MachineState *machine)
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
@@ -140,6 +138,7 @@ static void kzm_machine_init(MachineClass *mc)
     mc->desc =3D "ARM KZM Emulation Baseboard (ARM1136)";
     mc->init =3D kzm_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_ram_id =3D "kzm.ram";
 }
=20
 DEFINE_MACHINE("kzm", kzm_machine_init)
--=20
2.18.1


