Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94D5C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95740206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVxboxOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95740206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHk6-0008T0-Aw
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCS-0005pE-5M
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCN-00049Z-1y
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49161
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCM-00046P-NA
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xv1RPkuSm6t0Srcj+G3GqWiLB3MVoukuWQ9Luti8Zqc=;
 b=cVxboxOQlosUNBbdYyoxhiBdoUtmBe1Mi1M8QrS3IjRQZH6SAZ4M2aWTa0IXmvLHJrPfKO
 qEKOQzbi8l3aGt9/XTaQB05mQc/5/mVUjS04ALTjEXwuAHrr4FKBxr7AkIoSzvd1JJF1/5
 hH4WkBRqdN+rIwMOlXGeQlOgfzZ9K2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-IRi_YhoDNbmNVxBDDsf0iQ-1; Tue, 31 Dec 2019 08:04:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F67477
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:30 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAEFC620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:29 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 50/86] m68k:mcf5208: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:34 +0100
Message-Id: <1577797450-88458-51-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: IRi_YhoDNbmNVxBDDsf0iQ-1
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
 hw/m68k/mcf5208.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 158c5e4..d050cb7 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -234,7 +234,6 @@ static void mcf5208evb_init(MachineState *machine)
     qemu_irq *pic;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *rom =3D g_new(MemoryRegion, 1);
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
=20
     cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
@@ -249,8 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x00000000, rom);
=20
     /* DRAM at 0x40000000 */
-    memory_region_allocate_system_memory(ram, NULL, "mcf5208.ram", ram_siz=
e);
-    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
+    memory_region_add_subregion(address_space_mem, 0x40000000, machine->ra=
m);
=20
     /* Internal SRAM.  */
     memory_region_init_ram(sram, NULL, "mcf5208.sram", 16 * KiB, &error_fa=
tal);
@@ -354,6 +352,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->init =3D mcf5208evb_init;
     mc->is_default =3D 1;
     mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m5208");
+    mc->default_ram_id =3D "mcf5208.ram";
 }
=20
 DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
--=20
2.7.4


