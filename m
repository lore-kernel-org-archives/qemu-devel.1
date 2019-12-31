Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59798C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21418206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX67JfAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21418206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHZi-0002hV-Mq
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCA-0005bN-R6
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHC9-0003Yy-EV
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHC9-0003Uk-9J
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMaB5P1HWTWZX9QKm2IEa5DZE5rnqMQANJg4MUCks/A=;
 b=PX67JfAlvHPi8skaX3woGRF5KH4fI59jh8Z2NNPfiuui/Vl4hGWesCZo3ny1MgReFzDda+
 KcUaqZGF+HmKQk8wu5VUHkctnnSZBgKg27Z/y94tLU9bA90zhWysl3wx1Nt8U8POuweS2T
 u0g8MA7CFiM9a4m5DjCsuRHV34X2Z3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-S-zPFiSwNdStVYImvbt_Qg-1; Tue, 31 Dec 2019 08:04:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74C77800D41
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:17 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFE6B620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:16 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/86] arm:vexpress: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:18 +0100
Message-Id: <1577797450-88458-35-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: S-zPFiSwNdStVYImvbt_Qg-1
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

replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/vexpress.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 4673a88..ed683ee 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -273,7 +273,6 @@ static void a9_daughterboard_init(const VexpressMachine=
State *vms,
 {
     MachineState *machine =3D MACHINE(vms);
     MemoryRegion *sysmem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *lowram =3D g_new(MemoryRegion, 1);
     ram_addr_t low_ram_size;
=20
@@ -283,8 +282,6 @@ static void a9_daughterboard_init(const VexpressMachine=
State *vms,
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "vexpress.highmem",
-                                         ram_size);
     low_ram_size =3D ram_size;
     if (low_ram_size > 0x4000000) {
         low_ram_size =3D 0x4000000;
@@ -293,9 +290,10 @@ static void a9_daughterboard_init(const VexpressMachin=
eState *vms,
      * address space should in theory be remappable to various
      * things including ROM or RAM; we always map the RAM there.
      */
-    memory_region_init_alias(lowram, NULL, "vexpress.lowmem", ram, 0, low_=
ram_size);
+    memory_region_init_alias(lowram, NULL, "vexpress.lowmem", machine->ram=
,
+                             0, low_ram_size);
     memory_region_add_subregion(sysmem, 0x0, lowram);
-    memory_region_add_subregion(sysmem, 0x60000000, ram);
+    memory_region_add_subregion(sysmem, 0x60000000, machine->ram);
=20
     /* 0x1e000000 A9MPCore (SCU) private memory region */
     init_cpus(machine, cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic,
@@ -360,7 +358,6 @@ static void a15_daughterboard_init(const VexpressMachin=
eState *vms,
 {
     MachineState *machine =3D MACHINE(vms);
     MemoryRegion *sysmem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
=20
     {
@@ -375,10 +372,8 @@ static void a15_daughterboard_init(const VexpressMachi=
neState *vms,
         }
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "vexpress.highmem",
-                                         ram_size);
     /* RAM is from 0x80000000 upwards; there is no low-memory alias for it=
. */
-    memory_region_add_subregion(sysmem, 0x80000000, ram);
+    memory_region_add_subregion(sysmem, 0x80000000, machine->ram);
=20
     /* 0x2c000000 A15MPCore private memory region (GIC) */
     init_cpus(machine, cpu_type, TYPE_A15MPCORE_PRIV,
@@ -795,6 +790,7 @@ static void vexpress_class_init(ObjectClass *oc, void *=
data)
     mc->init =3D vexpress_common_init;
     mc->max_cpus =3D 4;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_ram_id =3D "vexpress.highmem";
 }
=20
 static void vexpress_a9_class_init(ObjectClass *oc, void *data)
--=20
2.7.4


