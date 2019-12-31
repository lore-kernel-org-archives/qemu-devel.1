Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEEC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DB3205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ck7WIIbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DB3205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHwn-0000Hc-DJ
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCg-00068H-4a
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCe-0004zd-SO
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51294
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCe-0004wC-LR
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQXiMawicfvYJvvySbAjj44ZFJrLq15U9RH3R6J2BQ0=;
 b=ck7WIIbnPg9VvGYYRq6qRm7mg8ywaJko5UQWKRJmvFKf3rMUGMCOFW0EGbnNJifE79gCt8
 RXoReUUKfoyYU0LrYFaeWYzErOOKKNf503m2QlXNs/wvY1Uw5IImnbNEcNCU62NFbi8TI8
 BQmUFupb/vVRuw3tzeVyk1ohWUJq//8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-FJP86F50N-mLb5BjbnVO4Q-1; Tue, 31 Dec 2019 08:04:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 434D1107ACC4
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:49 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDF16620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:48 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 74/86] sparc:niagara: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:58 +0100
Message-Id: <1577797450-88458-75-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FJP86F50N-mLb5BjbnVO4Q-1
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
 hw/sparc64/niagara.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 5eb2d09..ab5ef8c 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -40,7 +40,6 @@
=20
 typedef struct NiagaraBoardState {
     MemoryRegion hv_ram;
-    MemoryRegion partition_ram;
     MemoryRegion nvram;
     MemoryRegion md_rom;
     MemoryRegion hv_rom;
@@ -111,11 +110,8 @@ static void niagara_init(MachineState *machine)
                            NIAGARA_HV_RAM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram);
=20
-    memory_region_allocate_system_memory(&s->partition_ram, NULL,
-                                         "sun4v-partition.ram",
-                                         machine->ram_size);
     memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
-                                &s->partition_ram);
+                                machine->ram);
=20
     memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVRAM_S=
IZE,
                            &error_fatal);
@@ -173,6 +169,7 @@ static void niagara_class_init(ObjectClass *oc, void *d=
ata)
     mc->max_cpus =3D 1; /* XXX for now */
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
+    mc->default_ram_id =3D "sun4v-partition.ram";
 }
=20
 static const TypeInfo niagara_type =3D {
--=20
2.7.4


