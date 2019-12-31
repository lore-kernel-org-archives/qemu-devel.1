Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F89DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFCF205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0X4UCsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFCF205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHLB-00019H-L3
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHBs-0005CS-Bt
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBr-0002Vx-1c
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBq-0002Tc-TD
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuhqGloe2JFox7+RnDN/Ndkz744NAvXh5x2+C2XCQcE=;
 b=K0X4UCswJODAvyYqEuTfiAtKKJ7ceUjU3aJjoUUx6EN+lquk8puYD8sN3aOLeOK+ksUVmq
 K6Lh9sTqchL8pGh0UACemjImiR0b/fanAOgOfb/ueiOdoebeehGD8BQW/CeQwzsSF9a/Kw
 UimUgwW5ioNUxa8htapSxbepJWvOk2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-OTAxBLfPPMStBvWuwNrbog-1; Tue, 31 Dec 2019 08:04:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4887800EB8
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:59 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BA6178E96
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:59 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/86] arm:aspeed: use memdev for RAM
Date: Tue, 31 Dec 2019 14:02:56 +0100
Message-Id: <1577797450-88458-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: OTAxBLfPPMStBvWuwNrbog-1
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
 hw/arm/aspeed.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 525c547..330254b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -35,7 +35,6 @@ static struct arm_boot_info aspeed_board_binfo =3D {
 struct AspeedBoardState {
     AspeedSoCState soc;
     MemoryRegion ram_container;
-    MemoryRegion ram;
     MemoryRegion max_ram;
 };
=20
@@ -184,6 +183,7 @@ static void aspeed_machine_init(MachineState *machine)
=20
     memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-container",
                        UINT32_MAX);
+    memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
=20
     object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
                             (sizeof(bmc->soc)), amc->soc_name, &error_abor=
t,
@@ -215,8 +215,6 @@ static void aspeed_machine_init(MachineState *machine)
     object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
                              &error_fatal);
=20
-    memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size)=
;
-    memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
     memory_region_add_subregion(get_system_memory(),
                                 sc->memmap[ASPEED_SDRAM],
                                 &bmc->ram_container);
@@ -393,6 +391,7 @@ static void aspeed_machine_class_init(ObjectClass *oc, =
void *data)
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
     mc->no_parallel =3D 1;
+    mc->default_ram_id =3D "ram";
 }
=20
 static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data=
)
--=20
2.7.4


